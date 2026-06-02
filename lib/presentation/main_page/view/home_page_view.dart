import 'package:flutter/material.dart';
import 'package:tiiame/core/widgets/custom_elevated_button.dart';
import 'package:tiiame/core/widgets/custom_outlined_button.dart';
import 'package:tiiame/core/widgets/custom_text_field.dart';
import 'package:tiiame/core/widgets/phone_number_field.dart';
import 'package:tiiame/presentation/main_page/logic/home_page_controller.dart';
import 'package:tiiame/presentation/main_page/view/widgets/launchable_file_tile.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key, required this.controller});

  final HomePageController controller;

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Tasdiqlash'),
          content: const Text('Rostdan ham akkauntdan chiqmoqchimisiz?'),
          actions: [
            CustomOutlinedButton(
              width: 110,
              text: 'Bekor qilish',
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            const SizedBox(height: 8),
            CustomElevatedButton(
              width: 110,
              text: 'Chiqish',
              isLoading: false,
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await controller.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background/photo1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 20,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: controller.isPageLoading
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 40),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Talaba profili',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.headlineSmall,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            _confirmLogout(context),
                                        tooltip: 'Logout',
                                        icon: const Icon(Icons.logout_rounded),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  _EditableStudentField(
                                    title: 'Ism',
                                    fieldKey: 'firstName',
                                    controller: controller.firstNameController,
                                    logic: controller,
                                  ),
                                  const SizedBox(height: 12),
                                  _EditableStudentField(
                                    title: 'Familiya',
                                    fieldKey: 'lastName',
                                    controller: controller.lastNameController,
                                    logic: controller,
                                  ),
                                  const SizedBox(height: 12),
                                  _EditableStudentField(
                                    title: 'Sinf',
                                    fieldKey: 'grade',
                                    controller: controller.gradeController,
                                    logic: controller,
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 12),
                                  _EditableStudentField(
                                    title: 'Maktab',
                                    fieldKey: 'school',
                                    controller: controller.schoolController,
                                    logic: controller,
                                  ),
                                  const SizedBox(height: 12),
                                  _EditableStudentField(
                                    title: 'Manzil',
                                    fieldKey: 'home',
                                    controller: controller.homeController,
                                    logic: controller,
                                  ),
                                  const SizedBox(height: 12),
                                  _EditablePhoneNumberField(
                                    title: 'Telefon raqam',
                                    fieldKey: 'phoneNumber',
                                    controller: controller.phoneController,
                                    logic: controller,
                                  ),
                                  const SizedBox(height: 12),
                                  _ProfileSection(controller: controller),
                                  const SizedBox(height: 12),
                                  _PassportSection(controller: controller),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({required this.controller});

  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    final hasPending = controller.pendingProfileFile != null;
    final hasRemote = (controller.studentData?.photoUrl ?? '').isNotEmpty;
    final fileSize = hasPending
        ? controller.formatFileSize(controller.pendingProfileFile!.size)
        : hasRemote
        ? 'Serverda saqlangan'
        : 'Rasm yuklanmagan';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Profil rasmi',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              controller.isEditingProfile
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomOutlinedButton(
                          width: 88,
                          text: 'Cancel',
                          onPressed: controller.cancelProfileEditing,
                        ),
                        const SizedBox(width: 8),
                        CustomElevatedButton(
                          width: 88,
                          text: 'Save',
                          isLoading: controller.isProfileSaving,
                          onPressed: controller.pendingProfileFile == null
                              ? null
                              : controller.saveProfileFile,
                        ),
                      ],
                    )
                  : IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: controller.startProfileEditing,
                    ),
            ],
          ),
          const SizedBox(height: 10),
          LaunchableFileTile(
            title: 'Profil rasmi',
            fileName:
                "${controller.studentData?.firstName ?? 'student'}_${controller.studentData?.lastName ?? 'profile'}_profile.jpg",
            fileSizeLabel: fileSize,
            fileTypeLabel: _fileTypeLabel("jpg"),
            icon: _fileIcon(".jpg"),
            url: hasPending ? null : controller.studentData?.photoUrl,
          ),
          if (controller.isEditingProfile) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: controller.startProfileEditing,
              child: const Text(
                'Rasm tanlash',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PassportSection extends StatelessWidget {
  const _PassportSection({required this.controller});

  final HomePageController controller;

  @override
  Widget build(BuildContext context) {
    final pendingName = controller.pendingPassportFile?.name;
    final remoteName = controller.fileNameFromUrl(
      controller.studentData?.passportUrl,
    );
    final viewName = pendingName ?? remoteName;
    final fileSizeLabel = controller.pendingPassportFile != null
        ? controller.formatFileSize(controller.pendingPassportFile!.size)
        : (controller.studentData?.passportUrl?.isNotEmpty ?? false)
        ? 'Serverda saqlangan'
        : 'Fayl yuklanmagan';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Passport',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              controller.isEditingPassport
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomOutlinedButton(
                          width: 88,
                          text: 'Cancel',
                          onPressed: controller.cancelPassportEditing,
                        ),
                        const SizedBox(width: 8),
                        CustomElevatedButton(
                          width: 88,
                          text: 'Save',
                          isLoading: controller.isPassportSaving,
                          onPressed: controller.pendingPassportFile == null
                              ? null
                              : controller.savePassportFile,
                        ),
                      ],
                    )
                  : IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: controller.startPassportEditing,
                    ),
            ],
          ),
          const SizedBox(height: 8),
          LaunchableFileTile(
            title: 'Passport',
            fileName:
                "${controller.studentData?.firstName ?? 'student'}_${controller.studentData?.lastName ?? 'passport'}_${controller.studentData?.uid}_idcard.pdf",
            fileSizeLabel: fileSizeLabel,
            fileTypeLabel: _fileTypeLabel("pdf"),
            icon: _fileIcon(".pdf"),
            url: controller.pendingPassportFile == null
                ? controller.studentData?.passportUrl
                : null,
          ),
          if (controller.isEditingPassport) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: controller.startPassportEditing,
              child: const Text(
                'Fayl tanlash',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

String _fileTypeLabel(String name) {
  final extension = name.split('.').last.toUpperCase();
  if (name == 'Fayl yuklanmagan' || name == 'Rasm yuklanmagan') {
    return 'FILE';
  }
  return extension.isEmpty ? 'FILE' : extension;
}

IconData _fileIcon(String name) {
  final extension = name.split('.').last.toLowerCase();
  switch (extension) {
    case 'pdf':
      return Icons.picture_as_pdf_rounded;
    case 'jpg':
    case 'jpeg':
    case 'png':
    case 'webp':
      return Icons.image_outlined;
    default:
      return Icons.insert_drive_file_rounded;
  }
}

class _EditableStudentField extends StatelessWidget {
  const _EditableStudentField({
    required this.title,
    required this.fieldKey,
    required this.controller,
    required this.logic,
    this.keyboardType = TextInputType.text,
  });

  final String title;
  final String fieldKey;
  final TextEditingController controller;
  final HomePageController logic;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final isEditing = logic.editingField == fieldKey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              CustomTextField(
                hint: title,
                controller: controller,
                enabled: isEditing,
                keyboardType: keyboardType,
                width: double.infinity,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: isEditing
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomOutlinedButton(
                      width: 88,
                      text: 'Cancel',
                      onPressed: logic.cancelFieldEditing,
                    ),
                    const SizedBox(width: 6),
                    CustomElevatedButton(
                      width: 88,
                      text: 'Save',
                      isLoading: logic.isFieldSaving,
                      onPressed: () => logic.saveField(fieldKey),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () => logic.startFieldEditing(fieldKey),
                  icon: const Icon(Icons.edit_outlined),
                ),
        ),
      ],
    );
  }
}

class _EditablePhoneNumberField extends StatelessWidget {
  final String title;
  final String fieldKey;
  final TextEditingController controller;
  final HomePageController logic;

  const _EditablePhoneNumberField({
    required this.title,
    required this.fieldKey,
    required this.controller,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    final isEditing = logic.editingField == fieldKey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              PhoneNumberField(controller: controller),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: isEditing
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomOutlinedButton(
                      width: 88,
                      text: 'Cancel',
                      onPressed: logic.cancelFieldEditing,
                    ),
                    const SizedBox(width: 6),
                    CustomElevatedButton(
                      width: 88,
                      text: 'Save',
                      isLoading: logic.isFieldSaving,
                      onPressed: () => logic.saveField(fieldKey),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () => logic.startFieldEditing(fieldKey),
                  icon: const Icon(Icons.edit_outlined),
                ),
        ),
      ],
    );
  }
}
