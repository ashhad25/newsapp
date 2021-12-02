// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/auth/register.dart';
import 'package:newsapp/views/home.dart';

class Login extends StatelessWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    
  
    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;

      final String email = emailController.text;
      final String password = passwordController.text;

    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(email: email, password: password);
      final DocumentSnapshot snapshot = await db.collection("users").doc(user.user?.uid).get();
        
      final data = snapshot.data();
      
      const CircularProgressIndicator();
      
      print("User Is Logged In");
      print((data as dynamic)["username"]);
      print((data as dynamic)["email"]);
      
      emailController.clear();
      passwordController.clear();
      Navigator.push(context, MaterialPageRoute(
      builder: (context) => const HomeScreen()
      ));
      } catch (e) {
        print(e.toString());
      }
      login();
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
            Row(
              children: [
           TextButton(onPressed: login, child: const Text("Sign In")),
           TextButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(
              builder: (context) => const Register()
              ));
           }, child: const Text("Signup",style: TextStyle(
            fontSize: 10,
           ),))
            ],
            )
          ],
        ),
      ),
    );
  }
}