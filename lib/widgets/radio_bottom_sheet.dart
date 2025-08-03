import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/loading_btn.dart';
import 'package:helper_repo/widgets/padding.dart';

// T is the dataType
enum ButtonAppearance{withButton, withoutButton}
class RadioBottomSheet<T> extends StatefulWidget {
  final ButtonAppearance buttonAppearance;
  final List<T> values;
  final List<String> titles;
  final String title;
  final T? initialValue;
  final FutureOr<void> Function(T val)? onSelectOption;
  final Color? btnColor;
  final Color? radioColor;
  final String? btnTitle;
  final double? btnHeight;
  final FutureOr<void> Function(T val)? onSubmit;
  final double borderRadius;

  const RadioBottomSheet({super.key,
    required this.title,
    required this.values,
    required this.titles,
    required this.onSelectOption,
    this.initialValue,
    this.borderRadius = 12,
    this.radioColor = Colors.blue,
  }) : btnTitle = null, btnColor = null, btnHeight = null, onSubmit = null,
        buttonAppearance = ButtonAppearance.withoutButton,
        assert(values.length == titles.length);

  const RadioBottomSheet.withButton({
    super.key,
    required this.title,
    required this.values,
    required this.titles,
    this.initialValue,
    this.btnColor = Colors.blue,
    this.btnTitle,
    this.btnHeight,
    required this.onSubmit,
    this.borderRadius = 12,
    this.radioColor = Colors.blue,
}) : onSelectOption = null,
        buttonAppearance = ButtonAppearance.withButton,
        assert(values.length == titles.length);

  @override
  State<RadioBottomSheet<T>> createState() => _RadioBottomSheetState<T>();
}
//
class _RadioBottomSheetState<T> extends State<RadioBottomSheet<T>> {
  T? groupValue;
  void _changeValue(T? newVal){
    setState(() => groupValue = newVal);
    widget.onSelectOption?.call(newVal!);
  }

  @override
  void initState() {
    groupValue = widget.initialValue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(widget.borderRadius)),
        ),
        child: Column(
          spacing: 12,
          children: [
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Column(
              spacing: 10,
              children: List.generate(
                widget.values.length,
                    (index) => index != widget.values.length -1? _RadioItem<T?>(
                      activeColor: widget.radioColor,
                  title: widget.titles[index],
                  value: widget.values[index],
                  groupValue: groupValue,

                  // onItemTap: widget.buttonAppearance == ButtonAppearance.withoutButton?
                  //     () {
                  //       log(widget.values[index].toString());
                  //       _changeValue(widget.values[index]);
                  //     } : () => log(widget.values[index].toString()),

                  onChanged: _changeValue,
                ) : Column(
                  children: [
                    _RadioItem<T?>(
                      activeColor: widget.radioColor,
                      title: widget.titles[index],
                      value: widget.values[index],
                      groupValue: groupValue,
                      onChanged: _changeValue,
                    ),

                    if(widget.buttonAppearance == ButtonAppearance.withButton)
                      LoadingBtn(
                          call: (context) async => groupValue == null? null :
                          await widget.onSubmit?.call(groupValue!),
                        height: 50,
                      )
                      // LoadingButton(
                      //   title: widget.btnTitle?? 'confirm',
                      //   onTap: () async => groupValue == null? null :
                      //   await widget.onSubmit(groupValue!),
                      //   height: widget.btnHeight?? 40,
                      //   color: groupValue == null?
                      //   Colors.grey[300] : widget.btnColor ?? Colors.red,
                      // ),
                  ],
                ),
              ),
            ),
          ],
        ).paddingAll(12),
      ),
    );
  }
}

class _RadioItem<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final void Function(T? val) onChanged;
  final Color? activeColor;
  // final void Function()? onItemTap;

  const _RadioItem({super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.activeColor,
    // this.onItemTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onItemTap,
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const Spacer(),
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: activeColor?? Colors.red,
          ),
        ],
      ),
    );
  }
}
