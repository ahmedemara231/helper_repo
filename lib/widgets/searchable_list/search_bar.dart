part of 'widget_selection.dart';

class _SearchBar<T> extends StatelessWidget {
  final List<T> items;
  final bool Function(T element, String written) searchCondition;
  final FutureOr<void> Function(List<T> searchedList) onSearchFinished;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? secure;
  final String? title;
  final TextStyle? style;
  final TextAlign? textAlign;

  _SearchBar({super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.secure,
    this.title,
    this.style,
    this.textAlign,
    required this.items,
    required this.searchCondition,
    required this.onSearchFinished,
  });

  List<T> _searchedList = [];
  void _search(String written){
    if(written.isEmpty){
      _searchedList = List.from(items);
    }else{
      _searchedList = items
          .where((element) => searchCondition.call(element, written))
          .toList();
    }


    onSearchFinished.call(_searchedList);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      secure: secure?? false,
      title: title,
      style: style,
      textAlign: textAlign,
      onChanged: (p1) => _search(p1?? ''),
      onSubmitted: (p1) => _search(p1?? ''),
    );
  }
}
