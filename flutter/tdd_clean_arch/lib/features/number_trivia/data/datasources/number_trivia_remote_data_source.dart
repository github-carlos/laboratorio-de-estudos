import 'dart:convert';

import 'package:tdd_clean_arch/core/error/exceptions.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  ///
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImp implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImp({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getNumberTrivia(Uri.http('numbersapi.com', '$number'));
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getNumberTrivia(Uri.http('numbersapi.com', 'random'));
  }

  Future<NumberTriviaModel> _getNumberTrivia(Uri uri) async {
    final result =
        await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (result.statusCode != 200) {
      throw ServerException();
    }

    final numberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(result.body));
    return numberTriviaModel;
  }
}
