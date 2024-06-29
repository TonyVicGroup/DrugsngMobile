import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText {
  static Text sp41(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 41.sp,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      );

  static Text sp20(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      );

  static Text sp18(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      );

  static Text sp16(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      );

  static Text sp14(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      );

  static Text sp12(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      );

  static Text sp10(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      );
}

extension HtTextExtensions on Text {
  Text copyWith({
    FontWeight? fontWeight,
    TextDecoration? decoration,
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
  }) =>
      Text(
        data ?? "",
        textAlign: textAlign ?? this.textAlign,
        maxLines: maxLines ?? this.maxLines,
        // style: style?.merge(this.style) ?? this.style,
        style: (style ?? const TextStyle()).copyWith(
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
        ),
      );

  Text get white => copyWith(color: AppColor.white);
  Text get black => copyWith(color: AppColor.black);
  Text get whiteBlue => copyWith(color: AppColor.whiteBlue);
  Text get primaryColor => copyWith(color: AppColor.primary);
  Text get lightGrey => copyWith(color: AppColor.lightGrey);
  Text setColor(Color color) => copyWith(color: color);
  Text get centerText => copyWith(textAlign: TextAlign.center);

  Text get justify => copyWith(textAlign: TextAlign.justify);
  Text get w200 => copyWith(fontWeight: FontWeight.w200);
  Text get w300 => copyWith(fontWeight: FontWeight.w300);
  Text get w400 => copyWith(fontWeight: FontWeight.w400);
  Text get w500 => copyWith(fontWeight: FontWeight.w500);
  Text get w600 => copyWith(fontWeight: FontWeight.w600);
  Text get w700 => copyWith(fontWeight: FontWeight.w700);
  Text get w800 => copyWith(fontWeight: FontWeight.w800);
  Text get w900 => copyWith(fontWeight: FontWeight.w900);
  Text setMaxLines(int lines) => copyWith(maxLines: lines);
  Text get strikeThrough => copyWith(decoration: TextDecoration.lineThrough);
  Text get underline => copyWith(decoration: TextDecoration.underline);
}
