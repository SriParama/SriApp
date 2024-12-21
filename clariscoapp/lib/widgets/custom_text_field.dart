import 'package:flutter/material.dart';
import '../core/utils/globle_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onSuffixIconTap;
  final int? maxLength;
  final bool? filled;
  final Color? filledColor;
  final bool borderEnable;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSuffixIconTap,
    this.maxLength,
    this.filled=false,
    this.filledColor=Colors.white,
    this.borderEnable=true,
    this.readOnly=false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength,
      minLines: 1,
      maxLines:isPassword?1: 5,
      readOnly: readOnly,
    

      
      decoration: InputDecoration(
        filled: filled,
        fillColor:filledColor,
        labelText: labelText,
        
        hintText: hintText,
        labelStyle: const TextStyle(color: GlobalColors.primaryTextColor),
        hintStyle: TextStyle(color: GlobalColors.primaryTextColor.withOpacity(0.5),fontSize: 12),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixIconTap,
                child: suffixIcon,
              )
            : null,
        border: 
        borderEnable?OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
         
        ):InputBorder.none,
        focusedBorder: 
        borderEnable?
        OutlineInputBorder(
          borderSide:const BorderSide(color: GlobalColors.appSecondryColor,width: 2),
          borderRadius: BorderRadius.circular(30),

          
        ):InputBorder.none,
        enabledBorder:borderEnable? OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey,width: 1.5),
          borderRadius: BorderRadius.circular(30),
        ):InputBorder.none,
errorBorder:borderEnable? OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red,width: 1.5),
        ):InputBorder.none,
      
      ),
    );
  }
}
