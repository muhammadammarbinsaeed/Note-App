import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/homescreen.dart';

class editnote extends StatefulWidget {
  const editnote({super.key});

  @override
  State<editnote> createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {
  TextEditingController notecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.withOpacity(.8),
        title: const Text("Edit Your Note"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: InputBorder.none
                      
              ),
              controller: notecontroller..text = Get.arguments['note'].toString(),
              ),
            ),
          ),
          ElevatedButton(

            onPressed: ()async {
              await FirebaseFirestore.instance.collection("notes").doc(Get.arguments['docid'].toString())
              .update({
                   'note': notecontroller.text.trim()
              }).then((value) => 
              Get.offAll(
                ()=>const homescreen()
              ));
            }, 
            child: const Text('Update'))
        ],
      ),
    );
  }
}
