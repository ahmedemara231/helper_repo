import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:helper_repo/widgets/padding.dart';
import 'package:helper_repo/widgets/base_widgets/text.dart';
import 'package:pagify/helpers/data_and_pagination_data.dart';
import 'package:pagify/helpers/errors.dart';
import 'package:pagify/pagify.dart';

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

    // if(currentPage == 1){
    //   throw DioException(requestOptions: RequestOptions());
    // }
    final items = List.generate(10, (index) => 'Item $index');
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

  int count = 0;

  /// pagify global key to use in controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Example Usage')),
        body: Pagify<ExampleModel, String>.gridView(
            isReverse: false,
            showNoDataAlert: true,
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
            ),
            onLoading: () => log('loading now ...!'),
            onSuccess: (context, data) => log('the data is ready $data'),
            onError: (context, page, e) async{
            await Future.delayed(const Duration(seconds: 2));
            count++;
            if(count > 3){
              return;
            }
            _easyPaginationController.retry();
              log('page : $page');
              if(e is PagifyNetworkException){
                log('check your internet connection');

              }else if(e is ApiRequestException){
                log('check your server ${e.msg}');

              }else{
                log('other error ...!');
              }
            },

            ignoreErrorBuilderWhenErrorOccursAndListIsNotEmpty: false,
            errorBuilder: (e) => Container(
                color: e is PagifyNetworkException?
                Colors.green: Colors.red,
                child: AppText(e.msg)
            ),

            listenToNetworkConnectivityChanges: true,
            onConnectivityChanged: (isConnected) => isConnected?
            log('connected') : log('disconnected'),

            onUpdateStatus: (s) => log('message $s'),
        )
    );
  }
}
