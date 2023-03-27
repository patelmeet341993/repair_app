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
  List<File>? pfiles;

  final ImagePicker imgpicker = ImagePicker();
  final ImagePicker videoPicker = ImagePicker();
  List<XFile>? imageList = [];
  List<XFile>? dummyImageList = [];
  File? videoList;
  PlatformFile? selectedfiles;
  XFile? pdf;
  int _indexs = 0;
  bool isVideoLoading = false, isPdfLoading = false;

  XFile? selectedVideo;
  bool isVideo = false;
  ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  File? videoFile;
  var thumbnailFile;
  String _fileText = "";
  late CartController cartController;

  Future<void> getVideo(ImageSource imageSource) async {
    try {
      XFile? _video = await _picker.pickVideo(source: ImageSource.gallery);
      videoFile = File(_video!.path);
      if (videoFile != null) {
        thumbnailFile = await VideoCompress.getFileThumbnail(videoFile?.path ?? "", quality: 50);
        setState(() {});
        _videoPlayerController = VideoPlayerController.file(videoFile!);
        print("Video file path : ${File(_video.path)}");
        print("Thumbnail : $thumbnailFile");
      }
    } catch (e, s) {
      print("Error in the getVideo method in additionissuescren $e");
      print(s);
    }
  }

  void selectPdf() async {
    result = await FilePicker.platform.pickFiles();
    selectedfiles = result!.files.first;

    if (result != null) {
      pfiles = result!.paths.map((path) => File(path!)).toList();
      setState(() {
        if (selectedfiles != null) {
          _fileText = selectedfiles!.name.toString();
        } else {
          _fileText = pfiles.toString();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pfiles = [];
    cartController = Get.find<CartController>();
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
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

                    //height: MediaQuery.of(context).size.height / 1.3,
                    // padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addPhotosWidget(),
                        SizedBox(
                          height: 5,
                        ),
                        videoWidget(),
                        SizedBox(
                          height: 5,
                        ),
                        getPdfWidget(),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2).copyWith(bottom: 10),
                                    child: Text(
                                      "Add Additional Details",
                                      style: ubuntuRegular.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeDefault),
                                      maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: Color(0xFEEDEDED))),
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
                            builder: (context) => ServiceCenterDialog(service: widget.service));
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

  Widget addPhotosWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
                child: Text(
                  "Add Photos (optional)",
                  style: ubuntuRegular.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeDefault),
                  maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Get.find<CartController>().isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      height: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: MaterialButton(
                          minWidth: 20,
                          onPressed: imageList?.isEmpty ?? true
                              ? null
                              : () async {
                                  cartController.setIsLoading(true);
                                  setState(() {});
                                  bool isSuccess = await Get.find<CartController>().uploadFiles();
                                  if (isSuccess) {
                                    imageList?.clear();
                                    setState(() {});
                                  }
                                  cartController.setIsLoading(false);
                                  setState(() {});
                                },
                          child: Text(
                            "Upload",
                            style: ubuntuMedium.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                          disabledColor: Colors.grey,
                        ),
                      ),
                    ),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 105,
                width: 105,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: IconButton(
                    onPressed: () async {
                      await cartController.pickMultipleImage(false);
                      imageList = cartController.pickedImageFile;
                      setState(() {});
                    },
                    icon: Image.asset(
                      Images.addImage,
                      width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                    ),
                  ),
                ),
              ),
              if (imageList!.length > 0)
                Flexible(
                  child: Container(height: 110, child: getImageList(imageList)),
                )
            ],
          ),
        ]),
      ),
    );
  }

  Widget videoWidget() {
    return Card(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
                      child: Text(
                        "Add Videos (optional)",
                        style: ubuntuRegular.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeDefault),
                        maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    isVideoLoading
                        ? CircularProgressIndicator()
                        : Container(
                            height: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: MaterialButton(
                                minWidth: 20,
                                onPressed: videoFile == null
                                    ? null
                                    : () async {
                                        isVideoLoading = true;
                                        setState(() {});
                                        bool isSuccess = await cartController
                                            .uploadVideoOrDocument(files: [XFile(videoFile?.path ?? "")], keyName: "service_video", isVideo: true);
                                        if(isSuccess){
                                          videoFile = null;
                                        }
                                        isVideoLoading = false;
                                        setState(() {});
                                      },
                                child: Text(
                                  "Upload",
                                  style: ubuntuMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.primary,
                                disabledColor: Colors.grey,
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: IconButton(
                          onPressed: () {
                            getVideo(ImageSource.gallery);
                          },
                          icon: Image.asset(
                            Images.addVideo,
                            width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                          ),
                        ),
                      ),
                    ),
                    if (videoFile != null) showvideo(thumbnailFile)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getPdfWidget() {
    return Card(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5).copyWith(bottom: 5),
                      child: Text(
                        "Add PDF (optional)",
                        style: ubuntuRegular.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width < 300 ? Dimensions.fontSizeExtraSmall : Dimensions.fontSizeDefault),
                        maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    isPdfLoading
                        ? CircularProgressIndicator()
                        : Container(
                            height: 25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: MaterialButton(
                                minWidth: 20,
                                onPressed: selectedfiles == null
                                    ? null
                                    : () async {
                                        isPdfLoading = true;
                                        setState(() {});
                                        bool isSuccess = await cartController
                                            .uploadVideoOrDocument(files: [XFile(selectedfiles?.path ?? "")], keyName: "service_pdf", isVideo: false);
                                        if(isSuccess){
                                          selectedfiles = null;
                                        }
                                        isPdfLoading = false;
                                        setState(() {});
                                        // cartController.uploadFiles();
                                      },
                                child: Text(
                                  "Upload",
                                  style: ubuntuMedium.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.primary,
                                disabledColor: Colors.grey,
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 110,
                      width: 110,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        child: IconButton(
                          onPressed: () {
                            selectPdf();
                          },
                          icon: Image.asset(
                            Images.addImage,
                            width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                          ),
                        ),
                      ),
                    ),
                    (selectedfiles == null)
                        ? Container()
                        : Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    OpenFile.open(selectedfiles!.path);
                                  },
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.picture_as_pdf),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              _fileText.toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -5,
                                  right: -1,
                                  child: InkWell(
                                    onTap: () {
                                      selectedfiles = null;
                                      setState(() {});
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                        child: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                          size: 15,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(imagepath: imageList!.elementAt(index).path)));
              print("Image path : ${imageList!.elementAt(index).path}");
            },
            onTap: () {
              print("image delete");
              // WidgetsBinding.instance.addPostFrameCallback((_) {

              // });
            },
            child: Container(
              child: Image.file(
                File(list[index].path),
                fit: BoxFit.cover,
              ),
              // height: MediaQuery.of(context).size.height / 11,
              // width: MediaQuery.of(context).size.width * 1.5,
              height: 100,
              width: 110,
            ),
          ),
        );
      },
    );
  }

  Widget showvideo(File paths) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          width: 110,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: GestureDetector(
                child: Image.file(File(thumbnailFile.path)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideoScreen(videoPath: videoFile!.path)));
                  print("Image path : ${videoFile?.path}");
                }),
          ),
        ),
        Positioned(
          top: -5,
          right: -1,
          child: InkWell(
            onTap: () {
              videoFile = null;
              setState(() {});
            },
            child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 15,
                )),
          ),
        )
      ],
    );
  }

  Widget getImageList(List<XFile>? list) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        scrollDirection: Axis.horizontal,
        itemCount: list!.length,
        itemBuilder: (context, index) {
          return Stack(
            clipBehavior: Clip.none,
            fit: StackFit.passthrough,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(imagepath: imageList!.elementAt(index).path)));
                  print("Image path : ${imageList!.elementAt(index).path}");
                },
                // onDoubleTap: () {
                //   print("image delete");
                //   // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   setState(() {
                //     imageList!.removeAt(index);
                //   });
                //   // });
                // },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    // padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(list[index].path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // height: MediaQuery.of(context).size.height / 11,
                    // width: MediaQuery.of(context).size.width * 1.5,
                    width: 105,
                    height: 105,
                  ),
                ),
              ),
              Positioned(
                top: -5,
                right: -1,
                child: InkWell(
                  onTap: () {
                    cartController.pickMultipleImage(true, index: index);
                    setState(() {});
                  },
                  child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 15,
                      )),
                ),
              )
            ],
          );
        });
  }
}
