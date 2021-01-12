import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emag_clone/src/models/auth/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class AuthApi {
  AuthApi({@required FirebaseAuth auth, @required FirebaseFirestore firestore})
      : assert(auth != null),
        assert(firestore != null),
        _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<AppUser> login({@required String email, @required String password}) async {
    final UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

    final DocumentSnapshot snapshot = await _firestore.doc('user/${result.user.uid}').get();

    snapshot.data();

    return AppUser.fromJson(snapshot.data());
  }
}
