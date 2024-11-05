import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/domain/entities/local_user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.profilePic,
    super.bio,
    super.groupId,
    super.enrolledCourseId,
    super.following,
    super.followers,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
        );

  LocalUserModel copyWith({
    String? uid,
    String? email,
    int? points,
    String? fullName,
    String? profilePic,
    String? bio,
    List<String>? groupId,
    List<String>? enrolledCourseId,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      groupId: groupId ?? this.groupId,
      enrolledCourseId: enrolledCourseId ?? this.enrolledCourseId,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['fullName'] as String,
          points: (map['points'] as num).toInt(),
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          groupId: (map['groupId'] as List<dynamic>).cast<String>(),
          enrolledCourseId:
              (map['enrolledCourseId'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
        );

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'points': points,
      'profilePic': profilePic,
      'bio': bio,
      'groupId': groupId,
      'enrolledCourseId': enrolledCourseId,
      'followers': followers,
      'following': following,
    };
  }
}
