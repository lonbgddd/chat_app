import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CallDataProvider extends ChangeNotifier {
  User? _userFormFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return user;
    }
  }

  Future<bool> loginWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = FirebaseAuth.instance.currentUser;

    QuerySnapshot dataUserSave = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get();

    if (dataUserSave.docs.isNotEmpty) {
      await HelpersFunctions.saveIdUserSharedPreference(user.uid);
      final token =
      await HelpersFunctions().getUserTokenSharedPreference() as String;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'token': token});
      return true;
    } else {
      return false;
    }
  }


  Future<void> confirmProfile(String gender, String birthday,
      List<String> interests, String biography) async {
    User? user = FirebaseAuth.instance.currentUser;
    final token =
        await HelpersFunctions().getUserTokenSharedPreference() as String;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'avatar': user.photoURL,
        'email': user.email,
        'fullName': user.displayName,
        'post': [],
        'status': 'online',
        'token': token,
        'gender': gender,
        'biography': biography,
        'uid': user.uid,
        'interests': interests,
        'birthday': birthday,
      });
      await HelpersFunctions.saveIdUserSharedPreference(user.uid);
    }
  }

  Stream<User?>? get user {
    return FirebaseAuth.instance.authStateChanges().map(_userFormFirebase);
  }

  Future<String?> loginWithEmailAndPass(String email, String password) async {
    String? key = 'success';
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _userFormFirebase(credential.user);
      QuerySnapshot dataUserSave = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: credential.user!.uid)
          .get();
      print(dataUserSave.docs.single['email']);
      await HelpersFunctions.saveIdUserSharedPreference(credential.user!.uid);
      await HelpersFunctions.saveNameUserSharedPreference(
          dataUserSave.docs.single['name']);
      await HelpersFunctions.saveAvatarUserSharedPreference(
          dataUserSave.docs.single['avatar']);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        key = 'user-not-found';
      }
      if (e.code == 'wrong-password') {
        // setKeyValue = 'wrong-password';
        key = 'wrong-password';
        print('Wrong password provided for that user.');
      } else {
        key = 'success';
      }
    }
    return key;
  }

  Future<void> signOut() async {
    await HelpersFunctions.saveIdUserSharedPreference('');
    _userFormFirebase(null);
    await GoogleSignIn().signOut();
    return await FirebaseAuth.instance.signOut();
  }

// Future<String?> signUpWithEmailAndPassword(String email, String password,
//     String name, String sex, String year,String biography) async {
//   try {
//     User user = (await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(email: email, password: password))
//         .user!;
//     if (user != null) {
//       await DatabaseServices(user.uid)
//           .saveUserByEmailAndName(email, "", user.uid, name, sex, year,biography);
//       return 'success';
//     }
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     }
//     if (e.code == 'email-already-in-use') {
//       return 'email-already-in-use';
//     } else {
//       return 'success';
//     }
//   } catch (e) {
//     print(e);
//   }
// }
}
