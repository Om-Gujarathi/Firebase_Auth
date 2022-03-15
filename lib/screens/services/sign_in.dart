import 'package:coffee/models/user.dart';
import 'package:coffee/screens/services/auth.dart';
import 'package:coffee/shared/constants.dart';
import 'package:coffee/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in'),
        actions: [
          TextButton.icon(
                onPressed: (() {
                  widget.toggleView();
                }),
                icon: const Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                label: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black87
                  ),
                ),
              ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (value) {
                    value = value!.trim();
                    return value.isEmpty ? "Enter an Email" : null;
                  },
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (value) {
                    value = value!.trim();
                    return value.length < 6
                        ? "Enter a Password having 6+ Characters"
                        : null;
                  },
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                  child: const Text(
                    'Sign In',
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      MyUser? result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          loading=false;
                          error = 'Problem signing In with These Credentials';
                        });
                      }
                    }
                  }),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
