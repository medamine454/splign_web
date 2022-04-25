import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:splign_web/stats/Stream_builder.dart';
import 'package:splign_web/stats/stats_page.dart';

class ListpatientStream extends StatefulWidget {
  @override
  _ListpatientStreamState createState() => _ListpatientStreamState();
}

class _ListpatientStreamState extends State<ListpatientStream> {
  Widget _card(String id_patient, String name, String email, String img) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Color.fromARGB(255, 29, 29, 29),
      elevation: 6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(img),
            ),
            title: Text(name,
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.email,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                      text: "  Email  : $email ",
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ],
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  final id = user!.uid;
                  DocumentReference ref =
                      FirebaseFirestore.instance.collection('users').doc(id);
                  await ref
                      .update({
                        'pending_patients':
                            FieldValue.arrayRemove([id_patient]),
                        'accepted_patients':
                            FieldValue.arrayUnion([id_patient]),
                      })
                      .then((value) => print("Patient deleted"))
                      .catchError(
                          (error) => print("Failed to add user: $error"));
                  setState(() {
                    cards_pending.remove(_card(id_patient, name, email, img));
                    patients_pending.remove(id_patient);
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Colors.green,
              ),
              RaisedButton.icon(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  final id = user!.uid;
                  DocumentReference ref =
                      FirebaseFirestore.instance.collection('users').doc(id);
                  await ref
                      .update({
                        'pending_patients':
                            FieldValue.arrayRemove([id_patient]),
                      })
                      .then((value) => print("Patient deleted"))
                      .catchError(
                          (error) => print("Failed to add user: $error"));
                  setState(() {
                    cards_pending.remove(_card(id_patient, name, email, img));
                    patients_pending.remove(id_patient);
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'Decline',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.green,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _card_normal(
      String id_patient, String name, String email, String img) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Color.fromARGB(255, 29, 29, 29),
      elevation: 6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(img),
            ),
            title: Text(name,
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.email,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                      text: "  Email  : $email ",
                      style: TextStyle(color: Colors.white, fontSize: 18.0)),
                ],
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LineChartSample2()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'View Stats',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.graphic_eq,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.black,
                color: Colors.green,
              ),
              RaisedButton.icon(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  final id = user!.uid;
                  DocumentReference ref =
                      FirebaseFirestore.instance.collection('users').doc(id);
                  await ref
                      .update({
                        'pending_patients':
                            FieldValue.arrayRemove([id_patient]),
                      })
                      .then((value) => print("Patient deleted"))
                      .catchError(
                          (error) => print("Failed to add user: $error"));
                  setState(() {
                    cards_pending.remove(_card(id_patient, name, email, img));
                    patients_pending.remove(id_patient);
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                textColor: Colors.white,
                splashColor: Colors.grey,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> patients_id = [];
  List<Widget> cards_pending = [];
  List<String> patients_pending = [];
  List<Widget> cards_accepted = [];
  List<String> patients_accepted = [];
  _fetch() async {
    final user = FirebaseAuth.instance.currentUser;
    final id = user!.uid;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) async {
        patients_pending = value.data()!['pending_patients'].cast<String>();
        patients_accepted = value.data()!['accepted_patients'].cast<String>();

        for (var i = 0; i < patients_pending.length; i++) {
          print(i);
          String name;
          String email;
          String img;
          String id_patient;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(patients_pending[i])
              .get()
              .then((value) {
            email = value.data()!['Email'];
            name = value.data()!['Username'];
            img = value.data()!['ImgUrl'];
            id_patient = patients_pending[i];
            cards_pending.add(_card(id_patient, name, email, img));
          }).catchError((e) {
            print(e);
          });
        }

        for (var i = 0; i < patients_accepted.length; i++) {
          print(i);
          String name;
          String email;
          String img;
          String id_patient;
          await FirebaseFirestore.instance
              .collection('users')
              .doc(patients_accepted[i])
              .get()
              .then((value) {
            email = value.data()!['Email'];
            name = value.data()!['Username'];
            img = value.data()!['ImgUrl'];
            id_patient = patients_accepted[i];
            cards_accepted.add(_card_normal(id_patient, name, email, img));
          }).catchError((e) {
            print(e);
          });
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              } else {
                return Scaffold(
                    body: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Pending invitations',
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                            width: 500,
                            height: 600,
                            padding: new EdgeInsets.all(10.0),
                            child: ListView.builder(
                                itemCount: patients_pending.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return cards_pending[index];
                                })),
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    Column(
                      children: [
                        Text('Current patients',
                            style: TextStyle(fontSize: 20)),
                        Container(
                            width: 500,
                            height: 600,
                            padding: new EdgeInsets.all(10.0),
                            child: ListView.builder(
                                itemCount: patients_accepted.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return cards_accepted[index];
                                })),
                      ],
                    ),
                  ],
                ));
              }
            }));
  }
}
