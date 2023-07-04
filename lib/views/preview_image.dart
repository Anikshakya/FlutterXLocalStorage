import "package:flutter/material.dart";
import "package:image_test/widgets/image_widget.dart";
import "package:photo_manager/photo_manager.dart";

class ViewFullScreenImage extends StatelessWidget {
  final dynamic keys, entity;
  
  const ViewFullScreenImage({super.key, this.keys, this.entity});

  @override
  Widget build(BuildContext context) {
    //Transformation Controller of Interactive Viewer
    final transformationController = TransformationController();
    late TapDownDetails doubleTapDetails;

    void handleDoubleTapDown(TapDownDetails details) {
      doubleTapDetails = details;
    }

    void handleDoubleTap() {
      if (transformationController.value != Matrix4.identity()) {
        transformationController.value = Matrix4.identity();
      } else {
        final position = doubleTapDetails.localPosition;
        transformationController.value = Matrix4.identity()
          ..translate(-position.dx * 2, -position.dy * 2)
          ..scale(3.0);
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right : 8.0),
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: const Icon(Icons.clear, size: 20,)
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            transformationController: transformationController,
            child: GestureDetector(
              onDoubleTapDown: handleDoubleTapDown,
              onDoubleTap: handleDoubleTap,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ImageItemWidget(
                  key: keys,
                  entity: entity,
                  option: const ThumbnailOption(size: ThumbnailSize.square(500)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}