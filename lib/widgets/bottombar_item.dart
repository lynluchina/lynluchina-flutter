import 'package:flutter/material.dart';
import 'package:real_estate/theme/color.dart';

class BottomBarItem extends StatelessWidget {
  const BottomBarItem(
    this.icon, {
    this.onTap,
    this.color = AppColor.inActiveColor,
    this.activeColor = AppColor.primary,
    this.isActive = false,
    this.isNotified = false,
    this.text = "",
  });

  final IconData icon;
  final Color color;
  final Color activeColor;
  final bool isNotified;
  final bool isActive;
  final String text;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isActive
                        ? AppColor.primary.withOpacity(.1)
                        : Colors.transparent,
                  ),
                  child: Icon(
                    icon,
                    size: 25,
                    color: isActive ? activeColor : color,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? activeColor : color,
                  ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
