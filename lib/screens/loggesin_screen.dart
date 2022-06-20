import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mikhivision_app/providers/google_signin.dart';
import 'package:provider/provider.dart';

class LoggedInScreen extends StatelessWidget {
  // const LoggedInScreen({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Center(child: Text('Logged In')),
        actions: [
          TextButton.icon(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                if (user.email.toString().contains('gmail')) {
                  provider.googleLogout();
                } else {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black54,
              ),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.black54),
              ))
        ],
      ),
      body: Center(
        child: Container(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.photoURL == null
                      ? 'https://fluttergems.dev/media-cards/camera_camera.png'
                      : user.photoURL!),
                ),
                Text('Email: ' + user.email!,
                    style: TextStyle(color: Colors.black54, fontSize: 20)),
                Text('UID: ' + user.uid,
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
              ]),
        ),
      ),
    );
  }
}
