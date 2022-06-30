import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Parameters> {
  Future<Either<Failure, Type>> call({Parameters params});
}

abstract class NoParams extends Equatable {}
