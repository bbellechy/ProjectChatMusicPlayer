import 'package:chatmusic/pages/setting.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        flexibleSpace: Center(
          child: Text(
            "My Profile",
            style: TextStyle(
              fontFamily: 'atma',
              fontSize: 33,
              color: Color(0xFFFF6B00),
            ),
          ),
        ),
        //color: Color(0xFFFF6B00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(""),
              radius: 80,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Name",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B00),
                ),
              ),
            ),
            Container(
              //กลับทิศทาง Icon 180 องศา
              child: Transform.rotate(
                angle: 3.14, 
                child: Icon(
                  Icons.logout_sharp,
                  color: Color(0xFFFF6B00), // เปลี่ยนสีไอคอนเป็นสีขาว
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => settingPage()));
              },
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 8), // เพิ่มระยะห่างระหว่าง Icon และ Text
                  const Text("S E T T I N G"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}