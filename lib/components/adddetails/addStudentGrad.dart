import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddStudentGraduatePage extends StatefulWidget {
  final title;
  final name;
  final expressPhoto;
  final gradPhoto;
  final uid;
  final course;
  final fromAdminPage;
  AddStudentGraduatePage(
      {Key key,
      this.title,
      this.name,
      this.expressPhoto,
      this.gradPhoto,
      this.uid,
      this.fromAdminPage,
      this.course});

  @override
  _AddStudentGraduatePageState createState() => _AddStudentGraduatePageState(
      title: title,
      name: name,
      fromAdminPage: fromAdminPage,
      expressPhoto: expressPhoto,
      gradPhoto: gradPhoto,
      uid: uid,
      course: course);
}

class _AddStudentGraduatePageState extends State<AddStudentGraduatePage> {
  _AddStudentGraduatePageState({
    Key key,
    this.title,
    this.fromAdminPage,
    this.expressPhoto,
    this.gradPhoto,
    this.uid,
    this.name,
    this.course,
  });
  final title;
  final fromAdminPage;
  final expressPhoto;
  final gradPhoto;
  // This uid actually describes as the ID of the document.
  final uid;
  final name;
  final course;

  bool disableGradButton = true;
  bool disableExpressButton = true;

  dynamic _gradImage = null;
  dynamic _expressImage = null;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController mottoController = TextEditingController();

