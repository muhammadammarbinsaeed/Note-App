// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/signinscreen.dart';


import 'homescreen.dart';

class mydrawer extends StatefulWidget {
  const mydrawer({super.key});

  @override
  State<mydrawer> createState() => _mydrawerState();
}

class _mydrawerState extends State<mydrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  Future<String?> fetchUsername() async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("No user is currently signed in.");
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get();

   if (userDoc.exists) {
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('username')) {
        return data['username'] as String?;
      } else {
      throw Exception("User document does not exist.");
    }
  } 
  }catch (e) {
    print("Error fetching username: $e");
    return null;
  }
}
   
  @override
  Widget build(BuildContext context) {
    Future<String?> Username = fetchUsername();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
                decoration:  const BoxDecoration(
              color: Colors.orange
            ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage: getprofileimage()?.image,
                    // ),
                 
                    FutureBuilder<String?>(
          future: fetchUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Text('Hello '
               + '${snapshot.data}'); 
            } else {
              return Text('Hello');
            }
          },
        ),
                     Text('Welcome to Notes App'),
                  ],
                ), 
          ),
            
             ListTile(
            leading: const Icon(Icons.home),  
            title: const Text('Home'),
            onTap: () {
              Get.to(()=>const homescreen());
              // Handle item 1 tap
            },
          ), 
          // ListTile(
          //   leading: const Icon(Icons.color_lens), 
          //   title: const Text('Themes'),
          //   onTap: () {
              
              
          //   },
          // ),   
           ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Log Out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
                //in replacement with navigator.pushreplacement
                Get.off(() => const loginscreen());
              // Handle item 1 tap
            },
          ),  
          
        ],
      ),
    );
  }
}
Image? getprofileimage(){
  if(FirebaseAuth.instance.currentUser?.photoURL!=null){
        return Image.network(FirebaseAuth.instance.currentUser!.photoURL!);
  }
  else{
    return null;
  }
}