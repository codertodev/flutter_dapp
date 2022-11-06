import 'package:flutter_dapp/shared/models/payable_account/ethereum_payable_account.dart';
import 'package:flutter_dapp/shared/models/wallet/wallet_base.dart';
import 'package:web3dart/credentials.dart';

class EthereumWallet extends WalletBase {
  EthereumWallet({ String encryptedMnemonic, String encryptedPrivateKey }): super(encryptedMnemonic: encryptedMnemonic, encryptedPrivateKey: encryptedPrivateKey);

  @override
  Future<EthPrivateKey> getSigner(String walletPassword) async {
    final String privateKey = await getPrivateKey(walletPassword);
    return EthPrivateKey.fromHex(privateKey);
  }
  
  @override
  Future<String> approve(String asset, String spender, String walletPassword, { double amount }) async {
    final singer = await getSigner(walletPassword);
    return (getAccount(asset) as EthereumPayableAccount).approve(spender, singer, amount: amount);
  }
  
  @override
  Future transfer(String asset, String recipient, double amount, String walletPassword) async {
    final singer = await getSigner(walletPassword);
    return (getAccount(asset) as EthereumPayableAccount).transfer(recipient, amount, singer);
  }
  
}