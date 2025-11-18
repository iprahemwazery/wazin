import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:wazin/core/custom_colors.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? selectedImageFile;
  final String? profileImageUrl;
  final Function(File) onImagePicked;

  const ProfileImagePicker({
    super.key,
    required this.selectedImageFile,
    required this.profileImageUrl,
    required this.onImagePicked,
  });

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: DecorationImage(
                image:
                    selectedImageFile != null
                        ? FileImage(selectedImageFile!)
                        : (profileImageUrl != null
                            ? NetworkImage(profileImageUrl!)
                            : const AssetImage(
                                  'assets/images/profile/Ellipse 192.png',
                                )
                                as ImageProvider),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _pickImage(context),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: CustomColors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
