import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_app/views/signinscreen.dart';

 signupservices(String username, String userphone, String useremail, String userpassword)
 async
{
    User? Currentuser = FirebaseAuth.instance.currentUser;
  try {
      await FirebaseFirestore.instance.collection("users").doc(Currentuser!.uid).set({
                        'username' : username,
                        'userphone' : userphone,
                        'useremail' : useremail,
                        'userpassword' : userpassword,
                        'CreateAt': DateTime.now(),
                        'userID': Currentuser.uid,
                      }).then((value) => {
                          FirebaseAuth.instance.signOut(),
                          Get.to(()=>const loginscreen()),
                      });
                      
    
  } on FirebaseAuthException catch (e) {
    print("Error $e");
    
  }

}


                      