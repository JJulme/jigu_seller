import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/api/api_service.dart';
import 'package:jigu_seller/screen/album_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({super.key});

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  // 가져온 Question 정보
  int id = Get.arguments[0];
  String title = Get.arguments[1];
  String body = Get.arguments[2];
  int userId = Get.arguments[3];

  // 갤러리에서 받아올 이미지 변수
  List<dynamic> imageList = [];
  // 이미지를 파일형식으로 변경해서 저장할 리스트
  List<dynamic> _imgFileList = [];
  // 선택된 이미지를 파일형식으로 변환시키는 함수
  Future<dynamic> getFileList(List<dynamic> assetList) async {
    // 임시저장될 리스트 생성
    List<dynamic> imgList = [];
    for (var asset in assetList) {
      // 각 이미지를 파일형식으로 변경
      File? imgFile = await asset.file;
      // 리스트에 추가
      imgList.add(imgFile);
    }
    // 리스트 새로고침해서 저장
    setState(() {
      _imgFileList = imgList;
    });
  }

  // TextFormField Key
  final _answerKey = GlobalKey<FormState>();
  final TextEditingController _answerController = TextEditingController();

  // API에서 POST 응답 받기전 false 변수 설정
  late Future<bool> okAnswer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 빈화면 눌러서 키보드 내리기
        FocusScope.of(context).unfocus();
      },
      // back key 설정
      child: WillPopScope(
        onWillPop: () async => backProsses(),
        child: Scaffold(
          // appbar 설정
          appBar: AppBar(
            // 뒤로가기 버튼 커스텀
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              // 버튼 동작 변경
              onPressed: () => backProsses(),
            ),
            actions: [
              // 답변하기 버튼
              TextButton(
                onPressed: () {
                  // 키보드 내리는 설정
                  FocusScope.of(context).unfocus();
                  final answerKeyState = _answerKey.currentState!;
                  if (answerKeyState.validate()) {
                    answerKeyState.save();
                    getFileList(imageList);
                    // 답변을 완료할지 물어보는 팝업창
                    showDialog(
                      context: context,
                      // 팝업창 외의 화면을 눌렀을 때 화면 닫기
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("답변을 작성하실 건가요?"),
                          actions: [
                            // 답변하기 버튼
                            TextButton(
                              onPressed: () {
                                // 팝업창 닫기
                                Navigator.of(context).pop();
                                // 답변내용 POST, 성공유무를 bool로 가져옴
                                okAnswer = ApiService().answerPost(
                                    _answerController.text, _imgFileList);
                                // POST 로딩, 성공, 실패 팝업창 보여줌
                                answerDialog(context);
                              },
                              child: const Text("답변하기"),
                            ),
                            // 취소 버튼
                            TextButton(
                              onPressed: () {
                                // 팝업창을 닫기
                                Navigator.of(context).pop();
                              },
                              child: const Text("취소"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "답변하기",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          // 스크롤 생성
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 질문 제목
                  Text(
                    "제목: $title",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Divider(thickness: 0.5, height: 40),
                  // 질문 본문
                  Text(body, style: const TextStyle(fontSize: 23)),
                  const Divider(thickness: 0.5, height: 40),
                  // 답변자의 사진 첨부칸
                  const Text(
                    "사진 첨부",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // 앨범화면을 불러오는 버튼과 선택한 이미지를 보여줌
                  imageScrollView(),
                  const SizedBox(height: 20),
                  // 답변 칸
                  const Text(
                    "내 답변",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Form으로 입력된 텍스트 제어
                  Form(
                    // Form Key 설정
                    key: _answerKey,
                    // 답변 입력칸
                    child: TextFormField(
                      // 최소 크기 3줄
                      minLines: 3,
                      // 최대 크기 8줄
                      maxLines: null,
                      // 최대 100자
                      maxLength: 120,
                      // 입력된 텍스트 가져올 컨트롤러
                      controller: _answerController,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                          // 테두리 생성 설정
                          border: OutlineInputBorder(),
                          // 오류 텍스트 크기 설정
                          errorStyle: TextStyle(fontSize: 18)),
                      // 입력값 필터링
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 선택한 사진이나 작성된 글이 있을때 뒤로가기 방지
  backProsses() {
    // 선택된 이미지나 작성된 내용이 없다면 팝업창 없이 뒤로가기 실행
    if (imageList.isEmpty && _answerController.text.isEmpty) {
      Get.back();
      // 선택된 이미지나 작성된 내용이 있다면 팝업창으로 한번 물어보고 뒤로가기
    } else {
      showDialog(
        context: context,
        // 배경 눌러서 창 닫기 허용
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            content: const Text("작성하신 내용이 사라집니다.\n나가시겠습니까?"),
            actions: [
              TextButton(
                  onPressed: () {
                    // 팝업창 닫고 뒤로가기
                    Navigator.of(context).pop();
                    Get.back();
                  },
                  child: const Text("나가기")),
              TextButton(
                  onPressed: () {
                    // 팝업창을 닫기
                    Navigator.of(context).pop();
                  },
                  child: const Text("머무르기"))
            ],
          );
        },
      );
    }
  }

  // [답변하기 > 답변하기]를 눌렀을 때 Post 대기, 결과(true or false) 받기
  Future<dynamic> answerDialog(BuildContext context) {
    // 팝업창 생성
    return showDialog(
      // 주변 배경 눌렀을 때 창 안닫힘
      barrierDismissible: false,
      context: context,
      builder: (context) {
        // Post에 대한 FutureBuilder
        return FutureBuilder(
          future: okAnswer,
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
                    content: const Text("답변이 완료되었습니다."),
                    actions: [
                      TextButton(
                          onPressed: () {
                            // 팝업창 닫고 뒤로가기
                            Navigator.of(context).pop();
                            Get.back();
                          },
                          child: const Text("확인"))
                    ],
                  ),
                );
              }
              // false를 가져왔을 경우
              return AlertDialog(
                content: const Text("답변에 실패했습니다."),
                actions: [
                  TextButton(
                      onPressed: () {
                        // 팝업창 닫기
                        Navigator.of(context).pop();
                      },
                      child: const Text("확인"))
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
