import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/data/datasources/auth_remote_data_src.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;

  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;
  User? _user;

  @override
  User? get user => _user;

  set user(User? value) {
    if (_user != value) _user = value;
  }
}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late FirebaseStorage dbClient;
  late AuthRemoteDataSrc dataSrc;
  late UserCredential userCredential;
  late MockUser mockUser;
  late DocumentReference<DataMap> documentReference;

  const tUser = LocalUserModel.empty();

  setUpAll(() async {
    authClient = MockFirebaseAuth();
    cloudStoreClient = FakeFirebaseFirestore();
    documentReference = cloudStoreClient.collection('users').doc();
    await documentReference.set(
      tUser.copyWith(uid: documentReference.id).toMap(),
    );
    dbClient = MockFirebaseStorage();
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    dataSrc = AuthRemoteDataSrcImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );

    when(() => authClient.currentUser).thenReturn(mockUser);
  });

  const tPassword = 'Test password';
  // const tFullName = 'Test full name';
  const tEmail = 'testmail@mail.org';

  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user-not-found',
    message: "There is no user record corresponding to this identifier",
  );

  group(
    "forgotPassword",
    () {
      test(
        "Should complete successfully when no [Exception] is thrown",
        () async {
          when(
            () => authClient.sendPasswordResetEmail(
              email: any(named: "email"),
            ),
          ).thenAnswer(
            (_) => Future.value(),
          );

          final call = dataSrc.forgotPassword(tEmail);

          expect(call, completes);

          verify(
            () => authClient.sendPasswordResetEmail(email: tEmail),
          ).called(1);
          verifyNoMoreInteractions(authClient);
        },
      );

      test(
        "Should return [ServerException ] when [FirebaseAuthException] is thrown",
        () async {
          when(
            () => authClient.sendPasswordResetEmail(
              email: any(named: "email"),
            ),
          ).thenThrow(tFirebaseAuthException);

          final call = dataSrc.forgotPassword;

          expect(() => call(tEmail), throwsA(isA<ServerException>()));

          verify(
            () => authClient.sendPasswordResetEmail(email: tEmail),
          ).called(1);
          verifyNoMoreInteractions(authClient);
        },
      );
    },
  );

  group(
    'signIn',
    () {
      test(
        'Should successfully signed in with the right data',
        () async {
          when(
            () => authClient.signInWithEmailAndPassword(
              email: tEmail,
              password: tPassword,
            ),
          ).thenAnswer((_) async => userCredential);

          final result =
              await dataSrc.signIn(email: tEmail, password: tPassword);

          expect(result.uid, userCredential.user!.uid);
          verify(
            () => authClient.signInWithEmailAndPassword(
              email: tEmail,
              password: tPassword,
            ),
          ).called(1);
          verifyNoMoreInteractions(authClient);
        },
      );
    },
  );

  // setUp(() async {
  //   cloudStoreClient = FakeFirebaseFirestore();
  //   // final googleSignIn = MockGoogleSignIn();
  //   // final signInAccount = await googleSignIn.signIn();
  //   // final googleAuth = await signInAccount!.authentication;
  //   // final AuthCredential credential = GoogleAuthProvider.credential(
  //   //   accessToken: googleAuth.accessToken,
  //   //   idToken: googleAuth.idToken,
  //   // );
  //   final mockUser = MockUser(
  //     isAnonymous: false,
  //     uid: 'someuid',
  //     email: 'bob@somedomain.com',
  //     displayName: 'Bob',
  //   );
  //   authClient = MockFirebaseAuth(mockUser: mockUser, signedIn: true);

  //   // final result = await authClient.signInWithCredential(credential);
  //   // final user = result.user;

  //   dbClient = MockFirebaseStorage();

  //   dataSrc = AuthRemoteDataSrcImpl(
  //     authClient: authClient,
  //     cloudStoreClient: cloudStoreClient,
  //     dbClient: dbClient,
  //   );
  // });

  // test("SignUp", () async {
  //   await dataSrc.signUp(
  //     email: tEmail,
  //     fullName: tFullName,
  //     password: tPassword,
  //   );

  //   expect(authClient.currentUser, isNotNull);
  //   expect(authClient.currentUser!.displayName, tFullName);

  //   final user = await cloudStoreClient
  //       .collection("users")
  //       .doc(authClient.currentUser!.uid)
  //       .get();

  //   expect(user.exists, isTrue);
  // });

  // test("SignIn", () async {
  //   await dataSrc.signUp(
  //     email: "newEmail@gmail.com",
  //     fullName: tFullName,
  //     password: tPassword,
  //   );
  //   await authClient.signOut();
  //   await dataSrc.signIn(
  //     email: "newEmail@gmail.com",
  //     password: tPassword,
  //   );
  //   expect(authClient.currentUser, isNotNull);
  //   expect(authClient.currentUser!.email, "newEmail@gmail.com");
  // });

  // group("updateUser", () {
  //   test("displayName", () async {
  //     await dataSrc.signUp(
  //       email: tEmail,
  //       fullName: tFullName,
  //       password: tPassword,
  //     );

  //     await dataSrc.updateUser(
  //       action: UserActionEnum.fullName,
  //       userData: 'new name',
  //     );

  //     expect(
  //       authClient.currentUser!.displayName,
  //       equals('new name'),
  //     );
  //   });

  //   test("email", () async {
  //     await dataSrc.signUp(
  //       email: tEmail,
  //       fullName: tFullName,
  //       password: tPassword,
  //     );

  //     await dataSrc.updateUser(
  //       action: UserActionEnum.email,
  //       userData: 'newEmail@gmail.com',
  //     );

  //     expect(
  //       authClient.currentUser!.email,
  //       equals('newEmail@gmail.com'),
  //     );
  //   });
  // });
}
