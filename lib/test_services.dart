import 'dart:convert';
import 'dart:developer';

import 'package:odoo_api/odoo_config.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class Testservice {
  Future<dynamic> fetchdata() async {
    final client = OdooClient(OdooConfig.base);
    print("Client Made");
    var result = [];

    try {
      await client.authenticate(
          OdooConfig.dbName, OdooConfig.adminName, OdooConfig.adminPass);
      print("Authentication done");

      final response = await client.callKw({
        'model': 'res.users',
        'method': 'search_read',
        'args': [
          [
            // ['id', '=', 29]
          ]
        ], // Simplified to check if this works
        // 'domain': ["id", "=", 61],
        'kwargs': {
          'context': {'bin_size': true},
          'fields': ['id', 'name', 'login', 'email'],
          'order': 'id DESC', // Example fields
          // 'limit': 65,
          // 'offset': 0 // Limit to a single record for simplicity
        },
      });

      print("Response received");
      // print("this is response $response");

      var parsedList = jsonEncode(response);

      // print("this is list $parsedList");

      // if (parsedList.isNotEmpty) {
      //   parsedList.first["password"] = password;
      result = jsonDecode(parsedList);
      // for (var element in result) {
      //   print(element);
      // }
      // }
      //else {
      // result = {
      //   "status": false,
      //   "type": "name",
      //   "result": "Can't sign in, please check your username."
      // };
      // }
      // log(result.toString());
    } catch (error) {
      if (error is OdooException) {
        print("OdooException: ${error.message}");
        log("OdooException details: ${jsonEncode(error.message)}");
      } else {
        print("Unexpected error: $error");
      }
    }
    return result;
  }

  Future<dynamic> updateData(String name, String email, int id) async {
    var result = {};

    final client = OdooClient(OdooConfig.base);
    print("Client Made");

    try {
      await client.authenticate(
          OdooConfig.dbName, OdooConfig.adminName, OdooConfig.adminPass);
      print("Authentication done");

      final response = await client.callKw({
        'model': 'res.users',
        'method': 'write',
        'args': [
          [id],
          {"name": name, "email": email}
        ], // Simplified to check if this works
        // 'domain': ["id", "=", 60],
        'kwargs': {
          'context': {'bin_size': true},
          // 'fields': ['id', 'name', 'login', 'email'], // Example fields
          // 'limit': 60, // Limit to a single record for simplicity
        },
      });

      print("Response received");
      log(jsonEncode(response));
      result = {"status": true, "result": response};
    } catch (e) {
      if (e is OdooException) {
        print("OdooException: ${e.message}");
        log("OdooException details: ${jsonEncode(e.message)}");
      } else {
        print("Unexpected error: $e");
      }
      result = {"status": true, "result": e};
    }
    return result;
  }

  Future<dynamic> deleteData(int id) async {
    var result = {};

    final client = OdooClient(OdooConfig.base);
    print("Client Made");

    try {
      await client.authenticate(
          OdooConfig.dbName, OdooConfig.adminName, OdooConfig.adminPass);
      print("Authentication done");

      final response = await client.callKw({
        'model': 'res.users',
        'method': 'unlink',
        'args': [
          [id],
        ], // Simplified to check if this works
        // 'domain': ["id", "=", 60],
        'kwargs': {
          'context': {'bin_size': true},
          // 'fields': ['id', 'name', 'login', 'email'], // Example fields
          // 'limit': 60, // Limit to a single record for simplicity
        },
      });
      print("Response received");
      log(jsonEncode(response));

      result = {"status": true, "result": "Record Deleted Successful"};
      // log(result.toString());
    } catch (error) {
      if (error is OdooException) {
        print("OdooException: ${error.message}");
        log("OdooException details: ${jsonEncode(error.message)}");
      } else {
        print("Unexpected error: $error");
      }
      result = {"status": true, "result": error};
    }
    return result;
  }

  Future<dynamic> createdata(String name, String email) async {
    var result = {};

    final client = OdooClient(OdooConfig.base);
    print("client made");
    try {
      await client.authenticate(
          OdooConfig.dbName, OdooConfig.adminName, OdooConfig.adminPass);
      print("Authentication made");
      final response = await client.callKw({
        'model': 'res.users',
        'method': 'create',
        'args': [
          {
            'name': name,
            'email': email,
            'login': email,
            // 'password' : '121212'
          }
        ],
        'kwargs': {
          'context': {'bin_size': true},
        },
      });

      print("Response received");
      log(jsonEncode(response));
      result = {"status": true, "result": response};
    } catch (e) {
      if (e is OdooException) {
        print("OdooException: ${e.message}");
        log("OdooException details: ${jsonEncode(e.message)}");
      } else {
        print("Unexpected error: $e");
      }
      result = {"status": true, "result": e};
    }
    return result;
  }
}
