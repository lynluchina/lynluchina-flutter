import 'package:flutter/material.dart';
import 'package:real_estate/pages/alts/REQuiz.dart';
import 'package:real_estate/pages/alts/chatbot.dart';
import 'package:real_estate/pages/alts/home_alt.dart';
import 'package:real_estate/theme/color.dart';


class RootAltApp extends StatefulWidget {
  const RootAltApp({Key? key}) : super(key: key);

  @override
  _RootAltAppState createState() => _RootAltAppState();
}

class _RootAltAppState extends State<RootAltApp> {
  int _activeTab = 0;
  final List _barItems = [
    {
      "icon": Icons.home_rounded,
      "active_icon": Icons.home_rounded,
      "page": HomeAlt(),
      "text": "Home",
    },
    {
      "icon": Icons.chat_bubble,
      "active_icon": Icons.chat,
      "page": ChatScreen(),
      "text": "RE Chat",
    },
    {
      "icon": Icons.quiz,
      "active_icon": Icons.quiz_outlined,
      "page": REQuiz(),
      "text": "Preferences",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return IndexedStack(
            index: _activeTab,
            children: List.generate(
              _barItems.length,
                  (index) => SizedBox(
                child: _barItems[index]["page"],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _activeTab,
      onTap: (index) {
        setState(() {
          _activeTab = index;
        });
      },
      items: _barItems.map((item) => BottomNavigationBarItem(
        icon: Icon(item["icon"]),
        label: item["text"],
      )).toList(),
      backgroundColor: AppColor.bottomBarColor,
      selectedItemColor: AppColor.primary,
      unselectedItemColor: Colors.grey,
    );
  }
}