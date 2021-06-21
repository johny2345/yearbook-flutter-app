import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yearbook/components/adddetails/addStudentGrad.dart';
import 'package:yearbook/components/adddetails/graduateDetails.dart';

class DisplayGraduatesPage extends StatefulWidget {
  final course;
  DisplayGraduatesPage({Key key, this.course});

  @override
  _DisplayGraduatesPageState createState() =>
      _DisplayGraduatesPageState(course: course);
}

class _DisplayGraduatesPageState extends State<DisplayGraduatesPage> {
  final course;
  _DisplayGraduatesPageState({Key key, this.course});

  var userId;
  bool canAdd = false;

  @override
  void initState() {
    super.initState();
    isAuthorizedOrNot(context);
  }

  @override
  Widget build(BuildContext context) {
    print(course);
    print('-----DISPLAY GRADUATES-------');
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          userId = snapshot.data.uid;
          print(snapshot.data);
          return isAuthorizedOrNot(context);
        }
        return Material(
          child: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
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
      appBar: AppBar(
        title: Text(course),
        backgroundColor: Colors.teal,
      ),
      body: new GetStudentsData(course: course),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AddStudentGraduatePage(
                          course: course,
                        )));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}

class GetStudentsData extends StatefulWidget {
  final course;
  GetStudentsData({Key key, this.course});
  @override
  _GetStudentsDataState createState() => _GetStudentsDataState(course: course);
}

class _GetStudentsDataState extends State<GetStudentsData> {
  _GetStudentsDataState({Key key, this.course});
  final course;
  @override
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection('graduate')
          .where('course', isEqualTo: course)
          .orderBy('name')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return _displayStudents(context, snapshot.data);
        }
      },
    );
  }

  Widget _displayStudents(BuildContext context, QuerySnapshot snapshot) {
    debugPrint('display graduates----------');
    print(snapshot.documents);
    debugPrint('display graduates----------');
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
                        builder: (context) => new GraduateDetailsPage(
                            graduateDetails: document)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
