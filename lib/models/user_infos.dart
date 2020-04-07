import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfos {
  UserInfos({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.createdAt,
  });

  final String uid;
  final String email;
  final String photoUrl;
  String displayName;
  final Timestamp createdAt;

  factory UserInfos.fromMap(Map snapshot) {
    snapshot = snapshot ?? {};
    return UserInfos(
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'] ?? null,
      displayName: snapshot['displayName'] ?? '',
      createdAt: snapshot['createdAt'] ?? null,
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'displayName': displayName,
        'createdAt': createdAt,
      };
}
