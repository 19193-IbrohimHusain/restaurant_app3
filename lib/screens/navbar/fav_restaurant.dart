import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app3/data/model/restaurant_detail.dart';
import 'package:restaurant_app3/utils/helper/background/state_result.dart';
import 'package:restaurant_app3/utils/resource/style.dart';

import '../../provider/database_provider.dart';
import '../../widgets/restaurant_item.dart';
import '../restaurant/detail_page.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = 'favorite_page';

  const FavoritePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite),
            const SizedBox(width: 5),
            Text(
              "Favorite",
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: primary,
        centerTitle: true,
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == StateResult.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == StateResult.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                var restaurant = provider.favorites[index];
                return RestaurantItem(
                  restaurant: restaurant,
                );
              },
            );
          } else {
            return Center(
              child:
                  Text(provider.message, style: const TextStyle(fontSize: 20)),
            );
          }
        },
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  final RestaurantDetail restaurant;
  final String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";
  const Favorite({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            RestaurantsPage.routeName,
            arguments: restaurant.id,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: primary.withOpacity(0.6)),
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Image.network(pictureUrl + restaurant.pictureId,
                        width: 120),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(color: Colors.transparent, height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: secondary,
                                  size: 20,
                                ),
                                Text(restaurant.city),
                              ],
                            ),
                            const Divider(
                              color: Colors.transparent,
                              height: 5,
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: restaurant.rating.toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 16,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 8,
                                  ),
                                  updateOnDrag: false,
                                  onRatingUpdate: (rating) {},
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
