import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  String? _imageUrl;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profileImages/${_user!.uid}.png');
        String imageUrl = await ref.getDownloadURL();
        setState(() {
          _imageUrl = imageUrl; // Update the image URL and refresh UI
        });
      } catch (e) {
        print('Error getting image URL: $e');
      }
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage != null && _user != null) {
      try {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profileImages/${_user!.uid}.png');
        UploadTask uploadTask = ref.putFile(_selectedImage!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          _imageUrl = imageUrl; // Update the image URL and refresh UI
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Image
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _imageUrl != null
                      ? CachedNetworkImageProvider(_imageUrl!)
                      : null,
                  child: _imageUrl == null
                      ? const CircularProgressIndicator() // Show loading indicator while image is loading
                      : null,
                ),
                IconButton(
                  onPressed: _selectImage,
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Username
            Text(
              _user?.displayName ?? 'No Username',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Upload Button
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
