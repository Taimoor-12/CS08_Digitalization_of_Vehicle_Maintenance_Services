import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JazzCashService {
  payment({required String amount, required String phone}) async {
    // var digest;
    // String refNo = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    // String dateandtime = DateFormat("yyyyMMddHHmmss")
    //     .format(DateTime.now().add(Duration(seconds: 4)));
    //
    // String dexpiredate = DateFormat("yyyyMMddHHmmss")
    //     .format(DateTime.now().add(Duration(days: 1)));
    // String tre = "T" + refNo;
    // String pp_Amount = "100000";
    // String pp_BillReference = "billRef";
    // String pp_Description = "Description";
    // String pp_Language = "EN";
    // String pp_MerchantID = "MC52087";
    // String pp_Password = "90ux9t34tw";
    // String pp_BankID = "";
    // String pp_ProductID = "";
    // String pp_SubMerchantID = "";
    //
    // String pp_ReturnURL =
    //     "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    // String pp_ver = "1.1";
    // String pp_TxnCurrency = "PKR";
    // String pp_TxnDateTime = dateandtime.toString();
    // print(pp_TxnDateTime);
    // // String pp_TxnDateTime = "20221224221836";
    //
    // String pp_TxnExpiryDateTime = dexpiredate.toString();
    // print(pp_TxnExpiryDateTime);
    // // String pp_TxnExpiryDateTime = "20221225221836";
    // String pp_TxnRefNo = tre.toString();
    // print(pp_TxnRefNo);
    // // String pp_TxnRefNo = "T20221224221833";
    // String pp_TxnType = "MWALLET";
    // String ppmpf_1 = phone;
    // String ppmpf_2 = "";
    // String ppmpf_3 = "";
    // String ppmpf_4 = "";
    // String ppmpf_5 = "";
    // String IntegeritySalt = "0b819evz09";
    // String and = '&';
    // String superdata = IntegeritySalt +
    //     and +
    //     pp_Amount +
    //     and +
    //     pp_BankID +
    //     and +
    //     pp_BillReference +
    //     and +
    //     pp_Description +
    //     and +
    //     pp_Language +
    //     and +
    //     pp_MerchantID +
    //     and +
    //     pp_Password +
    //     and +
    //     pp_ProductID +
    //     and +
    //     pp_ReturnURL +
    //     and +
    //     pp_SubMerchantID +
    //     and +
    //     pp_TxnCurrency +
    //     and +
    //     pp_TxnDateTime +
    //     and +
    //     pp_TxnExpiryDateTime +
    //     and +
    //     pp_TxnRefNo +
    //     and +
    //     pp_TxnType +
    //     and +
    //     pp_ver +
    //     and +
    //     ppmpf_1;
    //
    // print(superdata);
    //
    // var key = utf8.encode(IntegeritySalt);
    // var bytes = utf8.encode(superdata);
    // var bytes1 = Latin1Codec().encode(bytes.toString());
    // var hmacSha256 = new Hmac(sha256, key);
    // print(hmacSha256);
    // Digest sha256Result = hmacSha256.convert(bytes1);
    // print(sha256Result.toString());
    // var url =
    //     'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';
    //
    // var response = await http.post(Uri.parse(url), body: {
    //   // "pp_Version": pp_ver,
    //   // "pp_TxnType": pp_TxnType,
    //   // "pp_Language": pp_Language,
    //   // "pp_MerchantID": pp_MerchantID,
    //   // "pp_Password": pp_Password,
    //   // "pp_BankID": "",
    //   // "pp_ProductID": "",
    //   // "pp_TxnRefNo": pp_TxnRefNo,
    //   // "pp_Amount": amount,
    //   // "pp_TxnCurrency": pp_TxnCurrency,
    //   // "pp_TxnDateTime": pp_TxnDateTime,
    //   // "pp_BillReference": pp_BillReference,
    //   // "pp_Description": pp_Description,
    //   // "pp_TxnExpiryDateTime": pp_TxnExpiryDateTime,
    //   // "pp_ReturnURL": pp_ReturnURL,
    //   // "pp_SecureHash": sha256Result.toString(),
    //   // "ppmpf_1": ppmpf_1,
    //   // "ppmpf_2": "",
    //   // "ppmpf_3": "",
    //   // "ppmpf_4": "",
    //   // "ppmpf_5": "":
    //   "pp_Version": pp_ver,
    //   "pp_TxnType": pp_TxnType,
    //   "pp_Language": pp_Language,
    //   "pp_MerchantID": pp_MerchantID,
    //   "pp_SubMerchantID": "",
    //   "pp_Password": pp_Password,
    //   "pp_BankID": "",
    //   "pp_ProductID": "",
    //   "pp_TxnRefNo": pp_TxnRefNo,
    //   "pp_Amount": amount,
    //   "pp_TxnCurrency": "PKR",
    //   "pp_TxnDateTime": pp_TxnDateTime,
    //   "pp_BillReference": pp_BillReference,
    //   "pp_Description": pp_Description,
    //   "pp_TxnExpiryDateTime": pp_TxnExpiryDateTime,
    //   "pp_ReturnURL":
    //       "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction",
    //   "pp_SecureHash": sha256Result.toString(),
    //   "ppmpf_1": ppmpf_1,
    //   "ppmpf_2": "",
    //   "ppmpf_3": "",
    //   "ppmpf_4": "",
    //   "ppmpf_5": ""
    // });
    //
    // print("response=>");
    // print(response.body);

    var digest;
    String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    print(dateandtime);
    String dexpiredate = DateFormat("yyyyMMddHHmmss")
        .format(DateTime.now().add(Duration(days: 1)));
    String dateAndTime = DateFormat("yyyyMMddHHmmss")
        .format(DateTime.now().add(Duration(seconds: 15)));
    print(dateAndTime);
    String tre = "T" + dateandtime;
    String pp_Amount = amount;
    String pp_BillReference = "billRef";
    String pp_Description = "Description of Transaction";
    String pp_Language = "EN";
    String pp_MerchantID = "MC52087";
    String pp_Password = "90ux9t34tw";

    String pp_ReturnURL =
        "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    String pp_Version = "1.1";
    String pp_TxnCurrency = "PKR";
    String pp_TxnDateTime = dateAndTime.toString();
    String pp_TxnExpiryDateTime = dexpiredate.toString();
    String pp_TxnRefNo = tre.toString();
    String pp_TxnType = "MWALLET";
    String ppmpf_1 = phone;
    String ppmpf_2 = "2";
    String ppmpf_3 = "3";
    String ppmpf_4 = "4";
    String ppmpf_5 = "5";
    // String pp_MobileNumber = phone;
    // String pp_CNIC = "345678";
    String IntegeritySalt = "0b819evz09";
    String and = '&';
    String superdata = IntegeritySalt +
        and +
        pp_Amount +
        and +
        pp_BillReference +
        and +
        pp_Description +
        and +
        pp_Language +
        and +
        pp_MerchantID +
        and +
        pp_Password +
        and +
        pp_ReturnURL +
        and +
        pp_TxnCurrency +
        and +
        pp_TxnDateTime +
        and +
        pp_TxnExpiryDateTime +
        and +
        pp_TxnRefNo +
        and +
        pp_TxnType +
        and +
        pp_Version +
        and +
        ppmpf_1;

    print(superdata);

    var key = utf8.encode(IntegeritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);
    // print(sha256Result.toString().toUpperCase());
    var url =
        'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';
    var data = {
      "pp_Version": "1.1",
      "pp_TxnType": "MWALLET",
      "pp_Language": "EN",
      "pp_MerchantID": "MC52087",
      "pp_Password": "90ux9t34tw",
      "pp_TxnRefNo": pp_TxnRefNo,
      "pp_Amount": amount,
      "pp_TxnCurrency": "PKR",
      "pp_TxnDateTime": pp_TxnDateTime,
      "pp_BillReference": "billRef",
      "pp_Description": "Description",
      "pp_TxnExpiryDateTime": pp_TxnExpiryDateTime,
      "pp_ReturnURL":
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction",
      "ppmpf_1": phone,
    };

    var HashedString = hashingFunc(data, IntegeritySalt);
    print(HashedString);

    var response = await http.post(Uri.parse(url), body: {
      "pp_Version": "1.1",
      "pp_TxnType": "MWALLET",
      "pp_Language": "EN",
      "pp_MerchantID": "MC52087",
      "pp_SubMerchantID": "",
      "pp_Password": "90ux9t34tw",
      "pp_BankID": "",
      "pp_ProductID": "",
      // "pp_MobileNumber": "03123456789",
      // "pp_CNIC": "345678",
      "pp_TxnRefNo": pp_TxnRefNo,
      "pp_Amount": amount,
      "pp_TxnCurrency": "PKR",
      "pp_TxnDateTime": pp_TxnDateTime,
      "pp_BillReference": "billRef",
      "pp_Description": "Description",
      "pp_TxnExpiryDateTime": pp_TxnExpiryDateTime,
      "pp_ReturnURL":
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction",
      "pp_SecureHash": HashedString.toUpperCase(),
      "ppmpf_1": phone,
      "ppmpf_2": "",
      "ppmpf_3": "",
      "ppmpf_4": "",
      "ppmpf_5": "",
    });

    print("response=>");
    print(response.body);
  }

  String hashingFunc(Map<String, String> data, String integritySalt) {
    Map<String, String> temp2 = {};
    data.forEach((k, v) {
      if (v != "") v += "&";
      temp2[k] = v;
    });
    var sortedKeys = temp2.keys.toList(growable: false)
      ..sort((k1, k2) => k1.compareTo(k2));
    Map<String, String> sortedMap = Map.fromIterable(sortedKeys,
        key: (k) => k,
        value: (k) {
          return temp2[k]!;
        });

    var values = sortedMap.values;
    String toBePrinted = values.reduce((str, ele) => str += ele);
    toBePrinted = toBePrinted.substring(0, toBePrinted.length - 1);
    toBePrinted = integritySalt + '&' + toBePrinted;
    var key = utf8.encode(integritySalt);
    var bytes = utf8.encode(toBePrinted);
    var hash2 = Hmac(sha256, key);
    var digest = hash2.convert(bytes);
    var hash = digest.toString();
    data["pp_SecureHash"] = hash;
    String returnString = "";
    data.forEach((k, v) {
      returnString += k + '=' + v + '&';
    });
    returnString = returnString.substring(0, returnString.length - 1);

    return hash;
  }
  //
  // Future<void> pay({required String amount, required String phone}) async {
  //   // Transaction Start Time
  //   final currentDate = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
  //
  //   // Transaction Expiry Time
  //   final expDate = DateFormat('yyyyMMddHHmmss')
  //       .format(DateTime.now().add(Duration(minutes: 5)));
  //   final refNo = 'T' + currentDate.toString();
  //
  //   // The json map that contains our key-value pairs
  //   var data = {
  //     "pp_Amount": amount,
  //     "pp_BillReference": "billRef",
  //     "pp_Description": "Description of transaction",
  //     "pp_Language": "EN",
  //     "pp_MerchantID": "MC52087",
  //     "pp_Password": "90ux9t34tw",
  //     "pp_ReturnURL":
  //         "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction",
  //     "pp_TxnCurrency": "PKR",
  //     "pp_TxnDateTime": currentDate,
  //     "pp_TxnExpiryDateTime": expDate,
  //     "pp_TxnRefNo": refNo,
  //     "pp_TxnType": "",
  //     "pp_Version": "1.1",
  //     "pp_BankID": "TBANK",
  //     "pp_ProductID": "RETL",
  //     "ppmpf_1": phone,
  //     "ppmpf_2": "2",
  //     "ppmpf_3": "3",
  //     "ppmpf_4": "4",
  //     "ppmpf_5": "5",
  //   };
  //   String postData = hashingFunc(data);
  //   print(postData);
  //   String responseString = "";
  //   var url =
  //       'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';
  //   var response = await http.post(Uri.parse(url), body: {
  //     "postData": postData,
  //   });
  //   print(response.body);
  //
  //   // try {
  //   //   // Trigger native code through channel method
  //   //   // The first arguemnt is the name of method that is invoked
  //   //   // The second argument is the data passed to the method as input
  //   //   final result =
  //   //       await platform.invokeMethod('performPayment', {"postData": postData});
  //   //
  //   //   // Await for response from above before moving on
  //   //   // The response contains the result of the transaction
  //   //   responseString = result.toString();
  //   // } on PlatformException catch (e) {
  //   //   // On Channel Method Invocation Failure
  //   //   print("PLATFORM_EXCEPTION: ${e.message.toString()}");
  //   // }
  //   //
  //   // // Parse the response now
  //   // List<String> responseStringArray = responseString.split('&');
  //   // Map<String, String> response = {};
  //   // responseStringArray.forEach((e) {
  //   //   if (e.length > 0) {
  //   //     e.trim();
  //   //     final c = e.split('=');
  //   //     response[c[0]] = c[1];
  //   //   }
  //   // }); // Use the transaction response as needed now
  //   // print(response);
  // }
}
