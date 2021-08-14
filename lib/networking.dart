import 'dart:convert';

import 'package:http/http.dart' as http;

const APIKey = '4ABDC285-1ABE-4EDC-81FB-E071CAFB9382';

//new : 4ABDC285-1ABE-4EDC-81FB-E071CAFB9382
//old : 228BEE43-FC75-4ACE-AEC3-78184279811C
class Networking {
  Future getData({String cryptocurrency, String currency}) async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$cryptocurrency/$currency?apikey=$APIKey'));
    if (response.statusCode == 200) {
      try {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        return lastPrice;
      } catch (e) {
        print(e);
        return 0;
      }
    } else {
      print('Error in fetching data');
      return 0;
    }
  }
}
