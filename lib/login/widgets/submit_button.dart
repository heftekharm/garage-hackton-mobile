import 'package:flutter/material.dart';
import 'package:garage/login/login_bloc.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final SubmitStatus status;
  final VoidCallback onSubmit;

  const SubmitButton(this.text, this.status, this.onSubmit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var onPressedCallback = status == SubmitStatus.ready ? onSubmit : null;

    return FilledButton(
      onPressed: onPressedCallback,
      child: SizedBox(
        width: 65,
        height: 35,
        child: /* status == SubmitStatus.progress
              ? _rotatingElipse()
              :  */
            Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w100)),
      ),
    );
  }

  Widget _rotatingElipse() {
    return Image.asset("assets/elipse.png");
  }
}
