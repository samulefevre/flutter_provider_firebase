import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:flutter_provider_firebase/models/user.dart';
import 'package:flutter_provider_firebase/models/user_infos.dart';

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;

  static final Firestore _firestore = Firestore.instance;

  final _usersRef = _firestore.collection('users');

  Future createUser(User user) async {
    await _usersRef.document(user.uid).setData(user.toMap());
  }

  Future<User> getUser() async {
    DocumentSnapshot doc = await _usersRef.document(uid).get();
    User user = User.fromMap(doc.data);
    print('dp: ${user.displayName}');

    return user;
  }

  Stream<UserInfos> userData() {
    try {
      Stream<DocumentSnapshot> s = _usersRef.document(uid).snapshots();
      return s.map((snap) => UserInfos.fromMap(snap.data));
    } catch (e) {
      return e;
    }
  }

  addPhoto(User user, String photoUrl) async {
    await _usersRef.document(user.uid).updateData({
      'photoUrl': photoUrl,
    });
  }

  updateUser(UserInfos userInfos) async {
    await _usersRef.document(userInfos.uid).updateData(userInfos.toMap());
  }
}
