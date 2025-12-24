import 'package:flutter_jarvis/core/network_service.dart';
import 'package:flutter_jarvis/core/services/open_api_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerSingleton<OpenApiService>(OpenApiService());
  locator.registerSingleton<NetworkService>(NetworkService());
}
