// ignore_for_file: use_build_context_synchronously, avoid_print, duplicate_ignore


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
  List<AssetEntity>? _entities;
  int totalEntitiesCount = 0;
 dynamic entity;
 dynamic imagefile;
 List selectedDelete =[];
 List deletedlist =[];
 

  @override
  void initState() {
    initalise();
    super.initState();
  }
  initalise()async{
  var entiity = await ImageServices().requestLocalAssets();
      setState(() {
        _entities = entiity;
        for (var i = 0; i < _entities!.length; i++) {
        entity =_entities![i];
        }
      });
        var emtityFile = await  entity.file;
        setState(() {
        imagefile = emtityFile.path;
        });
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
          buildBody(context),
          selectedImageList(context),
        ],
      ),
      // floatingActionButton: Container(
      //   height: 45,
      //   width: 200,
      //   margin: const EdgeInsets.only(bottom: 20),
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.deepPurple,
      //     shape:  BeveledRectangleBorder(
      //       borderRadius: BorderRadius.circular(8)
      //     ),
      //     onPressed: () async{
      //       var entiity = await ImageServices().requestLocalAssets();
      //       setState(() {
      //         _entities = entiity;
      //         for (var i = 0; i < _entities!.length; i++) {
      //         entity =_entities![i];
      //         }
      //       });
      //         var emtityFile = await  entity.file;
      //         setState(() {
      //         imagefile = emtityFile.path;
      //         });
      //     },
      //     child: const Text("Show Local Image")
      //   ),
      // ),
    );
  }

  selectedImageList(context){
    return Container(
      height: 220,
      color: Colors.grey,
      child: Column(
        children: [
          SizedBox(
         height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                  width: 10,
                );
              },
              itemCount: selectedDelete.length,
              itemBuilder: (context, index) {
                return  Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ImageItemWidget(
                            key: ValueKey<int>(index),
                            entity: selectedDelete[index],
                            option: const ThumbnailOption(size: ThumbnailSize.square(500)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                            selectedDelete.removeAt(index);
                            });
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }, 
            ),
          ),
          Row(
            children: [
              Column(
                children: [
                  const Text('Button ID 1'),
                  SizedBox(width: 200,
                    child: ElevatedButton(
                      // ignore: avoid_print
                      onPressed: () => print("it's pressed"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text("ST0012"),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                const Text('Button ID 2'),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => print("it's pressed"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text("YA0909110",style: TextStyle(
                        color: Colors.blue
                      ),),
                    ),
                  )
                  
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                const Text('Button ID 3'),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => print("it's pressed"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text("T010909110",style: TextStyle(
                        color: Colors.blue
                      ),),
                    ),
                  )
                  
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                const Text('Button ID 4'),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async{
                        setState(() {
                        });
                        for (var i = 0; i < selectedDelete.length; i++) {
                        await ImageServices().deleteFile(
                          context: context, 
                          entity: selectedDelete[i], 
                        ).then((value) async{
                          var entiity = await ImageServices().requestLocalAssets();
                          setState(() {
                          _entities = entiity;
                          // selectedDelete.removeAt(i);
                          });
                         

                        }
                        );   
                      }
                      selectedDelete.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text("YA0909110",style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )
        ],
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
    return SizedBox(
      height: 350,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 5.0,
        ),
        itemCount: _entities!.length,
        itemBuilder: (BuildContext context, int index) {
          final AssetEntity entity = _entities![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3.0,
                      color: Colors.grey
                    ),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20.0) //                 <--- border radius here
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      // moreModalBottomSheet(context, index, entity);
                      setState(() {
                        if(!selectedDelete.contains(entity)){
                          selectedDelete.add(entity);
                        }
                      });
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ImageItemWidget(
                          key: ValueKey<int>(index),
                          entity: entity,
                          option: const ThumbnailOption(size: ThumbnailSize.square(500)),
                        ),
                      ),
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: const BorderRadius.all(
                    //         Radius.circular(20.0) //                 <--- border radius here
                    //     ),
                    //     image: DecorationImage(
                    //       fit: BoxFit.fill,
                    //       image:FileImage( File(imagefile),) )
                    //   ),
                    // )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent)
                  ),
                  child: Text('Image $index'),
                )
              ],
            ),
          );
        },
      ),
    );
    
  }

  getfile(file)async{
     var emtityFile = await  file.file;          
    return emtityFile.path; 
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
                        await ImageServices().deleteFile(
                          context: context, 
                          entity: entity, 
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