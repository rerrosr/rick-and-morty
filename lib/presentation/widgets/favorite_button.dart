import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/character_entity.dart';
import '../rick_and_morty_favorite_list/bloc/favorites_bloc.dart';
import '../rick_and_morty_list/bloc/characters_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final Character character;

  const FavoriteButton({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
          icon: Icon(
            character.isFavorite ? Icons.star : Icons.star_border,
            color: character.isFavorite ? Colors.orangeAccent : Colors.grey,
            size: 28,
          ),
          onPressed: () {
            final favoritesBloc = context.read<FavoritesBloc>();
            final charactersBloc = context.read<CharactersBloc>();
            if (character.isFavorite) {
              favoritesBloc.add(RemoveFavorite(character.id));
              charactersBloc.add(
                UpdateFavoriteStatus(characterId: character.id, newStatus: false),
              );
            } else {
              favoritesBloc.add(AddFavorite(character.id));
              charactersBloc.add(
                UpdateFavoriteStatus(characterId: character.id, newStatus: true),
              );
            }
          },
        ),
      ),
    );
  }
}