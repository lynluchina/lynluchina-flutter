import 'package:flutter/material.dart';
import 'package:real_estate/theme/color.dart';
import 'package:real_estate/utils/data.dart';
import 'package:real_estate/widgets/broker_item.dart';
import 'package:real_estate/widgets/company_item.dart';
import 'package:real_estate/widgets/custom_textbox.dart';
import 'package:real_estate/widgets/icon_box.dart';
import 'package:real_estate/widgets/recommend_item.dart';
import 'package:real_estate/widgets/category_item.dart';
import 'package:real_estate/widgets/list_item.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 55, left: 15),
            child: Text(
              "顶级推荐房源",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _buildRecommended(),
          const SizedBox(
            height: 20,
          ),
          _buildRecent(),
        ],
      ),
    );
  }

  _buildRecommended() {
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
      listings.length,
      (index) => Container(
        margin: EdgeInsets.only(bottom: 10), // Adjust the margin as needed
        child: RecentItem(
          data: listings[index],
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
