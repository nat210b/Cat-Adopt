import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/screen/User2.dart';
import 'package:my_first_app/screen/item_details.dart';

class ItemList extends StatelessWidget {
  ItemList({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('ProjectCat');
  final User = FirebaseFirestore.instance.collection("User").doc();
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //Check error
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }
            //Check if data arrived
            if (snapshot.hasData) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //Convert the documents to Maps
              List<Map> items = documents.map((e) => e.data() as Map).toList();

              //Display the list
              return Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 247, 233)),
                child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Get the item at this index
                      Map thisItem = items[index];
                      //REturn the widget for the list items
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 128, 126, 126),
                                    blurRadius: 4,
                                    offset: Offset(4, 8), // Shadow position
                                  ),
                                ],
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                    right: Radius.circular(30)),
                                color: Colors.orange,
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text('${thisItem['name']}'),
                                    subtitle:
                                        Text('พันธุ์ ${thisItem['species']}'),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_outlined),
                                    leading: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: thisItem.containsKey('image')
                                            ? Image.network(
                                                '${thisItem['image']}')
                                            : Container()),
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => ItemDetails(
                                                  '${thisItem['doc_id']}')));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }

            //Show loader
            return const Center(child: CircularProgressIndicator());
          },
        ),
        //Display a list // Add a FutureBuilder
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
                  onPressed: () {},
                ),
              ),
              IconButton(
                iconSize: 50.0,
                padding: const EdgeInsets.only(right: 50),
                icon: const Icon(Icons.account_circle_sharp),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return UserInfoScreen(
                          FirebaseAuth.instance.currentUser!.uid);
                    },
                  ));
                },
              )
            ],
          ),
        )));
  }
}
