import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatefulWidget {
  final String userId; // User ID to fetch the image for

  const ProfileImageWidget({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _getImageUrl();
  }

  Future<void> _getImageUrl() async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profileImages/${widget.userId}.png');
      String downloadUrl = await ref.getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error getting image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _imageUrl != null
        ? CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(_imageUrl!),
          )
        : CircularProgressIndicator();
  }
}
