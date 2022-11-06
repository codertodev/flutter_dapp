import 'dart:convert';

import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter_dapp/shared/models/erc20_token/erc20_token.dart';
import 'package:flutter_dapp/shared/models/payable_account/ethereum_payable_account.dart';
import 'package:flutter_dapp/shared/models/payable_account/payable_account_base.dart';
import 'package:flutter_dapp/shared/utils/crypto_utils.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';

abstract class WalletBase {
  String encryptedMnemonic;
  String encryptedPrivateKey;
  List<PayableAccountBase> accounts = [
    EthereumPayableAccount("TPhHVTqN2kyjiKRxvMtHr3aRfFyen9UbbZ",
        "TXLAQ63Xg1NAzckPwKHvzw7CSEmLMEqcdj")
  ];

  WalletBase({this.encryptedMnemonic, this.encryptedPrivateKey});

  dynamic getSigner(String walletPassword);
  Future<dynamic> approve(String asset, String spender, String walletPassword, { double amount });
  Future<dynamic> transfer(String asset, String recipient, double amount, String walletPassword);

  PayableAccountBase getDefaultAccount() {
    return accounts.first;
  }

  PayableAccountBase getAccount(String asset) {
    return accounts.firstWhere((element) => element.asset == asset);
  }

  Future<String> getPrivateKey(String walletPassword) async {
    if (encryptedPrivateKey != null && encryptedPrivateKey.isNotEmpty) {
      return CryptoUtils.decrypt(encryptedPrivateKey, walletPassword);
    }
    
    final mnemonic = CryptoUtils.decrypt(encryptedMnemonic, walletPassword);
    final seedBytes = bip39.mnemonicToSeedHex("diesel render razor tape sauce deny noble artwork together explain concert affair");
    Chain chain = Chain.seed(seedBytes);
    final data = chain.forPath("m/44'/195'/0'/0/0"); // m/44'/60'/0'/0/0
    final publicKey = data.publicKey();
    print('publicKey: $publicKey');
    final privateKey = data.privateKeyHex();
    print('private: $privateKey');
    return privateKey;
  }

  Future<BigInt> balance(String asset) {
    return getAccount(asset).balance();
  }

  Future<BigInt> allowance(String asset, String spender) {
    return getAccount(asset).allowance(spender);
  }
}
