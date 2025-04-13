import '../repositories/character_repository.dart';

class AddFavoriteUseCase {
  final CharacterRepository repository;

  AddFavoriteUseCase(this.repository);

  Future<void> call(int id) {
    return repository.addFavorite(id);
  }
}