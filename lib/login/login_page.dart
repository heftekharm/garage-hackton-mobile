import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage/login/login_bloc.dart';
import 'package:garage/login/widgets/circle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/login/widgets/submit_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('گاراژ', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text('سیستم رزرواسیون مزایده‌ای', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 64),
              inputField(),
              const SizedBox(height: 32),
              submitButton(),
              const Spacer(),
              bottomBgWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: 300,
          child: TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(8)],
            textAlign: TextAlign.left,
            onChanged: (value) => context.read<LoginBloc>().add(LoginPhonenumberChanged(value)),
            decoration: InputDecoration(
                errorText: state.errorMessage,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                labelText: "شماره بده",
                border: const OutlineInputBorder(),
                suffixText: "091"),
          ),
        );
      },
    );
  }

  Widget submitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SubmitButton("دریافت کد", state.submitStatus, () {
          context.read<LoginBloc>().add(LoginPhonenumberSubmited());
        });
      },
    );
  }

  SizedBox bottomBgWidget() {
    return SizedBox(
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
    );
  }
}
