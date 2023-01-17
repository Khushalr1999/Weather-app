import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelp {
  String url;
  double? latitude;
  double? longitude;
  NetworkHelp(this.url);
  Future getData() async {
    http.Response res = await http.get(
      Uri.parse(url),
    );
    if (res.statusCode == 200) {
      String data = res.body;
      var decodeData = jsonDecode(data);
      return decodeData;
    } else {
      print(res.statusCode);
    }
  }
}
