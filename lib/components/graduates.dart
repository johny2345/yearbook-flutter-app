import 'package:flutter/material.dart';
import 'package:yearbook/components/awardee.dart';
import 'package:yearbook/components/displayGraduates.dart';
import 'package:yearbook/components/graduateCourse.dart';
import 'package:yearbook/components/masteral/masteralGraduates.dart';

class GraduatePage extends StatefulWidget {
  @override
  _GraduatePageState createState() => _GraduatePageState();
}

class _GraduatePageState extends State<GraduatePage> {
  String category = '';
  String course = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _displayUnderGraduate(context),
          _displayGraduates(context),
          _displayAwardee(context),
          SizedBox(
            height: 30,
          )
          // _displayUnderGraduate(context),
        ],
      ),
    );
  }

  _displayGraduates(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'GRADUATE PROGRAMS',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'MIE';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new GraduateCoursePage(course: category)));
            },
            child: Text('MASTER IN INDUSTRIAL EDUCATION'.toUpperCase()),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'MAME';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'MASTER OF ARTS IN MATHEMATICS EDUCATION')));
            },
            child:
                Text('MASTER OF ARTS IN MATHEMATICS EDUCATION'.toUpperCase()),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'MAE';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new GraduateCoursePage(course: category)));
            },
            child: Text('MASTER OF ARTS IN EDUCATION'.toUpperCase()),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'MIT';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'MASTER IN INFORMATION TECHNOLOGY')));
            },
            child: Text('MASTER IN INFORMATION TECHNOLOGY'.toUpperCase()),
          ),
        ),
      ],
    );
  }

  _displayUnderGraduate(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'UNDERGRADUATE PROGRAMS',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'CEIT';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new GraduateCoursePage(course: category)));
            },
            child: Text(
              'COLLEGE OF ENGINEERING AND INFORMATION TECHNOLOGY',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // const SizedBox(
        //   height: 30.0,
        // ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'CAS';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new GraduateCoursePage(course: category)));
            },
            child: Text('COLLEGE OF ARTS AND SCIENCES'),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'CTE';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new GraduateCoursePage(course: category)));
            },
            child: Text('COLLEGE OF TEACHER EDUCATION'),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'CT';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new GraduateCoursePage(course: category)));
            },
            child: Text('COLLEGE OF TECHNOLOGY'),
          ),
        ),
      ],
    );
  }

  _displayAwardee(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'AWARDEE',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'LEADERSHIP AWARDEES';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AwardeePage(award: category)));
            },
            child: Text(
              'LEADERSHIP AWARDEES',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'THE HUB JOURNALISM AWARD';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AwardeePage(award: category)));
            },
            child: Text(
              'THE HUB JOURNALISM AWARD',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'OTHER AWARDEES';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AwardeePage(award: category)));
            },
            child: Text(
              'OTHER AWARDEES',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'HONOR GRADUATES';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AwardeePage(award: category)));
            },
            child: Text(
              'HONOR GRADUATES',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'LOYALTY AWARDEES';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AwardeePage(award: category)));
            },
            child: Text(
              'LOYALTY AWARDEES',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'CITY SCHOLARS';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AwardeePage(award: category)));
            },
            child: Text(
              'CITY SCHOLARS',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          width: 1000,
          height: 80.0,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: RaisedButton(
            textColor: Colors.white,
            color: Colors.teal[400],
            onPressed: () {
              setState(() {
                category = 'PROVINCIAL SCHOLARS';
              });
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new AwardeePage(award: category)));
            },
            child: Text(
              'PROVINCIAL SCHOLARS',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
