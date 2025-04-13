import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/character_entity.dart';
import '../../widgets/character_card.dart';
import '../../widgets/loading.dart';
import '../bloc/favorites_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is FavoritesLoaded) {
          final List<Character> favorites = state.favorites;
          if (favorites.isEmpty) {
            return const Center(child: Text('Нет избранных персонажей.'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final character = favorites[index];
              return CharacterCard(character: character);
            },
          );
        } else if (state is FavoritesError) {
          return Center(child: Text('Ошибка: ${state.message}'));
        }
        return Container();
      },
    );
  }
}