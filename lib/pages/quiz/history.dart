import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/pages/quiz/history_date.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);


  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Map<String, List<dynamic>> _history = {};
  Map<String, String?> _houseSuggestionImage = {};
  Map<String, String?> _houseSuggestion = {};
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    List<String> dates = [];
    if (prefs.containsKey('date')) {
      dates = prefs.getStringList('date')!;
      for (var date in dates) {
        _history[date] =
        List<dynamic>.from(json.decode(prefs.getString(date + '_link')!));
        _houseSuggestionImage[date] = prefs.getString(date + '_houseSuggestionImage');
        _houseSuggestion[date] = prefs.getString(date + '_houseSuggestion');
      }
      setState(() {});
    }
  }

  void _sortHistory() {
    setState(() {
      _isAscending = !_isAscending;
      List<String> sortedKeys = _history.keys.toList();
      sortedKeys.sort((a, b) => _isAscending ? a.compareTo(b) : b.compareTo(a));
      _history = {for (var k in sortedKeys) k: _history[k]!};
      print(_history.keys.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort By: "),
        actions: [
          IconButton(
            icon: Icon(
              _isAscending ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up,
              //color: primaryColor,
            ),
            onPressed: _sortHistory,
          ),
        ],
      ),
      body: _history.isNotEmpty
          ? ListView.builder(
        padding: const EdgeInsets.all(8),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: _history.length,
        itemBuilder: (BuildContext context, int index) {
          String date = _history.keys.elementAt(index);
          return Card(
            //color: primaryColor,
            child: ListTile(
              title: Text(
                date,
                //style: TextStyle(fontSize: 20, color: secondaryColor),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.play_circle_fill_outlined,
                  //color: secondaryColor,
                ),
                tooltip: 'Show Images',
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => HistoryDate(
                          links: _history[date]!,
                          houseSuggestionImage: _houseSuggestionImage[date]!,
                          houseSuggestion: _houseSuggestion[date] ?? "love"
                      )
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
          : Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfQ1L9b8tFaGXBQxOdCCaq-AcYkmawPtRVZA&s', height: 200),
            ),
            Text(
              'No videos analyzed yet.',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}