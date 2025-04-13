part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final int characterId;
  const AddFavorite(this.characterId);

  @override
  List<Object?> get props => [characterId];
}

class RemoveFavorite extends FavoritesEvent {
  final int characterId;
  const RemoveFavorite(this.characterId);

  @override
  List<Object?> get props => [characterId];
}

