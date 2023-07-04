
import 'package:flutter/material.dart';
import 'package:image_test/views/local_image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController conStaffId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title(),
            SizedBox(height: size.height * 0.05,),
            form(size, context)
          ],
        ),
      ),
    );
  }
  
  title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.local_hospital, size: 60, color: Colors.orange,),
        const SizedBox(width: 10.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('病院', style: TextStyle(fontSize: 12),),
            Text('リハビリテーション', style: TextStyle(fontSize: 18),),
            Text('Kurame Rehabilitation Hospital',style: TextStyle(fontSize: 10),)
          ],
        )
      ],
    );
  }
  
  form(size, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width *0.1, vertical: size.height * 0.08),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text('リハビリID', style: TextStyle(fontSize: 16),),
          const SizedBox(height: 12.0,),
          SizedBox(
            height: 40,
            width: size.width * 0.25,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFcb5e33)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
              },
              child: Center(
                child: TextFormField(
                  controller: conStaffId,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: size.width * 0.05, bottom: 8.0, top: 4.0, right: size.width * 0.05),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.07,),
          SizedBox(
            height: 40,
            width: size.width * 0.15,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LocalImagePage()));
              },
              child: const Text('テーション'),
            ),
          )
        ],
      ),
    );
  }
}