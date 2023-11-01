import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/api/api_service.dart';
import 'package:jigu_seller/model/model.dart';
import 'package:jigu_seller/screen/question_detail_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // api 정보 가져오기
  final Future<List<dynamic>> posts = ApiService().getPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("질문")),
      body: FutureBuilder(
        // posts를 기다림
        future: posts,
        builder: (context, snapshot) {
          // posts를 받아올 경우
          if (snapshot.hasData) {
            // 구분선이 있는 리스트 뷰
            return ListView.separated(
              // 받아온 데이터 개수 지정
              itemCount: snapshot.data!.length,
              // 구분선 설정
              separatorBuilder: (context, index) => const Divider(thickness: 1),
              // 리스트 뷰 실행
              itemBuilder: (context, index) {
                // 모델 선언
                Questions question = Questions.fromJson(snapshot.data![index]);
                return ListTile(
                  // 제목 설정
                  title: Text(question.title),
                  // 내용 설정
                  subtitle: Text(question.body),
                  // 눌렀을 때 이동하는 변수와 화면 설정
                  onTap: () {
                    Get.to(() => const QuestionDetailScreen(), arguments: [
                      question.id,
                      question.title,
                      question.body,
                      question.userId,
                    ]);
                  },
                );
              },
            );
          }
          // 데이터 받아오는중
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
