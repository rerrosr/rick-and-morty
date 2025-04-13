import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/exceptions/custom_exceptions.dart';
import '../../models/character_model.dart';
import 'character_remote_data_source.dart';

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final http.Client client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> fetchCharacters({int page = 1}) async {
    final url = Uri.parse('https://rickandmortyapi.com/api/character/?page=$page');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final results = (jsonMap['results'] as List)
          .map((item) => CharacterModel.fromJson(item))
          .toList();
      return results;
    } else {
      throw ServerException('Ошибка при загрузке данных. Код: ${response.statusCode}');
    }
  }

  @override
  Future<List<CharacterModel>> fetchCharactersByIds(List<int> ids) async {
    final idString = ids.join(',');
    final url = Uri.parse('https://rickandmortyapi.com/api/character/$idString');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      List<CharacterModel> characters;
      if (ids.length == 1) {
        characters = [CharacterModel.fromJson(decoded)];
      } else {
        characters = (decoded as List)
            .map((item) => CharacterModel.fromJson(item))
            .toList();
      }
      return characters;
    } else {
      throw ServerException('Ошибка при загрузке избранных персонажей. Код: ${response.statusCode}');
    }
  }
}