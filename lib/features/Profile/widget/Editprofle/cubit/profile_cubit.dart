import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// تحميل بيانات المستخدم
  Future<void> loadUserData() async {
    emit(ProfileLoading());

    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      emit(ProfileError("User not found"));
      return;
    }

    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      final data = doc.data();

      emit(
        ProfileLoaded(
          name: data?['name'] ?? "",
          email: data?['email'] ?? "",
          phone: data?['phone'] ?? "",
          imageUrl: data?['imageUrl'],
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  /// تحديث البيانات مع رفع الصورة لو اتغيرت
  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    File? imageFile,
  }) async {
    emit(ProfileUpdating());

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    String? imageUrl;

    try {
      // لو المستخدم اختار صورة → ارفعها
      if (imageFile != null) {
        final ref = _storage.ref().child("profile_images/$uid.jpg");
        await ref.putFile(imageFile);
        imageUrl = await ref.getDownloadURL();
      }

      // تحديث البيانات
      await _firestore.collection('users').doc(uid).update({
        "name": name,
        "email": email,
        "phone": phone,
        if (imageUrl != null) "imageUrl": imageUrl,
      });

      emit(ProfileUpdated());
      loadUserData(); // رجّع البيانات بعد التحديث
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
