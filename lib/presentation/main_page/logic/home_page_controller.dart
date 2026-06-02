import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:tiiame/core/services/file_service.dart';
import 'package:tiiame/core/services/firestore_service.dart';
import 'package:tiiame/core/services/storaga_service.dart';
import 'package:tiiame/core/toasts/error_toast.dart';
import 'package:tiiame/data/model/student.dart';
import 'package:tiiame/data/services/auth_service.dart';

class HomePageController extends ChangeNotifier {
  HomePageController({
    FirestoreService? firestoreService,
    FileService? fileService,
    AuthService? authService,
  }) : _firestoreService = firestoreService ?? FirestoreService(),
       _fileService = fileService ?? FileService(),
       _authService = authService ?? AuthService();

  final FirestoreService _firestoreService;
  final FileService _fileService;
  final AuthService _authService;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController homeController = TextEditingController();

  StudentData? studentData;
  String? editingField;
  PlatformFile? pendingProfileFile;
  PlatformFile? pendingPassportFile;

  bool isPageLoading = true;
  bool isFieldSaving = false;
  bool isProfileSaving = false;
  bool isPassportSaving = false;
  bool isEditingProfile = false;
  bool isEditingPassport = false;

  Future<void> loadProfile() async {
    isPageLoading = true;
    notifyListeners();

    try {
      studentData = await _firestoreService.getCurrentStudentProfile();
      _syncControllers(studentData);
    } catch (_) {
      showErrorToast('Profil ma\'lumotlarini yuklab bo\'lmadi');
    } finally {
      isPageLoading = false;
      notifyListeners();
    }
  }

  void _syncControllers(StudentData? data) {
    firstNameController.text = data?.firstName ?? '';
    lastNameController.text = data?.lastName ?? '';
    phoneController.text = data?.phoneNumber?.replaceFirst("+998-", "") ?? '';
    gradeController.text = data?.grade?.toString() ?? '';
    schoolController.text = data?.school ?? '';
    homeController.text = data?.home ?? '';
  }

  void startFieldEditing(String fieldKey) {
    _syncControllers(studentData);
    editingField = fieldKey;
    notifyListeners();
  }

  void cancelFieldEditing() {
    _syncControllers(studentData);
    editingField = null;
    notifyListeners();
  }

  Future<void> saveField(String fieldKey) async {
    if (studentData == null) return;

    final grade = int.tryParse(gradeController.text.trim());
    if (fieldKey == 'grade' && grade == null) {
      showErrorToast('Sinf raqami noto\'g\'ri');
      return;
    }

    StudentData next = studentData!;
    if (fieldKey == 'firstName') {
      next = next.copyWith(firstName: firstNameController.text.trim());
    } else if (fieldKey == 'lastName') {
      next = next.copyWith(lastName: lastNameController.text.trim());
    } else if (fieldKey == 'grade') {
      next = next.copyWith(grade: grade);
    } else if (fieldKey == 'phoneNumber') {
      next = next.copyWith(phoneNumber: "+998-${phoneController.text.trim()}");
    } else if (fieldKey == 'school') {
      next = next.copyWith(school: schoolController.text.trim());
    } else if (fieldKey == 'home') {
      next = next.copyWith(home: homeController.text.trim());
    }

    isFieldSaving = true;
    notifyListeners();

    try {
      final updated = next.copyWith(lastUpdated: DateTime.now());
      await _firestoreService.updateStudentProfile(updated);
      studentData = updated;
      editingField = null;
    } catch (_) {
      showErrorToast('Saqlashda xatolik yuz berdi');
    } finally {
      isFieldSaving = false;
      notifyListeners();
    }
  }

  Future<void> startProfileEditing() async {
    isEditingProfile = true;
    pendingProfileFile = null;
    notifyListeners();

    final picked = await _fileService.pickImage();
    if (picked != null) {
      pendingProfileFile = picked;
      notifyListeners();
    }
  }

  void cancelProfileEditing() {
    isEditingProfile = false;
    pendingProfileFile = null;
    notifyListeners();
  }

