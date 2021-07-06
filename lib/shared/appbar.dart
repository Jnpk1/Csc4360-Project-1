import 'package:flutter/material.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';

PreferredSizeWidget memoAppBar(BuildContext context, String appBarTitle) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    title: Text(
      appBarTitle,
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(color: kOnPrimaryColor),
    ),
  );
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.text, required this.onPressed});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => MaterialButton(
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor,
        onPressed: onPressed,
      );
}
