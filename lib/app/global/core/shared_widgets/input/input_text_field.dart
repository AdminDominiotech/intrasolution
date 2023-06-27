import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/shared_widgets/input/_input_style.dart';
import 'package:safe2biz/app/global/core/shared_widgets/text/label.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    Key? key,
    this.controller,
    this.leadingIcon,
    this.trailingIcon,
    this.placeholder,
    this.minWidth,
    this.onChanged,
    this.validator,
    this.autoValidate = false,
    this.isShowIconStatus = false,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.type = InputType.text,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? placeholder;
  final InputLeadingIcon? leadingIcon;
  final InputTrailingIcon? trailingIcon;
  final double? minWidth;
  final void Function(String)? onChanged;
  final InputTextValidator<String>? validator;
  final VoidCallback? onTap;
  final bool autoValidate;
  final bool isShowIconStatus;
  final InputType type;
  final bool enabled;
  final bool readOnly;

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final _focusNode = FocusNode();
  late TextEditingController _controller;

  late InputStyle _inputStyle;
  InputStatus? _inputStatus;

  bool showText = true;

  @override
  void initState() {
    super.initState();
    _inputStyle = InputStyle.inactive;
    _focusNode.addListener(_onFocus);
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocus);
    super.dispose();
  }

  void _onFocus() {
    final status = _focusNode.hasFocus;
    if (status) {
      _inputStyle = InputStyle.focused;
    } else {
      _inputStyle = InputStyle.inactive;
      if (widget.autoValidate && widget.validator != null) {
        onValidator(_controller.text);
      }
    }
    _updateView();
  }

  String? onValidator(String? value) {
    if (widget.validator != null && value != null) {
      final valid = widget.validator!(value);
      if (valid != null) {
        _inputStyle = InputStyle.error;
        _inputStatus = InputStatus(
          status: false,
          message: valid,
        );
        _updateView();
        return '-';
      } else {
        _inputStyle = InputStyle.success;
        _inputStatus = InputStatus(status: true, message: '');
        _updateView();
        return null;
      }
    }
    _inputStyle = InputStyle.inactive;
    _inputStatus = InputStatus(status: true, message: '');
    _updateView();
    return null;
  }

  void _updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.enabled) {
          widget.onTap?.call();
        }
      },
      child: SizedBox(
        // width: widget.minWidth ?? inputMinWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: inputHeight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(inputBorderRadius),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.all(S2BSpacing.zero),
                padding: const EdgeInsets.all(S2BSpacing.zero),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(inputBorderRadius),
                  border: Border.all(
                    color: _inputStyle.colorBorder,
                    width: inputWidthBorder,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      // ===== TRAILING ICON =====
                      if (widget.leadingIcon != null)
                        Container(
                          height: inputHeight,
                          decoration: BoxDecoration(
                            color: widget.leadingIcon!.backgroundColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(inputBorderRadius),
                              bottomRight: Radius.circular(inputBorderRadius),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Icon(
                            widget.leadingIcon!.icon,
                            color: widget.leadingIcon!.color ??
                                _inputStyle.colorBorder,
                            size: widget.leadingIcon!.size,
                          ),
                        ),
                      // ===== TEXTFORMFIELD =====
                      Expanded(
                        child: TextFormField(
                          controller: widget.controller,
                          focusNode: _focusNode,
                          obscureText:
                              widget.type == InputType.password && showText,
                          onChanged: widget.onChanged,
                          readOnly: widget.readOnly,
                          enabled: widget.enabled,
                          onTap: () {
                            if (widget.enabled) {
                              widget.onTap?.call();
                            }
                          },
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            labelText: widget.placeholder,
                            labelStyle: TextStyle(
                              color: _inputStyle.labelColor,
                              fontSize: 13,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: _inputStyle.labelColor,
                              fontSize: 12,
                            ),
                            errorStyle: inputErrorStyle,
                            isDense: false,
                            fillColor: Colors.white,
                            filled: true,

                            contentPadding: const EdgeInsets.fromLTRB(
                              10,
                              8,
                              10,
                              10,
                            ),
                            border: InputBorder.none,
                            // // ===== ICON STATUS =====
                            suffixIcon: (widget.isShowIconStatus &&
                                    _inputStatus != null)
                                ? Icon(
                                    !_inputStatus!.status
                                        ? Icons.error
                                        : Icons.check_circle,
                                    color: _inputStyle.colorBorder,
                                  )
                                : null,
                          ),
                          validator: onValidator,
                        ),
                      ),

                      if (widget.type == InputType.password)
                        InkWell(
                          onTap: () {
                            showText = !showText;
                            _updateView();
                          },
                          child: Container(
                            height: inputHeight,
                            decoration: const BoxDecoration(
                              color: S2BColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(inputBorderRadius),
                                bottomRight: Radius.circular(inputBorderRadius),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Icon(
                              !showText
                                  ? FontAwesomeIcons.eyeLowVision
                                  : FontAwesomeIcons.eye,
                              color: S2BColors.white,
                              size: 20,
                            ),
                          ),
                        )
                      else if (widget.trailingIcon != null)
                        // ===== TRAILING ICON =====
                        Container(
                          height: inputHeight,
                          decoration: BoxDecoration(
                            color: widget.trailingIcon!.backgroundColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(inputBorderRadius),
                              bottomRight: Radius.circular(inputBorderRadius),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Icon(
                            widget.trailingIcon!.icon,
                            color: widget.trailingIcon!.color ??
                                _inputStyle.colorBorder,
                            size: widget.trailingIcon!.size,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                if (_inputStatus != null && !_inputStatus!.status)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: inputBorderRadius,
                      top: 3,
                    ),
                    child: Label(
                      _inputStatus!.message,
                      color: InputStyle.colorError,
                      textType: TextType.labelSmall,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
