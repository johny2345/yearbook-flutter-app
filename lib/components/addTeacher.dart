import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddTeacherPage extends StatefulWidget {
  AddTeacherPage({Key key}) : super(key: key);

  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  _AddTeacherPageState({Key key});

  TextEditingController nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  var _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#|^&*(),,.<>:[]{}';
  Random _rnd = Random();
  dynamic awardPhoto = null;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  displaySnackBar(message) {
    final snackbar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future uploadAwardee(_photo) async {
    setState(() {
      isLoading = true;
    });
    String name = nameController.text;
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('award/' + getRandomString(35));
    StorageUploadTask uploadTask = storageReference.putFile(_photo);
    await uploadTask.onComplete;
    if (uploadTask.isSuccessful) {
      dynamic photo = await storageReference.getDownloadURL();
      Firestore.instance.collection("teacher").add({
        'photo': photo,
        'name': name.toUpperCase(),
      });
      setState(() {
        photo = null;
        isLoading = false;
      });
      displaySnackBar('Teacher added successully');
      print('----------FILE UPLOADED SUCCESSFULLY---------');
    } else {
      setState(() {
        isLoading = false;
      });
      displaySnackBar('Failed to add teacher');
    }
  }

  void choosePhoto(ImageSource source, {BuildContext context}) async {
    try {
      await _picker.getImage(source: ImageSource.gallery).then((imageFile) {
        setState(() {
          awardPhoto = File(imageFile.path);
        });
      });
    } catch (e) {
      setState(() {
        print('ERROR WITH CHOOSING PHOTO------${'e.toString()'}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Add Teacher'),
            backgroundColor: Colors.teal,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                _displayLoadData(context),
              ],
            ),
          )),
    );
  }

  _displayLoadData(BuildContext context) {
    if (isLoading == false) {
      return _displayForm(context);
    } else {
      return Center(
        child: Container(
          child: Image.asset('assets/loading2.gif'),
        ),
      );
    }
  }

  _displayForm(BuildContext context) {
    print('-----DEBUG ID------');
    if (awardPhoto != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Image.file(
            awardPhoto,
            height: 300,
          ),
          Container(
            height: 100.0,
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: RaisedButton(
              textColor: Colors.white,
              onPressed: () {
                choosePhoto(ImageSource.gallery, context: context);
              },
              child: Row(
                children: [
                  Icon(Icons.change_history),
                  Text(
                    'CHANGE PHOTO',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              color: Colors.teal[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              maxLength: 30,
              controller: nameController,
              decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  labelText: "Enter Full Name"),
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter the Full Name';
                }
              },
            ),
          ),
          Container(
            height: 100.0,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: () {
                uploadAwardee(awardPhoto);
              },
              child: Row(
                children: [
                  Icon(Icons.file_upload),
                  Text('ADD TEACHER'),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (awardPhoto == null) {
      return Center(
        child: Column(
          children: <Widget>[
            Center(
              child: Image.asset('assets/graduate.png'),
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.teal[400],
                onPressed: () {
                  choosePhoto(ImageSource.gallery, context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload),
                    Text('CHOOSE TEACHER PHOTO'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
