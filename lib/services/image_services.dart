import "dart:developer";
import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:image_cropper/image_cropper.dart";
import "package:image_gallery_saver/image_gallery_saver.dart";
import "package:image_picker/image_picker.dart";
import "package:permission_handler/permission_handler.dart";
import "package:photo_manager/photo_manager.dart";

class ImageServices{
  pickImage({required bool pickFromGalley}) async{
    try {
      final image = await ImagePicker().pickImage(source: pickFromGalley ? ImageSource.gallery : ImageSource.camera , maxWidth: 1024, maxHeight: 1024, requestFullMetadata: true, imageQuality: 85);
      if (image == null) {
        return null;
      } else{
        return File(image.path);
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to upload image: $e");
      return null;
    }
  }

  Future pickAndCropImage({required bool pickFromGalley}) async {
    //----Noice----
    //Before using image cropper package----------
    // Add this into your AndroidManifest.xml
    // <activity
    //     android:name="com.yalantis.ucrop.UCropActivity"
    //     android:screenOrientation="portrait"
    //     android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>

    try {
      final image = await ImagePicker().pickImage(source: pickFromGalley ? ImageSource.gallery : ImageSource.camera, maxWidth: 1024, maxHeight: 1024, requestFullMetadata: true, imageQuality: 85);
      if (image == null) return null;

      File selFile = File(image.path);
      int fileSizeInBytes = await selFile.length();
      log('File Size => $fileSizeInBytes');
      
      if(fileSizeInBytes <= 5242880){    // check if image is under 5 MB
        //Crop Image
        final croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // 1:1 aspect ratio
          uiSettings:[
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepPurple,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              showCropGrid: true,
            ),
            IOSUiSettings(
              title: 'Crop Image',
            ),
            // WebUiSettings(
            //   context: context,
            //   presentStyle: CropperPresentStyle.dialog,
            //   boundary: const CroppieBoundary(
            //     width: 520,
            //     height: 520,
            //   ),
            //   viewPort:
            //       const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            //   enableExif: true,
            //   enableZoom: true,
            //   showZoomer: true,
            // ),
          ],
          maxWidth: 1024,
          maxHeight: 1024,
          cropStyle: CropStyle.rectangle, // Change to circle for circular crop
          compressQuality: 100, // Image quality from 0 to 100
        );
        return File(croppedImage!.path);
      } else {
        // showMessage('Notice', 'Image size too large, cannot be used');
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to upload image: $e");
    }
  }

  //Request to access the local images and videos
  Future requestLocalAssets() async {
    //To Use this add read write permission in android manifest and dont forget to put this if u have android > 12 android:requestLegacyExternalStorage="true"
    await Permission.storage.request();
    final PermissionState storagePermisson = await PhotoManager.requestPermissionExtend();
    if (!storagePermisson.hasAccess) return;

    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(onlyAll: true,);
    if (paths.isEmpty) return;

    // totalEntitiesCount = await _path!.assetCountAsync;
    final List<AssetEntity> entities = await paths.first.getAssetListPaged(
      page: 0,
      size: 100,//How much image to load
    );

    return entities;//entities.file has path of the images, videos
  }

  //Save image
  Future<void> saveToGallery({context, required  file}) async {
    if (file != null) {
      await ImageGallerySaver.saveFile(file.path);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image Saved Successful'))
      );
    }
  }

  //Delete Entities
  Future <void> deleteFile({context, entity, }) async {
    try {
      await PhotoManager.editor.deleteWithIds([entity.id])//This will delete the entity
      .then((value) async{
        // await requestLocalAssets();//Reload The Data after delete
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deleted Succesfully'),
            duration: Duration(seconds: 1),
          )
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while deleting the file: $e'))
      );
      debugPrint('An error occurred while deleting the file: $e');
    }
  }

  //Delete multiple images
  multiDelete(File fileList) async{
    List<File> selectedFile = [fileList];
    await Future.forEach(selectedFile, (element) async {
      if (await element.exists()) {  
        await element.delete();
      }
    });
  }
}