// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// class FullImageView extends StatelessWidget {
//   final String imageUrl;
//
//   const FullImageView({Key? key, required this.imageUrl}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.close, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Center(
//         child: PhotoView(
//           imageProvider: NetworkImage(imageUrl),
//           backgroundDecoration: BoxDecoration(color: Colors.black),
//           minScale: PhotoViewComputedScale.contained,
//           maxScale: PhotoViewComputedScale.covered * 2,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_application/app/utils/color_manager.dart';
import 'package:photo_view/photo_view.dart';

class FullImageView extends StatelessWidget {
  final String imageUrl;

  const FullImageView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration: BoxDecoration(color: ColorManager.bodyColor),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,

          ),
          Positioned(
            top: 40.h,
            left: 16.w,
            child: IconButton(
              icon: Icon(Icons.close, color: ColorManager.appBarColor),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
