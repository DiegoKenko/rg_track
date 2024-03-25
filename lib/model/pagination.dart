import 'package:ms_map_utils/ms_map_utils.dart';

class Pagination<R> {
  final List<R> data;
  final int? currentPage;
  final int page;
  final int? from;
  final int? perPage;
  final int? lastPage;
  final int? to;
  final int? total;

  Pagination({
    this.data = const [],
    this.page = 1,
    this.currentPage,
    this.from,
    this.perPage,
    this.lastPage,
    this.to,
    this.total,
  });

  Map<String, dynamic> get query => compact<String, dynamic>({
        'page': page,
        'per_page': perPage,
      });

  Pagination.initial({this.perPage = 15})
      : page = 1,
        currentPage = 1,
        from = 1,
        lastPage = 1,
        to = 1,
        total = 0,
        data = const [];

  Pagination._empty()
      : page = 1,
        currentPage = 1,
        lastPage = 1,
        to = 1,
        data = [],
        total = 0,
        from = 1,
        perPage = 15;

  factory Pagination.fromMap(
    dynamic map,
    R Function(Map<String, dynamic> data) parseData,
  ) {
    Pagination<R> pag = Pagination<R>._empty();
    if (map is Map<String, dynamic>) {
      pag = Pagination(
        data: [
          ...(map['data'] as List)
              .whereType<Map>()
              .cast<Map<String, dynamic>>()
              .map(parseData)
        ],
        currentPage: map['current_page'],
        from: map['from'],
        perPage: map['per_page'],
        lastPage: map['last_page'],
        to: map['to'],
        total: map['total'],
      );
    } else if (map is List && map.isNotEmpty) {
      List<R> datas = map.map((e) => parseData(e)).cast<R>().toList();
      pag = Pagination(
        data: datas,
        perPage: datas.length,
        currentPage: 1,
        from: 1,
        page: 1,
        lastPage: 1,
        to: 1,
        total: datas.length,
      );
    } else {}
    return pag;
  }

  Pagination<R> nextPage() {
    return Pagination(
      perPage: perPage ?? 15,
      page: (currentPage ?? 0) + 1,
    );
  }

  factory Pagination.fromList([List<R> list = const []]) => Pagination(
        data: list,
        perPage: list.length,
        currentPage: 1,
        from: 1,
        page: 1,
        lastPage: 1,
        to: 1,
        total: list.length,
      );
}
