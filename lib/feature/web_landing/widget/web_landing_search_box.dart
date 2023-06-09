import 'package:repair/components/custom_button.dart';
import 'package:repair/components/custom_image.dart';
import 'package:repair/components/custom_loader.dart';
import 'package:repair/components/custom_snackbar.dart';
import 'package:repair/core/helper/responsive_helper.dart';
import 'package:repair/core/helper/route_helper.dart';
import 'package:repair/core/theme/dark_theme.dart';
import 'package:repair/feature/address/model/address_model.dart';
import 'package:repair/feature/location/controller/location_controller.dart';
import 'package:repair/feature/location/model/prediction_model.dart';
import 'package:repair/feature/location/model/zone_response.dart';
import 'package:repair/feature/web_landing/controller/web_landing_controller.dart';
import 'package:repair/utils/dimensions.dart';
import 'package:repair/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class WebLandingSearchSection extends StatefulWidget {
  final String baseUrl;
  final textContent;
  final bool? fromSignUp;
  final String? route;

  WebLandingSearchSection(
      {Key? key,
      required this.baseUrl,
      required this.textContent,
      required this.fromSignUp,
      required this.route})
      : super(key: key);

  @override
  State<WebLandingSearchSection> createState() =>
      _WebLandingSearchSectionState();
}

class _WebLandingSearchSectionState extends State<WebLandingSearchSection> {
  TextEditingController _controller = TextEditingController();

