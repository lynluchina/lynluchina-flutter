import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/pages/quiz/history.dart';
import 'package:real_estate/pages/quiz/intro_to_quiz.dart';


class REQuiz extends StatefulWidget {
  const REQuiz();


  @override
  State<REQuiz> createState() => _REQuizState();
}

class _REQuizState extends State<REQuiz> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get to know your Real Estate Preference"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: "https://dfhresources.com/read/communityphotos/91lpmn75/330257_pomona_01.jpg",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Text(
                  "Take this quiz so that we can provide you with an idea of your dream house",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const IntroREQuiz()),
                    );
                  },
                  child: const Text(
                    "Begin",
                  ),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HistoryPage()),
                  );
                },
                child: const Text(
                  "View your Past choices",
                ),
              ),
            ],
          ),
        ),
      ), //Padding
    );
  }
}