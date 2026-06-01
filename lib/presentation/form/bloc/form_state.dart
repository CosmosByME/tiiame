part of 'form_bloc.dart';

class FormState extends Equatable {
  final StudentData? studentData;
  final bool isLoading;
  final bool isSuccess;
  final bool isUploaded;
  const FormState({this.studentData, this.isLoading = false, this.isSuccess = false, this.isUploaded = false});


    FormState copyWith({
      StudentData? studentData,
      bool? isLoading,
      bool? isSuccess,
      bool? isUploaded,
    }) {
      return FormState(
        studentData: studentData ?? this.studentData,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        isUploaded: isUploaded ?? this.isUploaded,
      );
    }
  
  @override
  List<Object?> get props => [studentData, isLoading, isSuccess, isUploaded];
}

