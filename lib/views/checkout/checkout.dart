
import 'package:flutter/material.dart';
import 'helpers/payment_helper.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? selected;

  final List<Map<String, String>> gateways = [
    {
      'name': 'bKash',
      'logo': 'assets/bkash-com-logo.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: false,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Select a payment method',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, index) {
                      return PaymentMethodTile(
                        logo: gateways[index]['logo']!,
                        name: gateways[index]['name']!,
                        selected: selected ?? '',
                        onTap: () {
                          setState(() {
                            selected = gateways[index]['name']!
                                .replaceAll(' ', '_')
                                .toLowerCase();
                          });
                        },
                      );
                    },
                    separatorBuilder: (_, index) =>
                    const SizedBox(height: 10),
                    itemCount: gateways.length,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: selected == null
                  ? null
                  : () => onButtonTap(selected!,context),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: selected == null
                      ? Colors.blueAccent[50]
                      : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Continue to payment',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PaymentMethodTile extends StatelessWidget {
  final String logo;
  final String name;
  final VoidCallback? onTap;
  final String selected;

  const PaymentMethodTile({
    super.key,
    required this.logo,
    required this.name,
    this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected == name.replaceAll(' ', '_').toLowerCase()
                ? Colors.blueAccent
                : Colors.black,
            width: 2,
          ),
        ),
        child: ListTile(
          leading: SizedBox(
            height: 35,
            width: 35,
            child: Image.asset(
              logo,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(name),
        ),
      ),
    );
  }
}

