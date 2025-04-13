import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/character_entity.dart';
import '../../../domain/usecases/get_characters.dart';

part 'characters_state.dart';
part 'characters_event.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUseCase getCharactersUseCase;

  CharactersBloc({required this.getCharactersUseCase})
      : super(CharactersInitial()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<RefreshCharacters>(_onRefreshCharacters);
    on<UpdateFavoriteStatus>(_onUpdateFavoriteStatus);
  }

  void _onFetchCharacters(FetchCharacters event, Emitter<CharactersState> emit) async {
    final currentState = state;
    List<Character> characters = [];
    int nextPage = event.page;

    if (currentState is CharactersLoaded) {
      characters = currentState.characters;
      nextPage = currentState.currentPage + 1;
    }

    try {
      if (state is CharactersInitial) {
        emit(CharactersLoading());
      }
      final newCharacters = await getCharactersUseCase.call(page: nextPage);

      bool hasReachedMax = newCharacters.isEmpty;
      characters.addAll(newCharacters);

      emit(CharactersLoaded(
        characters: characters,
        currentPage: nextPage,
        hasReachedMax: hasReachedMax,
      ));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  void _onRefreshCharacters(RefreshCharacters event, Emitter<CharactersState> emit) async {
    try {
      emit(CharactersLoading());
      final newCharacters = await getCharactersUseCase.call(page: 1);
      emit(CharactersLoaded(
        characters: newCharacters,
        currentPage: 1,
        hasReachedMax: newCharacters.isEmpty,
      ));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  void _onUpdateFavoriteStatus(UpdateFavoriteStatus event, Emitter<CharactersState> emit) {
    final currentState = state;
    if (currentState is CharactersLoaded) {
      final updatedCharacters = currentState.characters.map((character) {
        if (character.id == event.characterId) {
          return Character(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            gender: character.gender,
            image: character.image,
            isFavorite: event.newStatus,
          );
        }
        return character;
      }).toList();
      emit(currentState.copyWith(characters: updatedCharacters));
    }
  }
}