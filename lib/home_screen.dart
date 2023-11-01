import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jigu_seller/screen/chat_screen.dart';
import 'package:jigu_seller/screen/mypage_screen.dart';
import 'package:jigu_seller/screen/question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // BottomNavigationBar 화면 전환을 위한 인덱스 설정
  int currentIndex = 0;
  // BottomNavigationBar 누른 버튼에 따라 바뀌는 body 화면 설정
  List bodyScreen = [
    const QuestionScreen(),
    const ChatScreen(),
    const MypageScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 인덱스에 따라 바뀌는 화면 설정
      body: bodyScreen.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        // 버튼 누르면 커지는 효과
        type: BottomNavigationBarType.fixed,
        // 초기 화면 인덱스 설정
        currentIndex: currentIndex,
        // 누르면 인덱스 번호 바뀜
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        // 버튼 순서와 디자인 설정
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.live_help_rounded),
            label: "질문",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_fill),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: "Mypage",
          ),
        ],
      ),
    );
  }
}
