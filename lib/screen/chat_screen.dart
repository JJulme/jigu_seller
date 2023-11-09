import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/screen/info_screen.dart';
import 'package:jigu_seller/screen/info_screen2.dart';
import 'package:jigu_seller/screen/promotion_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                onPressed: () {
                  Get.to(() => const InfoScreen2());
                },
                child: const Text(
                  "[기본 정보 설정] [불변: 사업자번호, 주소]\n[필수: 카테고리, 사진, 영업시간, 연락처]\n[설정: 소개글, 결제수단, 편의시설, 소개링크, \n노출태크]",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                onPressed: () {
                  Get.to(() => const PromotionScreen());
                },
                child: const Text(
                  "[홍보글 설정] [홍보글 직성]\n[홍보글 수정] [홍보글 배치 변경]",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                onPressed: () {
                  Get.to(() => const InfoScreen());
                },
                child: const Text(
                  "[판매 정보 설정] [판매 기본 소개 작성]\n[대메뉴 설정] [소메뉴 설정]",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
