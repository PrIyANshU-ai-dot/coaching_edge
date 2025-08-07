import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String? phoneNumber;
  final String name;
  final String? profileImage;
  final String role; // student, teacher, admin
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final bool isActive;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  
  // Student specific fields
  final String? grade;
  final String? school;
  final List<String> enrolledCourses;
  final Map<String, double> courseProgress; // courseId: progress percentage
  
  // Teacher specific fields
  final String? qualification;
  final String? specialization;
  final List<String> teachingCourses;
  final double rating;
  final int totalStudents;
  final int totalClasses;
  
  // Admin specific fields
  final List<String> permissions;
  
  UserModel({
    required this.id,
    required this.email,
    this.phoneNumber,
    required this.name,
    this.profileImage,
    required this.role,
    required this.createdAt,
    this.lastLoginAt,
    required this.isActive,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    this.grade,
    this.school,
    this.enrolledCourses = const [],
    this.courseProgress = const {},
    this.qualification,
    this.specialization,
    this.teachingCourses = const [],
    this.rating = 0.0,
    this.totalStudents = 0,
    this.totalClasses = 0,
    this.permissions = const [],
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  
  UserModel copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? name,
    String? profileImage,
    String? role,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    String? grade,
    String? school,
    List<String>? enrolledCourses,
    Map<String, double>? courseProgress,
    String? qualification,
    String? specialization,
    List<String>? teachingCourses,
    double? rating,
    int? totalStudents,
    int? totalClasses,
    List<String>? permissions,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isActive: isActive ?? this.isActive,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      grade: grade ?? this.grade,
      school: school ?? this.school,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      courseProgress: courseProgress ?? this.courseProgress,
      qualification: qualification ?? this.qualification,
      specialization: specialization ?? this.specialization,
      teachingCourses: teachingCourses ?? this.teachingCourses,
      rating: rating ?? this.rating,
      totalStudents: totalStudents ?? this.totalStudents,
      totalClasses: totalClasses ?? this.totalClasses,
      permissions: permissions ?? this.permissions,
    );
  }
  
  bool get isStudent => role == 'student';
  bool get isTeacher => role == 'teacher';
  bool get isAdmin => role == 'admin';
  
  bool get isVerified => isEmailVerified && (phoneNumber == null || isPhoneVerified);
} 