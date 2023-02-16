import 'package:encrypthat/main.dart';
import 'package:encrypthat/views/ble_devices_view.dart';
import 'package:go_router/go_router.dart';

import 'views/keys_view.dart';
import 'views/signature_view.dart';
import 'views/signature_validator_view.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MyHomePage(
      title: '',
    ),
  ),
  GoRoute(
    path: '/views/keys_view',
    builder: (context, state) => const KeysView(),
  ),
  GoRoute(
    path: '/views/ble_devices_view',
    builder: (context, state) => const BLEDevicesView(),
  ),
  GoRoute(
    path: '/views/signature_generator_view',
    builder: (context, state) => const SignatureGeneratorView(),
  ),
  GoRoute(
    path: '/views/signature_validator_view',
    builder: (context, state) => const SignatureValidatorView(),
  )
]);
