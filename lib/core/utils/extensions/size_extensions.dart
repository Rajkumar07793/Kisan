import 'package:flutter/material.dart';

extension SizeExtensions on num {
  // Returns a SizedBox with the number as height
  Widget get height => SizedBox(height: toDouble());

  // Returns a SizedBox with the number as width
  Widget get width => SizedBox(width: toDouble());

  // Returns a Vertical padding
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  // Returns a Horizontal padding
  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  // Returns All side padding
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());
}
