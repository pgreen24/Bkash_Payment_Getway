import 'package:bkash/bkash.dart';
import 'package:flutter/cupertino.dart';


void onButtonTap(String selected, BuildContext context) async {
  switch (selected) {
    case 'bkash':
      await bkashPayment(context);
      break;

    default:
      debugPrint('No gateway selected');
  }
}

double totalPrice = 1.00;

/// bKash
Future<void> bkashPayment(BuildContext context) async {
  final bkash = Bkash(
  bkashCredentials: BkashCredentials(
    username: 'sandboxTokenizedUser02',
    password: 'sandboxTokenizedUser02@12345',
    appKey: '4f6o0cjiki2rfm34kfdadl1eqq',
    appSecret: '2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b',
    isSandbox: true,
  ),
      logResponse: true);

  try {
    final response = await bkash.pay(
      context: context,
      amount: totalPrice,
      merchantInvoiceNumber: 'Test${DateTime.now().millisecondsSinceEpoch}',
    );

    debugPrint('Transaction ID: ${response.trxId}');
    debugPrint('Payment ID: ${response.paymentId}');

  } on BkashFailure catch (e) {
    debugPrint('bKash Error: ${e.message}');
  } catch (e) {
    debugPrint('Payment Error: $e');
  }
}