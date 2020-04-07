import 'package:flutter/material.dart';
import 'package:flutter_provider_firebase/pages/splash_page.dart';
import 'package:flutter_provider_firebase/models/user.dart';
import 'package:flutter_provider_firebase/pages/home_page.dart';
import 'package:flutter_provider_firebase/pages/sign_in_page.dart';

/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
/// Note: this class used to be called [LandingPage].
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : SignInPage();
    }
    return SplashPage();
  }
}
