import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:note_app/views/homescreen.dart';
import 'package:note_app/views/signupscreen.dart';

import 'forgotpasswordscreen.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginstate();
}

class _loginstate extends State<loginscreen> {
  TextEditingController loginemailcontroller = TextEditingController();
  TextEditingController loginpasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.withOpacity(.8),
        automaticallyImplyLeading: false,
        title: const Text('Login '),
        centerTitle: true,
        // actions: [
        //   Icon(Icons.more_vert)
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300,
                width: double.infinity,
                child: Lottie.asset("assets/animation_ll204av0.json"),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: loginemailcontroller,
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
              Container(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: loginpasswordcontroller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: const Icon(Icons.visibility),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: () async {
                            var loginemail = loginemailcontroller.text.trim();
                            var loginpassword =
                                loginpasswordcontroller.text.trim();
                            try {
                      final UserCredential usercredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginemail, password: loginpassword);
                      final User? firebaseUser = usercredentials.user;
                      if(firebaseUser!=null){
                        Get.to(()=>const homescreen());
                      }
                      else{
                        print("check email and password");
                      }

                            } on FirebaseAuthException catch (e) {
                                  print("Error $e");
                            }
                          },
                          child: const Text(
                            'Login',style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const forgotpasswordscreen());
                        },
                        child: Container(
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Card(
                  color: Colors.orange,
                  shadowColor: const Color.fromARGB(255, 231, 212, 180),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            'Dont have an account?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const signupscreen());
                          },
                          child: Container(
                            child: const Text(
                              'SignUp',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
