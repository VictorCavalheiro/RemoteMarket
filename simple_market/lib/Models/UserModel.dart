import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadDataUser();
  }

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
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required Map<String, dynamic> userData,
      @required pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: userData["email"], password: pass)
        .then((user) async {
      firebaseUser = user;
      await _loadDataUser();
      isLoading = false;
      notifyListeners();
      onSuccess();
    }).catchError((e) {
      print(e);
      isLoading = false;
      notifyListeners();
      onFail();
    });
  }

  void signOut() {
    userData = Map();
    firebaseUser = null;
    _auth.signOut();
    notifyListeners();
  }

  bool isLoggedIn() {
    return userData["name"] != null;
  }

  Future<Null> _saveUserCompletly(Map<String, dynamic> userData) async {
    print(Firestore.instance);
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadDataUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
  }
}
