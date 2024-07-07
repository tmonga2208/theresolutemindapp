import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseImageProvider extends StatefulWidget {
  final String basePath;
  final String uid;

  FirebaseImageProvider({
    required this.basePath,
    required this.uid,
  }) : super(key: Key('$basePath/$uid'));

  @override
  State<FirebaseImageProvider> createState() => _FirebaseImageState();
}

class _FirebaseImageState extends State<FirebaseImageProvider> {
  File? _file;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    final imageFile = await getImageFile();
    if (mounted) {
      setState(() {
        _file = imageFile;
      });
    }
  }

  Future<File?> getImageFile() async {
    // Construct the full storage path
    final storagePath = '${widget.basePath}/${widget.uid}';
    final tempDir = await getTemporaryDirectory();
    final fileName = storagePath.split('/').last;
    final file = File('${tempDir.path}/$fileName');

    // If the file does not exist, try to download
    if (!file.existsSync()) {
      try {
        await file.create(recursive: true);
        await FirebaseStorage.instance.ref(storagePath).writeToFile(file);
      } catch (e) {
        // If there is an error, delete the created file
        await file.delete(recursive: true);
        return null;
      }
    }
    return file;
  }

  @override
  Widget build(BuildContext context) {
    if (_file == null) {
      return const Icon(Icons.error);
    }
    return Image.file(
      _file!,
      width: 100,
      height: 100,
    );
  }
}
