import 'package:flutter/material.dart';

class LabelledIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const LabelledIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: detailColor),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.fade,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

const Color detailColor = Color(0x66000000);
const Color backgroundColor = Color(0xfff7f7f7);
const Color inactiveColor = Color(0xFFebebeb);
const Color cardShadowColor = Color(0x66ebebeb);
const Color primaryColor = Color(0xffffffff);
const Color secondaryColor = Color(0xffe65541);

const EdgeInsets standardPagePadding = EdgeInsets.only(left: 20, right: 20);
const EdgeInsets contentPadding = EdgeInsets.only(top: 30);
