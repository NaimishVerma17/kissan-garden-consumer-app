import 'package:http/http.dart' as http;
import 'package:kissan_garden/app_config.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import './preferences_service.dart';

abstract class ApiService {
  Future<Map<String, dynamic>> get(String url,
      {Map<String, String> params, bool useAuthHeaders = true}) async {
    final response = await http.get(_getUrlWithParams(url, params: params),
        headers: await _getHeaders(useAuthHeaders: useAuthHeaders));
    return _getResponse(response);
  }

  Future<Map<String, dynamic>> post(String url,
      {@required body, bool useAuthHeaders = true}) async {
    final response = await http.post(this._getUrl(url),
        headers: (await this._getHeaders(useAuthHeaders: useAuthHeaders)),
        body: json.encode(body));
    return _getResponse(response);
  }

  Future<Map<String, dynamic>> put(String url,
      {@required body, bool useAuthHeaders = true}) async {
    final response = await http.post(this._getUrl(url),
        headers: (await this._getHeaders(useAuthHeaders: useAuthHeaders)),
        body: json.encode(body));
    return _getResponse(response);
  }

  String _getUrl(String url) {
    return AppConfig.baseUrl + url;
  }

  Future<Map<String, String>> _getHeaders({useAuthHeaders = true}) async {
    final map = Map<String, String>.from({"Content-Type": "application/json"});

    if (useAuthHeaders) {
      map["Authorization"] =
          "${await PreferencesService().getAuthToken()}";
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

  Map<String, dynamic> _getResponse(http.Response response) {
    if (response.body.isEmpty) {
      return {'message': 'Success'};
    } else {
      final Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (body['errors'] != null) {
          Map<String, dynamic> errors = body['errors'];
          if (errors.keys.length > 0)
            throw (errors[errors.keys.elementAt(0)][0].toString());
        } else if (body['message'] != null) {
          throw (body['message']);
        } else {
          throw ('Something went wrong!');
        }
      }
      return body;
    }
  }
}
