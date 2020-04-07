import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_firebase/components/login_button.dart';
import 'package:flutter_provider_firebase/pages/sign_up_page.dart';
import 'package:flutter_provider_firebase/components/google_login_button.dart';
import 'package:flutter_provider_firebase/services/firebase_auth_service.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset('assets/logo.png', height: 200),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (value) =>
                      (value.isEmpty) ? 'Invalid Email' : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (value) =>
                      (value.isEmpty) ? 'Invalid Password' : null,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      LoginButton(
                        onPressed: () async {
                          signInUser(
                            _emailController.text,
                            _passwordController.text,
                            context,
                          );
                        },
                      ),
                      GoogleLoginButton(),
                      FlatButton(
                        child: Text(
                          'Create an Account',
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signInUser(String email, String password, BuildContext context) async {
    final FirebaseAuthService auth =
        Provider.of<FirebaseAuthService>(context, listen: false);

    try {
      await auth.signInWithEmailAndPassword(
        email,
        password,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
