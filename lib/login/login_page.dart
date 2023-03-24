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
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "شماره بده"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
