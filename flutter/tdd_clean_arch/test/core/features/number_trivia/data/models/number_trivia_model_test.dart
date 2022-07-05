import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Testing text');
  final tNumberTriviaDoubleModel =
      NumberTriviaModel(text: 'Testing text', number: 1e40);

  test('should be a subclass fo NumberTrivia entity', () async {
    // arrange
    // act
    // assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should return a valid model when the JSON number is an double',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, equals(tNumberTriviaDoubleModel));
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final Map<String, dynamic> expectedMap = {
        'text': 'Testing text',
        'number': 1
      };
      expect(tNumberTriviaModel.toJson(), expectedMap);
    });
  });
}
