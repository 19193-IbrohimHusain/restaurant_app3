import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app3/utils/resource/style.dart';
import 'package:restaurant_app3/data/api/api_service.dart';
import 'package:restaurant_app3/data/model/restaurant_detail.dart';
import 'package:restaurant_app3/data/model/restaurant.dart';
import '../../widgets/favorite_button.dart';
import '../../widgets/review_card.dart';
import '../home/home_page.dart';

class RestaurantsPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantsPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  Future<DetailRestaurant>? _detailRestaurant;
  final String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";
  late Future<bool> statusConnection;

  @override
  void initState() {
    super.initState();
    _detailRestaurant = ApiService().detailRestaurant(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
        ),
        body: _buildRestaurant(context));
  }

  Widget _buildRestaurant(BuildContext context) {
    return FutureBuilder(
      future: _detailRestaurant,
      builder: (context, AsyncSnapshot<DetailRestaurant> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            var restaurant = snapshot.data?.restaurant;
            return SingleChildScrollView(
                child: Column(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                    child: Image.network(
                      pictureUrl + restaurant!.pictureId,
                    )),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(restaurant.name,
                                    style:
                                        Theme.of(context).textTheme.headline4)),
                            FavoriteButton(restaurant: widget.restaurant)
                          ]),
                      const Divider(color: Colors.transparent, height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_pin,
                                  color: primary, size: 25),
                              const Padding(padding: EdgeInsets.only(left: 2)),
                              Text(
                                restaurant.address + ", " + restaurant.city,
                                style: GoogleFonts.openSans(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.yellow, size: 25),
                              Text(restaurant.rating.toString(),
                                  style: GoogleFonts.openSans(fontSize: 15))
                            ],
                          )
                        ],
                      ),
                      const Divider(color: Colors.transparent),
                      Text(
                        restaurant.description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Category'),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: List.generate(restaurant.categories.length,
                            (index) {
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 15, top: 5, right: 15, bottom: 5),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primary,
                            ),
                            child: Text(restaurant.categories[index].name),
                          );
                        }),
                      ),
                      const Divider(color: Colors.transparent),
                      const Text('Foods Menu'),
                      Column(
                        children: restaurant.menus.foods
                            .map((food) => Column(
                                  children: [
                                    Card(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.food_bank,
                                            color: primary,
                                            size: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(food.name),
                                                const SizedBox(
                                                    height: 10, width: 100),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                            .toList(),
                      ),
                      const Divider(color: Colors.transparent),
                      const Text('Drinks Menu'),
                      Column(
                        children: restaurant.menus.drinks
                            .map((drink) => Column(
                                  children: [
                                    Card(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.local_drink,
                                            color: secondary,
                                            size: 50,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(drink.name),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                            .toList(),
                      ),
                      const Divider(color: Colors.transparent),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Review Restaurant',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: restaurant.customerReviews.length,
                        itemBuilder: (BuildContext context, int index) {
                          CustomerReview currentReview =
                              restaurant.customerReviews[index];
                          return ReviewCard(
                            customerReview: currentReview,
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.mobiledata_off,
                      size: 150,
                    ),
                    Text(
                      "Failed to Load Data \nPlease Check Your Internet Connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('');
          }
        }
      },
    );
  }
}
