import 'dart:convert';

import 'package:http/http.dart';

// TODO: Update endpoint link
class WalletApi {
  static const String _endpoint = 'https://polkadot.js.org/apps/';

  static Future<Map> getRecommended() async {
    try {
      Response res = await get('$_endpoint/recommended.json');
      if (res == null) {
        return null;
      } else {
        return jsonDecode(res.body) as Map;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}