import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shouter_clock/shared/constant_definition.dart';
import 'package:shouter_clock/shared/local_device/local_device_entity.dart';
import 'package:sailor/sailor.dart';

import '../config/route_config.dart';

class App {
  /// Flavor of running app
  final Flavor flavor;

  /// Router of the app
  final Sailor router;

  /// Local device data
  LocalDevice device;

  static const String dbUrl = "https://api.airtable.com/v0/appVrd9Kpc06sb5w7/";
  static const String userUrl = "https://api.airtable.com/v0/appySASQvw1mse9h6/";
  static const String invoiceUrl = "https://api.airtable.com/v0/appn2BvOrdiGvYIv6/";
  static const String productUrl = "https://api.airtable.com/v0/app0tlLONMf6MFojF/";
  static const String token = "key72d00SyLBKpXmi";

  App({
    @required this.flavor,
    @required this.router,
  });

  /// Helper to get main App instance, one and only
  static App get main => GetIt.instance.get<App>();

  Future<void> init() async {
    // set default orientation to portrait
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // configure routes
    RouteConfig.configureMainRoutes(router);
  }

}
