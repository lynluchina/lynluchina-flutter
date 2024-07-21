import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/theme/color.dart';
import 'package:real_estate/utils/data.dart';
import 'package:real_estate/widgets/category_item.dart';
import 'package:real_estate/widgets/custom_image.dart';
import 'package:real_estate/widgets/custom_textbox.dart';
import 'package:real_estate/widgets/icon_box.dart';
import 'package:real_estate/widgets/banner.dart';
import 'package:real_estate/widgets/recent_item.dart';
import 'package:real_estate/widgets/recommend_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0; // Declare _current to track current carousel index
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[SliverToBoxAdapter(child: _buildBody())],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 75,
          ),
          _buildBanners(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "顶级推荐房源",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "查看全部",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecommended(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "最新房源",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "查看全部",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.darker),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecent(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildBanners() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 100,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: 0.85,
            enableInfiniteScroll: false, // Optional: disable infinite scroll
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: banners.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return PromoBanner(
                  imageUrl: item['image_src'],
                  link: item['link'],
                );
              },
            );
          }).toList(),
        ),
        _buildDotsIndicator(), // Call method to build dots indicator
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: banners.map((item) {
        int index = banners.indexOf(item);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _current == index ? AppColor.primary : AppColor.inActiveColor,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecommended() {
    List<Widget> lists = List.generate(
      recommended.length,
      (index) => RecommendItem(
        data: recommended[index],
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  Widget _buildRecent() {
    List<Widget> lists = List.generate(
      recents.length,
      (index) => Container(
        margin: EdgeInsets.only(bottom: 10), // Adjust the margin as needed
        child: RecentItem(
          data: recents[index],
        ),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Column(
        children: lists,
      ),
    );
  }
}
