class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateAdded;

//All the spellings should be same as that of backend
  Note({this.id, this.userid, this.title, this.content, this.dateAdded});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"],
      userid: map["userid"],
      title: map["title"],
      content: map["content"],
      dateAdded: DateTime.tryParse(map[
          "dateAdded"]), //if date is null, then it will not give error and will give null
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "title": title,
      "content": content,
      "dateAdded": dateAdded!.toIso8601String(),
    };
  }
}
