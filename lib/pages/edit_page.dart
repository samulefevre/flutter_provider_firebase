import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_firebase/models/user_infos.dart';
import 'package:flutter_provider_firebase/services/firestore_database.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool _isChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserInfos>(
          builder: (context, userInfos, child) {
            return Column(
              children: <Widget>[
                TextFormField(
                  initialValue: userInfos.displayName,
                  onChanged: (value) {
                    userInfos.displayName = value;
                    setState(() {
                      _isChanged = true;
                    });
                    //userRepository.updateUser(user);
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void deactivate() async {
    super.deactivate();
    if (_isChanged == true) {
      print('desactivate');
      final UserInfos userInfos =
          Provider.of<UserInfos>(context, listen: false);
      final database = Provider.of<FirestoreDatabase>(context, listen: false);
      await database.updateUser(userInfos);
      print(userInfos.displayName);
    }
  }
}
