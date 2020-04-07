import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_provider_firebase/components/uploader.dart';

class AddPhotoPage extends StatefulWidget {
  @override
  _AddPhotoPageState createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  /// Active image file
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a photo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            if (_imageFile == null) ...[
              GestureDetector(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.photo_camera),
                      SizedBox(width: 16.0),
                      Text('Take a photo'),
                    ],
                  ),
                ),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              SizedBox(
                height: 16.0,
              ),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.photo_library),
                    SizedBox(width: 16.0),
                    Text('Choose a photo from phone.'),
                  ],
                ),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
            Expanded(
              child: ListView(
                children: <Widget>[
                  if (_imageFile != null) ...[
                    Image.file(_imageFile),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          child: Icon(Icons.crop),
                          onPressed: _cropImage,
                        ),
                        FlatButton(
                          child: Icon(Icons.refresh),
                          onPressed: _clear,
                        ),
                      ],
                    ),
                    Uploader(file: _imageFile)
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
//        toolbarColor: Colors.purple,
//        toolbarWidgetColor: Colors.white,
//        toolbarTitle: 'Crop It'
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }
}
