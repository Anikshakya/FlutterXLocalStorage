import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_test/services/image_services.dart';

class PickAndSaveImage extends StatefulWidget {
  const PickAndSaveImage({super.key});

  @override
  State<PickAndSaveImage> createState() => _PickAndSaveImageState();
}

class _PickAndSaveImageState extends State<PickAndSaveImage> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Pick and Save Image to Local'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 400,
                height: 400,
              ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 45,
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple
                ),
                onPressed: () async {
                  var pickedImage = await ImageServices().pickImage(
                    pickFromGalley: false,
                  );
                  _imageFile = pickedImage;
                  setState(() {});
                },
                child: const Text('Pick Image from Camera'),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 45,
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple
                ),
                onPressed: () async{
                  var selectedCroppedImage = await ImageServices().pickAndCropImage(
                    pickFromGalley: false,
                  );
                  _imageFile = selectedCroppedImage;
                  setState(() {});
                },
                child: const Text('Take a pic & Crop Image'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 45,
        width: 200,
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          shape:  BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          onPressed: () async{
            await ImageServices().saveToGallery(
              context: context,
              file: _imageFile
            );
          },
          child: const Text("Save Selected Image")
        ),
      ),
    );
  }
}
