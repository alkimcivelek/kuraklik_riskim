import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  static Future getService(String url, String? contentType) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      HttpClientRequest req = await httpClient.getUrl(Uri.parse(url));
      req.headers.set('Content-Type', contentType ?? 'application/json');
      req.headers.set("Accept", contentType ?? "application/json");
      HttpClientResponse resp = await req.close();

      if (resp.statusCode == 201 || resp.statusCode == 200) {
        String jsonStr = await utf8.decodeStream(resp);
        dynamic jsonDyn = json.decode(jsonStr);
        return jsonDyn;
      } else {
        return {"message": "Bir hata oldu :("};
      }
    } catch (e) {
      return {"message": "Bir hata oldu :("};
    } finally {
      httpClient.close();
    }
  }

  static Future getBearerService(String url) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      HttpClientRequest req = await httpClient.getUrl(Uri.parse(url));
      req.headers.set('Authorization', 'Bearer ${prefs.getString("token")}');
      HttpClientResponse resp = await req.close();

      if (resp.statusCode == 201 || resp.statusCode == 200) {
        String jsonStr = await utf8.decodeStream(resp);
        dynamic jsonDyn = json.decode(jsonStr);
        return jsonDyn;
      } else {
        return {"message": "Bir hata oldu :("};
      }
    } catch (e) {
      return {"message": "Bir hata oldu :("};
    } finally {
      httpClient.close();
    }
  }

  static Future<dynamic> postService(Map data, String url) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      HttpClientRequest req = await httpClient.postUrl(Uri.parse(url));
      req.headers.set('Content-Type', 'application/json');
      req.headers.set("Accept", "application/json");
      req.add(utf8.encode(json.encode(data)));
      HttpClientResponse resp = await req.close();

      if (resp.statusCode == 201 || resp.statusCode == 200) {
        String jsonStr = await utf8.decodeStream(resp);
        dynamic jsonDyn = json.decode(jsonStr);
        return jsonDyn;
      } else {
        return {"message": "Bir hata oldu :("};
      }
    } catch (e) {
      return {"message": "Bir hata oldu :("};
    } finally {
      httpClient.close();
    }
  }

  static Future<dynamic> postBearerService(Map data, String url) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      HttpClientRequest req = await httpClient.postUrl(Uri.parse(url));
      req.headers.set('Authorization', 'Bearer ${prefs.getString("token")}');
      req.headers.set('Content-Type', 'application/json');
      req.add(utf8.encode(json.encode(data)));
      HttpClientResponse resp = await req.close();

      String jsonStr = await utf8.decodeStream(resp);
      dynamic jsonDyn = json.decode(jsonStr);
      return jsonDyn;
    } catch (e) {
      return {"message": "Bir hata oldu :("};
    } finally {
      httpClient.close();
    }
  }

  static Future<bool> deleteBearerService(Map data, String url) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      HttpClientRequest req = await httpClient.deleteUrl(Uri.parse(url));
      req.headers
          .set('Authorization', 'Bearer ${prefs.getString("deviceToken")}');
      req.headers.set('Content-Type', 'application/json');
      req.add(utf8.encode(json.encode(data)));
      HttpClientResponse resp = await req.close();

      String jsonStr = await utf8.decodeStream(resp);
      dynamic jsonDyn = json.decode(jsonStr);
      return jsonDyn['success'] == false ? false : true;
    } catch (e) {
      return false;
    } finally {
      httpClient.close();
    }
  }

  static Future<dynamic> putBearerService(Map data, String url) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      HttpClientRequest req = await httpClient.putUrl(Uri.parse(url));
      req.headers
          .set('Authorization', 'Bearer ${prefs.getString("deviceToken")}');
      req.headers.set('Content-Type', 'application/json');
      req.add(utf8.encode(json.encode(data)));
      HttpClientResponse resp = await req.close();

      String jsonStr = await utf8.decodeStream(resp);
      dynamic jsonDyn = json.decode(jsonStr);
      return jsonDyn;
    } catch (e) {
      return {"message": "Bir hata oldu :("};
    } finally {
      httpClient.close();
    }
  }
}
