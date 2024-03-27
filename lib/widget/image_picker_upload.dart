import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUpload extends StatefulWidget {
  const ImagePickerUpload({super.key, required this.onPickImage});
  final void Function(File pickImage) onPickImage;
  @override
  State<ImagePickerUpload> createState() => _ImagePickerUploadState();
}

class _ImagePickerUploadState extends State<ImagePickerUpload> {
  File? _pickedImage;

  void pickImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (pickedImageFile == null) {
      return;
    }

    setState(() {
      _pickedImage = File(pickedImageFile.path);
      print(_pickedImage);
    });

    widget.onPickImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImage == null ? null : FileImage(_pickedImage!),
        ),
        TextButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            "Add image",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        )
      ],
    );
  }
}
