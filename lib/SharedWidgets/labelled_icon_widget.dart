import 'package:flutter/material.dart';
import 'package:dttproperties/AppManagement/Shared.dart';

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
