import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/screen/promotion_create_screen.dart';
import 'package:jigu_seller/screen/promotion_edit_screen.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

// 목록 재배열
// https://velog.io/@sharveka_11/Flutter-36.-ReorderableListView

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("홍보글 설정"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: OutlinedButton(
                onPressed: () {
                  Get.to(() => const PromotionCreateScreen());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 30),
                    Text(
                      "홍보글 만들기",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            ListView(
              // 길이를 위젯에 맞춤 - 오류 방지
              shrinkWrap: true,
              // 스크롤 없애기
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile(
                    "title!!!yeahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile("안녕하세요 우리매장에서 이벤트를 진행중입니다. 많은 참여 부탁드립니다."),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile("활성된 홍보글의 개수를 제한, 과금시 개수 증가"),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile("홍보글 활성/비활성 설정 기능 필요"),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile("이전의 작성된 홍보글을 볼 수 있음"),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile("이전의 작성된 홍보글을 볼 수 있음 (개수 제한)"),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile("디자인 구상중"),
                Divider(
                  height: 1,
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                promotionTile("그알의 김상중입니다."),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell promotionTile(String title) {
    return InkWell(
      onTap: () {
        Get.to(() => const PromotionEditScreen());
      },
      child: Container(
        height: 105,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
