import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultancy_app/Models/users.dart';
import 'package:consultancy_app/Screens/auth/landing_page.dart';
import 'package:consultancy_app/Widgets/custom_toast.dart';
import 'package:consultancy_app/consts/collections.dart';
import 'package:consultancy_app/database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    // UserLocalData().logOut();
  }

  Future logIn({
    required String email,
    required final String password,
  }) async {
    print("here");
    try {
      // final UserCredential result =
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(" auth service login: $value");
        print(" auth service login uid: ${value.user!.uid}");

        // return value.user!.uid;
        DatabaseMethods()
            .fetchUserInfoFromFirebase(uid: value.user!.uid)
            .then((value) => Get.off(() => LandingPage()));
      });
      // return result.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        CustomToast.errorToast(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future deleteUser(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      User user = _firebaseAuth.currentUser!;
      AuthCredential credentials =
          EmailAuthProvider.credential(email: email, password: password);
      print(user);
      UserCredential result =
          await user.reauthenticateWithCredential(credentials);
      userRef.doc(user.uid).delete();

      await result.user!.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signinWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (googleAccount != null) {
      print('here');
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          String date = DateTime.now().toString();
          DateTime dateparse = DateTime.parse(date);
          String formattedDate =
              '${dateparse.day}-${dateparse.month}-${dateparse.year}';
          final UserCredential authResult = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          DocumentSnapshot doc = await userRef.doc(authResult.user!.uid).get();
          print(doc.exists);
          if (doc.exists) {
            currentUser = AppUserModel.fromDocument(doc);
            // final bool _isOkay = await UserAPI().addUser(currentUser!);

            return true;
          } else {
            final AppUserModel _appUser = AppUserModel(
              id: authResult.user!.uid,
              name: authResult.user!.displayName,
              email: authResult.user!.email,
              phoneNo: "",
              androidNotificationToken: "",
              imageUrl: authResult.user!.photoURL,
              password: "",
              subscriptionEndTIme: DateTime.now().toIso8601String(),
              isAdmin: false,
            );
            final bool _isOkay = await DatabaseMethods().addUser(_appUser);
            if (_isOkay) {
              currentUser = _appUser;
              return true;

              // UserLocalData().storeAppUserData(appUser: _appUser);
            } else {
              return false;
            }
          }
        } catch (error) {
          CustomToast.errorToast(message: error.toString());
        }
      }
    }
    return false;
  }

  Future<UserCredential?> signUp({
    required final String password,
    required final String? name,
    required final String? joinedAt,
    required final String? imageUrl,
    required final Timestamp? createdAt,
    required final String email,
    required final int phoneNo,
    final bool? isAdmin,
  }) async {
    print("1st stop");

    try {
      final UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((Object obj) {
        CustomToast.errorToast(message: obj.toString());
      });
      final UserCredential user = result;
      assert(user != null);
      assert(await user.user!.getIdToken() != null);
      if (user != null) {
        await DatabaseMethods().addUserInfoToFirebase(
            password: password,
            name: name,
            createdAt: createdAt,
            email: email,
            joinedAt: joinedAt,
            userId: user.user!.uid,
            phoneNo: phoneNo,
            imageUrl: imageUrl,
            isAdmin: false);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      CustomToast.errorToast(message: "$e.message");
    }
  }
}
