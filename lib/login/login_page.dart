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
        String inputHintCaption = state.shouldVerify ? "کد رو بزن" : "شماره بده";
        int textMaxLength = state.shouldVerify ? 6 : 8;
        var suffixText = state.shouldVerify ? null : "091";
        return SizedBox(
          width: 300,
          child: TextField(
            key: ValueKey(state.shouldVerify),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(textMaxLength)],
            textAlign: TextAlign.left,
            onChanged: (value) => context.read<LoginBloc>().add(state.shouldVerify ? LoginOTPChanged(value) : LoginPhonenumberChanged("091$value")),
            decoration: InputDecoration(
              errorText: state.errorMessage,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelText: inputHintCaption,
              border: const OutlineInputBorder(),
              suffixText: suffixText,
              prefixIcon: const Icon(Icons.close_outlined),
            ),
          ),
        );
      },
    );
  }

  Widget submitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        String submitButtonCaption = state.shouldVerify ? "تایید" : "دریافت کد";
        return SubmitButton(submitButtonCaption, state.submitStatus, () {
          context.read<LoginBloc>().add(const LoginSubmited());
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
