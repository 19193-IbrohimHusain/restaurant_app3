import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restaurant_app3/data/model/restaurant.dart';
import 'package:restaurant_app3/data/model/restaurant_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String _search = 'search?q=';
  static const String _list = 'list';
  static const String _detail = 'detail/';

  // API for Restaurant List
  Future<RestaurantList> listRestaurant(http.Client client) async {
    final response = await http.get(Uri.parse(_baseUrl + _list));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Load Restaurants List');
    }
  }

  // API for Restaurant Detail
  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Load Restaurant Detail');
    }
  }

  // API for Search Restaurant
  Future<SearchRestaurant> searchingRestaurant(String name) async {
    final response = await http.get(Uri.parse(_baseUrl + _search + name));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search Restaurant');
    }
  }

  Future<bool> checkConnection() async {
    try {
      final connect =
          await InternetAddress.lookup('restaurant-api.dicoding.dev');
      if (connect.isNotEmpty && connect[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
