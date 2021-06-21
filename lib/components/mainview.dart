import 'package:flutter/material.dart';
import 'package:yearbook/api/apiProvider.dart';
import 'package:yearbook/components/displayStudents.dart';
import 'package:yearbook/components/profile.dart';
import 'package:yearbook/components/uploadImage.dart';
import 'package:yearbook/setup/login.dart';
import 'package:yearbook/components/graduates.dart';
import 'package:yearbook/components/teacherCert.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),

    // ProfilePage()
    TeacherCurPage(),
    // DisplayStudent(),
    GraduatePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('YEARBOOK APP'),
          backgroundColor: Colors.teal,
          actions: <Widget>[
            RaisedButton(
              child: Text('Sign out'),
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: () {
                ApiProvider().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
          ]),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('TCC'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.school),
          //   title: Text('Graduates'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Graduates'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Image.asset(
                'assets/ssct.png',
                height: 250,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'FOREVER RADIANT',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Surigao State College Of Technology in Mindanao You’re a growing landmark SSCT, to you we bow.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "North star of the Region With a noble mission Here’s a place to mould men For technology, science and arts.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "North star of the Region With a noble mission Here’s a place to mould men For technology, science and arts.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Smiling youth and seasoned old Welcome ye to his glorious fold Learn and earn help all Be the wealth of our people.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Alma mater dearest Hope of our dear brothers Stand forever radiant, let the SSCT gear roll on and on.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Tow’ring high and mighty O’er man and nature’s threats You shall firmly stand The dark cloud of doubt Till the sun shines bright again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Surigao State College Of Technology, dear Stand forever radiant For your golden goals Our own success (back to tow’ring)",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "(Finale rit… with accent on radiant) Stay forever radiant, for our victory, is your…glo-ry…",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'PHILOSOPHY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "The Surigao State College of Technology (SSCT) is a community of lifelong learners who believe in the worth and total development of every individual. It adheres to the pursuit of excellence and to the democratic tenets of freedom, human dignity, wholesome work ethics, equality of opportunity and sustainable progress.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'VISION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "An innovative and technologically-advanced State College in Caraga.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'MISSION',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "To provide relevant, high quality and sustainable instruction, research production and extension programs and services within a culture of credible and responsive institutional governance.",
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'GOALS AND OBJECTIVES',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "SSCT aims to produce quality graduates that respond to the dynamics of national and international standards. Its goals and objectives are focused on the 5-point agenda: ",
                textAlign: TextAlign.justify,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Instruction, Research Development and Extension (RDE),   Resources Generation, Policy Implementation and Good Governance.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Instruction. To provide enhanced quality instruction that is responsive to the needs of the local, regional, national and global communities. Research, Development and Extension (RDE). To develop researches that can provide operative solutions and intensify research-based extension programs to its beneficiaries.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'QUALITY POLICY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Surigao State College of Technology provides quality instruction, research, extension, and production services to satisfy its customers by responding to their needs and expectations and continually improving its quality management system.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'INSTITUTIONAL CORE VALUES',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "SSCT is guided by its institutional core values:",
                textAlign: TextAlign.left,
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              width: 300,
              child: Text(
                "•	Service Oriented,",
                textAlign: TextAlign.left,
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              width: 300,
              child: Text(
                "•	Socially Responsive,",
                textAlign: TextAlign.left,
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              width: 300,
              child: Text(
                "•	Committed, and",
                textAlign: TextAlign.left,
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              width: 300,
              child: Text(
                "•	Transformational",
                textAlign: TextAlign.left,
                style: TextStyle(fontStyle: FontStyle.normal),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 70,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Center(
              child: Image.asset(
                'assets/pres.jpg',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'HON. GREGORIO Z. GAMBOA JR.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            Text(
              'College President',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              width: 300,
              child: Text(
                "My Cordial Felicitations to Batch 2015 graduates!",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Indeed, your academic toil has come to its fruition. Thanks to the strong bond of supporters with the intercession of the Almighty God who paved the way for your good harvest. Truly, you have carved your significant educational milestone.",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "The theme for this year’s Commencement Rites delves on SSCT: Rising to the Challenges of the ASEAN Integration. This theme resonates the new direction and perspective carried out by the Commission of Higher Education as the prime agency that oversees the academic welfare of the students of higher education institution. This is contained in CMO No. 11 series of 2014 which further defines the so-called ASEAN International Mobility for Students (AIMS). This subjected some HEIs to the internationalization process which gives students the chance to expand academic cooperation and adhere to the reciprocity principle. CHED listed some HEIs per region hoisting their flagship programs like UST and De La Salle for Language and Culture, UP for Food Tech, Economics, Engineering, Hospitality and Management, CMU for Agriculture, UM for Engineering, St. Paul University of the Philippines for Public Administration and Central Bicol University for Agriculture.",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Through SSCT is still an emerging academe striving to become a future university in CARAGA Region yet, there is this strong spark of hope that through the ASEAN integration there will always be a greater chance for our graduates to be in the mainstream of global workers equipped with ample knowledge, skills and attitudes hoisting our perspective flagship programs in the midst of ASEAN diversity.",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 300,
              child: Text(
                "Kudos to all of you dear Graduates! May you always remember your Alma Mater and the nurturing hands of your mentors and may the next posterity be able to reap bountiful educational harvest for a better Philippines and SSCT flourishing the ASEAN Integration! May SSCT in the near future become a part of the identified HEIs hoisting with pride our flagship program which will give our students the chance to share their expertise to the other receptive ASEAN schools.",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
