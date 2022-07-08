import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app3/provider/database_provider.dart';
import 'package:restaurant_app3/provider/preferences_provider.dart';
import 'package:restaurant_app3/provider/restaurant_provider.dart';
import 'package:restaurant_app3/provider/search_provider.dart';
import 'package:restaurant_app3/provider/scheduling_provider.dart';
import 'package:restaurant_app3/screens/home/home_page.dart';
import 'package:restaurant_app3/screens/navbar/fav_restaurant.dart';
import 'package:restaurant_app3/screens/navbar/profile_page.dart';
import 'package:restaurant_app3/screens/restaurant/list_page.dart';
import 'package:restaurant_app3/screens/restaurant/detail_page.dart';
import 'package:restaurant_app3/screens/restaurant/search_page.dart';
import 'package:restaurant_app3/utils/helper/background/background_service.dart';
import 'package:restaurant_app3/utils/helper/background/preferences.dart';
import 'package:restaurant_app3/utils/helper/navigation/navigation.dart';
import 'package:restaurant_app3/screens/splash/splash_screen.dart';
import 'package:restaurant_app3/utils/helper/notification/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/model/restaurant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper
      .initializeNotifications(flutterLocalNotificationsPlugin);
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(
              create: (context) => RestaurantProvider()),
          ChangeNotifierProvider<SearchProvider>(
              create: (context) => SearchProvider()),
          ChangeNotifierProvider<DatabaseProvider>(
              create: (context) => DatabaseProvider()),
          ChangeNotifierProvider<PreferencesProvider>(
              create: (context) => PreferencesProvider(
                  preferencesHelper: PreferencesHelper(
                      sharedPreferences: SharedPreferences.getInstance()))),
          ChangeNotifierProvider<SchedulingProvider>(
              create: (context) => SchedulingProvider()),
        ],
        child:
            Consumer<PreferencesProvider>(builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurant App',
            theme: provider.themeData,
            initialRoute: SplashScreen.routeName,
            navigatorKey: navigatorKey,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              HomePage.routeName: (context) => const HomePage(),
              SearchPage.routeName: (context) => const SearchPage(),
              ListRestaurant.routeName: (context) => const ListRestaurant(),
              RestaurantsPage.routeName: (context) => RestaurantsPage(
                  restaurant:
                      ModalRoute.of(context)?.settings.arguments as Restaurant),
              FavoritePage.routeName: (context) => const FavoritePage(),
              ProfilePage.routeName: (context) => const ProfilePage(),
            },
          );
        }));
  }
}
