import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_first_app/model/profile.dart';
import 'package:my_first_app/screen/Reset.dart';
import 'package:my_first_app/screen/item_list.dart';
import 'package:my_first_app/screen/reg.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({super.key});

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase =
      Firebase.initializeApp() as Future<FirebaseApp>;
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
                              "หาบ้านให้แมว",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ยินดีต้อนรับ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          child: Image.network(
                            "https://media.discordapp.net/attachments/1025736355772379167/1025736479663722526/Artboard_22.png?width=671&height=671",
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
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
                                      decoration:
                                          InputDecoration(hintText: "Email"),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "กรอกอีเมล"),
                                        EmailValidator(
                                            errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                                      ]),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (String? email) {
                                        profile.email = email;
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration:
                                          InputDecoration(hintText: "Password"),
                                      validator: RequiredValidator(
                                          errorText: "กรอกรหัสผ่าน"),
                                      obscureText: true,
                                      onSaved: (String? password) {
                                        profile.password = password;
                                      },
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                    onPressed: () {
                                      print("Forgot password");
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const ResetScreen();
                                      }));
                                    },
                                    child: Text("ลืมรหัสผ่าน?")),
                                SizedBox(
                                  height: 40,
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
                                      "เข้าสู่ระบบ",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState?.save();
                                        try {
                                          var email2 = profile.email!;
                                          var password2 = profile.password!;

                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email2,
                                                  password: password2)
                                              .then((value) {
                                            formKey.currentState?.reset();
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ItemList();
                                            }));
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.message!,
                                              gravity: ToastGravity.CENTER);

                                          // print(e.code);
                                          // print(e.message);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("ยังไม่มีบัญชีใช่ไหม?"),
                                      TextButton(
                                        child: Text("ลงทะเบียน",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 123, 0))),
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const RegScreen();
                                          }));
                                        },
                                      ),
                                    ]),
                                SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          ),
                        )),
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
