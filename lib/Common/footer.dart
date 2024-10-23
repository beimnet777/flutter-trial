import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CutsomFooter extends StatelessWidget {
  const CutsomFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Powered by '),
          Image.asset(
            'assets/kifiya.png', // Ensure the logo is added to assets
            width: 50,
            height: 50,
          ),
        ],
      ),
    );
  }
}
