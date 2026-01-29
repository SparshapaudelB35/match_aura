import 'dart:io';

import 'package:flutter/foundation.dart';

class ApiEndpoints{
  ApiEndpoints._();

  // static const String baseUrl = 'http://192.168.1.64:3000/api';
  // Base URL - change this for production
  // static const String baseUrl = 'http://10.0.2.2:3000/api/v1';
  //static const String baseUrl = 'http://localhost:3000/api/v1';
  // For Android Emulator use: 'http://10.0.2.2:3000/api/v1'
  // For iOS Simulator use: 'http://localhost:5000/api/v1'
  // For Physical Device use your computer's IP: 'http://192.168.x.x:5000/api/v1'

  static const bool isPhysicalDevice = true;  // Set to true for Physical Device
  // static const String compIpAddress = "192.168.1.147";
  // static const String emulatorIpAddress = "10.0.2.2";  // Android Emulator localhost

  // static String get baseUrl{
  //   if(kIsWeb){
  //     return 'http://localhost:3000/api';
  //   }else if (Platform.isAndroid){
  //     // Use 10.0.2.2 for Android Emulator, or your machine IP for physical device
  //     return isPhysicalDevice 
  //       ? 'http://$compIpAddress:3000/api'
  //       : 'http://$emulatorIpAddress:3000/api';
  //   }else if(Platform.isIOS){
  //     return 'http://localhost:3000/api';
  //   }else{
  //     return 'http://localhost:3000/api';
  //   }
  // }

  static const String _ipAddress = '192.168.1.147';
  static const int _port = 3000;

  // Base URLs
  static String get _host {
    if (isPhysicalDevice) return _ipAddress;
    if (kIsWeb || Platform.isIOS) return 'localhost';
    if (Platform.isAndroid) return '10.0.2.2';
    return 'localhost';
  }

  static String get serverUrl => 'http://$_host:$_port';
  static String get baseUrl => '$serverUrl/api';
  static String get mediaServerUrl => serverUrl;
  static const Duration connectionTimeout = Duration(seconds: 60);  // Increased from 30s
  static const Duration receiveTimeout = Duration(seconds: 60);     // Increased from 30s

  // user Endpoints

  static const String users = '/users/signup';
  static const String userLogin = '/users/login';
  static String userById(String id)=> '/users/$id';
  static String userPhoto(String id)=> '/users/$id/photo';
  static String userUploadPhoto = '/users/upload';

}