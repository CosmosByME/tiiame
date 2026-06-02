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

    // 1. Save to Firestore (For real-time UI)
    final gradesCollection = FirebaseFirestore.instance.collection('grades');
    final studentsCollection = gradesCollection
        .doc(classBucket)
        .collection('students');
    await studentsCollection.doc(uid).set(studentData.toJson());

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

          // Data matching your exact sheet.appendRow keys
          'lastUpdated':
              studentData.lastUpdated!.toIso8601String(),
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
        debugPrint(
          "Spreadsheet sync failed with status: ${response.statusCode}",
        );
      }
    } catch (e) {
      debugPrint("Network error syncing to spreadsheet: $e");
    }
  }
}
