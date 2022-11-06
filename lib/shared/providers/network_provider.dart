
import 'package:http/http.dart';

import 'package:web3dart/web3dart.dart';

class NetworkProvider {
  static final NetworkProvider _instance = NetworkProvider._();
  Web3Client _web3Client;
  String _rpc;
  int _chainId;

  NetworkProvider._();

  factory NetworkProvider(rpc, { chainId }) {
    _instance._rpc = rpc;
    _instance._chainId = chainId;
    _instance._web3Client = Web3Client(rpc, Client());
    return _instance;
  }

  static NetworkProvider get instance {
    return _instance;
  }

  Web3Client get web3Client {
    return _web3Client;
  }

  String get rpc {
    return _rpc;
  }

  int get chainId {
    return _chainId;
  }
  
}
