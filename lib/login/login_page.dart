import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'گاراژ',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'سیستم رزرواسیون مزایده‌ای',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 64),
            const SizedBox(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: "شماره بده",
                    border: OutlineInputBorder(),
                  ),
                )),
            const SizedBox(height: 32),
            FilledButton(
                onPressed: () {},
                child: const Text(
                  "دریافت کد",
                  style: TextStyle(fontWeight: FontWeight.w100),
                ))
          ],
        ),
      ),
    );
  }
}
