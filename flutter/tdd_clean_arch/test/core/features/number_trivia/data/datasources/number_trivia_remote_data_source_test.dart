import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_arch/core/error/exceptions.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImp dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImp(client: mockHttpClient);
  });

  void setupMockHttpSuccess200() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
            (invocation) async => http.Response(fixture('trivia.json'), 200));
  }

  void setupMockHttpFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
            (invocation) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      setupMockHttpSuccess200();

      dataSource.getConcreteNumberTrivia(tNumber);

      verify(() => mockHttpClient.get(Uri.http('numbersapi.com', '$tNumber'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      setupMockHttpSuccess200();
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setupMockHttpFailure404();
      final call = dataSource.getConcreteNumberTrivia;
      expect(
          () async => call(tNumber), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      setupMockHttpSuccess200();

      dataSource.getRandomNumberTrivia();

      verify(() => mockHttpClient.get(Uri.http('numbersapi.com', 'random'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      setupMockHttpSuccess200();
      final result = await dataSource.getRandomNumberTrivia();

      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setupMockHttpFailure404();
      final call = dataSource.getRandomNumberTrivia;
      expect(() async => call(), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
