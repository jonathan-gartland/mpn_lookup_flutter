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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50, width: 100),
              const Text(
                'Quanti-Tray/2000® MPN',
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
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 30.0, bottom: 30.0),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 40.0, // Larger font size
                ),
                onChanged: (value) => _onInputChanged(),
              ),
              const SizedBox(height: 50, width: 150),
              TextField(
                controller: _smallController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Enter Small Positive Well Count:',
                  labelStyle: TextStyle(
                    fontSize: 30.0, // Larger label text size
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 30.0, bottom: 30.0),
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
                '95% Confidence (L,H): ${mpnResult.length > 1
                    ? mpnResult[1]
                    : ''}, '
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
      ),
    );
  }
}
