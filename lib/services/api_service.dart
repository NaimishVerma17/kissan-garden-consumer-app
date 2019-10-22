import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

import './preferences_service.dart';

abstract class ApiService {
  static const BASE_URL = '';

  Future get(String url,
      {Map<String, String> params, bool useAuthHeaders = true}) async {
    return await http.get(_getUrlWithParams(url, params: params),
        headers: await _getHeaders(useAuthHeaders: useAuthHeaders));
  }

  Future post(String url, {@required body, bool useAuthHeaders = true}) async {
    return http.post(this._getUrl(url),
        headers: (await this._getHeaders(useAuthHeaders: useAuthHeaders)),
        body: json.encode(body));
  }

  String _getUrl(String url) {
    return BASE_URL + url;
  }

  Future<Map<String, String>> _getHeaders({useAuthHeaders = true}) async {
    final map = Map<String, String>.from({"Content-Type": "application/json"});

    if (useAuthHeaders) {
      map["Authorization"] =
          "bearer ${await PreferencesService().getAuthToken()}";
    }

    return map;
  }

  String _getUrlWithParams(url, {Map<String, String> params}) {
    var apiUrl = this._getUrl(url);
    if (params != null) {
      var paramsString = "";
      params.forEach((key, value) {
        paramsString += "&$key=$value";
      });

      return apiUrl + "?" + paramsString.substring(1);
    }

    return apiUrl;
  }
}
