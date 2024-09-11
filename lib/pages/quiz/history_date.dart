import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HistoryDate extends StatefulWidget {
    HistoryDate(
 {required this.houseSuggestionImage, required this.houseSuggestion, required  this.links}

       );

    final List links;
   final String houseSuggestionImage;
   final String houseSuggestion;

  @override
  State<HistoryDate> createState() => _HistoryDateState();
}

class _HistoryDateState extends State<HistoryDate> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
          children: <Widget>[
        CachedNetworkImage(
          imageUrl: widget.houseSuggestionImage,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Text(
          widget.houseSuggestion,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
    ],
      ),
    );
  }
}