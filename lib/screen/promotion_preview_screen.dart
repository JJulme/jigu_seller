import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/api/api_service.dart';
import 'package:jigu_seller/method/custom_method.dart';
import 'package:jigu_seller/screen/imageview_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class PromotionPreviewScreen extends StatefulWidget {
  const PromotionPreviewScreen({super.key});

  @override
  State<PromotionPreviewScreen> createState() => _PromotionPreviewScreenState();
}

class _PromotionPreviewScreenState extends State<PromotionPreviewScreen> {
  // 작성한 제목 가져옴
  String title = Get.arguments[0];
  // 선택한 이미지 리스트 가져옴
  List<dynamic> imageList = Get.arguments[1];
  // 이미지들의 경로를 가져옴
  late Future<dynamic> imageFiles;
  // API post 결과 가져옴
  late Future<bool> okEdit;

  @override
  Widget build(BuildContext context) {
    // 이미지 너비 = 디바이스 너비 - 30
    final imgWeight = MediaQuery.of(context).size.width - 30;
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 게시하기 버튼
          TextButton(
            child: const Text(
              "게시하기",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            // 게시하기 눌렀을 때
            onPressed: () {
              // 이미지들의 경로를 가져옴
              imageFiles = CustomMethod().assetEntity2File(imageList);
              // 팝업창 생성
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  // 이미지들의 경로를 가져오는 것을 기다림
                  return FutureBuilder(
                      future: imageFiles,
                      builder: (context, snapshot) {
                        // 이미지 경로 가져왔을 경우
                        if (snapshot.hasData) {
                          return AlertDialog(
                            content: const Text("홍보글을 수정 하시겠습니까?"),
                            actions: [
                              // 게시하기 버튼
                              TextButton(
                                child: const Text("게시하기"),
                                // 게시하기 버튼을 눌렀을 때
                                onPressed: () {
                                  // 팝업창 닫기
                                  Navigator.of(context).pop();
                                  // 제목과 이미지를 서버로 전송
                                  okEdit = ApiService()
                                      .answerPost(title, snapshot.data);
                                  // 서버전송 결과에 따라 팝업창 보여줌
                                  // 성공 - 성공했다는 메시지와 함께 promotion_screen.dart 으로 돌아감
                                  // 실패 - 실패했다는 메시지와 promotion_edit_screen.dart 으로 돌아감
                                  editDialog(context);
                                },
                              ),
                              // 취소 버튼
                              TextButton(
                                child: const Text("취소"),
                                // 취소 버튼을 눌렀을 때
                                onPressed: () {
                                  // 팝업창 닫기
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                        // 이미지 경로 가져올 동안 로딩
                        return const CircularProgressIndicator();
                      });
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(
                height: 20,
                color: null,
              ),
              ListView.builder(
                itemCount: imageList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Get.to(const ImageviewScreen(),
                        arguments: [index, imageList]),
                    child: Container(
                      height: imgWeight / 2,
                      width: imgWeight,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      clipBehavior: Clip.hardEdge,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: AssetEntityImage(
                        imageList[index],
                        isOriginal: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              imageList.isEmpty
                  ? const SizedBox()
                  : const Divider(
                      height: 20,
                      color: null,
                    ),
              const Text(
                "미안하다 이거 보여주려고 어그로끌었다.. 나루토 사스케 싸움수준 ㄹㅇ실화냐? 진짜 세계관최강자들의 싸움이다.. 그찐따같던 나루토가 맞나? 진짜 나루토는 전설이다..진짜옛날에 맨날나루토봘는데 왕같은존재인 호카게 되서 세계최강 전설적인 영웅이된나루토보면 진짜내가다 감격스럽고 나루토 노래부터 명장면까지 가슴울리는장면들이 뇌리에 스치면서 가슴이 웅장해진다.. 그리고 극장판 에 카카시앞에 운석날라오는 거대한 걸 사스케가 갑자기 순식간에 나타나서 부숴버리곤 개간지나게 나루토가 없다면 마을을 지킬 자는 나밖에 없다 라며 바람처럼 사라진장면은 진짜 나루토처음부터 본사람이면 안울수가없더라 진짜 너무 감격스럽고 보루토를 최근에 알았는데 미안하다.. 지금20화보는데 진짜 나루토세대나와서 너무 감격스럽고 모두어엿하게 큰거보니 내가 다 뭔가 알수없는 추억이라해야되나 그런감정이 이상하게 얽혀있다.. 시노는 말이많아진거같다 좋은선생이고..그리고 보루토왜욕하냐 귀여운데 나루토를보는것같다 성격도 닮았어 그리고버루토에 나루토사스케 둘이싸워도 이기는 신같은존재 나온다는게 사실임?? 그리고인터닛에 쳐봣는디 이거 ㄹㅇㄹㅇ 진짜팩트냐?? 저적이 보루토에 나오는 신급괴물임?ㅡ 나루토사스케 합체한거봐라 진짜 ㅆㅂ 이거보고 개충격먹어가지고 와 소리 저절로 나오더라 ;; 진짜 저건 개오지는데.. 저게 ㄹㅇ이면 진짜 꼭봐야돼 진짜 세계도 파괴시키는거아니야 .. 와 진짜 나루토사스케가 저렇게 되다니 진짜 눈물나려고했다.. 버루토그라서 계속보는중인데 저거 ㄹㅇ이냐..? 하.. ㅆㅂ 사스케 보고싶다..  진짜언제 이렇게 신급 최강들이 되었을까 옛날생각나고 나 중딩때생각나고 뭔가 슬프기도하고 좋기도하고 감격도하고 여러가지감정이 복잡하네.. 아무튼 나루토는 진짜 애니중최거명작임..",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              const Divider(
                height: 30,
                color: null,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "name",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "info",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // [답변하기 > 답변하기]를 눌렀을 때 Post 대기, 결과(true or false) 받기
  Future<dynamic> editDialog(BuildContext context) {
    // 팝업창 생성
    return showDialog(
      // 주변 배경 눌렀을 때 창 안닫힘
      barrierDismissible: false,
      context: context,
      builder: (context) {
        // Post에 대한 FutureBuilder
        return FutureBuilder(
          future: okEdit,
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
                    content: const Text("수정이 완료되었습니다."),
                    actions: [
                      TextButton(
                          onPressed: () {
                            // 팝업창 닫고 뒤로가기
                            Navigator.of(context).pop();
                            Get.back();
                            Get.back();
                          },
                          child: const Text("확인"))
                    ],
                  ),
                );
              }
              // false를 가져왔을 경우
              return AlertDialog(
                content: const Text("수정에 실패했습니다."),
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
}
