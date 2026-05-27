import 'package:flutter/material.dart';

class SetaVoltar extends StatelessWidget {
  final void Function()? ontap;

  const SetaVoltar({
    super.key,
    required this.ontap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30),
            child: Image.asset(
              'assets/images/seta.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
