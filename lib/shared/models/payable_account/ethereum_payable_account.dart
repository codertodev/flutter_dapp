import 'package:flutter_dapp/shared/models/erc20_token/erc20_token.dart';
import 'package:flutter_dapp/shared/models/payable_account/payable_account_base.dart';
import 'package:flutter_dapp/shared/providers/network_provider.dart';
import 'package:flutter_dapp/shared/utils/convert_utils.dart';
import 'package:web3dart/credentials.dart';

class EthereumPayableAccount extends PayableAccountBase {

  final network = NetworkProvider.instance;

  EthereumPayableAccount(String publicKey, String asset) : super(publicKey, asset);

  @override
  Future<BigInt> balance() {
    final Erc20Token erc20token = Erc20Token(asset, network);
    return erc20token.balanceOf(EthereumAddress.fromHex(publicKey));
  }
  
  @override
  Future<BigInt> allowance(String spender) {
    final Erc20Token erc20token = Erc20Token(asset, network);
    return erc20token.allowance(EthereumAddress.fromHex(publicKey), EthereumAddress.fromHex(spender));
  }
  
  @override
  Future<String> approve(String spender, dynamic signer, { double amount }) {
    final Erc20Token erc20token = Erc20Token(asset, network);
    double approveAmount = 9007199254740991;
    if (amount != null) {
      approveAmount = amount;
    }

    return erc20token.approve(EthereumAddress.fromHex(spender), ConvertUtils.toBigInt(approveAmount, 18), credentials: signer as EthPrivateKey);
  }
  
  @override
  Future<String> transfer(String recipient, double amount, dynamic signer) {
    final Erc20Token erc20token = Erc20Token(asset, network);
    return erc20token.transfer(EthereumAddress.fromHex(recipient), ConvertUtils.toBigInt(amount, 18), credentials: signer as EthPrivateKey);
  }

}