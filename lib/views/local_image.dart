// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import "package:image_test/services/image_services.dart";
import "package:image_test/widgets/image_widget.dart";
import "package:photo_manager/photo_manager.dart";

class LocalImagePage extends StatefulWidget {
  const LocalImagePage({super.key});

  @override
  State<LocalImagePage> createState() => _LocalImagePageState();
}

class _LocalImagePageState extends State<LocalImagePage> {
  final int _sizePerPage = 150;
  AssetPathEntity? _path;
  List<AssetEntity>? _entities;
  int totalEntitiesCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Local Images")
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildBody(context)),
        ],
      ),
      floatingActionButton: Container(
        height: 45,
        width: 200,
        margin: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          shape:  BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          onPressed: () async{
            var entiity = await ImageServices().requestLocalAssets();
            setState(() {
              _entities = entiity;
            });
          },
          child: const Text("Show Local Image")
        ),
      ),
    );
  }

  buildBody(BuildContext context) {
    if (_entities == null) {
      return const Center(child: Text('Click on the show image button to display local images'));
    }
    if (_entities!.isEmpty) {
      return const Center(child: Text('No assets found on this device.'));
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: _entities!.length,
      itemBuilder: (BuildContext context, int index) {
        final AssetEntity entity = _entities![index];
        return GestureDetector(
          onTap: () async {
            moreModalBottomSheet(context, index, entity);
          },
          child: ImageItemWidget(
            key: ValueKey<int>(index),
            entity: entity,
            option: const ThumbnailOption(size: ThumbnailSize.square(500)),
          )
        );
      },
    );
  }

  void moreModalBottomSheet(context, index, entity) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateBtm) {
            return Container(
              height: size.height * 0.55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(
                      height: 300,
                      child: ImageItemWidget(
                        key: ValueKey<int>(index),
                        entity: entity,
                        option: const ThumbnailOption(size: ThumbnailSize.square(500)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple
                      ),
                      onPressed: ()async{
                        final file = await entity.file;
                        await ImageServices().deleteFile(
                          context: context, 
                          entity: entity, 
                          file: file
                        ).then((value) async{
                          var entiity = await ImageServices().requestLocalAssets();
                          setState(() {
                            _entities = entiity;
                          });
                        });
                        // Directory destinationDir = Directory(file.parent.path);
                        // if (!destinationDir.existsSync()) {
                        //   destinationDir.createSync(recursive: true);
                        // }
                        // bool fileExists = await file.exists();
                        // if (fileExists) {
                        //   // File exists, proceed with deletion
                        //   bool deleted = await FileUtils.deleteFile(file.path);
                        //   if (deleted) {
                        //     // File deleted successfully
                        //     debugdebugPrint("Deleted");
                        //     Navigator.pop(context);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(content: Text('Deleted Succesfully'))
                        //     );
                        //   } else {
                        //     // Failed to delete the file
                        //     Navigator.pop(context);
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(content: Text('An error occurred while deleting the file'))
                        //     );
                        //     debugdebugPrint("Failed To delete");
                        //   }
                        // } else {
                        //   // File does not exist at the specified path
                        // }
                      }, 
                      child: const Text("Delete Image")
                    ),
                  ),
                ],
              )
            );
          }
        );
      }
    );
  }
}