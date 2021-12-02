// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/views/home.dart';

class Register extends StatelessWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    
    void register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

    try {
     final UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      await db.collection('users').doc(user.user?.uid).set({ 
      "username" : username,
      "email" : email,
      });
      usernameController.clear();
      emailController.clear();
      passwordController.clear();

      Navigator.push(context, MaterialPageRoute(
      builder: (context) => const HomeScreen()
      ));
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Flutter",style: TextStyle(color: Colors.black26),),
                Text("News",style: TextStyle(color: Colors.blue),)
              ],
            ),
          ),
      body: Container(
        padding: const EdgeInsets.only(left: 10,top: 80,),
        child: Column(
          children: [
             TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter username: ',
              ),
            ),
              TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter email: ',
              ),
            ),
              TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter password: ',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10,),
            TextButton(onPressed: register ,child: const Text("Signup"),)
          ],
        ),
      ),
    );
  }
}