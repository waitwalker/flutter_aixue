import 'package:flutter/material.dart';
import 'package:flutter_aixue/models/teacher_task_detail_model.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';

/// 大图浏览
class PhotoView extends StatefulWidget {

  PhotoView(
      {this.loadingChild,
        this.backgroundDecoration,
        this.minScale,
        this.maxScale,
        this.initialIndex,
        @required this.resourceList})
      : pageController = PageController(initialPage: initialIndex);

  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<ResourceList> resourceList;

  @override
  State<StatefulWidget> createState() {
    return _PhotoViewState();
  }
}

class _PhotoViewState extends State<PhotoView> {

  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.resourceList.length,
                loadingChild: widget.loadingChild,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Image ${currentIndex + 1}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 17.0, decoration: null),
                ),
              )
            ],
          )),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final ResourceList item = widget.resourceList[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(imageURL(item.resourceUrl)),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.resourceUrl),
      onTapUp: (BuildContext context,TapUpDetails details, PhotoViewControllerValue controllerValue){
        print("点击 tap up${controllerValue.scale}");
        Navigator.pop(context);
      },
    );
  }

  String imageURL(String originalString) {
    if (originalString == null || originalString.length == 0) return "";
    if (originalString.contains(".jpg")) {
      return originalString.replaceAll(".jpg", "_1.jpg");
    } else if (originalString.contains(".JPG")) {
      return originalString.replaceAll(".JPG", "_1.JPG");
    } else if (originalString.contains(".jpeg")) {
      return originalString.replaceAll(".jpeg", "_1.jpeg");
    } else if (originalString.contains(".JPEG")) {
      return originalString.replaceAll(".JPEG", "_1.JPEG");
    } else if (originalString.contains(".png")) {
      return originalString.replaceAll(".png", "_1.png");
    } else if (originalString.contains(".PNG")) {
      return originalString.replaceAll(".PNG", "_1.PNG");
    } else {
      return originalString;
    }
  }
}