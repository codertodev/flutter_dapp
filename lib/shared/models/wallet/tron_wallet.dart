

import 'package:flutter_dapp/shared/models/wallet/wallet_base.dart';
import 'package:web3dart/credentials.dart';
import 'package:tron/tron.dart' as tron;


class TronWallet extends WalletBase {
  TronWallet({ String encryptedMnemonic, String encryptedPrivateKey }): super(encryptedMnemonic: encryptedMnemonic, encryptedPrivateKey: encryptedPrivateKey);

  @override
  Future<EthPrivateKey> getSigner(String walletPassword) async {
    final String privateKey = await getPrivateKey(walletPassword);
    final credentials = EthPrivateKey.fromHex(privateKey);
    return credentials;
  }

  @override
  Future approve(String asset, String spender, String walletPassword, {double amount}) {

  }

  @override
  Future transfer(String asset, String recipient, double amount, String walletPassword) {

  }
  
}