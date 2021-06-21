import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ApiProvider {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Null> signOut() async {
    print('------------USER SIGNED OUT--------------');
    await auth.signOut();
  }

  Future<Uri> uploadFile(_image) async {
    print('FILE TO BE UPLOADED: ' + _image.toString());
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('graduates/akira');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    if (uploadTask.isSuccessful) {
      print('-------------------------------------');
      print("FILE UPLOADED SUCCESSFULLY");
      print('-------------------------------------');
    }
    storageReference.getDownloadURL().then((fileURL) {
      return fileURL;
    });
  }

  getStudents() async {
    return await Firestore.instance.collection('images').snapshots();
  }

  Future<bool> updateStudentName(uid, name, motto, birthday) async {
    try {
      await Firestore.instance.runTransaction((transaction) async {
        DocumentReference postRef =
            Firestore.instance.collection('graduate').document(uid);
        await transaction.update(postRef,
            {'name': name.toUpperCase(), 'motto': motto, 'birthday': birthday});
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAwardeeName(name, documentId) async {
    print(documentId);
    print(name);
    try {
      await Firestore.instance.runTransaction((transaction) async {
        DocumentReference postRef =
            Firestore.instance.collection('awardee').document(documentId);
        await transaction.update(postRef, {'name': name.toUpperCase()});
      });
      print('UPDATED SUCCESSFULLY');
      return true;
    } catch (err) {
      print('Error update name');
      print(err);
      return false;
    }
  }

  Future<bool> updateTeacherName(name, documentId) async {
    print(documentId);
    print(name);
    try {
      await Firestore.instance.runTransaction((transaction) async {
        DocumentReference postRef =
            Firestore.instance.collection('teacher').document(documentId);
        await transaction.update(postRef, {'name': name.toUpperCase()});
      });
      print('UPDATED SUCCESSFULLY');
      return true;
    } catch (err) {
      print('Error update name');
      print(err);
      return false;
    }
  }

  Future downloadImage(url) async {
    try {
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return;
      }
    } on PlatformException catch (error) {
      print(error);
    }
  }
}

Future<void> addStudent(firstName, lastName, section, motto, sectionId) async {
  String fnameCamelCase =
      firstName[0].toUpperCase() + firstName.substring(1).toString();
  String lnameCamelCase =
      lastName[0].toUpperCase() + lastName.substring(1).toString();

  Record student = Record(
      firstName: fnameCamelCase,
      lastName: lnameCamelCase,
      section: section,
      motto: motto);

  try {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await Firestore.instance
          .collection('section')
          .document(sectionId)
          .setData(student.toJson());

      return true;
    });
  } catch (e) {
    print(e.toString());
    return false;
  }
}

class Record {
  String firstName;
  String lastName;
  String section;
  String motto;
  DocumentReference reference;

  Record({this.firstName, this.lastName, this.section, this.motto});

  Record.fromMap(Map<String, dynamic> map, {this.reference}) {
    firstName = map['firstName'];
    lastName = map['lastName'];
    section = map['section'];
    motto = map['motto'];
  }

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$firstName:$lastName:$section:$motto>";

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'section': section,
      'motto': motto,
    };
  }
}
