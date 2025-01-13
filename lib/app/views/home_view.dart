import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_application/app/utils/api_manager.dart';
import 'package:image_application/app/utils/asset_manager.dart';
import 'package:image_application/app/utils/color_manager.dart';
import 'package:image_application/app/utils/string_manager.dart';
import 'package:image_application/app/utils/text_style_manager.dart';
import '../controllers/home_controller.dart';
import 'full_image_view.dart';


class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ImageController controller = Get.put(ImageController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        controller.fetchImages();
      }
    });

    return Scaffold(
      backgroundColor: ColorManager.bodyColor,
      appBar: AppBar(
        backgroundColor: ColorManager.appBarColor,
        centerTitle: true,
        title: Text(
          StringManager.headingText,
          style: TextStyleManager.headingTextStyle,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                StringManager.mainText,
                style: TextStyleManager.mainTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(() {
                if (controller.images.isEmpty && controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: ColorManager.appBarColor,
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 images per row
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                        ),
                        itemCount: controller.images.length,
                        itemBuilder: (context, index) {
                          final image = controller.images[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FullImageView(imageUrl: image.downloadUrl),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.5.r),
                              child: Image.network(
                                image.downloadUrl,
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
                        },
                      ),
                    ),
                    if (controller.isLoading.value)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(StringManager.loadImgText,style: TextStyleManager.subTextStyle,),
                            SizedBox(height: 5.h,),
                            CircularProgressIndicator(
                              backgroundColor: ColorManager.appBarColor,
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}



// class HomeView extends StatelessWidget {
//   HomeView({super.key});
//
//   final ImageController controller = Get.put(ImageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.bodyColor,
//       appBar: AppBar(
//         backgroundColor: ColorManager.appBarColor,
//         centerTitle: true,
//         title: Text(
//           StringManager.headingText,
//           style: TextStyleManager.headingTextStyle,
//         ),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         margin: EdgeInsets.symmetric(horizontal: 12.w),
//         child: Column(
//           children: [
//             SizedBox(height: 15.h),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 5.w),
//               child: Text(
//                 StringManager.mainText,
//                 style: TextStyleManager.mainTextStyle,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 15.h),
//             Expanded(
//               child: Obx(() {
//                 if (controller.images.isEmpty && controller.isLoading.value) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: ColorManager.appBarColor,
//                     ),
//                   );
//                 }
//
//                 return GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, // 3 images per row.
//                     crossAxisSpacing: 10.w,
//                     mainAxisSpacing: 10.h,
//                   ),
//                   itemCount: controller.images.length + 1,
//                   itemBuilder: (context, index) {
//                     if (index == controller.images.length) {
//                       return controller.isLoading.value
//                           ? Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             backgroundColor: ColorManager.appBarColor,
//                           ),
//                         ),
//                       )
//                           : Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: TextButton(
//                           onPressed: () {
//                             controller.fetchImages();
//                           },
//                           child: Text(
//                             'Load more',
//                             style: TextStyleManager.subTextStyle,
//                           ),
//                         ),
//                       );
//                     }
//
//                     final image = controller.images[index];
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => FullImageView(imageUrl: image.downloadUrl),
//                           ),
//                         );
//                       },
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12.5.r),
//                         child: Image.network(
//                           image.downloadUrl,
//                           fit: BoxFit.cover,
//                           loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                             if (loadingProgress == null) {
//                               return child;
//                             }
//                             return Center(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border:Border.all(
//                                     color: ColorManager.appBarColor,
//                                   ),
//                                     borderRadius: BorderRadius.circular(12.5.r)
//                                 ),
//                                 child: Image.asset(
//                                   AssetManager.defaultImg,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             );
//                           },
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 color: ColorManager.appBarColor,
//                                 borderRadius: BorderRadius.circular(12.5.r)
//                               ),
//                               child: Image.asset(
//                                 AssetManager.defaultImg,
//                                 fit: BoxFit.cover,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

