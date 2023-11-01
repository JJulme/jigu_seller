import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/screen/album_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  // 갤러리에서 받아올 이미지 변수
  List<dynamic> imageList = [];
  // 이미지를 파일형식으로 변경해서 저장할 리스트
  final List<dynamic> _imgFileList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text("프로필 설정", style: TextStyle(fontSize: 30)),
              const Text("나의 답변 관리", style: TextStyle(fontSize: 30)),
              const Text("사업자등록 변경시", style: TextStyle(fontSize: 30)),
              imageScrollView()
            ],
          ),
        ),
      ),
    );
  }

  // 앨범 선택 버튼, 선택된 이미지를 보여줌
  SingleChildScrollView imageScrollView() {
    // 스크롤 생성
    return SingleChildScrollView(
      // 가로 스크롤 설정
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 앨범을 열어주는 버튼 생성
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: OutlinedButton(
              // 버튼 내부 기본 여백 제거
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              // 버튼을 눌렀을 때 AlbumScreen으로 이동
              // imageList로 앨범에서 선택된 이미지를 가져옴
              onPressed: () async {
                imageList = await Get.to(() => const AlbumScreen());
                setState(() {});
              },
              // 버튼 크기 설정
              child: const SizedBox(
                height: 80,
                width: 80,
                child: Icon(Icons.add_a_photo_outlined),
              ),
            ),
          ),
          const SizedBox(width: 15),
          imageList.isEmpty
              // 선택된 이미지가 없다면 빈칸
              ? const SizedBox()
              // 선택된 이미지가 있다면 이미지 보여줌
              : SizedBox(
                  // 높이 = 앨범버튼 높이 + 앨범버튼 top 여백
                  height: 95,
                  // 이미지를 ListView로 보여줌
                  child: ListView.builder(
                    // 차지하는 공간 최소화 설정
                    shrinkWrap: true,
                    // 스크롤 안돼도록 설정
                    physics: const NeverScrollableScrollPhysics(),
                    // List 배열 가로로 설정
                    scrollDirection: Axis.horizontal,
                    // List 개수 알려줌
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      // 크기 설정 - Stack으로 이미지 밖으로 나오게 되는 X버튼까지
                      return SizedBox(
                        height: 95,
                        width: 95,
                        // 이미지 위에 X(삭제) 버튼추가를 위한 Stack
                        child: Stack(
                          // fit: StackFit.expand,
                          children: [
                            // 이미지 들어갈 Container
                            Container(
                              height: 80,
                              width: 80,
                              // 위, 오른쪽 여백 설정
                              margin: const EdgeInsets.fromLTRB(0, 15, 15, 0),
                              // 가져온 이미지가 Container에 맞춰 모양이 바뀌도록 설정
                              clipBehavior: Clip.hardEdge,
                              // Container 모서리 둥글게 설정
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              // 이미지 넣기
                              child: AssetEntityImage(
                                imageList[index],
                                // 모르겠음 조사 필요
                                isOriginal: false,
                                // 박스에 꽉차게 확대
                                fit: BoxFit.cover,
                              ),
                            ),
                            // X버튼 내부에 색을 채우기 위한 흰 Container
                            Positioned(
                              top: 4,
                              right: 4,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    // Container가 아이콘 밖으로 나오지 안게 모서리 둥글게 설정
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                            // 아이콘 버튼 설정
                            Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(
                                // 누르면 해당 인덱스 번호의 이미지 리스트 항목 제거
                                onPressed: () {
                                  setState(() {
                                    imageList.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.cancel_sharp,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
