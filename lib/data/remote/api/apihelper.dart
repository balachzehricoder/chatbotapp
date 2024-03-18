import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as httpClient;
import 'package:chatbotapp/data/remote/api/url.dart';

class apihelper {
  Future<dynamic> postApi({required String url, required String prompt}) async {
    try {
      var muri = Uri.parse(url);

      var response = await httpClient.post(muri,
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": prompt}
            ]
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${Urls.CHAT_COMPLETION_API_key}"
          });

      print(response.body.toString());

      if (response.statusCode == 200) {
        var mdata = jsonDecode(response.body);
        if (mdata['error'] != null) {
          throw (HttpException("error: ${mdata['error']['message']}"));
        } else {
          return mdata;
        }
      } else {
        throw (HttpException("server error: ${response.statusCode}"));
      }
    } catch (e) {
      throw (HttpException(e.toString()));
    }
  }
}
