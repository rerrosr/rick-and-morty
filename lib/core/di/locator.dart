import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local/character_local_data_source.dart';
import '../../data/datasources/local/character_local_data_source_impl.dart';
import '../../data/datasources/remote/character_remote_data_source.dart';
import '../../data/datasources/remote/character_remote_data_sourse_impl.dart';
import '../../data/datasources/repositories/character_repository_impl.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/get_characters.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/remove_favorite.dart';
import '../../presentation/rick_and_morty_favorite_list/bloc/favorites_bloc.dart';
import '../../presentation/rick_and_morty_list/bloc/characters_bloc.dart';



final di = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);
  di.registerLazySingleton(() => http.Client());

  di.registerLazySingleton<CharacterRemoteDataSource>(
        () => CharacterRemoteDataSourceImpl(client: di()),
  );

  di.registerLazySingleton<CharacterLocalDataSource>(
        () => CharacterLocalDataSourceImpl(sharedPreferences: di()),
  );

  di.registerLazySingleton<CharacterRepository>(
        () => CharacterRepositoryImpl(
      remoteDataSource: di(),
      localDataSource: di(),
    ),
  );

  di.registerLazySingleton(() => GetCharactersUseCase(di()));
  di.registerLazySingleton(() => AddFavoriteUseCase(di()));
  di.registerLazySingleton(() => RemoveFavoriteUseCase(di()));
  di.registerLazySingleton(() => GetFavoriteCharactersUseCase(di()));

  di.registerFactory(() => CharactersBloc(getCharactersUseCase: di()));
  di.registerFactory(() => FavoritesBloc(
    getFavoriteCharactersUseCase: di(),
    addFavoriteUseCase: di(),
    removeFavoriteUseCase: di(),
  ));
}