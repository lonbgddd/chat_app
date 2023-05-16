import 'package:chat_app/config/data.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CallDataProvider extends ChangeNotifier {
  User? _userFormFirebase(User? user) {
    if (user == null) {
      return null;
    } else {
      return user;
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
      await HelpersFunctions.saveIdUserSharedPreference(credential.user!.uid);
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
    return await FirebaseAuth.instance.signOut();
  }

  Future<String?> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user!;
      if (user != null) {
        await DatabaseServices(user.uid)
            .saveUserByEmailAndName(email, "", user.uid, name);
        return 'success';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      }
      if (e.code == 'email-already-in-use') {
        return 'email-already-in-use';
      } else {
        return 'success';
      }
    } catch (e) {
      print(e);
    }
  }
}
