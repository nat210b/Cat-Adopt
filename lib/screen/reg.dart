import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_first_app/screen/Wellcome.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final bool _validate = false;
  final formKey = GlobalKey<FormState>();
  DateTime date = DateTime(1990, 1, 1);
  String? gender;
  String? emailUser;
  String pass = '';
  List salary = [
    'น้อยกว่า 5,000 ',
    ' 5,001 - 10,000 ',
    ' 10,001 - 15,000 ',
    '15,001-20,000',
    '20,001-25,000',
    'มากกว่า25,000'
  ];
  String? saralyValue;
  String userSalary = '';
  String photo = '';
  String fname = '';
  String lname = '';
  String tel = '';
  String idCard = '';
  String address = '';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(color: Colors.orangeAccent),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                            "https://scontent.fbkk9-2.fna.fbcdn.net/v/t1.15752-9/306724367_510748177747518_8928436507697986768_n.png?_nc_cat=109&ccb=1-7&_nc_sid=ae9488&_nc_eui2=AeFo_VvbIgq_lPGNM_Jy_mnW-B3Sdb4HWo74HdJ1vgdajrkA_OF0rVkzorBbWhqerig7h2qfJu9jcf7oxtKZiial&_nc_ohc=DSM-UeQ9zWsAX-0D5Xh&tn=CNweDMgJ6ydRfd9g&_nc_ht=scontent.fbkk9-2.fna&oh=03_AdQUc-r9L4TYLj8sgYxL3DQPVapeMR7RRR7QZjNfNfI4Og&oe=638B1C87"),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "ชื่อ",
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "โปรดใส่ชื่อจริง"),
                                    ]),
                                    onSaved: (String? name) {
                                      fname = name!;
                                    },
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: "นามสกุล"),
                                    validator: RequiredValidator(
                                        errorText: "โปรดใส่นามสกุล"),
                                    onSaved: (String? lastname) {
                                      lname = lastname!;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "เบอร์ติดต่อ"),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "โปรดกรอกเบอร์ติดต่อ"),
                                      PatternValidator(r"0[0-9]",
                                          errorText: "เบอร์โทรศัพท์ไม่ถูกต้อง"),
                                      MinLengthValidator(10,
                                          errorText:
                                              "เบอร์โทรศัพท์ไม่ครบ 10 ตัว")
                                    ]),
                                    onSaved: (String? tele) {
                                      tel = tele!;
                                    },
                                  ),
                                  TextFormField(
                                    validator: MultiValidator([
                                      MinLengthValidator(13,
                                          errorText:
                                              "รูปแบบรหัสบัตรประชาชนไม่ถูกต้อง"),
                                      MaxLengthValidator(13,
                                          errorText:
                                              "รหัสบัตรประชาชนไม่มากกว่า 13 หลัก")
                                    ]),
                                    decoration: InputDecoration(
                                        hintText: "รหัสบัตรประชาชน"),
                                    onSaved: (String? card) {
                                      idCard = card!;
                                    },
                                  ),
                                  Column(
                                    children: [
                                      RadioListTile(
                                          title: Text("Male"),
                                          value: 'Male',
                                          groupValue: gender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              gender = value;
                                            });
                                          }),
                                      RadioListTile(
                                          title: Text("Female"),
                                          value: 'Female',
                                          groupValue: gender,
                                          onChanged: (String? value) {
                                            setState(() {
                                              gender = value;
                                            });
                                          }),
                                    ],
                                  ),

                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: "Email"),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Please enter Email"),
                                      EmailValidator(
                                          errorText: "Email incorrect"),
                                      PatternValidator(r"@hotmail.com",
                                          errorText: "Email incorrect")
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (email) {
                                      emailUser = email;
                                    },
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Password'),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "Plese enter Password"),
                                      MinLengthValidator(8,
                                          errorText:
                                              "Password must more than 8 "),
                                    ]),
                                    obscureText: true,
                                    onSaved: (String? password) {
                                      pass = password!;
                                    },
                                  ),

                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: "ที่อยู่"),
                                    onSaved: (String? loca) {
                                      address = loca!;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: DropdownButton(
                                          hint: Text("รายได้ต่อเดือน(บาท)"),
                                          value: saralyValue,
                                          isExpanded: true,
                                          items: salary.map((valueItem) {
                                            return DropdownMenuItem(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            if (newValue == null) return;
                                            setState(() {
                                              saralyValue = newValue as String?;
                                              userSalary = saralyValue!;
                                            });
                                          }),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        alignment: Alignment.center,
                                        iconSize: 30,
                                        onPressed: () async {
                                          ImagePicker imagePicker =
                                              ImagePicker();
                                          XFile? file =
                                              await imagePicker.pickImage(
                                                  source: ImageSource.gallery);
                                          print('${file?.path}');

                                          if (file == null) return;

                                          //Import dart:core

                                          /*Step 2: Upload to Firebase storage*/
                                          //Install firebase_storage
                                          //Import the library

                                          //Get a reference to storage root
                                          Reference referenceRoot =
                                              FirebaseStorage.instance.ref();
                                          Reference referenceDirImages =
                                              referenceRoot
                                                  .child('Profile_Picture');

                                          //Create a reference for the image to be stored
                                          Reference referenceImageToUpload =
                                              referenceDirImages
                                                  .child(file.path);

                                          //Handle errors/success
                                          try {
                                            await referenceImageToUpload
                                                .putFile(File(file.path));
                                            //Success: get the download URL

                                            photo = await referenceImageToUpload
                                                .getDownloadURL();
                                            print("ลิงค์${photo}");
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                        icon: const Icon(
                                            Icons.add_a_photo_rounded),
                                      ),
                                      SizedBox(
                                          child: Text(
                                        "วันเกิด",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                      SizedBox(
                                        child: Text(
                                          '${date.day}/${date.month}/${date.year}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          DateTime? newDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: date,
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime(2100));
                                          if (newDate == null) return;

                                          setState(() => date = newDate);
                                        },
                                        icon:
                                            Icon(Icons.calendar_month_rounded),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  //register
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 50),
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
                                        "ลงทะเบียน",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState?.save();
                                          try {
                                            FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: '$emailUser',
                                                    password: pass)
                                                .then((value) {
                                              FirebaseAuth.instance.currentUser!
                                                  .updateDisplayName(fname);
                                              FirebaseAuth.instance.currentUser!
                                                  .updatePhotoURL(photo);
                                              final user = User(
                                                name: fname,
                                                lname: lname,
                                                tel: tel,
                                                idCard: idCard,
                                                gender: '$gender',
                                                date: date,
                                                email: '$emailUser',
                                                address: address,
                                                saraly: userSalary,
                                                image: photo,
                                              );
                                              createUser(user);
                                              formKey.currentState?.reset();
                                              Fluttertoast.showToast(
                                                  msg: "Register Success",
                                                  gravity: ToastGravity.CENTER);
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return WellcomeScreen();
                                              }));
                                            });
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code ==
                                                "email-already-in-use") {
                                              String message =
                                                  "มีอีเมล์นี้ในระบบแล้ว";
                                              Fluttertoast.showToast(
                                                  msg: message,
                                                  gravity: ToastGravity.CENTER);
                                            } else if (e.code ==
                                                "weak-password") {
                                              String message =
                                                  "รหัสผ่านต้องมากกว่า 7 ตัว";
                                              Fluttertoast.showToast(
                                                  msg: message,
                                                  gravity: ToastGravity.CENTER);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: e.message!,
                                                  gravity: ToastGravity.CENTER);
                                            }
                                            // print(e.code);
                                            // print(e.message);
                                          }
                                        }
                                        //auth.createUserWithEmailAndPassword(email: email, password: password)
                                        //auth.currentUser!.updateDisplayName(fname.text);
                                        //ใส่ค่า
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color: Color.fromARGB(255,
                                                          255, 255, 255)))),
                                        ),
                                        child: Text(
                                          "ยกเลิก",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const WellcomeScreen();
                                          }));
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    user.id = FirebaseAuth.instance.currentUser!.uid;
    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  String id;
  final String name;
  final String lname;
  final String tel;
  final String idCard;
  final String gender;
  final DateTime date;
  final String email;
  final String address;
  final String saraly;
  final String image;
  User({
    this.id = '',
    required this.name,
    required this.lname,
    required this.tel,
    required this.idCard,
    required this.gender,
    required this.date,
    required this.email,
    required this.address,
    required this.saraly,
    required this.image,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        "lname": lname,
        'Tel': tel,
        'ID-Card': idCard,
        "Gender": gender,
        "DOB": date,
        'email': email,
        'address': address,
        'saraly': saraly,
        'Image': image,
      };
}
