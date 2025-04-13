import '../../models/character_model.dart';

abstract class CharacterLocalDataSource {
  Future<List<int>> getFavoriteIds();

  Future<void> saveFavoriteIds(List<int> ids);

  Future<void> cacheCharacters(List<CharacterModel> characters);

  Future<List<CharacterModel>> getCachedCharacters();
}