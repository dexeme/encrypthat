import 'package:encrypthat/test.dart';
import 'package:encrypthat/views/ble_devices_view.dart';
import 'package:encrypthat/views/home_page_view.dart';
import 'package:encrypthat/views/keys_page_view.dart';
import 'package:go_router/go_router.dart';
import 'views/signature_view.dart';
import 'views/signature_verifier_view.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/views/keys_page_view',
    builder: (context, state) => const KeysPage(),
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
  ),
  GoRoute(
    path: '/test',
    builder: (context, state) => const TestWidget(),
  )
]);