  String fullName, birthday, motto = '';
  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    fullNameController.dispose();
    birthdayController.dispose();
    mottoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  var _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#|^&*(),,.<>:[]{}';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  displaySnackBar(message) {
    final snackbar = new SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Future uploadStudent(_gradPhoto, _expressPhoto) async {
    if (uid != null) {
      setState(() {
        isLoading = true;
      });
      print('USER HAS ID------------------' + uid);
      fullName = name;
      print('FILE TO BE UPLOADED: ' + _gradPhoto.toString());
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('graduates/' + getRandomString(30));
      print('EXPRESS TO BE UPLOADED: ' + _expressPhoto.toString());
      StorageUploadTask uploadTask = storageReference.putFile(_gradPhoto);

      StorageReference storageReference2 = FirebaseStorage.instance
          .ref()
          .child('graduates/' + getRandomString(30));
      StorageUploadTask uploadTask2 = storageReference2.putFile(_expressPhoto);
      await uploadTask.onComplete;
      await uploadTask2.onComplete;
      if (uploadTask.isSuccessful && uploadTask2.isSuccessful) {
        dynamic gradphoto = await storageReference.getDownloadURL();
        dynamic expressPhoto = await storageReference2.getDownloadURL();
        Firestore.instance.runTransaction((transaction) async {
          DocumentReference postRef =
              Firestore.instance.collection('graduate').document(uid);
          await transaction.update(
              postRef, {'gradPhoto': gradphoto, 'expressPhoto': expressPhoto});
        });

        displaySnackBar('File uploaded successfully!');
        print("------------FILE UPLOADED SUCCESSFULLY------------");
        setState(() {
          _gradPhoto = null;
          _expressPhoto = null;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        displaySnackBar('Failed to upload image.');
      }
    } else {
      setState(() {
        isLoading = true;
      });
      fullName = fullNameController.text;
      birthday = birthdayController.text;
      motto = mottoController.text;

      print('FILE TO BE UPLOADED: ' + _gradPhoto.toString());
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('graduates/' + getRandomString(30));
      StorageUploadTask uploadTask = storageReference.putFile(_gradPhoto);
      await uploadTask.onComplete;

      StorageReference storageReference2 = FirebaseStorage.instance
          .ref()
          .child('graduates/' + fullName.toUpperCase() + getRandomString(30));
      StorageUploadTask uploadTask2 = storageReference2.putFile(_expressPhoto);
      await uploadTask2.onComplete;
      if (uploadTask.isSuccessful && uploadTask2.isSuccessful) {
        print('---------GETTING URLS------');
        dynamic gradphoto = await storageReference.getDownloadURL();
        dynamic expressPhoto = await storageReference2.getDownloadURL();
        Firestore.instance.collection("graduate").add({
          "gradPhoto": gradphoto,
          "expressPhoto": expressPhoto,
          "name": fullName.toUpperCase(),
          "motto": motto,
          "course": course,
          "birthday": birthday
        });
        setState(() {
          _expressPhoto = null;
          _gradPhoto = null;
          isLoading = false;
        });
        displaySnackBar('File uploaded successfully!');
        print("------------FILE UPLOADED SUCCESSFULLY------------");
      } else {
        setState(() {
          isLoading = false;
        });
        displaySnackBar('Failed to upload image.');
      }
    }
  }

  void chooseGradPhoto(ImageSource source, {BuildContext context}) async {
    setState(() {
      disableGradButton = false;
    });
    try {
      await _picker.getImage(source: ImageSource.gallery).then((imageFile) {
        setState(() {
          _gradImage = File(imageFile.path);
        });
      });
    } catch (e) {
      setState(() {
        // _pickImageError = e;
        print('---------------------------------------------');
        print("THIS ERROR: " + e.toString());
      });
    }
  }

  void chooseExpressPhoto(ImageSource source, {BuildContext context}) async {
    setState(() {
      disableExpressButton = false;
    });
    try {
      await _picker.getImage(source: ImageSource.gallery).then((imageFile) {
        setState(() {
          _expressImage = File(imageFile.path);
        });
      });
    } catch (e) {
      setState(() {
        // _pickImageError = e;
        print('---------------------------------------------');
        print("THIS ERROR: " + e.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Add'),
        ),
        body: _displayLoadData(context),
      ),
    );
  }

  _displayLoadData(BuildContext context) {
    if (isLoading == false) {
      return _previewImage(context);
    } else {
      return Center(
        child: Container(
          child: Image.asset('assets/loading2.gif'),
        ),
      );
    }
  }

  Widget _previewImage(BuildContext context) {
    if (_gradImage != null && _expressImage != null && fromAdminPage != true) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.file(
              _gradImage,
              height: 300,
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    chooseGradPhoto(ImageSource.gallery, context: context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.change_history),
                      Text(
                        'CHANGE GRADUATION PHOTO',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  color: Colors.teal[400]),
            ),
            new Image.file(
              _expressImage,
              height: 300,
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: RaisedButton(
                textColor: Colors.white,
                onPressed: () {
                  chooseExpressPhoto(ImageSource.gallery, context: context);
                },
                child: Row(
                  children: [
                    Icon(Icons.change_history),
                    Text(
                      'CHANGE EXPRESS YOURSELF PHOTO',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                color: Colors.teal[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 25,
                controller: fullNameController,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    labelText: 'Enter Full Name'),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter the full name';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 20,
                controller: birthdayController,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    labelText: 'Enter birthday'),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter the birthday';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 100,
                controller: mottoController,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    labelText: 'Enter motto'),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter the motto';
                  }
                },
              ),
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.teal,
                onPressed: () {
                  uploadStudent(_gradImage, _expressImage);
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
      // This condition is being put after the admin user chose the photo already.
    } else if (fromAdminPage == true &&
        _gradImage != null &&
        _expressImage != null) {
      print(
          '_gradImage != null && _expressImage != null && fromAdminPage != tru');
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              new Image.file(
                _gradImage,
                height: 300,
                width: 300,
              ),
              Container(
                height: 100.0,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    chooseGradPhoto(ImageSource.gallery, context: context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.change_history),
                      Text(
                        'CHANGE GRDUATION PHOTO',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  color: Colors.teal[400],
                ),
              ),
              new Image.file(
                _expressImage,
                height: 300,
                width: 300,
              ),
              Container(
                height: 100.0,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: RaisedButton(
                    textColor: Colors.white,
                    onPressed: () =>
                        chooseGradPhoto(ImageSource.gallery, context: context),
                    child: Row(
                      children: [
                        Icon(Icons.change_history),
                        Text(
                          'CHANGE EXPRESS PHOTO',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    color: Color(0xff0091EA)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 40,
                enabled: false,
                controller: fullNameController,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    labelText: 'Enter Full Name'),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter the full name';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 40,
                enabled: false,
                controller: birthdayController,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    labelText: 'Enter Birthday'),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Enter Birthday';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 40,
                enabled: false,
                controller: mottoController,
                decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                    labelText: 'Enter motto'),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please motto';
                  }
                },
              ),
              Container(
                height: 100.0,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.teal,
                  onPressed: () {
                    uploadStudent(_gradImage, _expressImage);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.file_upload),
                      Text('ADD'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (_gradImage == null || _expressImage == null) {
      print('_gradImage == null || _expressImage == null');
      print(_gradImage);
      print(_expressImage);
      return SingleChildScrollView(
          child: Center(
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
                color: Colors.teal,
                onPressed: disableGradButton
                    ? () =>
                        chooseGradPhoto(ImageSource.gallery, context: context)
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload),
                    Text('CHOOSE GRADUATE PHOTO'),
                  ],
                ),
              ),
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.teal,
                onPressed: disableExpressButton
                    ? () => chooseExpressPhoto(ImageSource.gallery,
                        context: context)
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload),
                    Text('CHOOSE EXPRESS PHOTO'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    } else {
      print('wala gyud sa condition');
      return Container();
    }
  }
}
