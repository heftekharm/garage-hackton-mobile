import 'package:flutter/material.dart';
import 'package:garage/login/login_bloc.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final SubmitStatus status;
  final VoidCallback onSubmit;

  const SubmitButton(this.text, this.status, this.onSubmit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: status == SubmitStatus.notReady
          ? null
          : () {
              if (status == SubmitStatus.ready) {
                onSubmit();
              }
            },
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w100),
      ),
    );
  }
}
