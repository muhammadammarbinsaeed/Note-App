import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/signinscreen.dart';

class forgotpasswordscreen extends StatefulWidget {
  const forgotpasswordscreen({super.key});

  @override
  State<forgotpasswordscreen> createState() => _forgotpasswordscreenstate();
}

class _forgotpasswordscreenstate extends State<forgotpasswordscreen> {
  TextEditingController forgotemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.withOpacity(.8),
          title: const Text(' Forgot Password '),
          centerTitle: true,
          // actions: [
          //   Icon(Icons.more_vert)
          // ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: 150,
              width: double.infinity,
              child: Lottie.asset("assets/animation_ll2jvuux.json"),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: forgotemail,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            )),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () async{
                       var forgotuseremail = forgotemail.text.trim();
                       try {
                        await  FirebaseAuth.instance.sendPasswordResetEmail(email: forgotuseremail)
                        .then((value) => {
                          print("Email Sent"),
                          Get.off(()=>const loginscreen())
                        });
                       } on FirebaseAuthException catch (e) {
                         print("Error $e");
                       }
                },
                child: const Text('Reset Password')),
          ]),
        )));
  }
}

