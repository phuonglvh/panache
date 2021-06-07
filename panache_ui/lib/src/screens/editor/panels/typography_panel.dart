import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/text_style_control.dart';

class TypographyThemePanel extends StatelessWidget {
  final TextTheme txtTheme;
  final String themeRef;
  final ThemeModel model;

  const TypographyThemePanel({
    Key key,
    @required this.txtTheme,
    @required this.themeRef,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey.shade200,
        padding: kPadding,
        child: Column(
          children: _buildTextThemeEditorFields(model),
        ),
      );

  List<Widget> _buildTextThemeEditorFields(ThemeModel model) {
    final headline = txtTheme.headline5;
    final title = txtTheme.headline6;
    final subhead = txtTheme.subtitle1;
    final subtitle = txtTheme.subtitle2;
    final body1 = txtTheme.bodyText2;
    final body2 = txtTheme.bodyText2;
    final caption = txtTheme.caption;
    final overline = txtTheme.overline;
    final button = txtTheme.button;
    final display1 = txtTheme.headline4;
    final display2 = txtTheme.headline3;
    final display3 = txtTheme.headline2;
    final display4 = txtTheme.headline1;

    final styleNames = [
      TextStyleControlData(styleName: 'headline', style: headline),
      TextStyleControlData(styleName: 'title', style: title),
      TextStyleControlData(styleName: 'subhead', style: subhead),
      TextStyleControlData(styleName: 'subtitle', style: subtitle),
      TextStyleControlData(styleName: 'body1', style: body1),
      TextStyleControlData(styleName: 'body2', style: body2),
      TextStyleControlData(styleName: 'caption', style: caption),
      TextStyleControlData(styleName: 'overline', style: overline),
      TextStyleControlData(styleName: 'button', style: button),
      TextStyleControlData(styleName: 'display1', style: display1),
      TextStyleControlData(styleName: 'display2', style: display2),
      TextStyleControlData(styleName: 'display3', style: display3),
      TextStyleControlData(styleName: 'display4', style: display4),
    ];

    return styleNames.map((data) {
      return TextStyleControl(
        data.styleName,
        style: data.style,
        onColorChanged: (color) =>
            apply(data.style.copyWith(color: color), data.styleName),
        onSizeChanged: (size) {
          print(
              'TypographyThemePanel._buildTextThemeEditorFields... $size ${data.style}');
          apply(data.style.copyWith(fontSize: size), data.styleName);
        },
        onWeightChanged: (isBold) => apply(
          data.style.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          data.styleName,
        ),
        onFontStyleChanged: (isItalic) => apply(
          data.style.copyWith(
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          data.styleName,
        ),
        onLetterSpacingChanged: (double spacing) =>
            apply(data.style.copyWith(letterSpacing: spacing), data.styleName),
        onWordSpacingChanged: (double spacing) =>
            apply(data.style.copyWith(wordSpacing: spacing), data.styleName),
        onLineHeightChanged: (double lineHeight) =>
            apply(data.style.copyWith(height: lineHeight), data.styleName),
        onDecorationChanged: (TextDecoration decoration) =>
            apply(data.style.copyWith(decoration: decoration), data.styleName),
        onDecorationStyleChanged: (TextDecorationStyle decorationStyle) =>
            apply(data.style.copyWith(decorationStyle: decorationStyle),
                data.styleName),
        onDecorationColorChanged: (Color color) =>
            apply(data.style.copyWith(decorationColor: color), data.styleName),
      );
    }).toList();
  }

  void apply(TextStyle style, String styleName) {
    final styleArgs = <Symbol, dynamic>{};
    styleArgs[Symbol(styleName)] = style;

    final args = <Symbol, dynamic>{};
    args[Symbol(themeRef)] = Function.apply(txtTheme.copyWith, null, styleArgs);
    model.updateTheme(Function.apply(model.theme.copyWith, null, args));
  }
}

class TextStyleControlData {
  final TextStyle style;
  final String styleName;

  TextStyleControlData({this.style, this.styleName});
}
