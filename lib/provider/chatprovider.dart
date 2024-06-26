
import 'package:chatbotapp/data/remote/api/apihelper.dart';
import 'package:chatbotapp/data/remote/api/url.dart';
import 'package:chatbotapp/modles/messagemodle.dart';
import 'package:flutter/material.dart';
import 'package:chatbotapp/modles/Aigeneratedmodle.dart';

class chatprovider extends ChangeNotifier {
  List<messagemodle> listMsg = [];

  void sendmyprompt({required String propmt}) async {
    listMsg.insert(
      0,
      messagemodle(
          mesg: propmt,
          sendAt: DateTime.now().millisecondsSinceEpoch,
          snederid: 0),
    );

    notifyListeners();

    try {
      var mdata = await apihelper()
          .postApi(url: Urls.CHAT_COMPLETION_API, prompt: propmt);

      Autogenerated Aimodle = Autogenerated.fromJson(mdata);

      listMsg.insert(
          0,
          messagemodle(
              mesg: Aimodle.choices![0].message!.content!,
              sendAt: DateTime.now().microsecondsSinceEpoch,
              snederid: 1));

      notifyListeners();
    } catch (e) {
      listMsg.insert(
          0,
          messagemodle(
              mesg: e.toString(),
              sendAt: DateTime.now().microsecondsSinceEpoch,
              snederid: 1));

      notifyListeners();
    }
  }

  List<messagemodle> getAllmsg() {
    return listMsg;
  }
}
