import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required num number, required String text})
      : super(number: number, text: text);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap) {
    return NumberTriviaModel(number: jsonMap['number'], text: jsonMap['text']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'number': number};
  }
}
