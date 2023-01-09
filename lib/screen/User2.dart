import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:my_first_app/screen/adoptedList.dart';
import 'package:my_first_app/screen/item_list.dart';
import 'package:my_first_app/screen/Wellcome.dart';

// ignore: non_constant_identifier_names

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen(this.uid, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('User').doc(uid);
    _futureData = _reference.get();
  }
  late DocumentReference _reference;
  late Future<DocumentSnapshot> _futureData;
  late Map data;
  String? uid;
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  var img = '${FirebaseAuth.instance.currentUser!.photoURL}';
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Container(
                child: Column(
              children: [
                Text("Something Went Wrong"),
                Text("${snapshot.error}"),
                ElevatedButton(
                    onPressed: () {
                      auth.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return WellcomeScreen();
                      }));
                    },
                    child: Text('Logout'))
              ],
            ));
          }
          if (snapshot.hasData) {
            DocumentSnapshot documentSnapshot = snapshot.data;
            data = documentSnapshot.data() as Map;
            if (data['Gender'] == "Male") {
              gender = "ชาย";
            } else if (data['Gender'] == "Female") {
              gender = "หญิง";
            }
            Timestamp t = data['DOB'];
            DateTime d = t.toDate();

            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  color: Color.fromARGB(255, 255, 135, 60),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return UserList();
                                    }));
                                  },
                                  icon: Icon(Icons.dehaze_rounded)),
                              IconButton(
                                  onPressed: () {
                                    print("Go to setting");
                                  },
                                  icon: Icon(Icons.settings))
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(img),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 247, 233),
                            border: Border.all(
                                color: Color.fromARGB(255, 226, 225, 225)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${user?.displayName}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 23, 70, 162)),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        data['lname'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 23, 70, 162)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      child: Text(
                                    ' เพศ $gender',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 95, 157, 247)),
                                  )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "รายได้ต่อเดือน ${data['saraly']} บาท ต่อเดือน",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 95, 157, 247))),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Text("เบอร์ติดต่อ ${data['Tel']}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    255, 95, 157, 247))),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: Row(children: [
                                      Text(
                                          'วันเกิด ${d.day}/${d.month}/${d.year}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 95, 157, 247))),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 210,
                                    alignment: Alignment.topLeft,
                                    child: Column(children: [
                                      Text("ที่อยู่ ${data['address']} ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 95, 157, 247))),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                  // elevation: 20.0,
                  child: Container(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: IconButton(
                        iconSize: 50,
                        icon: const Icon(Icons.home),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return ItemList();
                            },
                          ));
                        },
                      ),
                    ),
                    IconButton(
                      iconSize: 50.0,
                      padding: const EdgeInsets.only(right: 50),
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            auth.signOut();
                            return WellcomeScreen();
                          },
                        ));
                      },
                    )
                  ],
                ),
              )),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
