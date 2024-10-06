import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Enter email'),
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(hintText: 'Enter password'),
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  // final userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  // Object? value  = null;
                  // print(Object);
                  // print(userCredential);
                  // devtools.log(userCredential.toString());
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  // print(e.code);
                  if (e.code == 'user-not-found') {
                    // devtools.log('User not exists');
                    await showErrorDialog(
                      context,
                      'User Not Registered',
                    );
                  } else if (e.code == 'wrong-password') {
                    // devtools.log('User not exists');
                    await showErrorDialog(
                      context,
                      'Incorrect password',
                    );
                  } else if (e.code == 'network-request-failed') {
                    // devtools.log('User not exists');
                    await showErrorDialog(
                      context,
                      'No Internet Connection',
                    );
                  } else if (e.code == 'invalid-credential') {
                    // devtools.log('User not exists');
                    await showErrorDialog(
                      context,
                      'Wrong credentials',
                    );
                  } else {
                    // devtools.log('SOMETHING ELSE HAPPENDED');
                    // devtools.log(e.code);
                    await showErrorDialog(
                      context,
                      // 'SOMETHING ELSE HAPPENDED',
                      'Error: ${e.code}',
                    );
                  }
                  // print(" This is the error$e");     //To print the error
                  // print(e.runtimeType);      //Used to get the type
                } catch (e) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              },
              child: const Text('Login')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not Registered Yet? Register here!'),
          )
        ],
      ),
    );
  }
}
