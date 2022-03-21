class ToDo {
  static const String collectionName = 'ToDo';
  String id;

  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  ToDo(
      {required this.id,
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  ToDo.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as String,
            title: json['title']! as String,
            description: json['description']! as String,
            dateTime:
                DateTime.fromMillisecondsSinceEpoch(json['dateTime']! as int),
            isDone: json['isDone']! as bool);

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
