import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:real_estate_project/const/const.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_project/model/agent.dart';
import 'package:real_estate_project/utility/http_exception.dart';

class AgentProvider with ChangeNotifier {
  List<AgentCommentData> _agentComments = [];
  List<AgentCommentData> get agentComment => [..._agentComments];

  clearComments() {
    _agentComments.clear();
  }

  Future getAgentComments(String id) async {
    var url = "${AppConst.baseUrl}/comment/agent/$id";
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      _agentComments = [];
      var decodedData = jsonDecode(response.body);
      if (decodedData['data'] == null) {
      } else {
        _agentComments.addAll((decodedData['data'] as List)
            .map((e) => AgentCommentData.fromJson(e))
            .toList());
      }
    }
  }

  Future deleteComment(String commentID, String agentID) async {
    var url = "${AppConst.baseUrl}/comment/delete/$commentID";
    http.Response response = await http.delete(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      await getAgentComments(agentID);
      notifyListeners();
    } else {
      throw HttpException(errorMessage: "errorMessage");
    }
  }

  Future addComment(String? userId, String agentId, String comment) async {
    var url = "${AppConst.baseUrl}/comment/add";
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user": userId,
        "agent": agentId,
        "comment": comment,
      }),
    );
    if (response.statusCode == 201) {
      await getAgentComments(agentId);
      notifyListeners();
    } else {
      throw HttpException(errorMessage: "errorMessage");
    }
  }
}
