import '../entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters({int page});

  Future<void> addFavorite(int id);

  Future<void> removeFavorite(int id);

  Future<List<Character>> getFavoriteCharacters();
}