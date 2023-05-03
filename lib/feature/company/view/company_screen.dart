import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/data/provider/company_provider.dart';
import 'package:repair/feature/company/model/company_model.dart' as CompanyModel;
import 'package:repair/feature/company/view/additional_issue_screen.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/company/view/company_details_screen.dart';

import '../controller/company_controller.dart';
import '../controller/company_details_controller.dart';
import '../controller/company_details_tab_controller.dart';

class CompanyScreen extends StatefulWidget {
  final String serviceID;
  final String subCategoryId;

  const CompanyScreen({Key? key, required this.serviceID, required this.subCategoryId}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  late List<CompanyModel.CompanyDetailsModel> itemList1 = [];

  bool isDescending = false;
  bool isAlphabetsSorting = false;
  bool isRatingDescending = false;
  late String item1;
  late String item2;
  bool checkedValue = false;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<CompanyTabController>().pageSize ?? 0;
        if (Get.find<CompanyTabController>().offset! < pageSize) {
          Get.find<CompanyTabController>().getServiceReview(widget.serviceID, Get.find<CompanyTabController>().offset! + 1);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
      appBar: AppBar(
          title: Text(
            "Select Companies",
            style: TextStyle(fontSize: Dimensions.fontSizeLarge),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.sort,
                size: Dimensions.CART_WIDGET_SIZE,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Center(child: Text('A TO Z')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = true;
                                isDescending = false;
                              });
                              print('Rating a To z');
                              print("isDescending");
                              print(isDescending);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Center(child: Text('Z TO A')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = true;
                                isDescending = true;
                              });
                              print('Rating z To a');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Center(child: Text('Rating High To Low')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = false;
                                isRatingDescending = true;
                              });
                              print('Rating High To Low');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Center(child: Text('Rating Low To High')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = false;
                                isRatingDescending = false;
                              });
                              print('Rating low To high');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            IconButton(
              icon: Image.asset(
                Images.search_White,
                height: Dimensions.CART_WIDGET_SIZE,
                width: Dimensions.CART_WIDGET_SIZE,
              ),
              onPressed: () async {
                //searchlabel(details);
              },
            )
          ]),
      // CustomAppBar(centerTitle: false, title: 'Select Companies'.tr,showCart: true,),
      body: GetBuilder<CompanyDetailsController>(initState: (state) {
        Get.find<CompanyDetailsController>().getServiceDetails(widget.serviceID);
        Get.find<CompanyDetailsController>().getCompanyList(Get.find<CompanyController>().offset ?? 1, false, widget.serviceID, widget.subCategoryId);
      }, builder: (serviceController) {
        if (serviceController.service != null) {
          if (serviceController.service!.id != null) {
            Service? service = serviceController.service;
            Discount _discount = PriceConverter.discountCalculation(service!);
            double _lowestPrice = 0.0;
            if (service.variationsAppFormat!.zoneWiseVariations != null) {
              _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
              for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                if (service.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
                  _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                }
              }
            }

            return Column(
              children: [
                Expanded(
                    child: FooterBaseView(
                  isScrollView: ResponsiveHelper.isMobile(context) ? false : true,
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: DefaultTabController(
                      length: Get.find<CompanyDetailsController>().service!.faqs!.length > 0 ? 3 : 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        (!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context)) ? Radius.circular(8) : Radius.circular(0.0)),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: Dimensions.WEB_MAX_WIDTH,
                                            height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
                                            child: CustomImage(
                                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.coverImage}',
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: Dimensions.WEB_MAX_WIDTH,
                                            height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
                                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                                          ),
                                        ),
                                        Container(
                                          width: Dimensions.WEB_MAX_WIDTH,
                                          height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
                                          child: Center(
                                              child: Text(service.name ?? '',
                                                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Center(
                                child: Column(
                              children: [
                                FilterchipWidget(
                                  onSelectTap: () {
                                    // CompanyProvider companyProvider = Provider.of(context,listen: false);
                                    // companyProvider.setSelectedCompany(serviceController.companyContent.)
                                  },
                                  chipName: serviceController.companyContent ?? [],
                                  serviceID: '',
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                Consumer<CompanyProvider>(builder: (context, CompanyProvider provider, _) {
                  bool isSelectedCompany = provider.getSelectedCompany.isNotEmpty;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                      bottom: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: CustomButton(
                      width: Get.width,
                      radius: Dimensions.RADIUS_DEFAULT,
                      buttonText: 'Proceed to Add Details',
                      onPressed: isSelectedCompany
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return AdditionalIssueScreen(service: service,);
                                  },
                                ),
                              );
                            }
                          : null,
                    ),
                  );
                }),
              ],
            );
          } else {
            return NoDataScreen(
              text: 'no_service_available'.tr,
              type: NoDataType.SERVICE,
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  // var details;
  // void searchlabel(String query){
  //   final suggestion = itemList1.where((item) {
  //     final companyTitle = itemList1.data.toLowerCase();
  //     final input = query.toLowerCase();
  //     return companyTitle.contains(input);
  //   }).toList();
  //   setState(() {
  //      details= suggestion;
  //   });
  //   print(details);
  // }

  Widget selectIcon(int index) {
    return Checkbox(
        value: checkedValue,
        activeColor: Colors.green,
        onChanged: (value) {
          setState(() {
            checkedValue = value!;
          });
        });
  }
}

class FilterchipWidget extends StatefulWidget {
  final String serviceID;
  final Function()? onSelectTap;
  final List<CompanyModel.CompanyData> chipName;
  bool isSelected = false;

  FilterchipWidget({Key? key, required this.chipName, required this.serviceID, this.onSelectTap, this.isSelected = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterchipWidgetState();
}

class _FilterchipWidgetState extends State<FilterchipWidget> {
  var _isSelected = false;
  late int indexes;
  CompanyProvider? companyProvider;

  String getImageBaseUrl() {
    String imageBaseUrl = "";
    imageBaseUrl = (Get.find<SplashController>().configModel.content ?? Content()).imageBaseUrl ?? "";
    if (imageBaseUrl.isNotEmpty) {
      imageBaseUrl += "/provider/logo/";
    }
    return imageBaseUrl;
  }

  @override
  Widget build(BuildContext context) {
    companyProvider = Provider.of(context, listen: false);
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.chipName.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_RADIUS).copyWith(bottom: Dimensions.PADDING_SIZE_RADIUS),
                    child: Card(
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_RADIUS),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          boxShadow: Get.isDarkMode ? null : cardShadow,
                        ),
                        //padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                                height: Dimensions.PAGES_BOTTOM_PADDING,
                                width: Dimensions.PAGES_BOTTOM_PADDING,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl: "${getImageBaseUrl()}${widget.chipName[index].logo ?? " "}",
                                    errorWidget: (BuildContext context, img, _) {
                                      return Image.asset(
                                        Images.placeholder,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                )

                                // Image.asset(
                                //   Images.companyLogo,
                                //   fit: BoxFit.cover,
                                // ),
                                ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${widget.chipName[index].companyName}",
                                            style: ubuntuRegular.copyWith(
                                                fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeDefault,
                                                fontWeight: FontWeight.bold),
                                            maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        //Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) {
                                                  return CompanyDetailsScreen(
                                                      company_image: "${getImageBaseUrl()}${widget.chipName[index].logo ?? " "}",
                                                      companyData: widget.chipName[index],
                                                      company_name: "${widget.chipName[index].companyName}",
                                                      company_rating: "${widget.chipName[index].avgRating}");

                                                },
                                              ),
                                            );
                                            // Get.toNamed(RouteHelper.getSelectedCompanyRoute(
                                            //     company_image: "${getImageBaseUrl()}${widget.chipName[index].logo ?? " "}",
                                            // ));
                                          },
                                          child: Text("View Profile", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),Html(
                                      data: widget.chipName[index].aboutCompany,
                                      style: {
                                        'body': Style(
                                            margin: Margins.all(0),
                                            padding: EdgeInsets.zero,
                                            fontSize: FontSize(
                                              MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                            ),
                                            maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 2,
                                            color: Theme.of(context).disabledColor
                                          // textOverflow: TextOverflow.ellipsis
                                          // overflow: TextOverflow.ellipsis,
                                          // lineHeight: LineHeight(.5),
                                        ),
                                      },
                                    ),
                                    // Text(
                                    //   "${widget.chipName[index].aboutCompany} ",
                                    //   style: ubuntuRegular.copyWith(
                                    //       fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                    //       fontWeight: FontWeight.w500),
                                    //   maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 2,
                                    //   overflow: TextOverflow.ellipsis,
                                    // ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "${widget.chipName[index].bookingsCompletedCount ?? 0} Successful Orders",
                                      style: ubuntuRegular.copyWith(
                                          fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeDefault,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                      maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                              ),
                                              Text(
                                                " ${widget.chipName[index].avgRating}",
                                                style: ubuntuRegular.copyWith(
                                                    fontSize:
                                                        MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeDefault,
                                                    color: Colors.amber,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "(${widget.chipName[index].ratingCount})",
                                                style: ubuntuRegular.copyWith(
                                                  fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        CommonSubmitButton(
                                          text: _isSelected ? "Selected" : "Select",
                                          fontSize: Dimensions.fontSizeSmall,
                                          horizontalPadding: 25,
                                          onTap: () {
                                            bool isSelected = companyProvider?.getSelectedCompany.contains(widget.chipName[index].id) ?? false;
                                            if (isSelected) {
                                              companyProvider?.removeCompanyId(widget.chipName[index].id ?? "");
                                            } else {
                                              companyProvider?.setSelectedCompany(widget.chipName[index].id ?? "");
                                            }
                                            print("selected Company : ${companyProvider?.getSelectedCompany}");
                                            setState(() {});
                                          },
                                          isSelected: companyProvider?.getSelectedCompany.contains(widget.chipName[index].id) ?? false,
                                          //     (){
                                          //   setState(() => _isSelected = !_isSelected);
                                          // },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                        /*child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    bottom: 80.0,
                                    right: 5.0,
                                    child: TextButton(
                                      child: Text("View Profile", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        // Get.toNamed(RouteHelper.getSelectedCompanyRoute(
                                        //     company_image: widget.chipName[index].companyIcon,
                                        // ));
                                      },
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                            child: Positioned(
                                                child: Container(
                                              height: Dimensions.PAGES_BOTTOM_PADDING,
                                              width: Dimensions.PAGES_BOTTOM_PADDING,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey),
                                              child: Image.asset(
                                                Images.companyLogo,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                          ),
                                          Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                                child: Text(
                                                  "${widget.chipName[index].companyName}",
                                                  style: ubuntuRegular.copyWith(
                                                      fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                                      fontWeight: FontWeight.bold),
                                                  maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                width: 240,
                                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                                child: Text(
                                                  "${widget.chipName[index].aboutCompany}",
                                                  style: ubuntuRegular.copyWith(
                                                      fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                                      fontWeight: FontWeight.w500),
                                                  maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                                child: Text(
                                                  "${widget.chipName[index].orderCount}",
                                                  style: ubuntuRegular.copyWith(
                                                      fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                                      color: Colors.green,
                                                      fontWeight: FontWeight.bold),
                                                  maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 2,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  Text(
                                                    "${widget.chipName[index].avgRating}",
                                                    style: ubuntuRegular.copyWith(
                                                        fontSize:
                                                            MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                                        color: Colors.amber,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "(${widget.chipName[index].ratingCount})",
                                                    style: ubuntuRegular.copyWith(
                                                      fontSize:
                                                          MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeSmall,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  CommonSubmitButton(
                                                      text:  _isSelected ?"Selected":"Select",
                                                      fontSize: Dimensions.fontSizeSmall,
                                                      onTap:  (){
                                                        setState(() => _isSelected = !_isSelected);
                                                      },
                                                  ),

                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Positioned(
                                      bottom: 1.0,
                                      right: 5.0,
                                      child: SizedBox(
                                        height: 25,
                                        width: 90,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() => _isSelected = !_isSelected);
                                          },
                                          child: _isSelected ? Text("Selected") : Text("Select"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: _isSelected ? Colors.green : Theme.of(context).colorScheme.primary, // This is what you need!
                                          ),
                                        ),
                                      ))
                                ],
                              )*/
                      ),
                    ),
                  );
                }))
      ]),
    ));
  }
}
