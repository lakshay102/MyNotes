import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // backgroundColor: Theme.of(context).colorScheme.secondaryFixed,
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            // print(FirebaseAuth.instance.currentUser);
            final user = FirebaseAuth.instance.currentUser;
            final isEmailVerified = user?.emailVerified ?? false;
            if(isEmailVerified){
              print('You are a verified user');
            }
            else{
              print('You need to verify your email first');
            }
              return Text('Done');
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
