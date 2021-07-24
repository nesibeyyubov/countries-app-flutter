class Question {
  String? text;
  String? flag;
  final String answer;
  final List<String> options;

  Question(
      {this.text,
      this.flag,
      required this.answer,
      required this.options});
}
