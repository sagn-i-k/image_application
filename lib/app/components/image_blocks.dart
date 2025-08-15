import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/color_manager.dart';
import '../utils/string_manager.dart';
import '../utils/text_style_manager.dart';
import '../views/full_image_view.dart';
import 'package:image_application/app/utils/asset_manager.dart';






class CustomImageItem extends StatelessWidget {
  final String imageUrl;

  const CustomImageItem({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullImageView(imageUrl: imageUrl),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.5.r),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.appBarColor,
                  ),
                  borderRadius: BorderRadius.circular(12.5.r),
                ),
                child: Image.asset(
                  AssetManager.defaultImg,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: ColorManager.appBarColor,
                borderRadius: BorderRadius.circular(12.5.r),
              ),
              child: Image.asset(
                AssetManager.defaultImg,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}


