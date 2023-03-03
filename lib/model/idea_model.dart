class Idea {
  String id;
  String title;
  List likedUser;

  Idea({required this.title,
    required this.id,
    required this.likedUser});

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
        title: json["title"],
        id: json["id"],
        likedUser: List.from(json["likedUser"]));
  }

  Map<String, dynamic> toJson() => {
  "title": title,
  "id": id,
  "likedUser": List<dynamic>.from(likedUser),
};}
