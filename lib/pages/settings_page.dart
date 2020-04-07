import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_firebase/models/user_infos.dart';
import 'package:flutter_provider_firebase/services/firestore_database.dart';
import 'package:flutter_provider_firebase/providers/app_theme.dart';
import 'package:flutter_provider_firebase/components/platform_alert_dialog.dart';
import 'package:flutter_provider_firebase/components/platform_exception_alert_dialog.dart';
import 'package:flutter_provider_firebase/services/firebase_auth_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isChanged = false;

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final FirebaseAuthService auth =
          Provider.of<FirebaseAuthService>(context, listen: false);

      await auth.signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: 'Logout failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
//            Consumer<UserInfos>(
//              builder: (context, userInfos, child) {
//                return Column(
//                  children: <Widget>[
//                    SizedBox(
//                      height: 16.0,
//                    ),
//                  ],
//                );
//              },
//            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Dark mode: '),
                Switch(
                    value: Provider.of<AppTheme>(context).isDark,
                    onChanged: (value) {
                      Provider.of<AppTheme>(context, listen: false)
                          .updateTheme(value);
                    }),
              ],
            ),
            FlatButton(
              child: Text('Logout'),
              onPressed: () async => await _confirmSignOut(context),
            ),
          ],
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
