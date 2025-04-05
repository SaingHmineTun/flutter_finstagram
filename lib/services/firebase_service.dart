import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;
  Map<String, dynamic>? _currentUser;
  SharedPreferences? _sharedPreferences;

  final String USER_COLLECTION = "users";

  FirebaseService() {
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required File profileImage,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      String uid = userCredential.user!.uid;
      // TaskSnapshot snapshot = await _storage
      //     .ref(
      //       "images/$uid/${Timestamp.now().millisecondsSinceEpoch}.${path.extension(profileImage.path)}",
      //     )
      //     .putFile(profileImage);
      await _firestore.collection(USER_COLLECTION).doc(uid).set({
        "email": email,
        "name": name,
        "password": password,
        "image": "https://i.pravatar.cc/300",
      });
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        await _saveToSharedPreference(uid);
        _currentUser = await _getUserDataByUID(uid);
        print(_currentUser.toString());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>?> _getUserDataByUID(String uuid) async {
    var docSnapshot =
        await _firestore.collection(USER_COLLECTION).doc(uuid).get();
    return docSnapshot.data();
  }

  Future<void> _saveToSharedPreference(String uid) async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    _sharedPreferences!.setString("uid", uid);
  }

  Future<bool> alreadySignIn() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    String? uid = _sharedPreferences!.getString("uid");
    if (uid != null) _currentUser = await _getUserDataByUID(uid);
    if (_currentUser != null) return true;
    return false;
  }

  Future<void> logout() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    await _auth.signOut();
    _sharedPreferences!.remove("uid");
  }
}
