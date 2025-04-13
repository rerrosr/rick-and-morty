import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/character_model.dart';
import 'character_local_data_source.dart';

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  CharacterLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  static const String favoritesKey = 'favorite_ids';
  static const String characterCacheKey = 'character_cache';

  @override
  Future<List<int>> getFavoriteIds() async {
    final ids = sharedPreferences.getStringList(favoritesKey);
    if (ids != null) {
      return ids
          .map((e) => int.tryParse(e) ?? 0)
          .where((element) => element != 0)
          .toList();
    }
    return [];
  }

  @override
  Future<void> saveFavoriteIds(List<int> ids) async {
    final stringIds = ids.map((e) => e.toString()).toList();
    await sharedPreferences.setStringList(favoritesKey, stringIds);
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    final jsonList = characters.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await sharedPreferences.setString(characterCacheKey, jsonString);
  }

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    final jsonString = sharedPreferences.getString(characterCacheKey);
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded.map((item) => CharacterModel.fromJson(item)).toList();
    }
    return [];
  }
}