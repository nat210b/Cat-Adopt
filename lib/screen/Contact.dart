import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_first_app/screen/item_list.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Image.network(
              "https://scontent.fbkk9-2.fna.fbcdn.net/v/t1.15752-9/306724367_510748177747518_8928436507697986768_n.png?_nc_cat=109&ccb=1-7&_nc_sid=ae9488&_nc_eui2=AeFo_VvbIgq_lPGNM_Jy_mnW-B3Sdb4HWo74HdJ1vgdajrkA_OF0rVkzorBbWhqerig7h2qfJu9jcf7oxtKZiial&_nc_ohc=DSM-UeQ9zWsAX-cT7-K&tn=CNweDMgJ6ydRfd9g&_nc_ht=scontent.fbkk9-2.fna&oh=03_AdT91Etc8jlbdubhjxL1Ogqe_JP1obceLXfBLkyurF_hWA&oe=638A0347",
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 159, 240, 162)),
                  borderRadius: BorderRadius.circular(90),
                  color: Color.fromARGB(255, 159, 240, 162)),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Icon(
                  Icons.rocket_launch,
                  color: Colors.white,
                  size: 70,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "คำขอของท่านได้ส่งไปยังมูลนิธิแล้วโปรดรอการติดต่อกลับ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.yellow),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)))),
                    ),
                    child: Text(
                      "กลับสู่หน้าหลัก",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return ItemList(); //CreateData();
                        },
                      ));
                    }))
          ],
        )),
      ),
    );
  }
}
