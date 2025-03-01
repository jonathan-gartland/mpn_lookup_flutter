import 'package:test/test.dart';
import 'package:mpn_lookup_flutter/util/mpnqt.dart';

void main() {
  test('Mpn getElementAtIndex returns lists of length 3 for indices 0-51', () {
    Mpn mpn = Mpn();
    for (int i = 0; i <= 51; i++) {
      List<dynamic> result = mpn.getMpn(i);
      expect(result.length, equals(3), reason: 'Failed at index $i');
    }
  });
}
