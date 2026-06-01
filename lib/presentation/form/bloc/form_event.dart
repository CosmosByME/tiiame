part of 'form_bloc.dart';

sealed class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

final class GradeChanged extends FormEvent {
  final int grade;
  const GradeChanged(this.grade);

  @override
  List<Object> get props => [grade];
}

final class NameSurnameChanged extends FormEvent {
  final String name;
  final String surname;
  const NameSurnameChanged({required this.name, required this.surname});

  @override
  List<Object> get props => [name, surname];
}

final class SchoolChanged extends FormEvent {
  final String school;
  const SchoolChanged(this.school);

  @override
  List<Object> get props => [school];
}

final class HomeChanged extends FormEvent {
  final String home;
  const HomeChanged(this.home);

  @override
  List<Object> get props => [home];
}

final class PhoneNumberChanged extends FormEvent {
  final String phoneNumber;
  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

final class PictureChanged extends FormEvent {
  final PlatformFile pictureUrl;
  const PictureChanged(this.pictureUrl);

  @override
  List<Object> get props => [pictureUrl];
}

final class IdCardChanged extends FormEvent {
  final PlatformFile idCardUrl;
  const IdCardChanged(this.idCardUrl);

  @override
  List<Object> get props => [idCardUrl];
}

final class FormSubmitted extends FormEvent {}
