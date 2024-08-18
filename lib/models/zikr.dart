class Zikr {
  final String text;
  final int count;
  final String? title;
  Zikr({required this.text, this.title, required this.count});

  factory Zikr.fromJson(Map<String, dynamic> json) {
    return Zikr(
      text: json['text'],
      count: json['count'] ?? 0,
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'count': count,
      'title': title,
    };
  }
}
