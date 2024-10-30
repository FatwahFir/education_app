import 'package:equatable/equatable.dart';
import 'package:job_landing_course/core/res/media_res.dart';

class PageContent extends Equatable {
  const PageContent(
      {required this.image, required this.title, required this.description});
  final String image;
  final String title;
  final String description;

  const PageContent.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Brand new curiculum',
          description:
              'This is the first onile education platform designed by the '
              "worl's top professors",
        );

  const PageContent.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Brand a fun atmosphere',
          description:
              'This is the first onile education platform designed by the '
              "worl's top professors",
        );

  const PageContent.third()
      : this(
          image: MediaRes.casualMeditationScience,
          title: 'Easy to join the lesson',
          description:
              'This is the first onile education platform designed by the '
              "worl's top professors",
        );

  @override
  List<Object?> get props => [image, title, description];
}
