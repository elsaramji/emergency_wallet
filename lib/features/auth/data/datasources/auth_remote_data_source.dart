import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithGoogle();

  Future<void> logout();

  Future<void> forgotPassword({required String email});

  Future<UserModel?> getAuthenticatedUser();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(
    this._firebaseAuth,
    this._firestore,
    this._googleSignIn,
  );

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _getUserData(userCredential.user!);
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _createOrUpdateUserData(userCredential.user!, 'email', name);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign in failed');
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _createOrUpdateUserData(
      userCredential.user!,
      'google',
      userCredential.user!.displayName ?? 'User',
    );
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserModel?> getAuthenticatedUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return _getUserData(user);
    }
    return null;
  }

  Future<UserModel> _getUserData(User user) async {
    final rootDoc = await _firestore.collection('users').doc(user.uid).get();
    final profileDoc = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('profile')
        .doc('data')
        .get();

    if (!rootDoc.exists || !profileDoc.exists) {
      // Fallback if documents are missing for some reason
      return UserModel(
        id: user.uid,
        name: user.displayName ?? user.email?.split('@').first ?? 'User',
        email: user.email ?? '',
      );
    }

    return UserModel.fromFirestore(rootDoc.data()!, profileDoc.data()!);
  }

  Future<UserModel> _createOrUpdateUserData(
    User user,
    String provider,
    String name,
  ) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final profileRef = userRef.collection('profile').doc('data');

    final rootDoc = await userRef.get();

    if (!rootDoc.exists) {
      final firstName = name.contains(' ') ? name.split(' ').first : name;
      final lastName = name.contains(' ')
          ? name.split(' ').sublist(1).join(' ')
          : '';

      final userModel = UserModel(
        id: user.uid,
        name: name,
        email: user.email ?? '',
      );

      final batch = _firestore.batch();

      final rootData = userModel.toRootFirestore(provider);
      rootData['createdAt'] = FieldValue.serverTimestamp();
      rootData['updatedAt'] = FieldValue.serverTimestamp();
      batch.set(userRef, rootData);

      final profileData = userModel.toProfileFirestore(firstName, lastName);
      profileData['updatedAt'] = FieldValue.serverTimestamp();
      // Use photoURL if available from google sign in
      if (user.photoURL != null) {
        profileData['imageUrl'] = user.photoURL;
      }
      batch.set(profileRef, profileData);

      await batch.commit();

      return userModel;
    }

    // User exists, just fetch
    return _getUserData(user);
  }
}
