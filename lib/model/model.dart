class Questions {
  int userId;
  int id;
  String title;
  String body;

  Questions({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Questions.fromJson(Map<String, dynamic> json)
      : userId = json["userId"],
        id = json["id"],
        title = json["title"],
        body = json["body"];
}

class Comments {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comments({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  Comments.fromJson(Map<String, dynamic> json)
      : postId = json["postId"],
        id = json["id"],
        name = json["name"],
        email = json["email"],
        body = json["body"];
}
