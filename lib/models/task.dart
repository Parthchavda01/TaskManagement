class Task {
  final int? id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime dateCreated;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dateCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      dateCreated: DateTime.parse(map['dateCreated']),
    );
  }
}
