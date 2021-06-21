import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userId;

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
          return initializeScaffold(context, snapshot.data);
        } else {
          return Container();
        }
      },
    );
  }

  initializeScaffold(BuildContext context, snapshot) {
    print('---------SNAPSHOTS-----');
    print(snapshot.data['firstName']);
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset('assets/user.png'),
            ),
            Text(
              snapshot.data['firstName'] + ' ' + snapshot.data['lastName'],
              style: TextStyle(fontSize: 20),
            ),
            Container(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'The past is my heritage; the present - my responsibility, the future - my challenge.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
