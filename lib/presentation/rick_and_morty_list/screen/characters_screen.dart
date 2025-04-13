import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/character_entity.dart';
import '../../widgets/character_card.dart';
import '../../widgets/loading.dart';
import '../bloc/characters_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(const FetchCharacters(page: 1));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CharactersBloc>().add(const FetchCharacters());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoading && (state is! CharactersLoaded)) {
          return const Center(child: LoadingIndicator());
        } else if (state is CharactersLoaded) {
          final List<Character> characters = state.characters;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<CharactersBloc>().add(const RefreshCharacters());
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax ? characters.length : characters.length + 1,
              itemBuilder: (context, index) {
                if (index < characters.length) {
                  final character = characters[index];
                  return CharacterCard(character: character);
                } else {
                  return const Center(child: LoadingIndicator());
                }
              },
            ),
          );
        } else if (state is CharactersError) {
          return Center(child: Text('Ошибка: ${state.message}'));
        }
        return Container();
      },
    );
  }
}