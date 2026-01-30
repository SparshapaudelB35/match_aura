import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:match_aura/core/utils/snackbar_utils.dart';
import 'package:match_aura/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:match_aura/features/profile_setup/presentation/pages/gender.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileDetailsPage extends ConsumerStatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  ConsumerState<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends ConsumerState<ProfileDetailsPage> {
  DateTime? selectedDate;

  final List<XFile> _selectedMedia = [];
  final ImagePicker _imagePicker = ImagePicker();
  String? _selectedMediaType;

  Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.status;
    if (status.isGranted) return true;

    if (status.isDenied) {
      final result = await permission.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
      return false;
    }

    return false;
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("Permission Required"),
        content: Text(
          "This feature requires permission to access your camera or gallery. Please enable it in your device settings.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              openAppSettings();
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFromCamera() async {
    final hasPermission = await _requestPermission(Permission.camera);
    if (!hasPermission) return;

    final XFile? photo = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo != null) {
      setState(() {
        _selectedMedia.clear();
        _selectedMedia.add((photo));
        _selectedMediaType = 'photo';
      });

      await ref
        .read(authViewModelProvider.notifier)
        .uploadPhoto(File(photo.path));
    }
  }

  Future<void> _pickFromGallery({bool allowMultiple = false}) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedMedia.clear();
          _selectedMedia.add((image));
          _selectedMediaType = 'photo';
        });

        await ref
        .read(authViewModelProvider.notifier)
        .uploadPhoto(File(image.path));
      }
    } catch (e) {
      SnackbarUtils.showError(context, 'Failed to pick image: $e');
    }
  }

  Future<void> _pickFromVideo() async {
    try {
      final hasPermission = await _requestPermission(Permission.camera);
      if (!hasPermission) return;

      final hasMicPermission = await _requestPermission(Permission.microphone);
      if (!hasMicPermission) return;

      final XFile? video = await _imagePicker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(minutes: 1),
      );

      if (video != null) {
        setState(() {
          _selectedMedia.clear();
          _selectedMedia.add((video));
          _selectedMediaType = 'video';
        });
      }
    } catch (e) {
      _showPermissionDeniedDialog();
    }
  }

  void _showMediaPicker() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text("Record Video"),
                onTap: _pickFromVideo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle Date Picking
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFC033E6);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.9),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.purple,
                size: 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C27B0),
              ),
            ),
            const SizedBox(height: 40),

            // Profile Picture Section
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _selectedMedia.isNotEmpty
                        ? FileImage(File(_selectedMedia.first.path))
                        : const AssetImage('assets/images/logo.png')
                              as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _showMediaPicker();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 1),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // First Name Field
            TextField(
              decoration: InputDecoration(
                labelText: "First Name",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Last Name Field
            TextField(
              decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Birth Date Picker Button
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: primaryColor,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      selectedDate == null
                          ? "Choose Birth Date"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Bio",
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectGenderPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
