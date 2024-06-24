import 'package:flutter/material.dart';

class FilterCardWidget extends StatelessWidget {
  const FilterCardWidget({
    super.key,
    required this.onTap,
    required this.selected,
    required this.iconData,
    required this.labelText,
  });

  final void Function(bool) onTap;
  final bool selected;
  final IconData iconData;
  final String labelText;

  @override
  Widget build(BuildContext context) {

    BorderRadius borderRadius = BorderRadius.circular(3.0);
    Color? borderColor = const Color(0xFFD8DFE6);
    Color? labelTextAndIconColor = const Color(0xFF77818C);
    Color? backgroundColor;

    if (selected) {
      borderColor = Theme.of(context).primaryColor;
      backgroundColor = Theme.of(context).primaryColor;
      labelTextAndIconColor = Theme.of(context).colorScheme.onPrimary;
    }

    return InkWell(
      onTap: () => onTap(!selected),
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: borderRadius,
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              iconData,
              color: labelTextAndIconColor,
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Text(
                labelText,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: labelTextAndIconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
