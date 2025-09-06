class NoteModel {
  final String headline;
  final String description;
  final DateTime postTime;

  NoteModel({
    required this.description,
    required this.headline,
    required this.postTime,
  });

  // Convert JSON to NoteModel
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      headline: json['headline'] as String,
      description: json['description'] as String,
      postTime: DateTime.parse(json['createAt'] as String),
    );
  }

  // Convert NoteModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'headline': headline,
      'description': description,
      'createAt': postTime.toIso8601String(),
    };
  }
}
