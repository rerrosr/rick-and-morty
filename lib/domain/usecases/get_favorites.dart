import '../entities/character_entity.dart';
import '../repositories/character_repository.dart';

class GetFavoriteCharactersUseCase {
  final CharacterRepository repository;

  GetFavoriteCharactersUseCase(this.repository);

  Future<List<Character>> call() {
    return repository.getFavoriteCharacters();
  }
}