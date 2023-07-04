import 'package:flutter/material.dart';
import 'package:image_test/views/local_image.dart';

import 'pick_and_save_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Display Image Page
              SizedBox(
                height: 45,
                width: 265,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LocalImagePage()));
                  }, 
                  child: const Text("Display & Delete Local Image Page")
                ),
              ),
              const SizedBox(height: 30,),
              //Pick Image Page
              SizedBox(
                height: 45,
                width: 265,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const PickAndSaveImage()));
                  }, 
                  child: const Text("Pick and Save Image to Local Page")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}