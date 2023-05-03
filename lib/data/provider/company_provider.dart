import 'package:flutter/cupertino.dart';

class CompanyProvider extends ChangeNotifier {

  //region
  List<String> _getSelectedCompany = const [];

  List<String> get getSelectedCompany => _getSelectedCompany;

  void setSelectedCompany (String companyId, {bool isNotify = true}){

    if(_getSelectedCompany.isEmpty){
      _getSelectedCompany = [companyId];
    } else {
      if(!_getSelectedCompany.contains(companyId)) {
        _getSelectedCompany.add(companyId);
      }
    }
    if (isNotify){
      notifyListeners();
    }
  }

  void removeCompanyId(String companyId, {bool isNotify = true}){
    if(_getSelectedCompany.contains(companyId)){
      _getSelectedCompany.remove(companyId);
    }
    if(isNotify){
      notifyListeners();
    }
  }

  void clearSelectedCompany({bool isNotify = true}){
    if(_getSelectedCompany.isNotEmpty){
      _getSelectedCompany.clear();
    }
    if(isNotify){
      notifyListeners();
    }
  }
  //endregion


}