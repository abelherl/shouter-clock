
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shouter_clock/presentation/config/args/args.dart';
import 'package:shouter_clock/presentation/config/route_config.dart';
import 'package:shouter_clock/presentation/core/app.dart';
import 'package:shouter_clock/shared/clean_code/failure.dart';
import 'package:sailor/sailor.dart';

Future<bool> checkNetwork() async {
  bool connected = false;
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      connected = true;
    }
  } on SocketException catch (_) {
    print('not connected');
  }

  return connected;
}

// Future<void> samePin(String nik, [Function(bool) then]) async {
//   final result = await UserRemoteDataSourceImpl().getUsers();
//   final result2 = await LocalSessionRepositoryImpl().load();
//
//   result.fold(
//         (failure) {
//       return Left(
//         RequestFailure(
//             code: 0,
//             message: 'Somethings wrong',
//         ),
//       );
//     },
//         (user) {
//       // print('Hello ${user[0].name}!');
//
//       bool same = result2.fold((l) => null, (r) {
//         bool found = false;
//         user.forEach((element) {
//           if (r.user.pin == element.pin) {
//             print("SAME PING");
//             found = true;
//           }
//         });
//         print("DIFFERENT PIN");
//         return found;
//       });
//
//       if (same != null) {
//         print("SAME PIN: $same");
//         if (!same) {
//           LocalSessionRepositoryImpl().delete();
//
//           App.main.router.navigate(
//             RouteName.login,
//             navigationType: NavigationType.pushAndRemoveUntil,
//             removeUntilPredicate: (r) => r.isFirst,
//             args: LoginArgs(true, false),
//           );
//         }
//
//         then(same);
//
//         return Right(same);
//       }
//
//       return Left(
//         RequestFailure(
//           code: 0,
//           message: 'Somethings wrong',
//         ),
//       );
//     },
//   );
// }