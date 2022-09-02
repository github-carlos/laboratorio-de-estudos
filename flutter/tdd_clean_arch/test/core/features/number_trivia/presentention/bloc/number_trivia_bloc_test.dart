import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:tdd_clean_arch/core/util/input_converter.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUpAll(() {
    registerFallbackValue(const Params(number: 1));
  });
  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState sould be Empty', () {
    expect(bloc.state, Empty());
  });

  group('GetTriviaConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTriviaModel(number: 1, text: 'test trivia');

    void setUpMOckInputConverterSuccess() =>
        when(() => mockInputConverter.stringToUnsignedInteger(any()))
            .thenReturn(Right(tNumberParsed));

    test(
        'should call InputConverter to validate and convert the string to an unsigned integer',
        () async {
      setUpMOckInputConverterSuccess();
      when(() => mockGetConcreteNumberTrivia(params: any(named: 'params')))
          .thenAnswer((invocation) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));

      await untilCalled(
          () => mockInputConverter.stringToUnsignedInteger(any()));

      verify(() => mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should return fail when input convert fails',
      setUp: () {
        when(() => mockInputConverter.stringToUnsignedInteger(any()))
            .thenReturn(Left(InvalidInputFailure()));
      },
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [isA<Error>()],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should get data form concrete use case',
        setUp: () {
          when(() => mockGetConcreteNumberTrivia(params: any(named: 'params')))
              .thenAnswer((_) async => Right(tNumberTrivia));
          setUpMOckInputConverterSuccess();
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
        // expect: () => [isA<NumberTriviaModel>()],
        verify: (_) {
          verify(() => mockGetConcreteNumberTrivia(
              params: Params(number: tNumberParsed)));
        });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emit [Loading, Loaded] when data is gotten successfully',
        setUp: () {
          setUpMOckInputConverterSuccess();
          when(() => mockGetConcreteNumberTrivia(params: any(named: 'params')))
              .thenAnswer((_) async => Right(tNumberTrivia));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
        expect: () => [Loading(), Loaded(trivia: tNumberTrivia)]);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emit [Loading, Error] when getting data fails',
        setUp: () {
          setUpMOckInputConverterSuccess();
          when(() => mockGetConcreteNumberTrivia(params: any(named: 'params')))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
        expect: () =>
            [Loading(), const Error(message: SERVER_FAILURE_MESSAGE)]);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        setUp: () {
          setUpMOckInputConverterSuccess();
          when(() => mockGetConcreteNumberTrivia(params: any(named: 'params')))
              .thenAnswer((_) async => Left(CacheFailure()));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForConcreteNumber(tNumberString)),
        expect: () => [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)]);
  });

  group('GetTriviaRandomNumber', () {
    final tNumberTrivia = NumberTriviaModel(number: 1, text: 'test trivia');

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should get data from random use case',
        setUp: () {
          when(() => mockGetRandomNumberTrivia(params: any(named: 'params')))
              .thenAnswer((_) async => Right(tNumberTrivia));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        // expect: () => [isA<NumberTriviaModel>()],
        verify: (_) {
          verify(() => mockGetRandomNumberTrivia());
        });

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emit [Loading, Loaded] when data is gotten successfully',
        setUp: () {
          when(() => mockGetRandomNumberTrivia())
              .thenAnswer((_) async => Right(tNumberTrivia));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: () => [Loading(), Loaded(trivia: tNumberTrivia)]);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emit [Loading, Error] when getting data fails',
        setUp: () {
          when(() => mockGetRandomNumberTrivia())
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: () =>
            [Loading(), const Error(message: SERVER_FAILURE_MESSAGE)]);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        setUp: () {
          when(() => mockGetRandomNumberTrivia())
              .thenAnswer((_) async => Left(CacheFailure()));
        },
        build: () => bloc,
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: () => [Loading(), const Error(message: CACHE_FAILURE_MESSAGE)]);
  });
}
