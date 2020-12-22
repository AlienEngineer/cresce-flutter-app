import 'dart:math';

import 'package:cresce_flutter_app/features/authentication/authentication.dart';
import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class LoginWidget extends StatefulWidget {
  final LoginWidgetLabels messages;
  final void Function(Token credentialsDto) onSuccess;

  const LoginWidget({
    Key key,
    this.onSuccess,
    this.messages = const LoginWidgetLabels(),
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return _LoginCardWidget(
      messages: widget.messages,
      onCredentialsSubmit: submitCredentials,
    );
  }

  void submitCredentials(Credentials credentials) {
    context.get<LoginServices>().login(
          credentials,
          onSuccess: widget.onSuccess,
        );
  }
}

class _LoginCardWidget extends StatefulWidget {
  final Function(Credentials) onCredentialsSubmit;
  final LoginWidgetLabels messages;

  const _LoginCardWidget({
    this.onCredentialsSubmit,
    this.messages = const LoginWidgetLabels(),
  });

  @override
  _LoginCardWidgetState createState() => _LoginCardWidgetState();
}

class _LoginCardWidgetState extends State<_LoginCardWidget> {
  final _CredentialsFields fields = _CredentialsFields();
  final AnimationOrchestrator trigger = AnimationOrchestrator();

  @override
  void dispose() {
    super.dispose();
    fields.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);

    return BitCard(
      animation: BitAnimations.flip(
        onComplete: trigger,
      ),
      width: cardWidth,
      children: <Widget>[
        BitInputTextField(
          widget.messages.userField,
          field: fields.user,
          animation: BitAnimations.width(
            animateAfter: trigger,
          ),
        ),
        SizedBox(height: context.sizes.small),
        BitInputPasswordField(
          widget.messages.passwordField,
          field: fields.password,
          animation: BitAnimations.width(
            animateAfter: trigger.delayedExtraShort(context),
          ),
        ),
        SizedBox(height: context.sizes.small),
        Center(
          child: BitPrimaryButton(
            onTap: () => widget.onCredentialsSubmit(
              fields.toCredentialsDto(),
            ),
            label: widget.messages.loginLabel,
            animation: BitAnimations.scale(animateAfter: trigger),
          ),
        ),
      ],
    );
  }
}

class _CredentialsFields {
  final Field<String> user = Field<String>();
  final Field<String> password = Field<String>();

  void dispose() {
    user.dispose();
    password.dispose();
  }

  Credentials toCredentialsDto() {
    return Credentials(
      user: user.getValue(),
      password: password.getValue(),
    );
  }
}
