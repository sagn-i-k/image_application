import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:image_application/app/utils/api_manager.dart';

import '../models/image_model.dart';

class ImageController extends GetxController {
  var images = <ImageModel>[].obs;
  var isLoading = false.obs;
  var currentPage = 1;
  final int pageSize = 18;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  Future<void> fetchImages() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse("${ApiManager.imageApi}$currentPage&limit=$pageSize"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<ImageModel> fetchedImages =
        data.map((json) => ImageModel.fromJson(json)).toList();
        images.addAll(fetchedImages);
        currentPage++;
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      print('Error fetching images: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
