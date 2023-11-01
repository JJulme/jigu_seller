import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/method/custom_method.dart';
import 'package:photo_manager/photo_manager.dart';

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
  late Future<dynamic> imageFiles;
  // 캐러셀의 컨트롤러 생성
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    imageFiles = CustomMethod().assetEntity2File(imageList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 배경 검은색으로 변경
        backgroundColor: Colors.black,
        appBar: AppBar(
          // 상단 숫자 가운데 정렬
          centerTitle: true,
          // 앱바 배경 검은색으로 변경
          backgroundColor: Colors.black,
          // 이미지 전체 개수와 보고있는 순서 보여줌
          title: Text("${imageIndex + 1}/${imageList.length}"),
        ),
        // 이미지 슬라이더 생성
        body: FutureBuilder(
          future: imageFiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider.builder(
                // 전체 이미지 개수 알려줌
                itemCount: imageList.length,
                // 캐러셀의 컨토롤러 설정
                carouselController: _carouselController,
                itemBuilder: (context, index, realIndex) {
                  // 이미지 보여줌
                  // return InteractiveViewer(child: AssetEntityImage(imageList[index]));
                  String imagePath = snapshot.data[index].path;
                  print(snapshot.data[index].runtimeType);
                  return Image.file(snapshot.data[index]);
                },
                // 옵션 설정
                options: CarouselOptions(
                  // 눌렀을 때 보여줄 이미지 인덱스
                  initialPage: imageIndex,
                  // 크기 설정 - 최대크기 설정
                  height: MediaQuery.of(context).size.height,
                  // 화면 꽉채우기 설정
                  viewportFraction: 1,
                  // 가운데 설정
                  enlargeCenterPage: true,
                  // 마지막에서 첫번째로 슬라이더 방지
                  enableInfiniteScroll: false,
                  // 화면이 바뀔때 인덱스 전달
                  onPageChanged: (index, reason) {
                    setState(() {
                      imageIndex = index;
                    });
                  },
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
