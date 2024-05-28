import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/views/signinscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/signupservices.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupstate();
}

class _signupstate extends State<signupscreen> {
    TextEditingController usernamecontroller = TextEditingController();
    TextEditingController userphonecontroller = TextEditingController();
    TextEditingController useremailcontroller = TextEditingController();
    TextEditingController userpasswordcontroller = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.withOpacity(.8),
        title: const Text('Sign Up '),
        centerTitle: true,
        // actions: [
        //   Icon(Icons.more_vert)
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              )
              ,
              Container(
                alignment: Alignment.center,
                height: 150,
                width: double.infinity,
                child: Lottie.asset("assets/animation_ll25ghtu.json"),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                      hintText: 'Username',
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
                   controller: userphonecontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                      hintText: 'Phone',
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
                   controller: useremailcontroller,
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
                   controller: userpasswordcontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: const Icon(Icons.visibility),
                      hintText: 'Password',
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
                  // trim remove all whitespaces from start and end
                  var username = usernamecontroller.text.trim();
                   var userphone = userphonecontroller.text.trim();
                    var useremail = useremailcontroller.text.trim();
                     var userpassword = userpasswordcontroller.text.trim();
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: useremail, 
                      password: userpassword).then((value)=>{
                      log('user created'),
                      signupservices(username,userphone,useremail,userpassword)
                      }
                
                      );
                      
                }, 
                child: const Text('SignUp'))
                ,
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
                            'Already have an account?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>const loginscreen());
                          },
                          child: Container(
                            child: const Text(
                              'SignIn',
                              style: TextStyle(fontWeight: FontWeight.bold,
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
