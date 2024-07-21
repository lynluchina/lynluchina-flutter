import 'package:flutter/material.dart';
import 'package:real_estate/theme/color.dart';
import 'package:real_estate/widgets/webview_screen.dart';
import 'custom_image.dart';

class RecentItem extends StatelessWidget {
  const RecentItem({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    Widget listingContent = Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
            data["imageURL"],
            height: 140, // Adjust height as needed
            width: 150, // Adjust width as needed
            borderRadiusOnly: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: _buildInfo(),
          ),
        ],
      ),
    );

    listingContent = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(url: data["URL"]),
          ),
        );
      },
      child: listingContent,
    );

    return listingContent;
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data["name"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            data["type"],
            style: TextStyle(fontSize: 12, color: AppColor.darker),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "${data["area"]} | ${data["bedrooms"]} | ${data["bathrooms"]}",
            style: TextStyle(fontSize: 12, color: AppColor.darker),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.place_outlined,
                size: 13,
                color: AppColor.darker,
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: Text(
                  data["location"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: AppColor.darker),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            data["price"],
            style: TextStyle(
              fontSize: 13,
              color: AppColor.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
