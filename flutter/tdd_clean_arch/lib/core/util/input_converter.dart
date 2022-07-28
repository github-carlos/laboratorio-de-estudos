import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    final parsed = int.tryParse(str);

    if (parsed == null || parsed < 0) {
      return Left(InvalidInputFailure());
    }

    return Right(parsed);
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}
