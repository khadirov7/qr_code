import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code/bloc/qrcode_event.dart';
import 'package:qr_code/data/model/qrcode_model.dart';
import 'package:qr_code/screens/tab_box_screen.dart';

import '../bloc/qrcode_bloc.dart';
import '../utils/app_colors.dart';
class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_333333,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_333333.withOpacity(0.84),
        title:  Text('Generate', style: TextStyle(
            color: AppColors.white, fontSize: 26.w
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          TextField(
            controller: controller,
            style: TextStyle(
                color: AppColors.white, fontSize: 16.w
            ),
            decoration: InputDecoration(
                hintText: "Add Link",
                hintStyle: TextStyle(
                    color: AppColors.white.withOpacity(0.5), fontSize: 16.w
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        width: 1, color: AppColors.white)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        width: 1, color: AppColors.white)
                )
            ),
          ),
          SizedBox(height: 20.h,),
          SizedBox(
            width: double.infinity,
            child: TextButton(onPressed: () {
           if(controller.text.isNotEmpty) {
             context.read<QrCodeBloc>().add(AddQrCodeEvent(
                 scannerModel: QrCodeModel(id:DateTime.now().microsecond,
                   name:"Data",
                   qrCode:controller.text,)));
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TabBox1()));
           }else{
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Center(child: Text("Malumo kiriting"))));
           }
            },
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.c_FDB623
                ),
                child: Text("Generate QrCode", style: TextStyle(
                    color: AppColors.white, fontSize: 16.w
                ),)),
          )
        ],),
      ),
    );
  }
}