import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String? hint;
  final IconData? prefixIcon;
  final Color? color;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;
  final Function? onTap;
  final IconData? suffix;
  final Function? onChange;

  EntryField({
    this.hint,
    this.prefixIcon,
    this.color,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.textAlign,
    this.suffixIcon,
    this.textInputType,
    this.label,
    this.maxLines,
    this.onTap,
    this.suffix,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        label != null
            ? Text('\n' + label! + '\n',
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.white, fontSize: 15))
            : SizedBox.shrink(),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: controller,
                  initialValue: initialValue,
                  readOnly: readOnly ?? false,
                  maxLines: maxLines ?? 1,
                  textAlign: textAlign ?? TextAlign.left,
                  keyboardType: textInputType,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: prefixIcon != null
                        ? Icon(
                      prefixIcon,
                      color: Theme.of(context).primaryColor,
                      size: 18.5,
                    )
                        : null,
                    suffixIcon: IconButton(onPressed: () {  }, icon: Icon(suffixIcon),),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.grey, fontSize: 15),
                    hintText: hint,
                    filled: true,
                    // fillColor: color ?? Color(0xfff4f7f8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (suffix != null)
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 8),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    suffix,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}