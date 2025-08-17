import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/padding.dart';
import 'package:helper_repo/widgets/pagination/helpers/data_and_pagination_data.dart';
import 'package:helper_repo/widgets/pagination/helpers/errors.dart';
import 'package:helper_repo/widgets/pagination/pagify.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';

class ExampleModel{
  List<String> items;
  int totalPages;

  ExampleModel({
    required this.items,
    required this.totalPages
  });
}

class PagifyTest extends StatefulWidget {
  const PagifyTest({super.key});

  @override
  State<PagifyTest> createState() => _PagifyTestState();
}

class _PagifyTestState extends State<PagifyTest> {

  Future<ExampleModel> _fetchData(int currentPage) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate api call with current page

    // if(currentPage == 2){
    //   throw DioException(requestOptions: RequestOptions());
    // }
    final items = List.generate(25, (index) => 'Item $index');
    return ExampleModel(items: items, totalPages: 4);
  }

  late PagifyController<String> _easyPaginationController;
  @override
  void initState() {
    _easyPaginationController = PagifyController<String>();
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
        body: Pagify<ExampleModel, String>.listView(
            isReverse: false,
            showNoDataAlert: true,
            onLoading: () => log('loading now ...!'),
            onSuccess: (context, data) => log('the data is ready $data'),
            onError: (context, page, e) {
              log('page : $page');
              if(e is PagifyNetworkException){
                log('check your internet connection');

              }else if(e is ApiRequestException){
                log('check your server ${e.msg}');

              }else{
                log('other error ...!');
              }
            },
            onUpdateStatus: (s) => log('message $s'),
            controller: _easyPaginationController,
            asyncCall: (context, page)async => await _fetchData(page),
            mapper: (response) => PagifyData(
                data: response.items,
                paginationData: PaginationData(
                  totalPages: response.totalPages,
                  perPage: 10,
                )
            ),
            errorMapper: PagifyErrorMapper(
              errorWhenDio: (e) => 'e.response?.data['']', // if you using Dio
              errorWhenHttp: (e) => 'e.message', // if you using Http
            ),
            itemBuilder: (context, data, index, element) => Center(
                child: InkWell(
                    onTap: (){
                      log('enter here');
                      _easyPaginationController.addAtBeginning('otieuytoiuet');
                    },
                    child: AppText(element, fontSize: 20,).paddingSymmetric(vertical: 10))
            )
        )
    );
  }
}
