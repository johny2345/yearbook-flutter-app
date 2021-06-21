import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yearbook/api/apiProvider.dart';
import 'package:yearbook/components/uploadImage.dart';

class StudentDetails extends StatefulWidget {
  final name, url, id;
  StudentDetails({Key key, this.name, this.url, this.id});

  @override
  _StudentDetailsState createState() =>
      _StudentDetailsState(name: name, url: url, id: id);
}

class _StudentDetailsState extends State<StudentDetails> {
  _StudentDetailsState(
      {Key key, @required this.name, @required this.url, this.id});
  TextEditingController fullNameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final name, url, id;
  var userId;
  // bool _canUpdate = false;

  displaySnackBar(message) {
    final snackbar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

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
            return displayDetailsForAdmin(context);
          } else {
            print('---------IS NOT ADMIN---------');
            return displayDetailsForStudents(context);
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget displayDetailsForAdmin(BuildContext context) {
    final bool _fromAdminPage = true;
    final String _title = 'CHANGE PHOTO';
    fullNameController.text = name;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('STUDENT DETAILS'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FadeInImage.assetNetwork(
                    placeholder: 'assets/loading2.gif', image: url),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      enabled: true,
                      controller: fullNameController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          labelText: 'Full Name'),
                    )),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new UploadImage(
                                    title: _title,
                                    name: name,
                                    fromAdminPage: _fromAdminPage,
                                    url: url,
                                    id: id)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.change_history),
                          Text('CHANGE PHOTO'),
                        ],
                      ),
                      color: Color(0xff0091EA)),
                ),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal[400],
                    onPressed: () {
                      // String fname = fullNameController.text;
                      // ApiProvider().updateStudentName(id, fname).then((value) {
                      //   print(value);
                      //   if (value) {
                      //     displaySnackBar('Data updated successfully!');
                      //   } else {
                      //     displaySnackBar('Data failed to update!');
                      //   }
                      // });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.update),
                        Text('UPDATE DETAILS'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget displayDetailsForStudents(BuildContext context) {
    fullNameController.text = name;
    return Scaffold(
      appBar: AppBar(
        title: Text('STUDENT DETAILS'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FadeInImage.assetNetwork(
                    placeholder: 'assets/loading2.gif', image: url),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      enabled: false,
                      controller: fullNameController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          labelText: 'Full Name'),
                    )),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal[400],
                    onPressed: () {
                      ApiProvider().downloadImage(url);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_download),
                        Text('DOWNLOAD IMAGE'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// sign up
