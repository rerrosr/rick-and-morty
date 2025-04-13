import 'package:flutter/material.dart';

import '../../domain/entities/character_entity.dart';
import 'character_avatar.dart';
import 'character_info.dart';
import 'favorite_button.dart';


class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CharacterAvatar(imageUrl: character.image),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: CharacterInfo(character: character),
            ),
            FavoriteButton(character: character),
          ],
        ),
      ),
    );
  }
}