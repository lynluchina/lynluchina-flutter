import 'package:flutter/material.dart';
import 'package:real_estate/theme/color.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.name, {
    Key? key,
    this.width = 100,
    this.height = 100,
    this.bgColor,
    this.borderWidth = 0,
    this.borderColor,
    this.trBackground = false,
    this.isNetwork = true,
    this.radius = 50,
    this.borderRadiusOnly,
  }) : super(key: key);

  final String name;
  final double width;
  final double height;
  final double borderWidth;
  final Color? borderColor;
  final Color? bgColor;
  final bool trBackground;
  final bool isNetwork;
  final double radius;
  final BorderRadius? borderRadiusOnly; // New property to support BorderRadius.only

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadiusOnly ?? BorderRadius.circular(radius), // Use provided borderRadiusOnly or circular radius
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          image: isNetwork ? NetworkImage(name) : AssetImage(name) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}