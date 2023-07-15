import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dopproject/doctor_screen/doctor_screen.dart';
import 'package:dopproject/pharmacy_screen/pharmacy_screen.dart';
import 'package:dopproject/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detect_cubit/detect_cubit.dart';

// ignore: must_be_immutable
class Detect extends StatefulWidget {
  File image;

  Detect({super.key, required this.image});

  @override
  State<Detect> createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetectCubit()
        ..loadModel()
        ..classifyLungImage(widget.image),
      child: BlocConsumer<DetectCubit, DetectState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = DetectCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlueAccent,
              title: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'Detect X-Ray'),
            ),
            body: ConditionalBuilder(
                condition: cubit.outputs != null,
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Center(
                          child: Image.file(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        cubit.outputs![0]['label'].toString() == '0 Broken' ? 'Broken' : 'Non - Broken',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.lightBlueAccent),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        cubit.outputs![0]['label'].toString() == '0 Broken' ? 'You need to see a doctor' : 'You are okay',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.lightBlueAccent),
                      ),
                      const SizedBox(height: 40),
                      if (cubit.outputs![0]['label'].toString() == '0 Broken')
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(bottom: 10),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (builder) => Doctor()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View Doctors',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(20)),
                              child: ExpansionTile(
                                title: const Center(
                                  child: Text(
                                    'You must get...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                childrenPadding: const EdgeInsets.all(20),
                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(
                                      'Panadol',
                                      style: const TextStyle(color: Colors.white, height: 1.6),
                                    ),
                                    Text(
                                      'medicine',
                                      style: const TextStyle(color: Colors.white, height: 1.6),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (builder) => Pharmacy()));
                                        },
                                        child: Text(
                                          'View near pharmacies',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ))
                                  ])
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: cubit.notes,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: 'Write your Notes',
                                  labelText: 'Notes',
                                  labelStyle: const TextStyle(color: Colors.lightBlueAccent, fontSize: 20, fontWeight: FontWeight.bold),
                                  prefixIcon: const Icon(
                                    Icons.note_add_outlined,
                                    color: Colors.lightBlueAccent,
                                    size: 25,
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            !loading
                                ? ElevatedButton(
                                    onPressed: () {
                                      String? id;
                                      loading = true;
                                      setState(() {});
                                      FirebaseStorage.instance.ref().child('doctor/${DateTime.now()}').putFile(widget.image).then((value) {
                                        value.ref.getDownloadURL().then((value) {
                                          FirebaseFirestore.instance.collection('user').doc(uId).collection('history').add({
                                            'image': value.toString(),
                                            'date': DateTime.now().toString(),
                                            'note': cubit.notes.text.toString(),
                                          }).then((value) {
                                            id = value.id;
                                            Navigator.pop(context);
                                          }).then((value) {
                                            FirebaseFirestore.instance.collection('user').doc(uId).collection('history').doc(id).update({
                                              'id': id,
                                            });
                                          });
                                        });
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.lightBlueAccent,
                                        elevation: 10.0,
                                        textStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                    child: const Text('Add To History'),
                                  )
                                : CircularProgressIndicator(),
                          ],
                        ),
                    ])))),
          );
        },
      ),
    );
  }
}
