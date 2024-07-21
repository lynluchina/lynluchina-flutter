import 'package:flutter/material.dart';
import 'package:real_estate/widgets/custom_image.dart';
import 'package:real_estate/widgets/webview_screen.dart';
import 'package:real_estate/theme/color.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({
    Key? key,
    required this.imageUrl,
    required this.link,
  }) : super(key: key);

  final String imageUrl;
  final String link;

  @override
  Widget build(BuildContext context) {
    final bool isClickable = link != "#";

    Widget bannerContent = Stack(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: isClickable ? AppColor.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: CustomImage(
            imageUrl,
            width: double.infinity,
            height: 100,
            radius: 5,
          ),
        ),
        if (isClickable)
          Positioned(
            right: 10,
            bottom: 10,
            child: Icon(
              Icons.touch_app,
              color: Colors.white,
              size: 24,
            ),
          ),
      ],
    );

    if (isClickable) {
      bannerContent = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: link),
            ),
          );
        },
        child: bannerContent,
      );
    }

    return bannerContent;
  }
}