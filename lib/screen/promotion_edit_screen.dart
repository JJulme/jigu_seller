import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/api/api_service.dart';
import 'package:jigu_seller/screen/album_screen.dart';
import 'package:jigu_seller/screen/promotion_preview_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class PromotionEditScreen extends StatefulWidget {
  const PromotionEditScreen({super.key});

  @override
  State<PromotionEditScreen> createState() => _PromotionEditScreenState();
}

class _PromotionEditScreenState extends State<PromotionEditScreen> {
  // 컨트롤러에는 작성했던 제목, 내용이 들어갈 예정
  final TextEditingController _titleEditingController =
      TextEditingController(text: "작성했던 홍보글 제목");
  final TextEditingController _bodyEditingController =
      TextEditingController(text: "작성했던 홍보글 내용");
  final _titleKey = GlobalKey<FormState>();
  final _bodyKey = GlobalKey<FormState>();
  // 갤러리에서 받아올 이미지 변수
  List<dynamic> imageList = [];
  // API delete 결과 가져옴
  late Future<bool> okDelete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 빈화면 눌러서 키보드 내리기
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text("홍보글 수정"),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  // 수정한 홍보글 미리보기 버튼
                  PopupMenuItem(
                    child: const Text("미리보기"),
                    onTap: () {
                      // 키보드 내리는 설정
                      FocusScope.of(context).unfocus();
                      final titleKeyState = _titleKey.currentState;
                      final bodyKeyState = _bodyKey.currentState;
                      if (titleKeyState!.validate() &&
                          bodyKeyState!.validate()) {
                        titleKeyState.save();
                        Get.to(() => const PromotionPreviewScreen(),
                            // 작성한 제목, 선택한 이미지 전달
                            arguments: [
                              _titleEditingController.text,
                              imageList
                            ]);
                      }
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("삭제"),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return AlertDialog(
                            content: const Text("삭제 하시겠습니까?"),
                            actions: [
                              TextButton(
                                child: const Text("삭제하기"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  okDelete = ApiService().promotionDelete();
                                  deleteDialog(context);
                                },
                              ),
                              TextButton(
                                child: const Text("취소"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ];
              },
            ),
          ],
        ),
        // 스크롤 생성
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "제 목",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.white24,
                ),
                // 제목 작성 텍스트필드
                Form(
                  key: _titleKey,
                  child: TextFormField(
                    // 처음 기본 1줄
                    minLines: 1,
                    // 줄의 길이 제한 없음
                    maxLines: null,
                    // 글자수 제한 - 일반적으로 3줄 정도
                    maxLength: 120,
                    // 텍스트 전달을 위한 컨트롤러 설정
                    controller: _titleEditingController,
                    // 내부 스크롤 없애기
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    style: const TextStyle(fontSize: 22),
                    // 꾸미기
                    decoration: const InputDecoration(
                        // 카운터 텍스트 스타일 설정
                        counterStyle: TextStyle(fontSize: 18),
                        // 배경 색채우기
                        filled: true,
                        // 배경 색 설정
                        fillColor: Color.fromARGB(255, 238, 238, 238),
                        // 밑에 줄 설정
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          // 줄 두께 설정
                          width: 2.5,
                          // 줄 색 설정
                          color: Colors.grey,
                        ))),
                    validator: (value) {
                      // 입력된 값 공백제거
                      var trimValue = value!.replaceAll(RegExp("\\s"), "");
                      if (trimValue.length < 5) {
                        return "5자 이상, 120자 이하로 입력해주세요.";
                      }
                      return null;
                    },
                  ),
                ),
                Divider(
                  height: 30,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                const Text(
                  "사진 첨부",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // 앨범에서 이미지 가져오고 가로스크롤 생성
                imageScrollView(),
                Divider(
                  height: 30,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                const Text(
                  "내 용",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.white24,
                ),
                // 본문내용 작성 텍스트 필드
                Form(
                  key: _bodyKey,
                  child: TextFormField(
                    // 기본 크기 10줄
                    minLines: 10,
                    // 줄의 길이 제한 없음
                    maxLines: null,
                    // 최대 900자
                    maxLength: 900,
                    // 텍스트 전달을 위한 컨트롤러 설정
                    controller: _bodyEditingController,
                    // 내부 스크롤 없애기
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    style: const TextStyle(fontSize: 22),
                    // 꾸미기
                    decoration: const InputDecoration(
                        // 카운터 텍스트 스타일 설정
                        counterStyle: TextStyle(fontSize: 18),
                        // 배경 색 채우기
                        filled: true,
                        // 배경 색 설정
                        fillColor: Color.fromARGB(255, 238, 238, 238),
                        // 밑에 줄 설정
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          // 줄 두께 설정
                          width: 2.5,
                          // 줄 색상 설정
                          color: Colors.grey,
                        ))),
                    validator: (value) {
                      // 입력된 값 공백제거
                      var trimValue = value!.replaceAll(RegExp("\\s"), "");
                      if (trimValue.length < 5) {
                        return "5자 이상, 900자 이하로 입력해주세요.";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // [삭제 > 삭제하기]를 눌렀을 때 Delete 대기, 결과(true or false) 받기
  Future<dynamic> deleteDialog(BuildContext context) {
    // 팝업창 생성
    return showDialog(
      // 주변 배경 눌렀을 때 창 안닫힘
      barrierDismissible: false,
      context: context,
      builder: (context) {
        // Delete에 대한 FutureBuilder
        return FutureBuilder(
          future: okDelete,
          builder: (context, snapshot) {
            // 결과를 받아왔을 경우
            if (snapshot.hasData) {
              // true를 받아왔을 경우
              if (snapshot.data == true) {
                // 뒤로가기 제어
                return WillPopScope(
                  // Back Key 금지
                  onWillPop: () async => false,
                  child: AlertDialog(
                    content: const Text("삭제되었습니다."),
                    actions: [
                      TextButton(
                        child: const Text("확인"),
                        onPressed: () {
                          // 팝업창 닫고 뒤로가기
                          Navigator.of(context).pop();
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              }
              // false를 가져왔을 경우
              return AlertDialog(
                content: const Text("삭제에 실패했습니다."),
                actions: [
                  TextButton(
                    child: const Text("확인"),
                    onPressed: () {
                      // 팝업창 닫기
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
            // 결과를 기다리는 경우
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  // 앨범이동후 이미지 가져오는 버튼
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
                                isOriginal: true,
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
