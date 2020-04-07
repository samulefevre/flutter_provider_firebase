import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_firebase/models/user.dart';
import 'package:flutter_provider_firebase/services/firestore_database.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({this.file});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  _startUpload(User user, BuildContext context) async {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);

    /// Unique file name for the file
    String filePath = 'users/${user.uid}/${DateTime.now()}.png';

    StorageUploadTask task =
        _storage.ref().child(filePath).putFile(widget.file);

    setState(() {
      _uploadTask = task;
    });

    StorageTaskSnapshot snapshot = await task.onComplete;
    String photoUrl = await snapshot.ref.getDownloadURL();

    await database.addPhoto(user, photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                if (_uploadTask.isComplete) Text('🎉🎉🎉'),

                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: () => _startUpload(user, context),
      );
    }
  }
}
