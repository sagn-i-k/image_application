import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_application/app/components/image_blocks.dart';
import 'package:image_application/app/utils/color_manager.dart';
import 'package:image_application/app/utils/string_manager.dart';
import 'package:image_application/app/utils/text_style_manager.dart';
import '../components/loading_section.dart';
import '../controllers/home_controller.dart';


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
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                        ),
                        itemCount: controller.images.length,
                        itemBuilder: (context, index) {
                          final image = controller.images[index];
                          return InkWell(
                            onTap: (){
                              //Get.back()
                            },
                            child: CustomImageItem(
                              imageUrl: image.downloadUrl,
                            ),
                          );
                        },
                      ),
                    ),
                    if (controller.isLoading.value)
                      LoadingSection()
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


