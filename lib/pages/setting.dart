import 'package:chatmusic/pages/home_page.dart';
import 'package:chatmusic/pages/profile.dart';
import 'package:chatmusic/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class settingPage extends StatelessWidget {
  const settingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("S E T T I N G"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => Profile())); // ทำให้กลับไปยังหน้าที่แล้ว
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: Row(
          children: [
            Text("Dark Mode"),

            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value)=>
              Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}

