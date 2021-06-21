import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yearbook/components/adddetails/addAwardee.dart';
import 'package:yearbook/components/adddetails/awardeeDetails.dart';

class AwardeePage extends StatefulWidget {
  final award;
  AwardeePage({Key key, this.award});
  @override
  _AwardeePageState createState() => _AwardeePageState(award: award);
}

class _AwardeePageState extends State<AwardeePage> {
  final award;
  _AwardeePageState({Key key, this.award});

  var userId;
  bool isAdmin;
  bool canAdd = false;

  @override
  void initState() {
    super.initState();
    // isAuthorizedOrNot(context);
  }

  @override
  Widget build(BuildContext context) {
    print('This awardee build UI');
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('getting userId');
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
        });
  }

  isAuthorizedOrNot(BuildContext context) {
    debugPrint('tHIS BUILD STREAMBUILDER');
    print(userId);
    return StreamBuilder(
      stream:
          Firestore.instance.collection('users').document(userId).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data['is_admin'] == true) {
            // setState(() {
            // });
            isAdmin = true;
            print('THE USER IS AN ADMIN');
            canAdd = true;
            return initializeScaffold(context);
          } else {
            // setState(() {
            // });
            isAdmin = false;
            print('THE USER IS NOT AN ADMIN');
            canAdd = false;
            return initializeScaffold(context);
          }
        } else {
          return Material(
            child: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget initializeScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(award),
        backgroundColor: Colors.teal,
      ),
      body: GetAwardeeData(
        award: award,
        isAdmin: isAdmin,
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.teal,
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AddAwardeePage(
                          award: award,
                        )));
          },
        ),
      ),
    );
  }
}

class GetAwardeeData extends StatefulWidget {
  final award, isAdmin;
  GetAwardeeData({Key key, this.award, this.isAdmin});

  @override
  _GetAwardeeDataState createState() =>
      _GetAwardeeDataState(award: award, isAdmin: isAdmin);
}

class _GetAwardeeDataState extends State<GetAwardeeData> {
  _GetAwardeeDataState({Key key, this.award, this.isAdmin});
  final award, isAdmin;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('awardee')
            .where('award', isEqualTo: award)
            .orderBy('name')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Material(
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            return _displayAwardee(context, snapshot.data);
          }
        });
  }

  Widget _displayAwardee(BuildContext context, QuerySnapshot snapshot) {
    print('---This awardee-----');
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
                print(isAdmin);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AwardeeDetailsPage(
                              student: document,
                              isAdmin: isAdmin,
                            )));
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
