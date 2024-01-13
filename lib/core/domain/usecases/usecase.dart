import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParameters extends Equatable {
  const NoParameters();
  @override
  List<Object?> get props => [];
}
