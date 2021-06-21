import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdatePhotoPage extends StatefulWidget {
  final toUpdate;
  final objectClass;
  UpdatePhotoPage({Key key, this.toUpdate, this.objectClass});

  @override
  _UpdatePhotoPageState createState() =>
      _UpdatePhotoPageState(toUpdate: toUpdate, objectClass: objectClass);
}

class _UpdatePhotoPageState extends State<UpdatePhotoPage> {
  final toUpdate, objectClass;
  _UpdatePhotoPageState({Key key, this.toUpdate, this.objectClass});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();
  File _image = null;
  bool isLoading = false;

  var _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#|^&*(),,.<>:[]{}';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    super.initState();
  }

  displaySnackBar(message) {
    final snackbar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future updateGraduatePhoto() async {
    StorageReference storageReference;
    setState(() {
      isLoading = true;
    });
    if (objectClass == 'gradPhoto') {
      storageReference = FirebaseStorage.instance
          .ref()
          .child('graduates/' + getRandomString(35));
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('photo uploaded successfully...');
      print('gettimg downloadurl...');
      await storageReference.getDownloadURL().then((value) {
        Firestore.instance.runTransaction((transaction) async {
          DocumentReference postRef = Firestore.instance
              .collection('graduate')
              .document(toUpdate.documentID);
          await transaction.update(postRef, {objectClass: value});
        });
      });
    } else if (objectClass == 'awardee') {
      storageReference = FirebaseStorage.instance
          .ref()
          .child('awardee/' + getRandomString(35));

      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('photo uploaded successfully...');
      print('gettimg downloadurl...');
      await storageReference.getDownloadURL().then((value) {
        Firestore.instance.runTransaction((transaction) async {
          DocumentReference postRef = Firestore.instance
              .collection('awardee')
              .document(toUpdate.documentID);
          await transaction.update(postRef, {'photo': value});
        });
      });
    } else if (objectClass == 'teacher') {
      debugPrint('update teacher photo!');
      print(toUpdate.documentID);
      storageReference = FirebaseStorage.instance
          .ref()
          .child('teacher/' + getRandomString(35));

      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('photo uploaded successfully...');
      print('gettimg downloadurl...');
      await storageReference.getDownloadURL().then((value) {
        Firestore.instance.runTransaction((transaction) async {
          DocumentReference postRef = Firestore.instance
              .collection('teacher')
              .document(toUpdate.documentID);
          await transaction.update(postRef, {'photo': value});
        });
      });
    } else {
      storageReference = FirebaseStorage.instance
          .ref()
          .child('graduates/' + toUpdate['name'] + getRandomString(30));

      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('photo uploaded successfully...');
      print('gettimg downloadurl...');
      await storageReference.getDownloadURL().then((value) {
        Firestore.instance.runTransaction((transaction) async {
          DocumentReference postRef = Firestore.instance
              .collection('graduate')
              .document(toUpdate.documentID);
          await transaction.update(postRef, {objectClass: value});
        });
      });
    }

    setState(() {
      isLoading = false;
    });
    displaySnackBar('File uploaded successfully!');
    print('---------GRADUATE PHOTO UPLOADED SUCCESSFULLY---------');
  }

  void chooseFile(ImageSource source, {BuildContext context}) async {
    try {
      await _picker.getImage(source: ImageSource.gallery).then((imageFile) {
        setState(() {
          _image = File(imageFile.path);
        });
      });
    } catch (err) {
      debugPrint('Failed to get the image.');
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print('----OBJECT CLASS-------');
    print(objectClass);
    print(toUpdate.documentID);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Change Photo'),
          backgroundColor: Colors.teal,
        ),
        body: _checkDisplay(context),
      ),
    );
  }

  _checkDisplay(BuildContext context) {
    if (isLoading == true) {
      return Center(
        child: Center(
            child: Container(
          child: Image.asset('assets/loading2.gif'),
        )),
      );
    } else {
      return _displayPhoto(context);
    }
  }

  _displayPhoto(BuildContext context) {
    if (_image != null) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            new Image.file(
              _image,
              height: 300,
              width: 300,
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    chooseFile(ImageSource.gallery, context: context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.change_history),
                      Text('CHANGE PHOTO'),
                    ],
                  ),
                  color: Colors.teal[400]),
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.teal,
                onPressed: () {
                  updateGraduatePhoto();
                },
                child: Row(
                  children: [
                    Icon(Icons.file_upload),
                    Text('UPLOAD PHOTO'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Container(
          height: 100.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: RaisedButton(
            textColor: Colors.white,
            onPressed: () {
              chooseFile(ImageSource.gallery, context: context);
            },
            child: Row(
              children: [
                Icon(Icons.change_history),
                Text('CHOOSE PHOTO'),
              ],
            ),
            color: Colors.teal[400],
          ),
        ),
      );
    }
  }
}
