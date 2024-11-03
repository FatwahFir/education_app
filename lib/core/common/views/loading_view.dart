import 'package:flutter/material.dart';
import 'package:job_landing_course/core/extensions/context_extension.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            context.theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
