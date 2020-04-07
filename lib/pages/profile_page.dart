import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_firebase/models/user_infos.dart';
import 'package:flutter_provider_firebase/pages/add_photo_page.dart';
import 'package:flutter_provider_firebase/pages/edit_page.dart';
import 'package:flutter_provider_firebase/pages/settings_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final UserInfos userInfos = Provider.of<UserInfos>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Profile'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            (userInfos?.photoUrl != null)
                ? CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage(userInfos.photoUrl))
                : CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.blue,
                  ),
            SizedBox(
              height: 16.0,
            ),
            (userInfos?.displayName != null)
                ? Text(userInfos.displayName)
                : Text(''),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ));
                  },
                ),
                FlatButton(
                  child: CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPhotoPage(),
                        ));
                  },
                ),
                FlatButton(
                  child: CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(),
                        ));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            //(userInfos?.email != null) ? Text(userInfos.email) : Text(''),
          ],
        ),
      ),
    );
  }
}
