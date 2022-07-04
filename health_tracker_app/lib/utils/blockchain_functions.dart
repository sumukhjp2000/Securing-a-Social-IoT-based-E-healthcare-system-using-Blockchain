import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:health_tracker/utils/const.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = Constants.contractAddress1;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Authentication'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

Future<List<dynamic>> registerPatient(String addr, String name, String password, String age, String sex, Web3Client ethClient) async {
  await callFunction('registerPatient', [EthereumAddress.fromHex(addr), name, password, age, sex], ethClient, Constants.Acc1privateKey);
  List<dynamic> result = await ask('registerPatient', [EthereumAddress.fromHex(addr), name, password, age, sex], ethClient);
  print('Patient registered successfully');
  print("Result $result");
  return result;
}

Future<List<dynamic>> registerDoctor(String addr, String name, String password, String age, String sex, Web3Client ethClient) async {
  await callFunction('registerDoctor', [EthereumAddress.fromHex(addr), name, password, age, sex], ethClient, Constants.Acc2privateKey);
  List<dynamic> result = await ask('registerDoctor', [EthereumAddress.fromHex(addr), name, password, age, sex], ethClient);
  print('Doctor registered successfully');
  print("Result $result");
  return result;
}

Future<List<dynamic>> loginPatient(String addr, String password, Web3Client ethClient) async {
  await callFunction('loginPatient', [EthereumAddress.fromHex(addr), password], ethClient, Constants.Acc1privateKey);
  List<dynamic> result = await ask('loginPatient', [EthereumAddress.fromHex(addr), password], ethClient);
  print('Patient Logged in successfully');
  print("Result $result");
  return result;
}
Future<List<dynamic>> loginDoctor(String addr, String password, Web3Client ethClient) async {
  await callFunction('loginDoctor', [EthereumAddress.fromHex(addr), password], ethClient, Constants.Acc2privateKey);
  List<dynamic> result = await ask('loginDoctor', [EthereumAddress.fromHex(addr), password], ethClient);
  print('Doctor Logged in successfully');
  print("Result $result");
  return result;
}
Future<List<dynamic>> CheckLoc(String Lat, String Long, Web3Client ethClient) async {
  await callFunction('CheckLoc', [Lat, Long], ethClient, Constants.Acc1privateKey);
  List<dynamic> result = await ask('CheckLoc', [Lat, Long], ethClient);
  print('Checked Location successfully');
  print("Result $result");
  return result;
}
Future<List<dynamic>> checkIsPatientLogged(String addr, Web3Client ethClient) async {
  await callFunction('checkIsPatientLogged', [EthereumAddress.fromHex(addr)], ethClient, Constants.Acc2privateKey);
  List<dynamic> result = await ask('checkIsPatientLogged', [EthereumAddress.fromHex(addr)], ethClient);
  print('Patient Data Retrieved Successfully');
  print("Result $result");
  return result;
}
Future<List<dynamic>> checkIsDoctorLogged(String addr, Web3Client ethClient) async {
  await callFunction('checkIsDoctorLogged', [EthereumAddress.fromHex(addr)], ethClient, Constants.Acc2privateKey);
  List<dynamic> result = await ask('checkIsDoctorLogged', [EthereumAddress.fromHex(addr)], ethClient);
  print('Doctor Data Retrieved Successfully');
  print("Result $result");
  return result;
}


Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result = ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}
