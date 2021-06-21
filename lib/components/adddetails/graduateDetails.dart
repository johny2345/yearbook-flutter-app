import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yearbook/api/apiProvider.dart';
import 'package:yearbook/components/adddetails/UpdatePhoto.dart';

class GraduateDetailsPage extends StatefulWidget {
  final graduateDetails;
  GraduateDetailsPage({Key key, this.graduateDetails});

  @override
  _GraduateDetailsPageState createState() =>
      _GraduateDetailsPageState(graduateDetails: graduateDetails);
}

class _GraduateDetailsPageState extends State<GraduateDetailsPage> {
  _GraduateDetailsPageState({Key key, this.graduateDetails});

  final graduateDetails;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mottoController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var userId;
  bool isLoading = false;

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
    fullNameController.text = graduateDetails['name'];
    mottoController.text = graduateDetails['motto'];
    birthdayController.text = graduateDetails['birthday'];
    print('-------PHOTO PRINT--------');
    print(graduateDetails['gradPhoto']);
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('PERSONAL DETAILS'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                FadeInImage.assetNetwork(
                    placeholder: 'assets/loading2.gif',
                    image: graduateDetails['gradPhoto']),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    color: Colors.teal[400],
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new UpdatePhotoPage(
                                    toUpdate: graduateDetails,
                                    objectClass: 'gradPhoto',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.change_history),
                        Text('CHANGE GRADUATE PHOTO'),
                      ],
                    ),
                  ),
                ),
                FadeInImage.assetNetwork(
                    placeholder: 'assets/loading2.gif',
                    image: graduateDetails['expressPhoto']),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    color: Colors.teal[400],
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new UpdatePhotoPage(
                                    toUpdate: graduateDetails,
                                    objectClass: 'expressPhoto',
                                  )));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.change_history),
                        Text(
                          'CHANGE EXPRESS YOURSELF PHOTO',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Text(
                    graduateDetails['course'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      enabled: true,
                      controller: birthdayController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          labelText: 'Birthday'),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      enabled: true,
                      controller: mottoController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          labelText: 'Motto'),
                    )),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal,
                    onPressed: () {
                      String name = fullNameController.text;
                      String motto = mottoController.text;
                      String birthday = birthdayController.text;
                      ApiProvider()
                          .updateStudentName(
                              graduateDetails.documentID, name, motto, birthday)
                          .then((value) {
                        print(value);
                        if (value) {
                          displaySnackBar('Data updated successfully!');
                        } else {
                          displaySnackBar('Data failed to update!');
                        }
                      });
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
    fullNameController.text = graduateDetails['name'];
    birthdayController.text = graduateDetails['birthday'];
    mottoController.text = graduateDetails['motto'];
    return Scaffold(
      appBar: AppBar(
        title: Text('PERSONAL DETAILS'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                FadeInImage.assetNetwork(
                    placeholder: 'assets/loading2.gif',
                    image: graduateDetails['gradPhoto']),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal,
                    onPressed: () {
                      ApiProvider().downloadImage(graduateDetails['gradPhoto']);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_download),
                        Text('DOWNLOAD GRADUATE PHOTO'),
                      ],
                    ),
                  ),
                ),
                FadeInImage.assetNetwork(
                    placeholder: 'assets/loading2.gif',
                    image: graduateDetails['expressPhoto']),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal,
                    onPressed: () {
                      ApiProvider()
                          .downloadImage(graduateDetails['expressPhoto']);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_download),
                        Text(
                          'DOWNLOAD EXPRESS YOURSELF PHOTO',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Text(
                    graduateDetails['course'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
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
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      enabled: false,
                      controller: birthdayController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          labelText: 'Birthday'),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      maxLength: 30,
                      enabled: false,
                      controller: mottoController,
                      decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                          labelText: 'Motto'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
