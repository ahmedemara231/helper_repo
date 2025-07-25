import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/padding.dart';

// T is the dataType
class RadioBottomSheet<T> extends StatefulWidget {
  final List<T> values;
  final List<String> titles;
  final String title;
  final FutureOr<void> Function(T val) onSubmit;
  final Color? btnColor;
  final String? btnTitle;
  final double? btnHeight;
  final T? initialValue;

  const RadioBottomSheet({super.key,
    required this.title,
    required this.onSubmit,
    required this.values,
    required this.titles,
    this.btnColor,
    this.btnTitle,
    this.btnHeight,
    this.initialValue
  }) : assert(values.length == titles.length);

  @override
  State<RadioBottomSheet<T>> createState() => _RadioBottomSheetState<T>();
}
//
class _RadioBottomSheetState<T> extends State<RadioBottomSheet<T>> {
  T? groupValue;
  void _changeValue(T? newVal){
    setState(() => groupValue = newVal);
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
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
                      activeColor: widget.btnColor,
                  title: widget.titles[index],
                  value: widget.values[index],
                  groupValue: groupValue,
                  onChanged: _changeValue,
                ) : Column(
                  children: [
                    _RadioItem<T?>(
                      activeColor: widget.btnColor,
                      title: widget.titles[index],
                      value: widget.values[index],
                      groupValue: groupValue,
                      onChanged: _changeValue,
                    ),
                    LoadingButton(
                      title: widget.btnTitle?? 'confirm',
                      onTap: () async => groupValue == null? null :
                      await widget.onSubmit(groupValue!),
                      height: widget.btnHeight?? 40,
                      color: groupValue == null?
                      Colors.grey[300] : widget.btnColor ?? Colors.red,
                    ),
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

  const _RadioItem({super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.activeColor
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
