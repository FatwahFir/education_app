import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_landing_course/core/common/views/page_under_construction.dart';
import 'package:job_landing_course/core/extensions/context_extension.dart';
import 'package:job_landing_course/core/services/injector_container.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';
import 'package:job_landing_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:job_landing_course/features/auth/presentation/pages/sign_in.dart';
import 'package:job_landing_course/features/auth/presentation/pages/sign_up.dart';
import 'package:job_landing_course/features/dashboard/views/dashboard_view.dart';
import 'package:job_landing_course/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:job_landing_course/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:job_landing_course/features/on_boarding/presentation/pages/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'router.main.dart';
