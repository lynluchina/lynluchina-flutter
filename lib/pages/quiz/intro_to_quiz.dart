import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class IntroREQuiz extends StatefulWidget {
  const IntroREQuiz();

  @override
  State<IntroREQuiz> createState() => _IntroREQuizState();
}

class _IntroREQuizState extends State<IntroREQuiz> {
  final _questions = const [
    {
      'questionText': 'When entering my home, I want to feel... ',
      'answers': [
        {'text': 'Prestige and an air of formality.', 'score': 1},
        {'text': 'No clutter, open spaces and clean lines without complication.', 'score': 2},
        {'text': 'Passion for interesting and exotic treasures. A little bling here and there.', 'score': 3},
        {'text': 'Organization and balance with a welcoming feeling.', 'score': 4},
      ],
    },
    {
      'questionText': 'Your ideal kitchen is... ',
      'answers': [
        {'text': 'Lots of texture', 'score': 1},
        {'text': 'Funky color', 'score': 2},
        {'text': 'A sense of timelessness', 'score': 3},
        {
          'text': 'Cutting-edge appliances',
          'score': 4
        },
      ],
    },
    {
      'questionText': 'Your Sunday Garden should look like... ',
      'answers': [
        {'text': 'Sink into a peaceful chair with a cool drink', 'score': 1},
        {'text': 'Submerge yourself in the sounds, colours and scents of nature', 'score': 2},
        {'text': 'Eat dinner outside with the family', 'score': 3},
        {'text': 'Eat dinner outside with the family', 'score': 4},
      ],
    },
    {
      'questionText': 'After a hard day’s work, you like to…',
      'answers': [
        {'text': 'Soak in a warm bath enhanced with a blend of stress-relieving essential oils, while you watch an episode of your favourite TV series.', 'score': 1},
        {'text': 'Jump in the shower and have the hot jet-sprays blast your stiff shoulders and back.', 'score': 2},
        {'text': 'Quickly get out of your work clothes and veg out in your air-conditioned room, while you wait for the bathroom – which your brother got to before you – to dry.', 'score': 3},
        {'text': 'Rinse the day’s stresses away with a quick hot shower, and then cool down with a long, cold one.', 'score': 4},
      ],
    },
    {
      'questionText': 'Are you a Modernist or a Traditionalist? ',
      'answers': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 1},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;


  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Your Preferences"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
            answerQuestion: _answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
          )
              : Result(_totalScore, _resetQuiz),
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            questions[questionIndex]['questionText'] as String,
          ),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return ElevatedButton(
              child: Text(answer['text'] as String),
              onPressed: () => answerQuestion(answer['score']),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class Result extends StatefulWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  @override
  State<Result> createState() => _ResultState();
}


class _ResultState extends State<Result> {
  List links = [];
  String houseSuggestionImage = "";
  String houseSuggestion = "";

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dates = [];
    dates = prefs.getStringList('date') ?? [];

    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd hh:mm a');
    String formattedDate = formatter.format(now);
    dates.add(formattedDate);
    prefs.setStringList('date', dates);
    prefs.setString('${formattedDate}_link', json.encode(links));
    prefs.setString('${formattedDate}_houseSuggestion', houseSuggestion);
    prefs.setString('${formattedDate}_houseSuggestionImage', houseSuggestionImage);
    print("prefs: $prefs");
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resultScore > 0 && widget.resultScore <= 6) {
      setState(() {
        houseSuggestion = "You may into this kind of house, with a fresh garden in the front and back, the color of wood will be a plus for this design";
        houseSuggestionImage = "https://upload.wikimedia.org/wikipedia/commons/9/98/Phillips_Mansion%2C_Pomona_1.jpg";
      });
    }
    else if (widget.resultScore > 6 && widget.resultScore < 12) {
      setState(() {
        houseSuggestion = "Comfy, spacious and in the color of white, this house will surely satisfy your preferences. Plus, the garden is lovely!";
        houseSuggestionImage = "https://images.homes.com/listings/111/7668952683-105247771/3773-live-oak-dr-pomona-ca-primaryphoto.jpg";
      });
    }
    else {
      setState(() {
        houseSuggestion = "More classic, with a chimney, and donning a color of yellow, you cannot go wrong with that!";
        houseSuggestionImage = "https://upload.wikimedia.org/wikipedia/commons/9/98/Manor_House_%28Pomona%29_%282%29.jpg";
      });
    }
      return Center(
      child: Column(
        children: <Widget>[
          Text("${widget.resultScore}"),
          CachedNetworkImage(
            imageUrl: houseSuggestionImage,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(
            houseSuggestion,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          // Card(
          //   child: Column(
          //     children: [
          //
          //       Text(
          //
          //         'Your Score: $resultScore',
          //         style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          //       ),
          //       //Ima
          //     ],
          //   ),
          // ),
          TextButton(
            onPressed: () => widget.resetHandler(),
            child: Text('Restart Quiz!'),
          ),
          ElevatedButton(
              onPressed: () {
                _saveData().then((value) => widget.resetHandler());
              },
              child: const Text("Save your Choices"),
          )
        ],
      ),
    );
  }
}
