import 'package:flutter/material.dart';
import 'package:garage/login/widgets/circle.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                )),
            const Spacer(),
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Transform.translate(
                      offset: const Offset(-45, 160),
                      child: const OverflowBox(maxHeight: 550, minHeight: 550, minWidth: 550, maxWidth: 550, child: FilledCircle())),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 290,
                      height: 220,
                      child: Image(
                        image: AssetImage("assets/login_bottom_image.png"),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
