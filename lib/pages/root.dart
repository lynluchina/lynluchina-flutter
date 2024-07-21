import 'package:flutter/material.dart';
import 'package:real_estate/pages/about_us.dart';
import 'package:real_estate/pages/news.dart';
import 'package:real_estate/pages/explore.dart';
import 'package:real_estate/theme/color.dart';
import 'package:real_estate/widgets/bottombar_item.dart';
import 'home.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _activeTab = 0;
  final List _barItems = [
    {
      "icon": Icons.home_rounded,
      "active_icon": Icons.home_rounded,
      "page": HomePage(),
      "text": "首页",
    },
    {
      "icon": Icons.search,
      "active_icon": Icons.search,
      "page": ExplorePage(),
      "text": "曝盘",
    },
    {
      "icon": Icons.newspaper_rounded,
      "active_icon": Icons.newspaper_rounded,
      "page": ArticleListPage(),
      "text": "新闻",
    },
    {
      "icon": Icons.info_outline_rounded,
      "active_icon": Icons.info_outline_rounded,
      "page": AboutUsPage(),
      "text": "关于我们",
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