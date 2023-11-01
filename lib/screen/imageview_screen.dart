import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// https://velog.io/@dal-pi/Flutter-Shuffle-Gallery-%EC%95%B1-%EA%B0%9C%EB%B0%9C-%EB%A1%9C%EA%B7%B8
// https://velog.io/@mi-fasol/Flutter-CarouselSlider%EB%A1%9C-%EC%97%AC%EB%9F%AC-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EB%B3%B4%EC%97%AC%EC%A3%BC%EA%B8%B0
class ImageviewScreen extends StatefulWidget {
  const ImageviewScreen({super.key});

  @override
  State<ImageviewScreen> createState() => _ImageviewScreenState();
}

class _ImageviewScreenState extends State<ImageviewScreen> {
  // 선택한 이미지의 인덱스를 가져옴
  var imageIndex = Get.arguments[0];
  // 전체 이미지의 목록을 가져옴
  List<dynamic> imageList = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 상단 숫자 가운데 정렬
        centerTitle: true,
        // 앱바 배경 검은색으로 변경
        backgroundColor: Colors.black,
        // 이미지 전체 개수와 보고있는 순서 보여줌
        title: Text("${imageIndex + 1}/${imageList.length}"),
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          itemCount: imageList.length,
          pageController: PageController(initialPage: imageIndex),
          onPageChanged: (index) {
            setState(() {
              imageIndex = index;
            });
          },
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetEntityImageProvider(imageList[index]),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 1.8,
            );
          },
        ),
      ),
    );
  }
}
