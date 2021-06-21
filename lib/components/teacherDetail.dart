import 'package:flutter/material.dart';
import 'package:yearbook/api/apiProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yearbook/components/adddetails/updatePhoto.dart';

class TeacherDetailsPage extends StatefulWidget {
  final teacher;
  final isAdmin;
  TeacherDetailsPage({Key key, this.teacher, this.isAdmin});

  @override
  _TeacherDetailsPageState createState() =>
      _TeacherDetailsPageState(teacher: teacher, isAdmin: isAdmin);
}

class _TeacherDetailsPageState extends State<TeacherDetailsPage> {
  final teacher;
  final isAdmin;
  _TeacherDetailsPageState({Key key, this.teacher, this.isAdmin});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  displaySnackBar(message) {
    final snackbar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    if (isAdmin == true) {
      if (isLoading == false) {
        return displayDetailForAdmin(context);
      } else {
        return Center(
          child: Container(
            child: Image.asset('assets/loading2.gif'),
          ),
        );
      }
    } else {
      debugPrint('Is not admin');
      return displayDetailForStudents(context);
    }
  }

  Widget displayDetailForAdmin(BuildContext context) {
    nameController.text = teacher['name'];
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('TEACHER DETAILS'),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeInImage.assetNetwork(
                      placeholder: 'assets/loading2.gif',
                      image: teacher['photo']),
                  Container(
                    height: 100.0,
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: RaisedButton(
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new UpdatePhotoPage(
                                      toUpdate: teacher,
                                      objectClass: 'teacher')));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.change_history),
                            Text('CHANGE PHOTO'),
                          ],
                        ),
                        color: Colors.teal[400]),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 30,
                        enabled: true,
                        controller: nameController,
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
                      color: Colors.teal,
                      onPressed: () {
                        ApiProvider()
                            .updateTeacherName(
                                nameController.text, teacher.documentID)
                            .then((value) {
                          print('this value: ' + value.toString());
                          if (value) {
                            displaySnackBar('Name updated successfully');
                          } else {
                            displaySnackBar('Data failed to update');
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
                  SizedBox(height: 30.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget displayDetailForStudents(BuildContext context) {
    nameController.text = teacher['name'];
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('TEACHER DETAILS'),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FadeInImage.assetNetwork(
                      placeholder: 'assets/loading2.gif',
                      image: teacher['photo']),
                  Container(
                    height: 100.0,
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: RaisedButton(
                        textColor: Colors.white,
                        onPressed: () {
                          ApiProvider().downloadImage(teacher['photo']);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.change_history),
                            Text('DOWNLOAD PHOTO'),
                          ],
                        ),
                        color: Colors.teal[400]),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 30,
                        enabled: false,
                        controller: nameController,
                        decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                            labelText: 'Full Name'),
                      )),
                  SizedBox(height: 30.0)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
