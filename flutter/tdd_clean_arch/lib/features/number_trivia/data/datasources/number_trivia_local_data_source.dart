import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_arch/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) async {
    sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, json.encode(numberTriviaModel.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final savedNumberInString =
        sharedPreferences.getString(CACHED_NUMBER_TRIVIA);

    if (savedNumberInString != null) {
      final cachedNumber =
          NumberTriviaModel.fromJson(json.decode(savedNumberInString));
      return Future.value(cachedNumber);
    } else {
      throw CacheException();
    }
  }
}
