
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repair/feature/shop/features/cart/widget/image_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../components/custom_image.dart';
import '../../../../../core/helper/responsive_helper.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../splash/controller/splash_controller.dart';
import '../model/product_model.dart';

class ProductMediaWidget extends StatefulWidget {
  final Product product;

  const ProductMediaWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductMediaWidget> createState() => _ProductMediaWidgetState();
}

class _ProductMediaWidgetState extends State<ProductMediaWidget> {
  _launchURL(String url, {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url),mode: launchMode);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: mainWidget(),
    );
  }

  Widget mainWidget() {
    return Column(
      children: [
        Row(
          children: [
            videoWidget(),
            SizedBox(width: 15,),
            documentWidget(),
          ],
        ),
        SizedBox(height: 15,),
        imageWidget(),
      ],
    );
  }

  Widget imageWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Images",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 15,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: widget.product.media?.length,
          gridDelegate: (SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.1)),
          itemBuilder: (BuildContext context, int index) {
            Media media = widget.product.media?[index] ?? Media();
            return Container(
              width: Dimensions.WEB_MAX_WIDTH,
              height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context) {
                    return ImageViewPage(
                      isDialog: true,
                      images: widget.product.media ?? [],initialIndex: index,);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomImage(
                    image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/product/${media.otherImages}',
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget videoWidget() {
    if(widget.product.videoURL.isEmpty){
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Video",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: (){
            _launchURL(widget.product.videoURL);
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
            height: 100,
            width: 100,
            child: Icon(Icons.play_circle),
          ),
        )

      ],
    );
  }
  static String getSecureUrl(String url) {
    String scheme = Uri.base.scheme;

    String current = "", target = "";
    if(scheme == "http") {
      current = "https:";
      target = "http:";
    }
    else {
      current = "http:";
      target = "https:";
    }
    if(url.startsWith(current)) {
      url = url.replaceFirst(current, target);
    }
    return url;
  }
  Widget documentWidget() {
    if(widget.product.brochure.isEmpty){
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Document",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: (){
            String url = "${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/product/${widget.product.brochure}";
            _launchURL(getSecureUrl(url), launchMode: LaunchMode.externalApplication);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                height: 100,
                width: 100,
                child: Icon(Icons.file_copy),
              ),
              // Text("${widget.product.brochure}")
            ],
          ),
        )
      ],
    );
  }


}
