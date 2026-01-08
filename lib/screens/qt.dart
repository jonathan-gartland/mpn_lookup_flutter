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
  final FocusNode _largeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    updateMpnResult();
    _largeFocus.addListener(() {
      if (_largeFocus.hasFocus && _largeController.text == '0') {
        _largeController.clear();
      } else if (!_largeFocus.hasFocus && _largeController.text.isEmpty) {
        _largeController.text = '0';
        updateMpnResult();
      }
    });
  }

  @override
  void dispose() {
    _largeController.dispose();
    _largeFocus.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onInputChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final widthFactor = screenWidth < 600 ? 0.9 : 0.4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quanti-Tray® MPN',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FractionallySizedBox(
              widthFactor: widthFactor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Enter Positive Wells',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'Cochin',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextField(
                        controller: _largeController,
                        focusNode: _largeFocus,
                        textAlign: TextAlign.center,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Tap to enter count',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 16.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        onChanged: (value) => _onInputChanged(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (mpnResult.isNotEmpty && mpnResult[0] != 'Invalid input')
                    Card(
                      elevation: 4,
                      color: Colors.red[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const Text(
                              'Result',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'MPN: ${mpnResult[0]}',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontFamily: 'Cochin',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            const Divider(),
                            const SizedBox(height: 8),
                            Text(
                              '95% Confidence Interval',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Low: ${mpnResult.length > 1 ? mpnResult[1] : ''}  High: ${mpnResult.length > 2 ? mpnResult[2] : ''}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontFamily: 'Cochin',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (mpnResult == [] || mpnResult == ['Invalid input'])
                    Card(
                      elevation: 2,
                      color: Colors.orange[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Please enter a valid well count',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
