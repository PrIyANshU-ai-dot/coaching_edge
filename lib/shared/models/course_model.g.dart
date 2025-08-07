// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      subject: json['subject'] as String,
      teacherId: json['teacherId'] as String,
      teacherName: json['teacherName'] as String,
      teacherImage: json['teacherImage'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      difficulty: json['difficulty'] as String,
      duration: (json['duration'] as num).toInt(),
      totalLessons: (json['totalLessons'] as num).toInt(),
      totalStudents: (json['totalStudents'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num).toDouble(),
      isFree: json['isFree'] as bool,
      isPublished: json['isPublished'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      thumbnail: json['thumbnail'] as String?,
      previewVideo: json['previewVideo'] as String?,
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      prerequisites: (json['prerequisites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      learningOutcomes: (json['learningOutcomes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'subject': instance.subject,
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'teacherImage': instance.teacherImage,
      'tags': instance.tags,
      'difficulty': instance.difficulty,
      'duration': instance.duration,
      'totalLessons': instance.totalLessons,
      'totalStudents': instance.totalStudents,
      'rating': instance.rating,
      'totalRatings': instance.totalRatings,
      'price': instance.price,
      'isFree': instance.isFree,
      'isPublished': instance.isPublished,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'thumbnail': instance.thumbnail,
      'previewVideo': instance.previewVideo,
      'lessons': instance.lessons,
      'prerequisites': instance.prerequisites,
      'learningOutcomes': instance.learningOutcomes,
      'metadata': instance.metadata,
    };

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      duration: (json['duration'] as num).toInt(),
      videoUrl: json['videoUrl'] as String,
      thumbnail: json['thumbnail'] as String?,
      isFree: json['isFree'] as bool,
      order: (json['order'] as num).toInt(),
      resources: (json['resources'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration,
      'videoUrl': instance.videoUrl,
      'thumbnail': instance.thumbnail,
      'isFree': instance.isFree,
      'order': instance.order,
      'resources': instance.resources,
      'metadata': instance.metadata,
    };
