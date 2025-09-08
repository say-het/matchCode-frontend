import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: "215144348530-46lcbhcrcm3ggj4r2an6domtm98qa93k.apps.googleusercontent.com");

  User? user;

  Future<User?> signInWithGoogle() async {
    try {
      // Start interactive sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      setState(() {
        user = userCredential.user;
      });

      return user;
    } catch (e) {
      debugPrint("Google Sign-In error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    setState(() {
      user = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Sign-In")),
      body: Center(
        child: user == null
            ? ElevatedButton(
                onPressed: signInWithGoogle,
                child: const Text("Sign in with Google"),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (user?.photoURL != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.photoURL!),
                      radius: 40,
                    ),
                  const SizedBox(height: 12),
                  Text("Hello, ${user?.displayName ?? 'User'}"),
                  Text(user?.email ?? ""),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signOut,
                    child: const Text("Sign out"),
                  ),
                ],
              ),
      ),
    );
  }
}
