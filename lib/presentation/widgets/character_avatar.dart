import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading.dart';

class CharacterAvatar extends StatelessWidget {
  final String imageUrl;

  const CharacterAvatar({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            child: const LoadingIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
