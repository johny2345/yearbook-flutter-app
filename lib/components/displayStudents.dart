import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yearbook/components/displayStudentDetails.dart';
import 'package:yearbook/components/uploadImage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DisplayStudent extends StatefulWidget {
  @override
  _DisplayStudentState createState() => _DisplayStudentState();
}

class _DisplayStudentState extends State<DisplayStudent> {
  var userId;
  bool canAdd = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userId = snapshot.data.uid;
          print('----------------SNAPSHOT DATA DISPLAYYYYYY-------------');
          print(snapshot.data);
          return isAuthorizedOrNot(context);
        } else {
          return new CircularProgressIndicator();
        }
      },
    );
  }

  isAuthorizedOrNot(BuildContext context) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('users').document(userId).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data['is_admin'] == true) {
            canAdd = true;
            return initializeScaffold(context);
          } else {
            canAdd = false;
            print('---------IS NOT ADMIN---------');
            return initializeScaffold(context);
          }
        } else {
          return Container();
        }
      },
    );
  }

  initializeScaffold(BuildContext context) {
    return Scaffold(
      body: new GetStudentsData(),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => UploadImage(title: 'ADD STUDENT')));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        visible: canAdd,
      ),
    );
    ;
  }
}

class GetStudentsData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream:
          Firestore.instance.collection('images').orderBy('name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          return _displayStudents(context, snapshot.data);
        }
      },
    );
  }

  Widget _displayStudents(BuildContext context, QuerySnapshot snapshot) {
    return ListView(
      children: snapshot.documents.map((document) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0)),
            child: ListTile(
              leading: Icon(Icons.person),
              title: new Text(document['name']),
              onTap: () {
                print('--------------DOCUMENT ID: -------------------------');
                print(document.documentID);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new StudentDetails(
                            name: document['name'],
                            url: document['url'],
                            id: document.documentID)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
