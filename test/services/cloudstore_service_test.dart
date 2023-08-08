import 'package:flutter_test/flutter_test.dart';
import 'package:smartnote/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CloudstoreServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
