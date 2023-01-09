import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  UserList({Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance
        .collection('Historycat')
        .doc(auth.currentUser!.uid);
    _futureData = _reference.get();
  }
  late DocumentReference _reference;
  final auth = FirebaseAuth.instance;
  late Future<DocumentSnapshot> _futureData;
  late DocumentReference _cat;
  late Future<DocumentSnapshot> _futureCat;
  late Stream<QuerySnapshot> _stream;
  late Map catdoc;
  late Map data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 251, 218),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Color.fromARGB(255, 138, 200, 96)),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    title: Text(
                      auth.currentUser!.displayName!,
                    ),
                    leading: Image.network(auth.currentUser!.photoURL!),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: _futureData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Some error occurred ${snapshot.error}'));
                }
                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Center(
                    child: Text("ยังไม่ได้รับการอนุมัติ"),
                  );
                }
                if (snapshot.hasData) {
                  DocumentSnapshot documentSnapshot = snapshot.data;
                  data = documentSnapshot.data() as Map;
                  _cat = FirebaseFirestore.instance
                      .collection("ProjectCatBackup")
                      .doc(data['catId']);
                  _futureCat = _cat.get();
                  return FutureBuilder(
                      future: _futureCat,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                                  'Some error occurred ${snapshot.error}'));
                        }
                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Center(child: Text("ยังไม่ได้รับการอนุมัติ"));
                        }
                        if (snapshot.hasData) {
                          DocumentSnapshot documentSnapshot = snapshot.data;
                          catdoc = documentSnapshot.data() as Map;
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "แมวที่ได้รับการอุปการะ",
                                      style: TextStyle(fontSize: 28),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "ชื่อ: ${catdoc['name']} ",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "อายุ ${catdoc['AgeCat']} ปี ",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'เพศ ${catdoc['gendercat']}',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("สายพันธุ์ ${catdoc['species']}",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "ประวัติ",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "ฉีดวัคซีนล่าสุด: ${catdoc['date']} ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Image.network(
                                    catdoc["image"],
                                    width: 300,
                                    height: 300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Center(child: Text("กำลังโหลด"));
                      });
                }
                return Center(child: Text("กำลังโหลด"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
