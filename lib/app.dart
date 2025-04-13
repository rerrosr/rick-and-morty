import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/rick_and_morty_favorite_list/bloc/favorites_bloc.dart';
import 'package:rick_and_morty/presentation/rick_and_morty_list/bloc/characters_bloc.dart';
import 'package:rick_and_morty/presentation/screens/main_screen.dart';

import 'core/di/locator.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.di<CharactersBloc>(),
        ),
        BlocProvider(
          create: (_) => di.di<FavoritesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData.dark(),
        home: const MainScreen(),
      ),
    );
  }
}