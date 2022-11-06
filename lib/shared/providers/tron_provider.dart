import 'package:flutter_dapp/shared/providers/network_provider.dart';
import 'package:http/http.dart' as httpClient;

final network = NetworkProvider.instance;

class TronProvider {
  Map<String, String> _headers; 

  TronProvider() {
    final entries = [
    const MapEntry("accept", "application/json"),
    const MapEntry("content-type", "application/json")
  ];
    _headers = Map.fromEntries(entries);
  }

  readFunction(String path, String contractAddress, String functionName, String parameter) async {
    final url = Uri(path: 'wallet/triggerconstantcontract');
    final body = {
      "contract_address": contractAddress.trim(),
      "function_selector": functionName.trim(),
      "parameter": parameter.trim()
    };
    final res = await httpClient.post(url, headers: _headers, body: body);
  }
}