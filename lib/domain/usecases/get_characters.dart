import '../entities/character_entity.dart';
import '../repositories/character_repository.dart';

class GetCharactersUseCase {
  final CharacterRepository repository;

  GetCharactersUseCase(this.repository);

  Future<List<Character>> call({int page = 1}) {
    return repository.getCharacters(page: page);
  }
}