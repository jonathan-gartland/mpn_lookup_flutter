import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Weather API test', () async {
    var request = http.Request('GET', Uri.parse('https://api.openweathermap.org/data/2.5/weather?id=4975802&appid=8dae322cd00667e4add31949c24c8020'));

    http.StreamedResponse response = await request.send();

    response.statusCode == 200 ? print(await response.stream.bytesToString()) : print(response.reasonPhrase);

    expect(response.statusCode, 200);
  });
}
