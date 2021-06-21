import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yearbook/api/apiProvider.dart';
import 'package:yearbook/components/mainview.dart';
import 'package:yearbook/setup/signUp.dart';
import 'package:yearbook/widgets/widgetProperty.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _iconVisible = Icon(Icons.visibility);
  String _email, _password;
  int _hasClicked = 0;
  bool _obscureText = true;
  FirebaseUser user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    getUser().then((user) {
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainView()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading == true) {
      return WidgetProperties().loadingProgress(context);
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Yearbook'),
          ),
          body: Builder(builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please provide an email';
                            }
                          },
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Enter email',
                              icon: new Icon(Icons.mail)),
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 30),
                      TextFormField(
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Input password';
                          }
                        },
                        onSaved: (input) => _password = input,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Password',
                          icon: new Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: _iconVisible,
                            onPressed: () {
                              if (_obscureText == true) {
                                setState(() {
                                  _obscureText = false;
                                  _iconVisible = Icon(Icons.visibility_off);
                                });
                              } else {
                                setState(() {
                                  _iconVisible = Icon(Icons.visibility);
                                  _obscureText = true;
                                });
                              }
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        maxLength: 30,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                      ),
                      new OutlineButton(
                        highlightedBorderColor: Colors.teal,
                        borderSide: BorderSide(color: Colors.teal),
                        onPressed: () {
                          signIn();
                        },
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                        child: Text('LOGIN'),
                        splashColor: Colors.teal,
                      ),
                      new Padding(padding: const EdgeInsets.only(top: 20.0)),
                      new Text('Don\'t have an account?'),
                      new InkWell(
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.teal),
                        ),
                        onTap: () {
                          print(
                              '--------------SIGN UP BUTTON CLICKED-----------');
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new SignUp()));
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }));
    }
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      if (_hasClicked == 0) {
        try {
          _hasClicked = 1;
          setState(() {
            _isLoading = true;
          });
          user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _email, password: _password))
              .user;

          if (user != null) {
            setState(() {
              _isLoading = false;
            });
            print('-------------THE USER HAS LOGGED IN-----------------------');
            print(user.uid);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainView()));
          }
          setState(() {
            _isLoading = false;
          });
          // return _hasClicked;
        } catch (e) {
          print(e);
          print('-------------INVALID EMAIL OR PASSWORD----------------------');
          setState(() {
            _hasClicked = 0;
            _isLoading = false;
          });
          WidgetProperties().invalidEmailOrPassword(context);
        }
      }
    }
  }
}
