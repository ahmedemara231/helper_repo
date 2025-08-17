import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../base_widgets/text_field.dart';
part 'search_bar.dart';

class SearchableList{
  static Widget searchBar({
    required List<dynamic> items,
    required bool Function(dynamic element, String written) searchCondition,
    required FutureOr<void> Function(List<dynamic> searchedList) onSearchFinished,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool? secure,
    String? title,
    TextStyle? style,
    TextAlign? textAlign,
}) => _SearchBar(
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    secure: secure,
    title: title,
    style: style,
    textAlign: textAlign,
    items: items,
    searchCondition: searchCondition,
    onSearchFinished: onSearchFinished,
  );

  // static Widget resultList() => _ResultList();
}