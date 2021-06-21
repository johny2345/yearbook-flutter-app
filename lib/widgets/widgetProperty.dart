import 'package:flutter/material.dart';
import 'package:yearbook/api/apiProvider.dart';
import 'package:yearbook/components/uploadImage.dart';

class WidgetProperties {
  loadingProgress(BuildContext context) {
    return Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  displayDialog(BuildContext context, message) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 250.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlineButton(
                      child: Text("Okay"),
                      textColor: Colors.black54,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      borderSide: BorderSide(color: Colors.blue),
                      onPressed: () {
                        Navigator.pop(context);
                        ApiProvider().signOut();
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeScreen()));
                      },
                    ),
                  ],
                ),
              ]),
            ),
          );
        });
  }

  isNotVerifiedDialog(BuildContext context, user) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 250.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          "Email not verified, please verify your email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlineButton(
                        child: Text("resend"),
                        textColor: Colors.black54,
                        borderSide: BorderSide(color: Colors.teal),
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        onPressed: () {
                          print(user);
                          print('kini nga user');
                          // user.sendEmailVerification();
                          ApiProvider().signOut();
                          Navigator.of(context).pop();
                        }),
                    OutlineButton(
                      child: Text("okay"),
                      textColor: Colors.black54,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      borderSide: BorderSide(color: Colors.blue),
                      onPressed: () {
                        ApiProvider().signOut();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ]),
            ),
          );
        });
  }

  Future<void> invalidEmailOrPassword(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Invalid email or password'),
          content: new Text("This email or password might not exist"),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                    child: RaisedButton(
                  color: Colors.blue,
                  // highlightedBorderColor: Colors.teal,
                  textColor: Colors.white,
                  child: Text('OK'),
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  onPressed: () {
                    print(
                        '------------HAS CLICKED INVALID EMAIL/PASSWORD!--------');
                    Navigator.of(context).pop();
                  },
                ))
              ],
            ),
          ],
        );
      },
    );
  }

  isCreatedSuccessfully(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 250.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                        ),
                        child: Center(
                          child: Text(
                            "Account created successfully",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text('Awesome'),
                    textColor: Colors.black,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    onPressed: () {
                      Navigator.pop(context);
                      ApiProvider().signOut();
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => UploadImage(),
                      //     ));
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  emailAlreadyExist(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 100.0,
              width: 200.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Column(children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                    ),
                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Email already in use, please use another",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      borderSide: BorderSide(color: Colors.black),
                      textColor: Colors.black54,
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ]),
            ),
          );
        });
  }
}
