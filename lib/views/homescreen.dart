import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/createnote.dart';
import 'package:note_app/views/drawer.dart';
import 'package:note_app/views/editnote.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  User? userID = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.withOpacity(.8),
        // automaticallyImplyLeading: false,
        title: const Text('Notes'),
        centerTitle: true,
        elevation: 0.0,
        // actions: [
        //   GestureDetector(
        //       onTap: () {
        //         FirebaseAuth.instance.signOut();
        //         //in replacement with navigator.pushreplacement
        //         Get.off(() => loginscreen());
        //       },
        //       child: Icon(Icons.logout))
        // ],
        
      ),
      drawer: const mydrawer(),
      body: LayoutBuilder(
        builder: (context,constraints){
        return Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("notes")
                .where("userId", isEqualTo: userID?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something Went Wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('Data Not Found!'));
              }
              if (snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                            constraints.maxWidth > 600 ? 3 : 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var docid = snapshot.data!.docs[index].id;
                      return Card(
                        color: const Color.fromARGB(255, 230, 223, 223),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data!.docs[index]['note'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=>const editnote(), arguments: {
                                     'note': snapshot.data!.docs[index]['note'],
                                     'docid': docid,
      
                                    });
                                  },
                                  child: const Icon(Icons.edit)
                                  
                                ),
                                 GestureDetector(
                                  child: const Icon(Icons.delete),
                                 onTap: () async{
                                   await FirebaseFirestore.instance.collection("notes")
                                   .doc(docid).delete();
                                  },
                                ),
                                const SizedBox(width: 10.0),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
      
                // return Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GridView.builder(
                //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      
                //         crossAxisCount: 2, // You can adjust the number of columns here
                //         crossAxisSpacing: 10.0,
                //         mainAxisSpacing: 5.0,
                //       ),
                //       itemCount: snapshot.data!.docs.length,
                //       itemBuilder: (context, index) {
                //         return Card(
                //           shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(6)),
                //           color: Color.fromARGB(255, 230, 223, 223),
                //           child: ListTile(
                //             title: Text(snapshot.data!.docs[index]['note'],
                //             overflow: TextOverflow.ellipsis,
                //             maxLines: 8,
                //             ),
      
                //             trailing: Row(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 Icon(Icons.edit),
                //                 SizedBox(width: 10.0),
                //                 Icon(Icons.delete),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                // );
                // return ListView.builder(
                //   itemCount: snapshot.data!.docs.length,
                //   itemBuilder: (context,index)
                // {
                //    return Card(
                //     color: Color.fromARGB(255, 230, 223, 223),
                //     child: ListTile(
                //       title: Text(snapshot.data!.docs[index]['note']),
                //       trailing: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           Icon(Icons.edit),
                //           SizedBox(
                //             width: 10.0,
                //           ),
                //           Icon(Icons.delete)
                //         ],
                //       ),
                //     ),
      
                //    );
                // }
                // );
              }
      
              return Container();
            },
          ),
        );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const createnote());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
