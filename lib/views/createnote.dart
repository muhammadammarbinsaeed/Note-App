import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class createnote extends StatefulWidget {
  const createnote({super.key});

  @override
  State<createnote> createState() => _createnoteState();
}

class _createnoteState extends State<createnote> {
  TextEditingController notescontroller = TextEditingController();
  User? noteuser = FirebaseAuth.instance.currentUser; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.withOpacity(.8),
        title: const Text('Write Note'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  maxLines: null,
                  controller: notescontroller,
                  decoration: const InputDecoration(
                    hintText: 'Write Note Here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                      )
                      ),
                    enabledBorder: OutlineInputBorder(
                       
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12)
                      )
                      )
                  
                  ),
                ),
              ),
              const SizedBox(
                  height: 5,
              ),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                onPressed: ()async{
                  var note = notescontroller.text.trim();
                  if(note!=""){
                    try {
                      await FirebaseFirestore.instance.
                      collection("notes")
                      .doc()
                      .set({
                        'createdAt' : DateTime.now(),
                        'note': note,
                        'userId': noteuser?.uid, 
                      });
                      
                    } catch (e) {
                      print("Error: $e");
                    }
                  }
                }, 
                child: const Text('Add Note')
                )
            ],
          ),
        ),
      ),
    );
  }
}