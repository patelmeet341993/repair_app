import 'package:repair/core/core_export.dart';
import 'package:repair/data/provider/checker_api.dart';
import 'package:repair/feature/company/model/company_model.dart';
import 'package:repair/feature/company/repository/company_repo.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController implements GetxService {
  final CompanyRepo companyRepo;

  CompanyController({required this.companyRepo});

  List<Data>? _companyContent;

  bool _isLoading = false;
  int? _pageSize;
  bool? _isSearching = false;
  String? _type = 'all';
  String? _searchText = '';
  int? _offset = 1;

  List<Data>? get companyContent => _companyContent;
  int? get pageSize => _pageSize;
  int? get offset => _offset;
  bool get isLoading => _isLoading;
  bool? get isSearching => _isSearching;
  String? get type => _type;
  String? get searchText => _searchText;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<CompanyController>().pageSize!;
        if (Get.find<CompanyController>().offset! < pageSize) {
          Get.find<CompanyController>().showBottomLoader();
          getCompanyList(Get.find<CompanyController>().offset! + 1, false);
        }
      }
    });
  }

  Future<void> getCompanyList(int offset, bool reload) async {
    _offset = offset;
    if (_companyContent == null || reload) {
      Response response = await companyRepo.getCompanyList(offset,"");
      if (response.statusCode == 200) {
        _companyContent = [];
        response.body['content']['data'].forEach((company) {
          _companyContent!.add(Data.fromJson(company));
        });
        _pageSize = response.body['content']['last_page'];
      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching!;
    //_searchProductList = [];
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
