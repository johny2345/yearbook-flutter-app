import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:yearbook/api/apiProvider.dart'; // For File Upload To Firestore
import 'package:firebase_storage/firebase_storage.dart';

class UploadImage extends StatefulWidget {
  final String title;
  final name;
  final url;
  final id;
  final fromAdminPage;
  UploadImage(
      {Key key, this.title, this.name, this.fromAdminPage, this.url, this.id})
      : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState(
      title: title,
      name: name,
      fromAdminPage: fromAdminPage,
      url: url,
      uid: id);
}

class _UploadImageState extends State<UploadImage> {
  _UploadImageState(
      {Key key, this.title, this.name, this.fromAdminPage, this.url, this.uid});
  final String title;
  final String name;
  final uid;
  final url;
  bool isLoading = false;
  final fromAdminPage;
  String fullName = '';
  File _image = null;
  dynamic _pickImageError;

  TextEditingController fullNameController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

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

  Future uploadFile(_image) async {
    if (uid != null) {
      setState(() {
        isLoading = true;
      });
      print('USER HAS ID------------------' + uid);
      fullName = name;
      print('FILE TO BE UPLOADED: ' + _image.toString());
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('graduates/' + fullName.toUpperCase());
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      if (uploadTask.isSuccessful) {
        await storageReference.getDownloadURL().then((value) {
          Firestore.instance.runTransaction((transaction) async {
            DocumentReference postRef =
                Firestore.instance.collection('images').document(uid);
            // DocumentSnapshot snapshot = await transaction.get(postRef);
            await transaction.update(postRef, {'url': value});
          });
        });
        displaySnackBar('File uploaded successfully!');
        print("------------FILE UPLOADED SUCCESSFULLY------------");
        setState(() {
          _image = null;
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
      print('FILE TO BE UPLOADED: ' + _image.toString());
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('graduates/' + fullName.toUpperCase());
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      if (uploadTask.isSuccessful) {
        await storageReference.getDownloadURL().then((value) {
          Firestore.instance.collection("images").add(
              {"url": value, "name": fullName.toUpperCase()}).then((value) {});
        });
        setState(() {
          _image = null;
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

  @override
  Widget build(BuildContext context) {
    print('FROM ADMIN PAGE NAME EXIST OR NOT------------>');
    print(name);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(title.toString()),
        ),
        body: _displayLoadData(context),
      ),
    );
  }

  void chooseFile(ImageSource source, {BuildContext context}) async {
    try {
      await _picker.getImage(source: ImageSource.gallery).then((imageFile) {
        setState(() {
          _image = File(imageFile.path);
        });
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
        print('---------------------------------------------');
        print("THIS ERROR: " + e.toString());
        print('---------------------------------------------');
      });
    }
  }

  Widget _displayLoadData(BuildContext context) {
    if (isLoading == false) {
      return _previewImage(context);
    } else {
      return Center(
          child: Container(
        child: Image.asset('assets/loading2.gif'),
      ));
    }
  }

  Widget _previewImage(BuildContext context) {
    Text('Selected Image');
    if (_image != null && fromAdminPage != true) {
      print('---------------------------------------------');
      print('IMAGE TO BE DISPLAYED!' + _image.toString());
      print('---------------------------------------------');
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.file(
              _image,
              height: 300,
              width: 300,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLength: 40,
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
            // Text('Image to be displayed!'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
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
                      color: Color(0xff0091EA)),
                ),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal,
                    onPressed: () {
                      uploadFile(_image);
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
          ],
        ),
      );
    } else if (fromAdminPage == true && _image == null) {
      fullNameController.text = name.toString();
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Image.asset('assets/graduate.png')),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: TextFormField(
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
            ),
            // Text('Image to be displayed!'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                      color: Color(0xff0091EA)),
                ),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal,
                    onPressed: () {
                      uploadFile(_image);
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
          ],
        ),
      );
    } else if (fromAdminPage == true && _image != null) {
      fullNameController.text = name.toString();
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.file(
              _image,
              height: 300,
              width: 300,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
              child: TextFormField(
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
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                      color: Color(0xff0091EA)),
                ),
                Container(
                  height: 100.0,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.teal,
                    onPressed: () {
                      uploadFile(_image);
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
          ],
        ),
      );
    } else if (_image == null) {
      print('this image is missing button should display!-------------------');
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
                onPressed: () {
                  chooseFile(ImageSource.gallery, context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_upload),
                    Text('CHOOSE PHOTO'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    } else {
      print('this image is missing hehehe-------------------');
      print(_image);
      return Container();
    }
  }
}
