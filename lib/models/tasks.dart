class Tasks {
  String id;
  String? title;
  bool isDone;

  Tasks(
      {
        required this.id,
        required this.title,
        this.isDone = false
      });

  factory Tasks.fromJson(Map<String, dynamic> json){
    return Tasks(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }
}