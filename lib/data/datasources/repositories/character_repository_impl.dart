import '../../../core/exceptions/custom_exceptions.dart';
import '../../../domain/entities/character_entity.dart';
import '../../../domain/repositories/character_repository.dart';
import '../../models/character_model.dart';
import '../local/character_local_data_source.dart';
import '../remote/character_remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Character>> getCharacters({int page = 1}) async {
    List<CharacterModel> remoteCharacters;
    try {
      remoteCharacters = await remoteDataSource.fetchCharacters(page: page);
      await localDataSource.cacheCharacters(remoteCharacters);
    } catch (e) {
      remoteCharacters = await localDataSource.getCachedCharacters();
      if (remoteCharacters.isEmpty) {
        throw CacheException("Нет подключения к интернету и кэшированных данных.");
      }
    }

    final favoriteIds = await localDataSource.getFavoriteIds();
    return remoteCharacters
        .map((model) => Character(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      gender: model.gender,
      image: model.image,
      isFavorite: favoriteIds.contains(model.id),
    ))
        .toList();
  }

  @override
  Future<void> addFavorite(int id) async {
    final currentFavorites = await localDataSource.getFavoriteIds();
    if (!currentFavorites.contains(id)) {
      currentFavorites.add(id);
      await localDataSource.saveFavoriteIds(currentFavorites);
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    final currentFavorites = await localDataSource.getFavoriteIds();
    if (currentFavorites.contains(id)) {
      currentFavorites.remove(id);
      await localDataSource.saveFavoriteIds(currentFavorites);
    }
  }

  @override
  Future<List<Character>> getFavoriteCharacters() async {
    final favoriteIds = await localDataSource.getFavoriteIds();
    if (favoriteIds.isEmpty) return [];

    final remoteFavorites = await remoteDataSource.fetchCharactersByIds(favoriteIds);
    return remoteFavorites
        .map((model) => Character(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      gender: model.gender,
      image: model.image,
      isFavorite: true,
    )).toList();
  }
}