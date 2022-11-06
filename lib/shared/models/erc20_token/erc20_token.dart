import 'package:flutter_dapp/shared/providers/network_provider.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';

class Erc20Token extends Erc20 {
  Erc20Token(String contract, NetworkProvider provider)
      : super(
            address: EthereumAddress.fromHex(contract),
            client: provider.web3Client,
            chainId: provider.chainId);
}
