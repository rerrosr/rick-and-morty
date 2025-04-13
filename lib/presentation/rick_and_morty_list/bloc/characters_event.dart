part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
  @override
  List<Object?> get props => [];
}

class FetchCharacters extends CharactersEvent {
  final int page;
  const FetchCharacters({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class RefreshCharacters extends CharactersEvent {
  const RefreshCharacters();
}

class UpdateFavoriteStatus extends CharactersEvent {
  final int characterId;
  final bool newStatus;
  const UpdateFavoriteStatus({required this.characterId, required this.newStatus});

  @override
  List<Object?> get props => [characterId, newStatus];
}