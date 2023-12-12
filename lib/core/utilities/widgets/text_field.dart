import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/colors.dart';

class CustomTextBox extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool enabled;
  final String labelText;
  final Function(String?)? onChanged;
  final TextInputType keyBoardType;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffix;
  final int maxLines;
  final int? maxLength;
  final Color? labelColor;

  const CustomTextBox(
      {Key? key,
      this.controller,
      this.onChanged,
        this.enabled = true,
      required this.hintText,
      required this.labelText,
      this.onTap,
      this.labelColor,
      this.validator,
      this.keyBoardType = TextInputType.text,
      this.maxLines = 1,
      this.obscureText = false,
      this.suffix,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText,
              style: TextStyle(
                  color: labelColor ?? Palette.customGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 3),
          TextFormField(
            onTap: onTap,
            enabled: enabled,
            onChanged: onChanged,
            maxLines: maxLines,
            controller: controller,
            validator: validator,
            obscureText: obscureText,
            maxLength: maxLength,
            obscuringCharacter: '*',
            style: const TextStyle(fontSize: 14.0),
            keyboardType: keyBoardType == TextInputType.number
                ? const TextInputType.numberWithOptions(signed: false, decimal: false)
                : keyBoardType,
            inputFormatters:
                keyBoardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : [],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              fillColor: Colors.white54,
              filled: true,
              hintText: hintText,
              //labelText: labelText,
              suffix: suffix,
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w400),
              //labelStyle: const TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w400),
              errorStyle: const TextStyle(color: Colors.red),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Colors.red, width: 1.0)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Palette.primaryColor, width: 1.0)),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Palette.primaryColor, width: 0.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
