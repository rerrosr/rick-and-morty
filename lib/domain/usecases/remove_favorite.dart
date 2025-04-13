import '../repositories/character_repository.dart';

class RemoveFavoriteUseCase {
  final CharacterRepository repository;

  RemoveFavoriteUseCase(this.repository);

  Future<void> call(int id) {
    return repository.removeFavorite(id);
  }
}