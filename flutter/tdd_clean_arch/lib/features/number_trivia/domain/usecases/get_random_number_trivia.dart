import 'package:tdd_clean_arch/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_clean_arch/core/usecases/usecase.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call({NoParams? params}) async {
    return await numberTriviaRepository.getRandomNumberTrivia();
  }
}
