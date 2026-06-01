class StudentData {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? school;
  final String? photoUrl;
  final String? passportUrl;
  final String? grade;
  final DateTime? lastUpdated;

  StudentData({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.school,
    this.photoUrl,
    this.passportUrl,
    this.grade,
    this.lastUpdated,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      school: json['school'] as String?,
      photoUrl: json['photoUrl'] as String?,
      passportUrl: json['passportUrl'] as String?,
      grade: json['grade'] as String?,
      lastUpdated: DateTime.tryParse(json['lastUpdated'] as String? ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastUpdated': lastUpdated?.toIso8601String(),
      'grade': grade,
      'firstName': firstName,
      'lastName': lastName,
      'school': school,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'passportUrl': passportUrl,
    };
  }

  StudentData copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? school,
    String? photoUrl,
    String? passportUrl,
    String? grade,
    DateTime? lastUpdated,
  }) {
    return StudentData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      school: school ?? this.school,
      photoUrl: photoUrl ?? this.photoUrl,
      passportUrl: passportUrl ?? this.passportUrl,
      grade: grade ?? this.grade,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
