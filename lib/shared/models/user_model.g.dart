// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      name: json['name'] as String,
      profileImage: json['profileImage'] as String?,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastLoginAt: json['lastLoginAt'] == null
          ? null
          : DateTime.parse(json['lastLoginAt'] as String),
      isActive: json['isActive'] as bool,
      isEmailVerified: json['isEmailVerified'] as bool,
      isPhoneVerified: json['isPhoneVerified'] as bool,
      grade: json['grade'] as String?,
      school: json['school'] as String?,
      enrolledCourses: (json['enrolledCourses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      courseProgress: (json['courseProgress'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      qualification: json['qualification'] as String?,
      specialization: json['specialization'] as String?,
      teachingCourses: (json['teachingCourses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalStudents: (json['totalStudents'] as num?)?.toInt() ?? 0,
      totalClasses: (json['totalClasses'] as num?)?.toInt() ?? 0,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'name': instance.name,
      'profileImage': instance.profileImage,
      'role': instance.role,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
      'isActive': instance.isActive,
      'isEmailVerified': instance.isEmailVerified,
      'isPhoneVerified': instance.isPhoneVerified,
      'grade': instance.grade,
      'school': instance.school,
      'enrolledCourses': instance.enrolledCourses,
      'courseProgress': instance.courseProgress,
      'qualification': instance.qualification,
      'specialization': instance.specialization,
      'teachingCourses': instance.teachingCourses,
      'rating': instance.rating,
      'totalStudents': instance.totalStudents,
      'totalClasses': instance.totalClasses,
      'permissions': instance.permissions,
    };
