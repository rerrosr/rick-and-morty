import '../../models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> fetchCharacters({int page});

  Future<List<CharacterModel>> fetchCharactersByIds(List<int> ids);
}

