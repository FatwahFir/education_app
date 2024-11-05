import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseId;
  final List<String> following;
  final List<String> followers;

  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.profilePic,
    this.bio,
    this.groupId = const [],
    this.enrolledCourseId = const [],
    this.following = const [],
    this.followers = const [],
  });

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          profilePic: '',
          points: 0,
          bio: '',
          fullName: '',
          groupId: const [],
          enrolledCourseId: const [],
          followers: const [],
          following: const [],
        );

  @override
  String toString() {
    return 'LocalUser(uid: $uid, email: $email, fullName: $fullName, points: $points)';
  }

  @override
  List<Object?> get props => [uid, email];
}
