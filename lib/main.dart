import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shouter_clock/presentation/core/app.dart';
import 'package:shouter_clock/presentation/core/main_app_widget.dart';
import 'package:shouter_clock/shared/constant_definition.dart';
import 'package:logging/logging.dart';
import 'package:sailor/sailor.dart';


Future<void> main() async {
  // Activate logger in root
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
      '${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}',
    );
  });

  GetIt.instance.registerSingleton(
    App(
      flavor: Flavor.development,
      router: Sailor(),
    ),
  );

  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  // wait initialized
  await App.main.init();

  runApp(MainApp());
}
