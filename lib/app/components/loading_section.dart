import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_manager.dart';
import '../utils/string_manager.dart';
import '../utils/text_style_manager.dart';

class LoadingSection extends StatelessWidget {
  final String? message;

  const LoadingSection({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringManager.loadImgText,
            style: TextStyleManager.subTextStyle,
          ),
          SizedBox(height: 5.h),
          CircularProgressIndicator(
            backgroundColor: ColorManager.appBarColor,
          ),
        ],
      ),
    );
  }
}