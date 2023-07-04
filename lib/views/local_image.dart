import "package:flutter/material.dart";
import "package:image_test/services/image_services.dart";
import "package:image_test/views/auth/login_page.dart";
import "package:image_test/views/preview_image.dart";
import "package:image_test/widgets/image_widget.dart";
import "package:photo_manager/photo_manager.dart";

class LocalImagePage extends StatefulWidget {
  const LocalImagePage({super.key});

  @override
  State<LocalImagePage> createState() => _LocalImagePageState();
}

class _LocalImagePageState extends State<LocalImagePage> {
  TextEditingController idCon = TextEditingController();
  List<AssetEntity>? _entities;
  int totalEntitiesCount = 0;
  dynamic entity;
  dynamic imagefile;
  List selectedDelete =[];
  List deletedlist =[];
  List categoriesList = [ 'カテゴリー','カテゴリー','カテゴリー','カテゴリー','カテゴリー','カテゴリー',
                      'カテゴリー','カテゴリー','カテゴリー','カテゴリー','カテゴリー','カテゴリー',];
  List selectedCategories = [];
  bool picsadd=false;

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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(size),
      body: Stack(
        children: <Widget>[
          buildBody(context,size),
          selectedImageList(context,size),
        ],
      ),
    );
  }

  appBar(size) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        color: const Color(0XFF9a8c8b),
        padding: EdgeInsets.fromLTRB(size.width * 0.05, 30, size.width * 0.05, 5),
        child: Row(
          children:  [
            const Icon(Icons.local_hospital, size: 40, color: Colors.orange,),
            const SizedBox(width: 5.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('病院', style: TextStyle(fontSize: 9),),
                Text('リハビリテーション', style: TextStyle(fontSize: 12),),
                Text('Kurame Rehabilitation Hospital',style: TextStyle(fontSize: 8),)
              ],
            ),
            const Spacer(),
            const Icon(Icons.camera_enhance, size: 28,),
            const SizedBox(width: 5.0,),
            const Text('テーショ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
            SizedBox(width: size.width*0.076,),
            const Text('リハビリID', style: TextStyle(fontSize: 16),),
            SizedBox(width: size.width*0.032,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 34),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('ST0012', style: TextStyle(color: Colors.blue, fontSize: 20),),
            ),
            SizedBox(width: size.width*0.032,),
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginPage()));
              }, 
              child:  const Text('LOGOUT', style: TextStyle(color: Colors.black, fontSize: 18),)
            )
          ],
        ),
      )
    );
  }

  buildBody(BuildContext context, size) {
    if (_entities == null) {
      return const Center(child: Text('Click on the show image button to display local images'));
    }
    if (_entities!.isEmpty) {
      return const Center(child: Text('No assets found on this device.'));
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.04),
      height: size.height*0.62,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context,index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const Text('テーショ', style: TextStyle(color: Colors.blue, fontSize: 14),),
              const SizedBox(height: 10,),
              Wrap(
                children: List.generate(_entities!.length, (index)  {
                  final AssetEntity entity = _entities![index];
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        if(!selectedDelete.contains(entity)){
                          selectedDelete.add(entity);
                        }else{
                          selectedDelete.remove(entity);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ImageItemWidget(
                              key: ValueKey<int>(index),
                              entity: entity,
                              option: const ThumbnailOption(size: ThumbnailSize.square(300)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom:16.0,top: 8),
                          padding: const EdgeInsets.fromLTRB(10,1,20,1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          ),
                          child: SizedBox(
                            width: 52,
                            child: Row(
                              children:[
                                SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: Transform.scale(
                                    scale: 0.75,
                                    child: Checkbox(
                                      value: selectedDelete.contains(entity)?true:false, 
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.8), // Border color
                                        width: 1, // Border width
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          if(!selectedDelete.contains(entity)){
                                            selectedDelete.add(entity);
                                          }else{
                                            selectedDelete.remove(entity);
                                          }
                                        });                
                                      }
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                const Text('ショ', style: TextStyle(color: Colors.blue, fontSize: 12),),
                              ] 
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })
              ),
              const SizedBox(height: 50,)
            ],
          );
        },
      )
    );
  }

  selectedImageList(context,size){
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 218,
        child: Column(
          children: [
            //headings
            Row(
              children: [
                const SizedBox(width: 50,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal:50),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Color(0xff1e967a),
                  ),
                  height: 25,
                  child: const Text('テーショ'),
                ),
                const SizedBox(width: 50,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal:50),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Color(0xffca9891),
                  ),
                  height: 25,
                  child: const Text('テーショ'),
                ),
              ],
            ),
            Container(
              height: 193,
              color: const Color(0xff1e967a),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //selected images
                  SizedBox(
                    height: 100,
                    child: selectedDelete.isEmpty ?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Step 1: リハビリテーション リハビリテー', style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w300),),
                          Text('Step 2: リハビリテーション リハビリテー リハビリテー', style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ):
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: 8,),
                      itemCount: selectedDelete.length,
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.only(top: 13.0),
                          child: GestureDetector(
                            onTap: (){
                              //preview
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                ViewFullScreenImage(
                                  keys: ValueKey<int>(index),
                                  entity: selectedDelete[index],
                                )
                              ));
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 75,
                                  width: 75,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: ImageItemWidget(
                                      key: ValueKey<int>(index),
                                      entity: selectedDelete[index],
                                      option: const ThumbnailOption(size: ThumbnailSize.square(500)),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  right: 3,
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                      selectedDelete.removeAt(index);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 20,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, 
                    ),
                  ),
                  //Id 
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        //ID
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            children: [
                              const Text('ーシID',style: TextStyle(fontSize: 18),),
                              const SizedBox(width: 20,),
                              Container(
                                height: 40,
                                width: size.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextFormField(
                                  controller: idCon,
                                  style: const TextStyle(color: Colors.blue, fontSize: 22),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: size.width * 0.03, bottom: 8.0, top: 4.0, right: size.width * 0.03),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(selectedDelete.length.toString(),style: const TextStyle(fontSize: 26),),
                              const Text('   病院ビ',style: TextStyle(fontSize: 18),),
                              const SizedBox(width: 20,),
                              //Delete
                              GestureDetector(
                                onTap: () async{
                                  setState(() {});
                                  for (var i = 0; i < selectedDelete.length; i++) {
                                    await ImageServices().deleteFile(
                                      context: context, 
                                      entity: selectedDelete[i], 
                                    ).then((value) async{
                                      var entiity = await ImageServices().requestLocalAssets();
                                      setState(() {
                                        _entities = entiity;
                                      });
                                    }
                                  );   
                                }
                                selectedDelete.clear();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 34),
                                  decoration: BoxDecoration(
                                    color: selectedDelete.isEmpty ? Colors.grey : Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('ビリテーシ', style: TextStyle(color: Colors.white, fontSize: 20),),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        //categories
                        SizedBox(
                          height: 32,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal:50),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) => const SizedBox(width: 8,),
                            itemCount: categoriesList.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  selectedCategories.contains(index) ? selectedCategories.remove(index) : selectedCategories.add(index);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 34),
                                  decoration: BoxDecoration(
                                    color: selectedCategories.contains(index) ? Colors.blue : Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(child: Text(categoriesList[index], style: TextStyle(color: selectedCategories.contains(index) ? Colors.white : Colors.blue, fontSize: 14,),textAlign: TextAlign.center,)),
                                ),
                              );
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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