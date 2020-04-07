import 'package:flutter/material.dart';
import 'package:flutter_provider_firebase/utils/validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider_firebase/services/firebase_auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _displayNameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(text: '');
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _displayNameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    labelText: 'Name',
                  ),
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (value) => (!Validators.isValidDisplayName(value))
                      ? 'Invalid Name'
                      : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (value) => (!Validators.isValidEmail(value))
                      ? 'Invalid Email'
                      : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autocorrect: false,
                  autovalidate: true,
                  validator: (value) => (!Validators.isValidPassword(value))
                      ? 'Invalid Password'
                      : null,
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    signUpUser(
                      _displayNameController.text,
                      _emailController.text,
                      _passwordController.text,
                      context,
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUpUser(
    String displayName,
    String email,
    String password,
    BuildContext context,
  ) async {
    final FirebaseAuthService auth =
        Provider.of<FirebaseAuthService>(context, listen: false);

    try {
      await auth.createUserWithEmailAndPassword(
        displayName,
        email,
        password,
      );
      print('register account');
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
