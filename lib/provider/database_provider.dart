import 'package:flutter/material.dart';
import 'package:restaurant_app3/utils/helper/db/database.dart';
import 'package:restaurant_app3/utils/helper/background/state_result.dart';
import '../data/model/restaurant.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  DatabaseProvider() {
    _getDataFavorite();
  }

  late StateResult _state;
  List<Restaurant> _favorites = [];
  String _message = '';

  StateResult get state => _state;
  List<Restaurant> get favorites => _favorites;
  String get message => _message;

  void _getDataFavorite() async {
    _state = StateResult.loading;
    _favorites = await databaseHelper.getFavorite();
    if (_favorites.isNotEmpty) {
      _state = StateResult.hasData;
    } else {
      _state = StateResult.noData;
      _message = "You haven't add any restaurant";
    }
    notifyListeners();
  }

  void addToFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.addFavorite(restaurant);
      _getDataFavorite();
    } catch (e) {
      _state = StateResult.error;
      _message = 'Error : $e';
    }
    notifyListeners();
  }

  Future<bool> checkStatusFavorite(String id) async {
    final dataFavoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return dataFavoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavoriteById(id);
      _getDataFavorite();
    } catch (e) {
      _state = StateResult.error;
      _message = 'Error : $e';
    }
    notifyListeners();
  }
}
