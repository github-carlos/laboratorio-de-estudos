import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_arch/core/network/network_info.dart';
import 'package:tdd_clean_arch/core/util/input_converter.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositorImplementation(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));
  sl.registerLazySingleton(() => InputConverter());
}
