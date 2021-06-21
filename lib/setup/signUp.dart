import 'package:flutter/material.dart';
import 'package:yearbook/api/apiProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yearbook/widgets/widgetProperty.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePass = true;

  FirebaseUser user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mottoController = TextEditingController();

  var _visible = Icon(Icons.visibility);

  String _email, _password, _confirmPassword, userId;
  String _firstName, _lastName, _motto;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool _isWait = false;

  @override
  Widget build(BuildContext context) {
    print(_isWait);
    print('----------IS LOADING-----------------');
    if (_isWait) {
      return Center(
        child: Image.asset('assets/loading.gif'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/graduate.png',
                      width: 300.0,
                      height: 200,
                    ),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Provide an email';
                      }
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Enter email',
                      icon: new Icon(Icons.mail),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    maxLength: 50,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Input password';
                      }
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Confirm password',
                      icon: new Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: _visible,
                        onPressed: () {
                          if (_obscurePass == true) {
                            setState(() {
                              _obscurePass = false;
                              _visible = Icon(Icons.visibility_off);
                            });
                          } else {
                            setState(() {
                              _visible = Icon(Icons.visibility);
                              _obscurePass = true;
                            });
                          }
                        },
                      ),
                    ),
                    obscureText: _obscurePass,
                    maxLength: 50,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Field required';
                      }
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Enter first name',
                      icon: new Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    controller: firstNameController,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Field required';
                      }
                    },
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Enter last name',
                      icon: new Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    controller: lastNameController,
                  ),
                  new Padding(
                    padding: EdgeInsets.all(20.0),
                  ),
                  new OutlineButton(
                    highlightedBorderColor: Colors.teal,
                    textColor: Colors.black54,
                    onPressed: () {
                      signUp();
                    },
                    padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                    child: Text('SIGN UP'),
                    splashColor: Colors.deepOrange,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Future signUp() async {
    print('SIGN UP CALLED-------');
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('validated form');
      setState(() {
        print('IS WAIT TO TRUE-------------------');
        _isWait = true;
      });
      try {
        user = (await _firebaseAuth.createUserWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        userId = user.uid;
        print('created user');
        if (user != null) {
          await user.sendEmailVerification();
          await studentDetails();
          setState(() {
            print('IS WAIT TO FALSE-------------------');
            _isWait = false;
          });
          ApiProvider().signOut();
        }
      } catch (signUpError) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          WidgetProperties().displayDialog(
              context, "Email already in use, please use another");
        }
      }
    } else {
      print('not validated form');
    }
  }

  Future studentDetails() async {
    print('---------------STUDENT CREATE-------------');
    _firstName = firstNameController.text;
    _lastName = lastNameController.text;

    String toCamelCaseFName =
        _firstName[0].toUpperCase() + _firstName.substring(1).toString();
    String toCamelCaseLName =
        _lastName[0].toUpperCase() + _lastName.substring(1).toString();

    try {
      await Firestore.instance.runTransaction((transaction) async {
        DocumentReference postRef =
            Firestore.instance.collection('users').document(userId);
        Firestore.instance.collection("users").document(userId).setData({
          'firstName': toCamelCaseFName,
          'lastName': toCamelCaseLName,
          'is_admin': false
        }).then((value) {});
      });
      print('---------------STUDENT CREATED SUCCESSFULLY-------------');
      setState(() {
        print('IS WAIT TO FALSE-------------------');
        _isWait = false;
      });
      firstNameController.clear();
      lastNameController.clear();
      WidgetProperties().displayDialog(context,
          "Account created successfully, please verify your email to continue");
    } catch (e) {
      print(e.toString());
    }
  }
}
