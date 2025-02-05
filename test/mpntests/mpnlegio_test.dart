import 'package:test/test.dart';
import 'package:mpn_lookup_flutter/util/mpnlegio.dart';

void main() {
  test('Test Mpn getMpn (Legiolert)', () {
    Mpn mpn = Mpn();
    for (int j = 0; j < 7; j++) {
      for (int i = 0; i <= 90; i++) {
        dynamic result = mpn.getMpn(i, j);
        expect(result, isNotNull);
        if (result.toString() == '<1') {
          expect((i == 0 && j == 0), true);
        }

        if (result.toString() == '>2272.6') {
          expect((i == 90 && j == 6), true);
        }
      }
    }

    expect(
      () => mpn.getMpn(99, 9),
      throwsA(predicate((e) => e == 'Invalid input')),
    );

    expect(
      () => mpn.getMpn(-1, -1),
      throwsA(predicate((e) => e == 'Invalid input')),
    );
  });
}
