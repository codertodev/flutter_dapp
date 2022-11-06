import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dapp/shared/models/wallet/ethereum_wallet.dart';
import 'package:flutter_dapp/shared/models/wallet/tron_wallet.dart';
import 'package:flutter_dapp/shared/models/wallet/wallet_base.dart';
import 'package:flutter_dapp/shared/providers/network_provider.dart';
import 'package:flutter_dapp/shared/utils/convert_utils.dart';
import 'package:flutter_dapp/shared/utils/crypto_utils.dart';
import 'package:web3dart/web3dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NetworkProvider network =
      NetworkProvider(" https://nile.trongrid.io");

  String encrypt = "";
  String decrypt = "";
  String balance;
  String allowance;

  Future<void> _incrementCounter() async {
    WalletBase wallet = TronWallet(encryptedMnemonic: "bo2MqMiVPj3OOgrbnWMS7c6vzD9wEKAT3KHNSlgzUQs5Iyr0XpacaoJvgAi9tcXkbExnPPAEQB9K5xvXUSYKJmu2e9H94OEloArNNOFE7Wg566oQFWxKrYzr9GbPgb73");
    final bala =
        await wallet.balance("TXLAQ63Xg1NAzckPwKHvzw7CSEmLMEqcdj");

    // final rs = await wallet.transfer("0xc544f0b5C0259172b6D6a1f6394aB21B5fd8F4Bf", "0xeeCA957c871256440dEb6ca9A192f2769c6F721F", 1100, "Abc@12345!@###%%") as String;
    // print('--------------$rs----------------');

    final kaka = await wallet.allowance(
        "TXLAQ63Xg1NAzckPwKHvzw7CSEmLMEqcdj",
        "TTG8u8fUKqJwMtB59ppaWqgFVGDb5ojWPU");
      
    
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      encrypt = CryptoUtils.encrypt(
          "diesel render razor tape sauce deny noble artwork together explain concert affair",
          "Abc@12345!@###%%");
      decrypt = CryptoUtils.decrypt(encrypt, "Abc@12345!@###%%");

      final value = ConvertUtils.toDouble(bala, 18);
      balance = ConvertUtils.convertToString(bala, 18);

      allowance = ConvertUtils.convertToString(kaka, 18);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$encrypt',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$decrypt',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$balance',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$allowance',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