  Future<void> saveProfileFile() async {
    if (studentData == null || pendingProfileFile == null) {
      showErrorToast('Rasm tanlanmagan');
      return;
    }
    if (pendingProfileFile!.bytes == null) {
      showErrorToast('Rasm o\'qilmadi');
      return;
    }

    isProfileSaving = true;
    notifyListeners();

    try {
      final extension = p
          .extension(pendingProfileFile!.name)
          .replaceAll('.', '');
      final fileName =
          '${studentData!.firstName ?? 'student'}_${studentData!.lastName ?? 'profile'}_${studentData!.uid}_profile.$extension';

      final url = await DriveStorageService.uploadFile(
        folder: 'class${studentData!.grade ?? 'unknown'}',
        fileName: fileName,
        bytes: pendingProfileFile!.bytes!,
        mimeType: lookupMimeType(pendingProfileFile!.name) ?? 'image/jpeg',
      );

      if (url == null) {
        showErrorToast('Rasm yuklashda xatolik');
        return;
      }

      final updated = studentData!.copyWith(
        photoUrl: url,
        lastUpdated: DateTime.now(),
      );

      await _firestoreService.updateStudentProfile(updated);
      studentData = updated;
      isEditingProfile = false;
      pendingProfileFile = null;
    } catch (_) {
      showErrorToast('Rasm saqlashda xatolik yuz berdi');
    } finally {
      isProfileSaving = false;
      notifyListeners();
    }
  }

  Future<void> startPassportEditing() async {
    isEditingPassport = true;
    pendingPassportFile = null;
    notifyListeners();

    final picked = await _fileService.pickFile();
    if (picked != null) {
      pendingPassportFile = picked;
      notifyListeners();
    }
  }

  void cancelPassportEditing() {
    isEditingPassport = false;
    pendingPassportFile = null;
    notifyListeners();
  }

  Future<void> savePassportFile() async {
    if (studentData == null || pendingPassportFile == null) {
      showErrorToast('Fayl tanlanmagan');
      return;
    }
    if (pendingPassportFile!.bytes == null) {
      showErrorToast('Fayl o\'qilmadi');
      return;
    }

    isPassportSaving = true;
    notifyListeners();

    try {
      final extension = p
          .extension(pendingPassportFile!.name)
          .replaceAll('.', '');
      final fileName =
          '${studentData!.firstName ?? 'student'}_${studentData!.lastName ?? 'passport'}_${studentData!.uid}_idcard.$extension';

      final url = await DriveStorageService.uploadFile(
        folder: 'class${studentData!.grade ?? 'unknown'}',
        fileName: fileName,
        bytes: pendingPassportFile!.bytes!,
        mimeType:
            lookupMimeType(pendingPassportFile!.name) ??
            'application/octet-stream',
      );

      if (url == null) {
        showErrorToast('Fayl yuklashda xatolik');
        return;
      }

      final updated = studentData!.copyWith(
        passportUrl: url,
        lastUpdated: DateTime.now(),
      );

      await _firestoreService.updateStudentProfile(updated);
      studentData = updated;
      isEditingPassport = false;
      pendingPassportFile = null;
    } catch (_) {
      showErrorToast('Fayl saqlashda xatolik yuz berdi');
    } finally {
      isPassportSaving = false;
      notifyListeners();
    }
  }

  Future<void> signOut() => _authService.signOut();

  String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    }
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String fileNameFromUrl(String? url) {
    if (url == null || url.isEmpty) return 'Fayl yuklanmagan';
    try {
      final path = Uri.decodeFull(Uri.parse(url).path);
      final name = p.basename(path);
      return name.isEmpty ? 'Fayl' : name;
    } catch (_) {
      return 'Fayl';
    }
  }

  bool isPdf(String fileNameOrUrl) {
    return fileNameOrUrl.toLowerCase().endsWith('.pdf');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    gradeController.dispose();
    schoolController.dispose();
    homeController.dispose();
    super.dispose();
  }
}
