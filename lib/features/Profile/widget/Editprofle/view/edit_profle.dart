import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:wazin/core/custom_colors.dart';
import 'package:wazin/features/Profile/widget/Editprofle/widget/profile_image_picker.dart';
import 'package:wazin/features/Profile/widget/Editprofle/widget/profile_text_field.dart';
import 'package:wazin/features/Profile/widget/Editprofle/widget/update_button.dart';
import 'package:wazin/features/home/widget/app_bare_notification.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? _selectedImageFile;
  String? _profileImageUrl;
  bool _isLoading = true;
  bool _updateLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _usernameController.text = data['name'] ?? '';
        _emailController.text = data['email'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _profileImageUrl = data['imageUrl'];
        _isLoading = false;
      });
    }
  }

  Future<String?> _uploadImage(File file) async {
    try {
      final uid = _auth.currentUser!.uid;

      final ref = _storage.ref().child("profile_images/$uid.jpg");
      await ref.putFile(file);

      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint("Image upload error: $e");
      return null;
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _updateLoading = true);

    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    String? imageUrl = _profileImageUrl;

    if (_selectedImageFile != null) {
      imageUrl = await _uploadImage(_selectedImageFile!);
    }

    await _firestore.collection('users').doc(uid).update({
      'name': _usernameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'imageUrl': imageUrl,
    });

    setState(() => _updateLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.green,
        body: Column(
          children: [
            const Gap(50),
            const AppBareNotification(title: 'Edit My Profile', showBack: true),
            const Gap(20),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.fill(
                    top: 100,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 27, right: 27),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 60),

                              Center(
                                child: Text(
                                  _usernameController.text,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Gap(5),
                              Center(
                                child: Text(
                                  'ID: ${_auth.currentUser?.uid ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                              const Gap(38),
                              const Text(
                                'Account settings',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const Gap(14),
                              ProfileTextField(
                                title: 'Username',
                                controller: _usernameController,
                              ),

                              const Gap(14),
                              ProfileTextField(
                                title: 'Phone',
                                controller: _phoneController,
                              ),

                              const Gap(14),
                              ProfileTextField(
                                title: 'Email Address',
                                controller: _emailController,
                              ),

                              const Gap(40),
                              Center(
                                child: UpdateButton(
                                  text:
                                      _updateLoading
                                          ? "Updating..."
                                          : 'Update Profile',
                                  onPressed:
                                      _updateLoading ? () {} : _updateProfile,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  ProfileImagePicker(
                    selectedImageFile: _selectedImageFile,
                    profileImageUrl: _profileImageUrl,
                    onImagePicked:
                        (file) => setState(() => _selectedImageFile = file),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
