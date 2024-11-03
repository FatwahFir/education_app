import 'package:flutter/material.dart';
import 'package:job_landing_course/core/extensions/context_extension.dart';
import 'package:job_landing_course/core/res/colors.dart';
import 'package:job_landing_course/core/res/fonts.dart';
import 'package:job_landing_course/features/on_boarding/domain/entities/page_content.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key, required this.pageContent});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pageContent.image,
          height: context.height * .4,
        ),
        SizedBox(
          height: context.height * .03,
        ),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.aeonik,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: context.height * .02,
              ),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.height * .05,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 17,
            ),
            backgroundColor: Colours.primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            //TODO(Get-Started): Implements this functionality
            //Cache user
            //Push them to the appropriate screen
          },
          child: const Text(
            'Get Started',
            style: TextStyle(
              fontFamily: Fonts.aeonik,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
