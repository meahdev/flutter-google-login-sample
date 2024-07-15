import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer'as log;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key,});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    //here pass clientId as webclient-id
    if(Platform.isAndroid){
      _googleSignIn = GoogleSignIn(
        clientId:"Your Web client id",
        scopes: [
          "email",
        ],
      );
    }else{
      //here pass clientId as ios client-id, serverClientId as webclient-id
      _googleSignIn = GoogleSignIn(
        clientId: "Your IOS Client id ",
        serverClientId: "Your Web client id",
        scopes: [
          "email",
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Login"),
          onPressed: () {
            _handleGoogleSignIn();
          },
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        account.authentication.then((googleKey) {
          log.log('your email: ${account.email} \n your id token:${googleKey.idToken}');
        });
      }}catch(_,trace)
    {
    log.log("Exception thrown $_ and trace $trace");
    }
  }
}