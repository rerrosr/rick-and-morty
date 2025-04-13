part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object?> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final int currentPage;
  final bool hasReachedMax;

  const CharactersLoaded({
    required this.characters,
    required this.currentPage,
    required this.hasReachedMax,
  });

  CharactersLoaded copyWith({
    List<Character>? characters,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return CharactersLoaded(
      characters: characters ?? this.characters,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [characters, currentPage, hasReachedMax];
}

class CharactersError extends CharactersState {
  final String message;

  const CharactersError(this.message);

  @override
  List<Object?> get props => [message];
}