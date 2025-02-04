import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_landing_course/core/common/widgets/gradient_background.dart';
import 'package:job_landing_course/core/common/widgets/rounded_button.dart';
import 'package:job_landing_course/core/extensions/context_extension.dart';
import 'package:job_landing_course/core/res/fonts.dart';
import 'package:job_landing_course/core/res/media_res.dart';
import 'package:job_landing_course/core/utils/core_utils.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';
import 'package:job_landing_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:job_landing_course/features/auth/presentation/pages/sign_up.dart';
import 'package:job_landing_course/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:job_landing_course/features/dashboard/presentation/pages/dashboard.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static const routeName = '/sign-in';
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.userProvider.initUser(state.userData as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.authGradientBackground,
            child: SafeArea(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const Text(
                      'Easy to learn, discover more skills.',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: Fonts.aeonik,
                        fontSize: 32,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Baseline(
                          baselineType: TextBaseline.alphabetic,
                          baseline: 100,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                SignUp.routeName,
                              );
                            },
                            child: const Text('Register account?'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SignInForm(
                      emailController: emailC,
                      passwordController: passC,
                      formKey: formKey,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RoundedButton(
                            label: 'Sign in',
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              FirebaseAuth.instance.currentUser?.reload();
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignInEvent(
                                        email: emailC.text.trim(),
                                        password: passC.text.trim(),
                                      ),
                                    );
                              }
                            },
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
