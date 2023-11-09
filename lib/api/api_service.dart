import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  BaseOptions options =
      BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com");

  // post 목록 가져오기
  Future<List<dynamic>> getPosts() async {
    // 옵션 적용해서 dio 생성
    Dio dio = Dio(options);
    // api 접속 시도
    Response response = await dio.get("/posts");
    // 성공할경우
    if (response.statusCode == 200) {
      // 데이터 반환
      return response.data;
    }
    // 실패할 경우
    throw Error();
  }

  // post의 comment 가져오기
  Future<List<dynamic>> getComments(int postId) async {
    // 옵션 적용해서 dio 생성
    Dio dio = Dio(options);
    // api 접속 시도
    Response response = await dio.get("/comments?postId=$postId");
    // 성공할 경우
    if (response.statusCode == 200) {
      // 데이터 반환
      return response.data;
    }
    // 실패할 경우
    throw Error();
  }

  Future<bool> answerPost(String answer, List<dynamic> imgFileList) async {
    Dio dio = Dio(options);
    // FormData formData;
    // List<MultipartFile> files = [];
    // if (imgFileList.isNotEmpty) {
    //   files = imgFileList
    //       .map((img) => MultipartFile.fromFileSync(img.path))
    //       .toList();
    // }
    // formData = FormData.fromMap(
    //     {"images": files, "body": answer, "postId": 1, "userId": 1});

    try {
      Response response = await dio.post("/posts",
          data: {"userId": 1, "id": 1, "title": "1", "body": answer});
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }

  Future<bool> promotionDelete() async {
    Dio dio = Dio(options);
    try {
      Response response = await dio.delete("/posts/1");
      if (response.statusCode == 200) {
        return true;
      } else {
        false;
      }
    } catch (e) {
      Exception(e);
    } finally {
      dio.close();
    }
    return false;
  }
}
