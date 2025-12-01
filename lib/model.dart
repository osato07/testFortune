abstract class Node {}

class QuestionNode extends Node {
  final String? text;
  final int? yes;
  final int? no;
  QuestionNode({this.text, this.yes, this.no});
}

class ResultNode extends Node {
  final String? emoji;
  final String? title;
  final String? description;
  ResultNode({this.emoji, this.title, this.description});
}
