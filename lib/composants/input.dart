import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tickup/ressources/const/app_colors.dart';

class InputText extends StatefulWidget {
  final String labelText;
  final String? hintext;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final String? prefixText;
  final TextStyle? prefixStyle;

  const InputText({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
    this.hintext,
    this.prefixText,
    this.prefixStyle,
  }) : super(key: key);

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  void _togglePasswordView() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscure,
      style: Theme.of(context).textTheme.bodyLarge, // style du texte saisi
      decoration: InputDecoration(
        hintText: widget.hintext,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.black.withOpacity(0.6),
        ),
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: _togglePasswordView,
        )
            : widget.suffixIcon,
      ),
    );
  }
}
