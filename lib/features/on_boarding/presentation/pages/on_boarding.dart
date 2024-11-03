import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_landing_course/core/common/views/loading_view.dart';
import 'package:job_landing_course/core/common/widgets/gradient_background.dart';
import 'package:job_landing_course/core/res/colors.dart';
import 'package:job_landing_course/core/res/media_res.dart';
import 'package:job_landing_course/features/on_boarding/domain/entities/page_content.dart';
import 'package:job_landing_course/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:job_landing_course/features/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  static const routeName = '/';

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserFirstTimer ||
                state is CachingFirstTimer) {
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(
                      pageContent: PageContent.first(),
                    ),
                    OnBoardingBody(
                      pageContent: PageContent.second(),
                    ),
                    OnBoardingBody(
                      pageContent: PageContent.third(),
                    ),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, 0.04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColor,
                      dotColor: Colors.white,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
