import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

  final response =
      await http.get(url, headers: {"key": "cfa895dc811c8ab1f3e1cd51acf16c95"});

  print(response.body);
}
