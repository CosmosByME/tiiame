import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiiame/data/model/student.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FirestoreService {
  
  Future<void> saveStudentProfile(StudentData studentData) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    String uid = currentUser.uid;
    String classBucket = "class${studentData.grade}";

    // 🔥 FIX: Extract the map and explicitly force the 'uid' field into it
    final Map<String, dynamic> studentMap = studentData.toJson();
    studentMap['uid'] = uid; 

    // 1. Save to Firestore (Now contains the internal 'uid' field!)
    final gradesCollection = FirebaseFirestore.instance.collection('grades');
    final studentsCollection = gradesCollection
        .doc(classBucket)
        .collection('students');
    await studentsCollection.doc(uid).set(studentMap); // Pass the updated map

    // 2. Mirror to Google Sheets via Apps Script Web API
    final scriptUrl = Uri.parse(
      'https://script.google.com/macros/s/AKfycbz10UyOC7LgQMV_uoYG0YAbD8OaDIv2gA_bg0iAx9aCH-psaQDG6Pr3nWGGEJYXsMAT/exec',
    );

    try {
      final response = await http.post(
        scriptUrl,
        headers: {'Content-Type': 'text/plain'},
        body: jsonEncode({
          'action': 'logStudent',
          'classBucket': classBucket,
          'uid': uid,
          'lastUpdated': studentData.lastUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
          'firstName': studentData.firstName ?? 'N/A',
          'lastName': studentData.lastName ?? 'N/A',
          'phoneNumber': studentData.phoneNumber ?? 'N/A',
          'school': studentData.school ?? 'N/A',
          'home': studentData.home ?? 'N/A',
          'photoUrl': studentData.photoUrl ?? 'N/A',
          'passportUrl': studentData.passportUrl ?? 'N/A',
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("Spreadsheet sync successful!");
      } else {
        debugPrint("Spreadsheet sync failed with status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Network error syncing to spreadsheet: $e");
    }
  }

  /// FETCH PROFILE: Finds the student across any class bucket using collectionGroup
  Future<StudentData?> getCurrentStudentProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('students')
          .where('uid', isEqualTo: currentUser.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        debugPrint("No existing student profile found.");
        return null;
      }

      return StudentData.fromJson(querySnapshot.docs.first.data());
    } catch (e) {
      debugPrint("❌ Error fetching profile: $e");
      return null;
    }
  }

  /// UPDATE PROFILE: Updates Firestore and mirrors the edit to Google Sheets
  Future<void> updateStudentProfile(StudentData studentData) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || studentData.grade == null) return;

    final uid = currentUser.uid;
    final classBucket = 'class${studentData.grade}';

    // 🔥 FIX: Extract map and append the 'uid' field here too
    final Map<String, dynamic> studentMap = studentData.toJson();
    studentMap['uid'] = uid;

    // 1. Update your hierarchical Firestore path
    final studentsCollection = FirebaseFirestore.instance
        .collection('grades')
        .doc(classBucket)
        .collection('students');

    await studentsCollection
        .doc(uid)
        .set(studentMap, SetOptions(merge: true));

    // 2. Instantly sync the edit over to Google Sheets
    await _syncEditToGoogleSheets(studentData, uid, classBucket);
  }

  /// PRIVATE HELPER: Handles the network call to your Google Apps Script
  Future<void> _syncEditToGoogleSheets(StudentData studentData, String uid, String classBucket) async {
    final scriptUrl = Uri.parse('https://script.google.com/macros/s/AKfycbz10UyOC7LgQMV_uoYG0YAbD8OaDIv2gA_bg0iAx9aCH-psaQDG6Pr3nWGGEJYXsMAT/exec');

    try {
      final response = await http.post(
        scriptUrl,
        headers: {'Content-Type': 'text/plain'}, 
        body: jsonEncode({
          'action': 'logStudent',
          'classBucket': classBucket,
          'uid': uid,
          'lastUpdated': studentData.lastUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
          'firstName': studentData.firstName ?? 'N/A',
          'lastName': studentData.lastName ?? 'N/A',
          'phoneNumber': studentData.phoneNumber ?? 'N/A',
          'school': studentData.school ?? 'N/A',
          'home': studentData.home ?? 'N/A',
          'photoUrl': studentData.photoUrl ?? 'N/A',
          'passportUrl': studentData.passportUrl ?? 'N/A',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 302) {
        debugPrint("🚀 Google Sheets edit synced successfully!");
      }
    } catch (e) {
      debugPrint("⚠️ Sheets sync failed during profile update: $e");
    }
  }
}