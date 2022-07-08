import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';
import '../utils/helper/background/state_result.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteButton({Key? key, required this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.checkStatusFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return isFavorite
                ? IconButton(
                    icon: const Icon(Icons.favorite),
                    iconSize: 30,
                    color: Colors.red[400],
                    onPressed: () {
                      provider.removeFavorite(restaurant.id);
                      showSnackbar(
                          text: 'Successfully Removed!',
                          context: context,
                          color: Colors.red);
                    })
                : IconButton(
                    icon: const Icon(Icons.favorite_border),
                    iconSize: 30,
                    color: Colors.red[400],
                    onPressed: () {
                      provider.addToFavorite(restaurant);
                      showSnackbar(
                        text: 'Restaurant Added!',
                        context: context,
                        color: Colors.red,
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