  AddressModel? _address;
  bool _isActiveCurrentLocation = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebLandingController>(
      builder: (webLandingController) {
        return Stack(
          children: [
            Container(
              width: Dimensions.WEB_MAX_WIDTH,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                    .copyWith(left: 300),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //first image
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top:
                                    BorderSide(width: 2.0, color: Colors.white),
                                left:
                                    BorderSide(width: 2.0, color: Colors.white),
                                right:
                                    BorderSide(width: 2.0, color: Colors.white),
                              ),
                            ),
                            child: ClipRRect(
                                child: CustomImage(
                              // fit: BoxFit.cover,
                              height: 200,
                              width: 370,
                              image:
                                  "${widget.baseUrl}/landing-page/${webLandingController.webLandingContent!.bannerImage!.elementAt(0).liveValues}",
                            )),
                          ),
                          //second image
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.white),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.white),
                                ),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0)),
                                  child: CustomImage(
                                    fit: BoxFit.cover,
                                    width: 485,
                                    height: 200,
                                    image:
                                        "${widget.baseUrl}/landing-page/${webLandingController.webLandingContent!.bannerImage!.elementAt(3).liveValues}",
                                  )),
                            ),
                          ),
                          //third image
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(flex: 2, child: SizedBox()),
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(
                                      width: 2.0, color: Colors.white),
                                  right: BorderSide(
                                      width: 2.0, color: Colors.white),
                                  bottom: BorderSide(
                                      width: 2.0, color: Colors.white),
                                  left: BorderSide(
                                      width: 2.0, color: Colors.white),
                                ),
                              ),
                              child: ClipRRect(
                                  child: CustomImage(
                                // fit: BoxFit.cover,
                                height: 200,
                                width: 200,
                                image:
                                    "${widget.baseUrl}/landing-page/${webLandingController.webLandingContent!.bannerImage!.elementAt(1).liveValues}",
                              )),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12.0)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    top: BorderSide(
                                        width: 2.0, color: Colors.white),
                                    right: BorderSide(
                                        width: 2.0, color: Colors.white),
                                    bottom: BorderSide(
                                        width: 2.0, color: Colors.white),
                                  ),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12.0)),
                                    child: CustomImage(
                                      fit: BoxFit.cover,
                                      height: 200,
                                      image:
                                          "${widget.baseUrl}/landing-page/${webLandingController.webLandingContent!.bannerImage!.elementAt(2).liveValues}",
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 30.0,
              child: Container(
                height: 260,
                width: 750,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  color: Color(0xffF5F5F5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.textContent['web_top_title'] != null &&
                        widget.textContent['web_top_title'] != '')
                      Text(
                        widget.textContent['web_top_title'],
                        style: ubuntuBold.copyWith(
                            fontSize: Dimensions.fontSizeOverLarge,
                            color: Colors.black),
                      ),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (widget.textContent['web_top_description'] != null &&
                        widget.textContent['web_top_description'] != '')
                      Text(
                        widget.textContent['web_top_description'],
                        style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    Container(
                      height: 85,
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: TypeAheadField(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            controller: _controller,
                                            textInputAction:
                                                TextInputAction.search,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            keyboardType:
                                                TextInputType.streetAddress,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'search_location_here'.tr,
                                              border: OutlineInputBorder(
                                                // borderRadius: BorderRadius.circular(10),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)),
                                                borderSide: BorderSide(
                                                    //strokeAlign: StrokeAlign.inside,
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.3),
                                                    width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)),
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(0.3),
                                                    width: 1),
                                              ),
                                              /*hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
                                              fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor,
                                            ),*/
                                              hintStyle: ubuntuMedium.copyWith(
                                                color: Theme.of(context)
                                                    .disabledColor,
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                              ),
                                              filled: true,
                                              fillColor: Get.isDarkMode
                                                  ? Colors.grey.withOpacity(0.2)
                                                  : Theme.of(context).cardColor,
                                              suffixIcon: IconButton(
                                                padding: EdgeInsets.only(
                                                    right: Dimensions
                                                        .PADDING_SIZE_LARGE),
                                                onPressed: () async {
                                                  Get.dialog(CustomLoader(),
                                                      barrierDismissible:
                                                          false);
                                                  _address = await Get.find<
                                                          LocationController>()
                                                      .getCurrentLocation(true);
                                                  _controller.text =
                                                      _address!.address!;
                                                  _isActiveCurrentLocation =
                                                      true;
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.my_location,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                            style: ubuntuRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: dark.primaryColor
                                                    .withOpacity(0.8)),
                                          ),
                                          suggestionsCallback: (pattern) async {
                                            if (_isActiveCurrentLocation) {
                                              _isActiveCurrentLocation = false;
                                              return [PredictionModel()];
                                            } else {
                                              return await Get.find<
                                                      LocationController>()
                                                  .searchLocation(
                                                      context, pattern);
                                            }
                                          },
                                          noItemsFoundBuilder: (context) {
                                            return SizedBox();
                                          },
                                          itemBuilder: (context,
                                              PredictionModel suggestion) {
                                            if (suggestion.description !=
                                                null) {
                                              return Padding(
                                                padding: EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.location_on),
                                                    SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_SMALL,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        suggestion.description!,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline2!
                                                            .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color,
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          },
                                          onSuggestionSelected: (PredictionModel
                                              suggestion) async {
                                            _controller.text =
                                                suggestion.description!;
                                            _address = await Get.find<
                                                    LocationController>()
                                                .setLocation(
                                                    suggestion.placeId!,
                                                    suggestion.description!,
                                                    null);
                                          },
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (_address != null &&
                                            _controller.text
                                                .trim()
                                                .isNotEmpty) {
                                          Get.dialog(CustomLoader(),
                                              barrierDismissible: false);
                                          ZoneResponseModel _response =
                                              await Get.find<
                                                      LocationController>()
                                                  .getZone(
                                            _address!.latitude!,
                                            _address!.longitude!,
                                            false,
                                          );
                                          if (_response.isSuccess) {
                                            Get.find<LocationController>()
                                                .saveAddressAndNavigate(
                                              _address!,
                                              widget.fromSignUp!,
                                              widget.route,
                                              ResponsiveHelper.isDesktop(
                                                  context),
                                            );
                                          } else {
                                            Get.back();
                                            customSnackBar(
                                                'service_not_available_in_current_location'
                                                    .tr);
                                          }
                                        } else {
                                          customSnackBar('pick_an_address'.tr);
                                        }
                                      },
                                      child: Container(
                                        width: 110,
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(10.0),
                                              topRight: Radius.circular(10.0)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'set_location'.tr,
                                          style: ubuntuMedium.copyWith(
                                            color: Colors.white,
                                            fontSize: Dimensions.fontSizeSmall,
                                          ),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL),
                                    Text(
                                      'or'.tr,
                                      style: ubuntuRegular.copyWith(
                                          color:
                                              Theme.of(context).disabledColor),
                                    ),
                                    SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL),
                                    CustomButton(
                                      width: 140,
                                      height: 55,
                                      fontSize: Dimensions.fontSizeSmall,
                                      buttonText: 'pick_from_map'.tr,
                                      onPressed: () => Get.toNamed(
                                        RouteHelper.getPickMapRoute(
                                            widget.route == null
                                                ? widget.fromSignUp!
                                                    ? RouteHelper.signUp
                                                    : RouteHelper.accessLocation
                                                : widget.route!,
                                            widget.route != null,
                                            'false'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
