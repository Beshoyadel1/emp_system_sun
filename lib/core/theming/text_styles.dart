import 'package:flutter/material.dart';
import '../../core/language/language.dart';
import '../../core/language/language_cubit/language_cubit.dart';
import '../../core/setup_git_it.dart';
import '../pages_widgets/general_widgets/font_selection.dart';

class TextInAppWidget extends StatefulWidget {
  const TextInAppWidget(
      {super.key,
      required this.text,
      this.textColor,
      this.textSize,
      this.textWidth,
      this.isTextCenter,
      this.textAlign,
      this.fontWeightIndex,
      this.isEllipsisTextOverflow,
      this.maxLines,
      this.decorationTextColor,
      this.decorationText = TextDecoration.none});

  final String text;

  final Color? textColor;

  final double? textSize;

  final double? textWidth;

  final bool? isTextCenter;

  final TextAlign? textAlign;

  final int? fontWeightIndex;

  final bool? isEllipsisTextOverflow;

  final int? maxLines;

  final TextDecoration decorationText;

  final Color? decorationTextColor;

  @override
  State<TextInAppWidget> createState() => _TextInAppWidgetState();
}

class _TextInAppWidgetState extends State<TextInAppWidget> {
  final LanguageCubit _languageCubit = getIt<LanguageCubit>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.textWidth,
      child: Text(AppLocalizations.of(context).translate(widget.text),
          textAlign: widget.textAlign ??
              (widget.isTextCenter == true
                  ? TextAlign.center
                  : TextAlign.start),
          maxLines: widget.maxLines,
          style: TextStyle(
            overflow: widget.isEllipsisTextOverflow == true
                ? TextOverflow.ellipsis
                : null,
            fontSize: widget.textSize != null
                ? (_languageCubit.isAllAppLanguageArabic
                    ? widget.textSize
                    : widget.textSize! - 2)
                : (_languageCubit.isAllAppLanguageArabic
                    ? size.width * 0.05
                    : size.width * 0.04),
            fontWeight:
                fontWeightSelection(fontWeightIndex: widget.fontWeightIndex),
            color: widget.textColor,
            fontFamily: fontSelection(),
            decoration: widget.decorationText,
            decorationColor: widget.decorationTextColor,
            decorationThickness: 1.5,
          )),
    );
  }
}
