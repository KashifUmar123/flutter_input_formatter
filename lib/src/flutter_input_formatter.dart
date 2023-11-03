import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormatter {
  final int charsCount;
  final TextEditingController controller = TextEditingController();
  final FocusNode focusnode = FocusNode();
  final TextInputType textInputType;
  final String? hintText;

  InputFormatter({
    required this.charsCount,
    this.textInputType = TextInputType.number,
    this.hintText,
  });
}

class FlutterInputFormatter extends StatefulWidget {
  const FlutterInputFormatter({
    super.key,
    this.baseWidth,
    required this.formatters,
    this.hintStyle,
    this.textStyle,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
    required this.onChange,
    this.cursorColor,
    this.textAlign = TextAlign.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final double? baseWidth;
  final List<InputFormatter> formatters;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Function(String val) onChange;
  final Color? cursorColor;
  final TextAlign textAlign;
  final MainAxisAlignment mainAxisAlignment;

  @override
  State<FlutterInputFormatter> createState() => _FlutterInputFormatterState();
}

class _FlutterInputFormatterState extends State<FlutterInputFormatter> {
  late double defaultWidth;
  @override
  void dispose() {
    for (var element in widget.formatters) {
      element.controller.dispose();
    }
    super.dispose();
  }

  Size _getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = _getSize(context);
    defaultWidth = size.width * 0.03;
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      children: widget.formatters
          .map(
            (e) => _formatterBlock(size, e, context, defaultWidth),
          )
          .toList(),
    );
  }

  Widget _formatterBlock(Size size, InputFormatter e, BuildContext context, double dWidth) {
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        border: Border.all(
          color: widget.borderColor ?? Colors.grey,
          width: 1,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: (widget.baseWidth ?? dWidth) * e.charsCount,
          child: TextField(
            controller: e.controller,
            focusNode: e.focusnode,
            cursorColor: widget.cursorColor,
            keyboardType: e.textInputType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintStyle: widget.hintStyle,
              hintText: e.hintText,
              border: InputBorder.none,
            ),
            textAlign: widget.textAlign,
            style: widget.textStyle,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            inputFormatters: [
              LengthLimitingTextInputFormatter(e.charsCount),
            ],
            onChanged: (String val) {
              if (val.length == e.charsCount) {
                _moveFocusFarward(e, context);
              }
              if (val.isEmpty) {
                _moveFocusBackward(e, context);
              }
              _handleTextChange();
            },
          ),
        ),
      ),
    );
  }

  // move focus to previous controller
  void _moveFocusBackward(InputFormatter e, BuildContext context) {
    int index = widget.formatters.indexOf(e);
    if (index != 0) {
      FocusScope.of(context).requestFocus(widget.formatters[index - 1].focusnode);
    }
  }

  // move foucs to next controller
  void _moveFocusFarward(InputFormatter e, BuildContext context) {
    int index = widget.formatters.indexOf(e);
    if (index == widget.formatters.length - 1) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(widget.formatters[index + 1].focusnode);
    }
  }

  // will combine all the text from controller to one string
  void _handleTextChange() {
    String text = "";
    for (final c in widget.formatters) {
      if (c.controller.text.isNotEmpty) {
        text += c.controller.text.trim();
      }
    }
    widget.onChange(text);
  }
}
