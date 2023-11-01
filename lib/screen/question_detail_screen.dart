import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jigu_seller/api/api_service.dart';
import 'package:jigu_seller/model/model.dart';
import 'package:jigu_seller/screen/answer_screen.dart';

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({super.key});

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  // 가져온 Question 정보
  int id = Get.arguments[0];
  String title = Get.arguments[1];
  String body = Get.arguments[2];
  int userId = Get.arguments[3];

  @override
  Widget build(BuildContext context) {
    // api post의 comment 정보 가져오기
    // build 내에 생성해야 오류 없음
    final Future<List<dynamic>> comments = ApiService().getComments(id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: FutureBuilder(
        future: comments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "제목: $title",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(thickness: 0.5, height: 30),
                    Text(body, style: const TextStyle(fontSize: 23)),
                    const Divider(thickness: 0.5, height: 30),
                    ListView.separated(
                      // 스크롤 없애기
                      physics: const NeverScrollableScrollPhysics(),
                      // 스크롤 에러 방지
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) =>
                          const Divider(thickness: 1),
                      itemBuilder: (context, index) {
                        Comments comment =
                            Comments.fromJson(snapshot.data![index]);
                        return ListTile(
                          // ListTile의 여백 제거
                          contentPadding: const EdgeInsets.all(0),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("이름: ${comment.name}"),
                              Text("<${comment.email}>"),
                              Text(comment.body),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      persistentFooterButtons: [
        Container(
          height: 68,
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => const AnswerScreen(),
                  arguments: [id, title, body, userId]);
            },
            child: const Text("답변하기", style: TextStyle(fontSize: 23)),
          ),
        )
      ],
    );
  }
}
