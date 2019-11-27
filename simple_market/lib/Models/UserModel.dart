import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  Future<FirebaseUser> signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onFail,
      @required VoidCallback onSuccess}) async {
    isLoading = true;
    notifyListeners();
    await _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((value) async {
      firebaseUser = value;
      await _saveUserCompletly(userData);
      onSuccess();
      isLoading=false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 4));

    isLoading = false;
    notifyListeners();
  }

  Future<Null> _saveUserCompletly(Map<String, dynamic> userData) async {
    print(Firestore.instance);
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }
}
