import 'package:shouter_clock/presentation/config/route/general_route.dart';
import 'package:sailor/sailor.dart';

/// Route name directory
class RouteName {
  // General routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String dashboard="/dashboard";
  static const String cart="/cart";
  static const String profile="/profile";
  static const String payment="/payment";
  static const String login="/login";
  static const String search="/search";
  static const String searched="/searched";
  static const String categories="/categories";
  static const String categoriesSearch="/categories/search";
  static const String transactions="/transactions";
  static const String transactionsDetail="/transactions/detail";
}

class RouteConfig {
  static void configureMainRoutes(Sailor router) {
    router.addRoutes(GeneralRouteConfig.routes);
  }
}
