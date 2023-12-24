import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_1/CreateNoteScreen.dart';
import 'package:firebase_1/EditScreen.dart';
import 'package:firebase_1/home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Blink Notes"),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => HomeScreen());
              },
              // ignore: prefer_const_constructors
              child: Icon(Icons.logout))
        ],
      ),
      // ignore: prefer_const_constructors, avoid_unnecessary_containers
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notes")
              .where("userId", isEqualTo: userId?.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              // ignore: prefer_const_constructors
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No Data Found"));
            }
            if (snapshot != null && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  // ignore: avoid_types_as_parameter_names
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data!.docs[index]['Note'],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(() => EditNoteScreen(), arguments: {
                                    'note': snapshot.data!.docs[index]['Note'],
                                    'docId': snapshot.data!.docs[index].id,
                                  });
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection('notes')
                                      .doc(snapshot.data!.docs[index].id)
                                      .delete();
                                },
                                child: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => CreateNoteScreen());
          },
          child: Icon(Icons.add)),
    );
  }
}
