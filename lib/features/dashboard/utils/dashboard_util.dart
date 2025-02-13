import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_landing_course/core/services/injector_container.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';

class DashboardUtil {
  DashboardUtil._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map(
        (event) => LocalUserModel.fromMap(event.data()!),
      );
}
