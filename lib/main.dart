import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mikhivision_app/providers/google_signin.dart';
import 'package:mikhivision_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

import './screens/registration_screen.dart';
import './screens/loggesin_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return LoggedInScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something Went Worng!'),
              );
            } else {}
            return RegistrationScreen();
          },
        ),
        routes: {
          '/login': ((context) => LoginScreen()),
          // '/loggedin': ((context) => LoggedInScreen()),
        },
      ),
    );
  }
}
