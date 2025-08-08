import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/padding.dart';
import 'package:helper_repo/widgets/pagination/helpers/controller.dart';
import 'package:helper_repo/widgets/pagination/helpers/data_and_pagination_data.dart';
import 'package:helper_repo/widgets/pagination/helpers/errors.dart';
import 'package:helper_repo/widgets/pagination/pagination_with_reverse_and_status_stream.dart';
import 'package:helper_repo/widgets/text.dart';


class ExampleModel{
  List<String> items;
  int totalPages;

  ExampleModel({
    required this.items,
    required this.totalPages
  });
}

class EasyPaginationTest extends StatefulWidget {
  const EasyPaginationTest({super.key});

  @override
  State<EasyPaginationTest> createState() => _EasyPaginationTestState();
}

class _EasyPaginationTestState extends State<EasyPaginationTest> {

  Future<ExampleModel> _fetchData(int currentPage) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate api call with current page

    if(currentPage == 1){
      // throw DioException(requestOptions: RequestOptions());
      // throw PaginationNetworkError('msg');
    }

    final items = List.generate(25, (index) => 'Item $index');
    return ExampleModel(items: items, totalPages: 3);
  }

  late EasyPaginationController<String> _easyPaginationController;
  @override
  void initState() {
    _easyPaginationController = EasyPaginationController<String>();
    super.initState();
  }

  @override
  void dispose() {
    _easyPaginationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Example Usage')),
        body: EasyPagination<ExampleModel, String>.listView(
            // isReverse: true,
          loadingBuilder: CupertinoActivityIndicator(),
            controller: _easyPaginationController,
            asyncCall: (page)async => await _fetchData(page),
            mapper: (response) => DataListAndPaginationData(
                data: response.items,
                paginationData: PaginationData(
                  totalPages: response.totalPages,
                  perPage: 10,
                )
            ),
            errorMapper: ErrorMapper(
              errorWhenDio: (e) => e.response?.data['errorMsg'], // if you using Dio
              errorWhenHttp: (e) => e.message, // if you using Http
            ),
            itemBuilder: (data, index, element) => AppText(element, fontSize: 20,).paddingSymmetric(vertical: 10)
        )
    );
  }
}
