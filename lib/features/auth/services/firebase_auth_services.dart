import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopsyncseller/features/auth/model/user_model.dart';
import 'package:shopsyncseller/features/auth/services/shared_preferences_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SharedPrefService _sharedPrefService = SharedPrefService();

  Future<void> signUpUser(UserModel userModel, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      userModel.uid = userCredential.user!.uid;

      await _firestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(userModel.uid)
          .collection('credentials')
          .doc(userModel.uid)
          .set(userModel.toMap());
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Failed to sign up: $e';
    }
  }

  Future<UserModel?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(userCredential.user!.uid)
          .collection('credentials')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Login failed: $e';
    }
  }

  Future<UserModel> fetchUser() async {
    try {
      String? uid = await _sharedPrefService.getUid();

      if (uid == null) throw "User is not logged in.";

      DocumentSnapshot userDoc = await _firestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('credentials')
          .doc(uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        throw "User not found.";
      }
    } catch (e) {
      throw "Failed to fetch user: $e";
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else {
        throw e.code;
      }
    }
  }

  Future<void> loggingOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw 'Failed to sign out: $e';
    }
  }
}
