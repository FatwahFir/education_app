import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:job_landing_course/core/common/widgets/my_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.fullNameController,
    required this.confirmPasswordController,
  });

  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isObscure = true;
  bool isObscureConfirm = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          MyField(
            controller: widget.fullNameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 25),
          MyField(
            controller: widget.emailController,
            hintText: 'Email Address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 25),
          MyField(
            controller: widget.passwordController,
            hintText: 'Password',
            obscureText: isObscure,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              icon: Icon(
                isObscure ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 25),
          MyField(
            controller: widget.confirmPasswordController,
            hintText: 'Confirm password',
            obscureText: isObscureConfirm,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscureConfirm = !isObscureConfirm;
                });
              },
              icon: Icon(
                isObscureConfirm ? IconlyLight.show : IconlyLight.hide,
                color: Colors.grey,
              ),
            ),
            overrideValidator: true,
            validator: (value) {
              if (value != widget.passwordController.text) {
                return 'Password do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
