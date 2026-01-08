import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mpn_lookup_flutter/util/mpnqt2k.dart';

class QuantiTray2000Page extends StatefulWidget {
  static const String routeName = 'qt2000';
  const QuantiTray2000Page({super.key});

  @override
  QuantiTray2000PageState createState() => QuantiTray2000PageState();
}

class QuantiTray2000PageState extends State<QuantiTray2000Page> {
  Mpn mpn = Mpn();
  int inL = 0;
  int inS = 0;
  List<dynamic> mpnResult = [];
  Timer? _debounce;
  final TextEditingController _largeController = TextEditingController(
      text: '0');
  final TextEditingController _smallController = TextEditingController(
      text: '0');
  final FocusNode _largeFocus = FocusNode();
  final FocusNode _smallFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    updateMpnResult();
    _largeFocus.addListener(() {
      if (_largeFocus.hasFocus && _largeController.text == '0') {
        _largeController.clear();
      } else if (!_largeFocus.hasFocus && _largeController.text.isEmpty) {
        _largeController.text = '0';
        setState(() {
          inL = 0;
          updateMpnResult();
        });
      }
    });
    _smallFocus.addListener(() {
      if (_smallFocus.hasFocus && _smallController.text == '0') {
        _smallController.clear();
      } else if (!_smallFocus.hasFocus && _smallController.text.isEmpty) {
        _smallController.text = '0';
        setState(() {
          inS = 0;
          updateMpnResult();
        });
      }
    });
  }

  @override
  void dispose() {
    _largeController.dispose();
    _smallController.dispose();
    _largeFocus.dispose();
    _smallFocus.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onInputChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        inL = int.tryParse(_largeController.text) ?? 0;
        inS = int.tryParse(_smallController.text) ?? 0;
        updateMpnResult();
      });
    });
  }

  void updateMpnResult() {
    try {
      mpnResult = mpn.getMpn(inL, inS);
    } catch (e) {
      mpnResult = [e.toString()];
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: const Text('Quanti-Tray/2000® MPN'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 50, width: 100),
//             const Text(
//               'Quanti-Tray/2000® MPN',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Cochin',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 50, width: 150),
//             TextField(
//               controller: _largeController,
//               textAlign: TextAlign.center,
//               decoration: const InputDecoration(
//                 labelText: 'Enter Large Positive Well Count:',
//                 labelStyle: TextStyle(
//                   fontSize: 30.0, // Larger label text size
//                 ),
//                 contentPadding: EdgeInsets.only(left: 20.0, top: 30.0, bottom: 30.0),
//                 border: InputBorder.none,
//               ),
//               keyboardType: TextInputType.number,
//               style: const TextStyle(
//                 fontSize: 40.0, // Larger font size
//               ),
//               onChanged: (value) => _onInputChanged(),
//             ),
//             const SizedBox(height: 50, width: 150),
//             TextField(
//               controller: _smallController,
//               textAlign: TextAlign.center,
//               decoration: const InputDecoration(
//                 labelText: 'Enter Small Positive Well Count:',
//                 labelStyle: TextStyle(
//                   fontSize: 30.0, // Larger label text size
//                 ),
//                 contentPadding: EdgeInsets.only(left: 20.0, top: 30.0, bottom: 30.0),
//                 border: InputBorder.none,
//               ),
//
//               keyboardType: TextInputType.number,
//               style: const TextStyle(
//                 fontSize: 40.0, // Larger font size
//               ),
//               onChanged: (value) => _onInputChanged(),
//             ),
//
//             const SizedBox(height: 50),
//             Text(
//               'MPN: ${mpnResult.isNotEmpty ? mpnResult[0] : ''} ',
//               style: const TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//                 fontFamily: 'Cochin',
//               ),
//             ),
//             Text(
//               '95% Confidence (L,H): ${mpnResult.length > 1 ? mpnResult[1] : ''}, '
//               '${mpnResult.length > 2 ? mpnResult[2] : ''}',
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//                 fontFamily: 'Cochin',
//               ),
//             ),
//             if (mpnResult == [] || mpnResult == ['Invalid input'])
//               const Text(
//                 'Enter valid value please!',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                   fontFamily: 'Cochin',
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final widthFactor = screenWidth < 600 ? 0.9 : 0.4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quanti-Tray/2000® MPN',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    child: Column(
                      children: [
                        const Text(
                          'Large',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _largeController,
                          focusNode: _largeFocus,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Enter count',
                            hintStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
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
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          onChanged: (value) => _onInputChanged(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Text(
                          'Small',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _smallController,
                          focusNode: _smallFocus,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Enter count',
                            hintStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
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
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          onChanged: (value) => _onInputChanged(),
                        ),
                      ],
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
                        'Please enter valid well counts',
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
    );
  }
}
