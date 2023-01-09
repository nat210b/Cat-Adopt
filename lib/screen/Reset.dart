import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_first_app/model/profile.dart';
import 'package:my_first_app/screen/Wellcome.dart';
import 'package:my_first_app/screen/item_list.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase =
      Firebase.initializeApp() as Future<FirebaseApp>;
  String mail = '';
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SingleChildScrollView(
              child: Scaffold(
                appBar: AppBar(
                  title: Text("error"),
                ),
                body: Center(
                  child: Text("${snapshot.error}"),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color.fromARGB(224, 255, 196, 0),
                    Color.fromARGB(255, 255, 115, 0)
                  ],
                )),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.00),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text(
                              "ลืมรหัสผ่าน",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "รับลิ้งค์เปลี่ยนรหัสผ่าน",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          child: Image.network(
                            'https://media.discordapp.net/attachments/1025736355772379167/1025736479663722526/Artboard_22.png?width=671&height=671',
                            alignment: Alignment.center,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "ระบุอีเมลผู้ใช้งาน"),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "กรอกอีเมล"),
                                          EmailValidator(
                                              errorText:
                                                  "รูปแบบอีเมลไม่ถูกต้อง")
                                        ]),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (String? email) {
                                          mail = email!;
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ]),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            try {
                                              auth.sendPasswordResetEmail(
                                                  email: mail);
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return const WellcomeScreen();
                                              }));
                                            } catch (e) {
                                              Fluttertoast.showToast(
                                                  msg: "ERROR");
                                            }
                                          },
                                          child: Text("Reset password"))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const WellcomeScreen();
                                          }));
                                        }),
                                  ),
                                  SizedBox(
                                    height: 160,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                    ]),
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
}
