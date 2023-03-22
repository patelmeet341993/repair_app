import 'package:repair/feature/company/view/VideoScreen.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/company/view/detail_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../../../components/service_center_dialog.dart';

class AdditionalIssueScreen extends StatefulWidget {
  final Service? service;
  const AdditionalIssueScreen({Key? key, this.service}) : super(key: key);

  @override
  State<AdditionalIssueScreen> createState() => _AdditionalIssueScreenState();
}

class _AdditionalIssueScreenState extends State<AdditionalIssueScreen> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  FilePickerResult? result;
  PlatformFile? selectedfiles;
  List<File>? pfiles;

  final ImagePicker imgpicker = ImagePicker();
  final ImagePicker videoPicker = ImagePicker();
  List<XFile>? imageList = [];
  List<XFile>? dummyImageList = [];
  File? videoList;
  XFile? pdf;

  @override
  void initState() {
    super.initState();
    pfiles = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
        appBar: CustomAppBar(centerTitle: false, title: 'Service Details'.tr),
        body: SafeArea(
          top: true,
          bottom: true,
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),

                    //height: MediaQuery.of(context).size.height / 1.3,
                   // padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
                                    child: Text(
                                      "Add Photos (optional)",
                                      style: ubuntuRegular.copyWith(
                                        fontWeight: FontWeight.w700,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  300
                                              ? Dimensions
                                                  .fontSizeExtraSmall
                                              : Dimensions
                                                  .fontSizeDefault),
                                      maxLines: MediaQuery.of(context)
                                                  .size
                                                  .width <
                                              300
                                          ? 1
                                          : 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)),
                                          child: IconButton(
                                            onPressed: () {
                                              selectImages(
                                                  imgpicker, imageList);
                                            },
                                            icon: Image.asset(
                                              Images.addImage,
                                              width: Dimensions
                                                  .PADDING_FOR_CHATTING_BUTTON,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (imageList!.length > 0) Flexible(
                                        child: Container(
                                            height: 100,
                                            child: getImageList(imageList)),
                                      )
                                      // if (imageList!.length > 0) ...[
                                      //   Container(
                                      //     height: 110,
                                      //     width: 110,
                                      //     child: Card(
                                      //       shape: RoundedRectangleBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(
                                      //                   10.0)),
                                      //       child: baseimage(imageList),
                                      //     ),
                                      //   ),
                                      // ]

                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
                                        child: Text(
                                          "Add Videos (optional)",
                                          style: ubuntuRegular.copyWith(
                                            fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width <
                                                      300
                                                  ? Dimensions
                                                      .fontSizeExtraSmall
                                                  : Dimensions
                                                      .fontSizeDefault),
                                          maxLines: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  300
                                              ? 1
                                              : 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 110,
                                            width: 110,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: IconButton(
                                                onPressed: () {
                                                  getVideo(
                                                      ImageSource.gallery);
                                                },
                                                icon: Image.asset(
                                                  Images.addVideo,
                                                  width: Dimensions
                                                      .PADDING_FOR_CHATTING_BUTTON,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (videofile != null)
                                            showvideo(thumbnailFile)

                                        ],
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
                                    child: Text(
                                      "Add PDF (optional)",
                                      style: ubuntuRegular.copyWith(
                                        fontWeight: FontWeight.w700,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  300
                                              ? Dimensions
                                                  .fontSizeExtraSmall
                                              : Dimensions
                                                  .fontSizeDefault),
                                      maxLines: MediaQuery.of(context)
                                                  .size
                                                  .width <
                                              300
                                          ? 1
                                          : 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 110,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)),
                                          child: IconButton(
                                            onPressed: () {
                                              selectPdf();
                                            },
                                            icon: Image.asset(
                                              Images.addImage,
                                              width: Dimensions
                                                  .PADDING_FOR_CHATTING_BUTTON,
                                            ),
                                          ),
                                        ),
                                      ),
                                      (selectedfiles == null)
                                          ? Container()
                                          : Center(
                                              child: GestureDetector(
                                                child: Container(
                                                  height: 110,
                                                  width: 110,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(
                                                              10.0),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          OpenFile.open(selectedfiles!.path);
                                                        },
                                                        child: Text(_fileText.toString()),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                    ],
                                  )
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2).copyWith(bottom: 10),
                                    child: Text(
                                      "Add Additional Details",
                                      style: ubuntuRegular.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width <
                                                  300
                                              ? Dimensions
                                                  .fontSizeExtraSmall
                                              : Dimensions
                                                  .fontSizeDefault),
                                      maxLines: MediaQuery.of(context)
                                                  .size
                                                  .width <
                                              300
                                          ? 1
                                          : 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    8.0),
                                            borderSide: BorderSide(
                                                color:
                                                    Color(0xFEEDEDED))),
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                      bottom: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: CustomButton(
                      width: MediaQuery.of(context).size.width,
                      radius: Dimensions.RADIUS_DEFAULT,
                      buttonText: 'proceed_to_checkout'.tr,
                      onPressed: () {
                        showModalBottomSheet(
                        useRootNavigator: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) =>
                            ServiceCenterDialog(service: widget.service));
                        // Get.toNamed(RouteHelper.getCartRoute());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void selectImages(ImagePicker? imgpicker, List<XFile>? list) async {
    final List<XFile>? selectedImages = await imgpicker!.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        list!.addAll(selectedImages);
      });
    }
    print("Image list Length:" + list!.length.toString());
  }

  XFile? selectedVideo;
  bool isVideo = false;
  ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  var videofile;
  var thumbnailFile;

  Future<void> getVideo(ImageSource imageSource) async {
    XFile? _vido = await _picker.pickVideo(source: ImageSource.gallery);
    videofile = File(_vido!.path);
    if (videofile != null) {
      thumbnailFile =
          await VideoCompress.getFileThumbnail(videofile.path, quality: 50);
      setState(() {});
      _videoPlayerController = VideoPlayerController.file(videofile);
      print("Video file path : ${File(_vido.path)}");
      print("Thumbnail : $thumbnailFile");
    }
  }

  String _fileText = "";
  void selectPdf() async {
    result = await FilePicker.platform.pickFiles();
    selectedfiles = result!.files.first;

    if (result != null) {
      pfiles = result!.paths.map((path) => File(path!)).toList();
      setState(() {
        if(selectedfiles != null){
          _fileText = selectedfiles!.name.toString();
        }else{
          _fileText = pfiles.toString();
        }
      });
    }
  }

  int _indexs = 0;

  // show images
  Widget baseimage(List<XFile>? list) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          height: 110,
          // autoPlay: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          autoPlayInterval: Duration(seconds: 2),
          onPageChanged: (index, reason) {
            setState(() {
              _indexs = index;
            });
          }),
      itemCount: list!.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Transform.scale(
          scale: index == _indexs ? 1 : 0.9,
          child: GestureDetector(
            onDoubleTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                          imagepath: imageList!.elementAt(index).path)));
              print("Image path : ${imageList!.elementAt(index).path}");
            },
            onTap: () {
              print("image delete");
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                imageList!.removeAt(index);
              });
              // });
            },
            child: Container(
              child: Image.file(
                File(list[index].path),
                fit: BoxFit.cover,
              ),
              // height: MediaQuery.of(context).size.height / 11,
              // width: MediaQuery.of(context).size.width * 1.5,
              height:100,
              width: 110,
            ),
          ),
        );
      },
    );
  }

  Widget showvideo(File paths) {
    return Container(
      height: 110,
      width: 110,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: GestureDetector(
            child: Image.file(File(thumbnailFile.path)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VideoScreen(videoPath: videofile!.path)));
              print("Image path : ${videofile.path}");
            }),
      ),
    );
  }



  Widget getImageList(List<XFile>? list){
    return ListView.builder(
      shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list!.length,
        itemBuilder: (context,index){
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                        imagepath: imageList!.elementAt(index).path)));
            print("Image path : ${imageList!.elementAt(index).path}");
          },
          onDoubleTap: () {
            print("image delete");
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              imageList!.removeAt(index);
            });
            // });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(

              margin: EdgeInsets.symmetric(horizontal: 5),
              //padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Image.file(
                File(list[index].path),
                fit: BoxFit.contain,

              ),
              // height: MediaQuery.of(context).size.height / 11,
              // width: MediaQuery.of(context).size.width * 1.5,
             width: 110,
            ),
          ),
        );
        }
    );

  }


}
