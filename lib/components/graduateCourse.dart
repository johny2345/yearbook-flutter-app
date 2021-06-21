import 'package:flutter/material.dart';
import 'package:yearbook/components/displayGraduates.dart';

class GraduateCoursePage extends StatelessWidget {
  final programs;
  final course;
  GraduateCoursePage({Key key, this.programs, this.course});
  String dept = '';
  String appbarTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Courses'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: _determineCategory(context),
      ),
    );
  }

  _determineCategory(BuildContext context) {
    if (course == 'CEIT') {
      return _displayCeit(context);
    } else if (course == 'CAS') {
      return _displayCas(context);
    } else if (course == 'CTE') {
      return _displayCte(context);
    } else if (course == 'CT') {
      return _displayCt(context);
    } else if (course == 'MIE') {
      return _displayMie(context);
    } else if (course == 'MAE') {
      return _displayMae(context);
    }
  }

  _displayCeit(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'COLLEGE OF ENGINEERING AND INFORMATION TECHNOLOGY',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Science in Civil Engineering')));
            },
            child: Text('Bachelor of Science in Civil Engineering'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Electronics Communication Engineering')));
            },
            child: Text(
              'Bachelor of Science in Electronics Communication Engineering',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Electrical Engineering')));
            },
            child: Text('Bachelor of Science in Electrical Engineering'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Computer Engineering')));
            },
            child: Text('Bachelor of Science in Computer Engineering'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Information Technology')));
            },
            child: Text('Bachelor of Science in Information Technology'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Science in Computer Science')));
            },
            child: Text('Bachelor of Science in Computer Science'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Information System')));
            },
            child: Text('Bachelor of Science in Information System'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  _displayCas(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'COLLEGE OF ARTS AND SCIENCES',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Environment Science')));
            },
            child: Text('Bachelor of Science in Environment Science'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Science and Mathematics')));
            },
            child: Text('Bachelor of Science and Mathematics'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Arts in English Literature')));
            },
            child: Text('Bachelor of Arts in English Literature'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  _displayCte(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.0,
        ),
        Text(
          'COLLEGE OF TEACHER EDUCATION',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Secondary Education Major in English')));
            },
            child: Text(
              'Bachelor of Secondary Education Major in English',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Secondary Education Major in Filipino')));
            },
            child: Text('Bachelor of Secondary Education Major in Filipino',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Secondary Education Major in Science')));
            },
            child: Text('Bachelor of Secondary Education Major in Science',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Secondary Education Major in Mathematics')));
            },
            child: Text('Bachelor of Secondary Education Major in Mathematics',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Elementary Education')));
            },
            child: Text('Bachelor of Elementary Education',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Physical Education')));
            },
            child: Text('Bachelor of Physical Education',
                textAlign: TextAlign.center),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  _displayCt(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'COLLEGE OF TECHNOLOGY',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Technical Teacher Education')));
            },
            child: Text('Bachelor of Technical Teacher Education'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Bachelor of Technical Teacher Education')));
            },
            child: Text('Bachelor of Technical Teacher Education'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Tourism Management')));
            },
            child: Text('Bachelor of Science in Tourism Management'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Science in Hospitality Management')));
            },
            child: Text('Bachelor of Science in Hospitality Management',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Technical Teacher Education Major in Automotive Technology')));
            },
            child: Text(
                'Bachelor of Technical Teacher Education Major in Automotive Technology',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Technical Teacher Education Major in Electrical Technology')));
            },
            child: Text(
                'Bachelor of Technical Teacher Education Major in Electrical Technology',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Technical Teacher Education Major in Foods and Services Management')));
            },
            child: Text(
                'Bachelor of Technical Teacher Education Major in Foods and Services Management',
                textAlign: TextAlign.center),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Automotive Engineering Technology')));
            },
            child: Text('Bachelor of Automotive Engineering Technology'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Bachelor of Electrical Engineering Technology')));
            },
            child: Text('Bachelor of Electrical Engineering Technology',
                textAlign: TextAlign.center),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  _displayMie(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'MASTER IN INDUSTRIAL EDUCATION ',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Major in Automotive Technology')));
            },
            child: Text('Major in Automotive Technology'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Major in Electrical Technology')));
            },
            child: Text('Major in Electrical Technology'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Major in Electronics Technology')));
            },
            child: Text('Major in Electronics Technology'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Major in Mechanical Technology')));
            },
            child: Text('Major in Mechanical Technology'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Major in Architectural Drafting Technology')));
            },
            child: Text(
              'Major in Architectural Drafting Technology',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course:
                              'Major in Foods Technology and Industrial Arts')));
            },
            child: Text(
              'Major in Foods Technology and Industrial Arts',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  _displayMae(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Text(
          'MASTER OF ARTS IN EDUCATION',
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Major in General Science')));
            },
            child: Text('Major in General Science'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Major in General English')));
            },
            child: Text('Major in General English'),
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
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisplayGraduatesPage(
                          course: 'Major in General Filipino')));
            },
            child: Text('Major in General Filipino'),
          ),
        ),
      ],
    );
  }
}
