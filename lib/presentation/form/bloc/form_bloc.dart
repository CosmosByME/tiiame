import 'package:mime/mime.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:tiiame/core/services/storaga_service.dart';
import 'package:tiiame/data/model/student.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState(studentData: StudentData(), isLoading: false, isSuccess: false)) {
    on<GradeChanged>(onGradeChanged);
    on<NameSurnameChanged>(onNameSurnameChanged);
    on<SchoolChanged>(onSchoolChanged);
    on<HomeChanged>(onHomeChanged);
    on<PhoneNumberChanged>(onPhoneNumberChanged);
    on<PictureChanged>(onPictureChanged);
    on<IdCardChanged>(onIdCardChanged);
  }

  void onGradeChanged(GradeChanged event, Emitter<FormState> emit) {
    emit(FormState(studentData: state.studentData!.copyWith(grade: event.grade)));
  }

  void onNameSurnameChanged(NameSurnameChanged event, Emitter<FormState> emit) {
    emit(FormState(studentData: state.studentData!.copyWith(firstName: event.name, lastName: event.surname)));
  }

  void onSchoolChanged(SchoolChanged event, Emitter<FormState> emit) {
    emit(FormState(studentData: state.studentData!.copyWith(school: event.school)));
  }

  void onHomeChanged(HomeChanged event, Emitter<FormState> emit) {
    emit(FormState(studentData: state.studentData!.copyWith(home: event.home)));
  }

  void onPhoneNumberChanged(PhoneNumberChanged event, Emitter<FormState> emit) {
    emit(FormState(studentData: state.studentData!.copyWith(phoneNumber: event.phoneNumber)));
    debugPrint("${state.studentData!.toJson()}");
  }

  void onPictureChanged(PictureChanged event, Emitter<FormState> emit) async {
  try {
    emit(FormState(studentData: state.studentData, isLoading: true));

    final url = await DriveStorageService.uploadFile(
      folder:   "class${state.studentData!.grade}",
      fileName: "${state.studentData!.firstName}_${state.studentData!.lastName}_profile.${event.pictureUrl.name.split('.').last}",
      bytes:    event.pictureUrl.bytes!,
      mimeType: lookupMimeType(event.pictureUrl.name) ?? "image/jpeg",
    );

    emit(FormState(
      studentData: state.studentData!.copyWith(photoUrl: url),
      isUploaded: true,
      isLoading: false,
    ));

    await Future.delayed(const Duration(seconds: 1));
    emit(FormState(studentData: state.studentData, isUploaded: false));

    debugPrint("${state.studentData!.toJson()}");

  } on Exception catch (e) {
    debugPrint(e.toString());
    emit(FormState(studentData: state.studentData, isLoading: false));
  }

}

void onIdCardChanged(IdCardChanged event, Emitter<FormState> emit) async {
  try {
    emit(FormState(studentData: state.studentData, isLoading: true));

    final url = await DriveStorageService.uploadFile(
      folder:   "class${state.studentData!.grade}",
      fileName: "${state.studentData!.firstName}_${state.studentData!.lastName}_idcard.${event.idCardUrl.name.split('.').last}",
      bytes:    event.idCardUrl.bytes!,
      mimeType: lookupMimeType(event.idCardUrl.name) ?? "image/jpeg",
    );

    emit(FormState(
      studentData: state.studentData!.copyWith(passportUrl: url),
      isUploaded: true,
      isLoading: false,
    ));

    await Future.delayed(const Duration(seconds: 1));
    emit(FormState(studentData: state.studentData, isUploaded: false));

    debugPrint("${state.studentData!.toJson()}");

  } on Exception catch (e) {
    debugPrint(e.toString());
    emit(FormState(studentData: state.studentData, isLoading: false));
  }
}
}
