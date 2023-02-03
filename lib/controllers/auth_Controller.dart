import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/admin_Model.dart' as model;
import '../models/role_Model.dart' as model;

class AuthControllers {
  //Initializing Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.Role> getRoleDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('roles').doc(currentUser.uid).get();

    return model.Role.fromSnap(snap);
  }

  //Sign Up Controller
  Future<String> signUpUser({
    required String fullName,
    required String email,
    required String age,
    required String password,
  }) async {
    String res = 'Some Error Occured';
    try {
      if (fullName.isNotEmpty ||
          email.isNotEmpty ||
          age.isNotEmpty ||
          password.isNotEmpty) {
        //Creating the User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //Add Role in the Roles Collection
        model.Role role = model.Role(uid: cred.user!.uid, role: 'Admin');
        await _firestore.collection('roles').doc(cred.user!.uid).set(
              role.toJSON(),
            );

        //Add Admin in the Admin Collection
        model.Admin admin = model.Admin(
          aId: cred.user!.uid,
          fullName: fullName,
          email: email,
          age: age,
          password: password,
        );
        await _firestore
            .collection('Admins')
            .doc(cred.user!.uid)
            .set(admin.toJSON());
      }
      res = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password is too weak';
      } else if (e.code == 'email-already-in-use') {
        res = 'User Already Exists Please try a differet Email';
      } else if (e.code == 'invalid-email') {
        res =
            'The email address you wrote is invalid. Please try a different one';
      }
    } catch (err) {
      print('Some Error Occured');
    }
    return res;
  }

  //Log In Controller
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String res = 'Something gone wrong';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No User registered with this email';
      } else if (e.code == 'wrong-password') {
        res = 'Incorrect Credentials';
      }
    } catch (err) {
      print(err.toString());
    }
    return res;
  }

  //Sign Out Controller
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
