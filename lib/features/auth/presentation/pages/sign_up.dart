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
import 'package:job_landing_course/features/auth/presentation/pages/sign_in.dart';
import 'package:job_landing_course/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:job_landing_course/features/dashboard/presentation/pages/dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = 'sign-up';
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailC = TextEditingController();
  final fullNameC = TextEditingController();
  final passC = TextEditingController();
  final passConfirmC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    fullNameC.dispose();
    passC.dispose();
    passConfirmC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedUp) {
            context.read<AuthBloc>().add(
                  SignInEvent(
                    email: emailC.text.trim(),
                    password: passC.text.trim(),
                  ),
                );
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
                    const Text(
                      'Sign up for an account',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            SignIn.routeName,
                          );
                        },
                        child: const Text('Already have an account?'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SignUpForm(
                      emailController: emailC,
                      passwordController: passC,
                      formKey: formKey,
                      fullNameController: fullNameC,
                      confirmPasswordController: passConfirmC,
                    ),
                    const SizedBox(height: 30),
                    state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RoundedButton(
                            label: 'Sign up',
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              FirebaseAuth.instance.currentUser?.reload();
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignUpEvent(
                                        email: emailC.text.trim(),
                                        fullName: fullNameC.text.trim(),
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
