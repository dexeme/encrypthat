import 'package:encrypthat/widgets/main_view.dart';
import 'package:encrypthat/views/keys_page_view.dart';
import 'package:go_router/go_router.dart';
import 'views/signature_page_view.dart';
import 'views/signature_verifier_view.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MainView(),
  ),
  GoRoute(
    path: '/views/keys_page_view',
    builder: (context, state) => const KeysPage(),
  ),
  GoRoute(
    path: '/views/signature_page_view',
    builder: (context, state) => const SignaturePage(),
  ),
  GoRoute(
    path: '/views/signature_validator_view',
    builder: (context, state) => const SignatureValidatorView(),
  ),
]);
