import 'package:flutter/material.dart';
import 'package:flutter_provider_firebase/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_firebase/services/firebase_auth_service.dart';
import 'package:flutter_provider_firebase/providers/app_theme.dart';
import 'package:flutter_provider_firebase/components/auth_widget.dart';
import 'package:flutter_provider_firebase/models/user.dart';

import 'package:flutter_provider_firebase/components/auth_widget_builder.dart';

void main() => runApp(MyApp(
      authServiceBuilder: (_) => FirebaseAuthService(),
      databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.authServiceBuilder, this.databaseBuilder})
      : super(key: key);
  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirebaseAuthService Function(BuildContext context) authServiceBuilder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: authServiceBuilder,
        ),
        ChangeNotifierProvider<AppTheme>(
          create: (context) => AppTheme(),
        ),
      ],
      child: AuthWidgetBuilder(
        databaseBuilder: databaseBuilder,
        builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
          return MaterialApp(
            theme: Provider.of<AppTheme>(context).theme,
            darkTheme: Provider.of<AppTheme>(context).darkTheme,
            home: AuthWidget(userSnapshot: userSnapshot),
          );
        },
      ),
    );
  }
}
