import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mpn_lookup_flutter/util/mpnlegio.dart';

class LegiolertPage extends StatefulWidget {
  static const String routeName = 'legiolert';
  const LegiolertPage({super.key});

  @override
  LegiolertPageState createState() => LegiolertPageState();
}

class LegiolertPageState extends State<LegiolertPage> {
  Mpn mpn = Mpn();
  int inL = 0;
  int inS = 0;
  dynamic mpnResult;
  Timer? _debounce;
  final TextEditingController _largeController = TextEditingController(text: '0');
  final TextEditingController _smallController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    updateMpnResult();
  }

  @override
  void dispose() {
    _largeController.dispose();
    _smallController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onInputChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        inL = int.tryParse(_largeController.text) ?? 0;
        inS = int.tryParse(_smallController.text) ?? 0;
        updateMpnResult();
      });
    });
  }

  void updateMpnResult() {
    try {
      mpnResult = mpn.getMpn(inS, inL);
    } catch (e) {
      mpnResult = [e.toString()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Legiolert® MPN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Legiolert® MPN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cochin',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _largeController,
              decoration: const InputDecoration(
                labelText: 'Enter Large Positive Well Count:',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _onInputChanged(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _smallController,
              decoration: const InputDecoration(
                labelText: 'Enter Small Positive Well Count:',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _onInputChanged(),
            ),
            const SizedBox(height: 50),
            Text(
              'MPN: $mpnResult ',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontFamily: 'Cochin',
              ),
            ),
            if (mpnResult == [] || mpnResult == ['Invalid input'])
              const Text(
                'Enter valid value please!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontFamily: 'Cochin',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
