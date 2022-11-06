abstract class PayableAccountBase {
  String publicKey;
  String asset;

  PayableAccountBase(this.publicKey, this.asset);

  Future<BigInt> balance();
  Future<BigInt> allowance(String spender);
  Future<dynamic> approve(String spender, dynamic signer, { double amount });
  Future<dynamic> transfer(String recipient, double amount, dynamic signer);
}