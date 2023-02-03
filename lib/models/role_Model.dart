import 'package:cloud_firestore/cloud_firestore.dart';

class Role {
  final String uid;
  final String role;

  const Role({
    required this.uid,
    required this.role,
  });

  Map<String, dynamic> toJSON() => {
        "uid": uid,
        "role": role,
      };

  static Role fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return Role(uid: snapShot['uid'], role: snapShot['role']);
  }
}
