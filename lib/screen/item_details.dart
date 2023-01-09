import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screen/Contact.dart';
import 'package:my_first_app/screen/item_list.dart';

// ignore: depend_on_referenced_packages
//import 'package:flutterfiredemo/edit_item.dart';
int i = 0;

class ItemDetails extends StatelessWidget {
  ItemDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference =
        FirebaseFirestore.instance.collection('ProjectCat').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;
  final auth = FirebaseAuth.instance;

  //_reference.get()  --> returns Future<DocumentSnapshot>
  //_reference.snapshots() --> Stream<DocumentSnapshot>
  late Future<DocumentSnapshot> _futureData;
  late Map data;
  late String contactid;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Center(
              child: Text("ไม่พบข้อมูล"),
            );
          }
          if (snapshot.hasData) {
            //Get the data
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;
            if (data["gendercat"] == "Female") {
              gender = "เมีย";
            } else if (data["gendercat"] == "Male") {
              gender = "ผู้";
            } else {
              gender = "ไม่ระบุ";
            }

            //display the data
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(224, 255, 196, 0),
                    Color.fromARGB(255, 255, 115, 0),
                  ],
                )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          " Information",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      data['image'],
                      width: 150,
                      height: 150,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60)),
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 214, 214, 214))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ชื่อ: ${data['name']} ",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "อายุ ${data['AgeCat']} ปี ",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'เพศ ${gender}',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text("สายพันธุ์ ${data['species']}",
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
                                  "ฉีดวัคซีนล่าสุด: ${data['date']} ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment(-1, 0),
                              child: Text("เบอร์ติดต่อ ${data['Tolfund']} ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                            Align(
                              alignment: Alignment(-1, 0),
                              child: Text("ที่อยู่ ${data['locationfund']}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ),
                            SizedBox(
                              height: 90,
                            ),
                            Container(
                                height: 50,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)))),
                                    ),
                                    child: Text(
                                      "ติดต่อรับเลี้ยง",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () {
                                      try {
                                        final contact = Contact(
                                            catId: data['doc_id'],
                                            userId: auth.currentUser!.uid);
                                        createContact(contact);
                                      } catch (e) {
                                        print(e);
                                      }
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return const ContactScreen(); //CreateData();
                                        },
                                      ));
                                    })),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)))),
                                ),
                                child: Text(
                                  "ย้อนกลับ",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return ItemList(); //CreateData();
                                    },
                                  ));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future createContact(Contact contact) async {
    final docUser =
        FirebaseFirestore.instance.collection("Contact").doc(data["doc_id"]);
    final json = contact.toJson();
    await docUser.set(json);
  }

  Future createhitorycat(Contact contact) async {
    final docUser = FirebaseFirestore.instance
        .collection("Historycat")
        .doc(auth.currentUser!.uid);
    final json = contact.toJson();
    await docUser.set(json);
  }
}

class Contact {
  final String catId;
  String userId;
  Contact({
    required this.catId,
    required this.userId,
  });
  Map<String, dynamic> toJson() => {'catId': catId, 'userId': userId};
}
