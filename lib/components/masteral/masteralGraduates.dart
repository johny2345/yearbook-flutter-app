import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MasteralGraduatesPage extends StatefulWidget {
  final masteral;
  MasteralGraduatesPage({Key key, this.masteral});
  @override
  _MasteralGraduatesPageState createState() =>
      _MasteralGraduatesPageState(masteral: masteral);
}

class _MasteralGraduatesPageState extends State<MasteralGraduatesPage> {
  final masteral;
  _MasteralGraduatesPageState({Key key, this.masteral});
  String determineMasteralDeg = '';
  String appTitle = '';
  var userId;
  bool canAdd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(masteral),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: _determineMasteral(context),
      )),
    );
  }

  _determineMasteral(BuildContext context) {
    if (masteral == 'MAME') {
      setState(() {
        determineMasteralDeg = 'MASTER OF ARTS IN MATHEMATICS EDUCATION';
        appTitle = 'MASTER OF ARTS IN MATHEMATICS EDUCATION';
      });
    } else if (masteral == 'MIT') {
      setState(() {
        determineMasteralDeg = 'MASTER IN INFORMATION TECHNOLOGY';
        appTitle = 'MASTER IN INFORMATION TECHNOLOGY';
      });
    }
  }

  _getUser(BuildContext context) {
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
      body: new GetStudentsData(course: determineMasteralDeg),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     new MaterialPageRoute(
            //         builder: (context) => UploadImage(title: 'ADD STUDENT')));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        visible: canAdd,
      ),
    );
    ;
  }

  _displayMame(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
        ]);
  }
}

class GetStudentsData extends StatelessWidget {
  final course;
  GetStudentsData({Key key, this.course});

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection('graduate')
          .orderBy('name')
          .where('course', isEqualTo: course)
          .snapshots(),
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
                // print('--------------DOCUMENT ID: -------------------------');
                // print(document.documentID);
                // Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //         builder: (context) => new StudentDetails(
                //             name: document['name'],
                //             url: document['url'],
                //             id: document.documentID)));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
