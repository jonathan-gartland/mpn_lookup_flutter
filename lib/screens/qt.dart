import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mpn_lookup_flutter/util/mpnqt.dart';

class QuantiTrayPage extends StatefulWidget {
  static const String routeName = 'qt';
  const QuantiTrayPage({super.key});

  @override
  QuantiTrayPageState createState() => QuantiTrayPageState();
}

class QuantiTrayPageState extends State<QuantiTrayPage> {
  Mpn mpn = Mpn();
  int inL = 0;
  List<dynamic> mpnResult = [];
  Timer? _debounce;
  final TextEditingController _largeController = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    updateMpnResult();
  }

  @override
  void dispose() {
    _largeController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onInputChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        inL = int.tryParse(_largeController.text) ?? 0;
        updateMpnResult();
      });
    });
  }

  void updateMpnResult() {
    try {
      mpnResult = mpn.getMpn(inL);
    } catch (e) {
      mpnResult = [e.toString()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Quanti-Tray® MPN'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50, width: 100),
            const Text(
              'Quanti-Tray® MPN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cochin',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50, width: 150),
            TextField(
              controller: _largeController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'Enter Large Positive Well Count:',
                labelStyle: TextStyle(
                  fontSize: 30.0, // Larger label text size
                ),
                // contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                contentPadding: EdgeInsets.only(left: 20.0, top: 30.0, bottom: 30.0),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 40.0, // Larger font size
              ),
              onChanged: (value) => _onInputChanged(),
            ),
            const SizedBox(height: 50),
            Text(
              'MPN: ${mpnResult.isNotEmpty ? mpnResult[0] : ''} ',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontFamily: 'Cochin',
              ),
            ),
            Text(
              '95% Confidence (L,H): ${mpnResult.length > 1 ? mpnResult[1] : ''}, '
              '${mpnResult.length > 2 ? mpnResult[2] : ''}',
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
