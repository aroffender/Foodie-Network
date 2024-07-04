import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/widgets/custom_text_field.dart';



class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();


  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();


  Future<void> _getImage() async{
    imageXFile== await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
       child: Column(
         mainAxisSize: MainAxisSize.max,
         children: [
           const SizedBox( height: 10,),
           InkWell(
             onTap: (){
               _getImage();
             },
             child: CircleAvatar(
                radius: MediaQuery.of(context).size.width*0.20,
               backgroundColor: Colors.white,
               backgroundImage: imageXFile ==null? null : FileImage(File(imageXFile!.path)),
               child: imageXFile == null?
               Icon(
                 Icons.add_photo_alternate,
                 size: MediaQuery.of(context).size.width*0.20 ,
                 color: Colors.grey,
               ) : null ,

             )
           ),
           const SizedBox( height: 10,),
           Form(
             key: _formKey ,
             child: Column(
               children: [
                 CustomTextField(
                   data: Icons.person ,
                   controller: nameController,
                   hintText: "Name",
                   isObscure: false,
                 ),
                 CustomTextField(
                   data: Icons.person ,
                   controller: emailController,
                   hintText: "Email",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.person ,
                   controller: passwordController,
                   hintText: "Password",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.person ,
                   controller: confirmPasswordController,
                   hintText: "Confirm Password",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.person ,
                   controller: phoneController,
                   hintText: "Phone",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.person ,
                   controller: locationController,
                   hintText: "Address",
                   isObscure: false,
                   enabled: false,

                 ),

                 Container(
                   width: 400,
                   height: 40,
                   alignment: Alignment.center,
                   child: ElevatedButton.icon(
                     label: const Text(
                       "Find my location",
                       style: TextStyle(color: Colors.white),
                       ),
                     icon: const Icon(
                       Icons.location_on,
                       color: Colors.white
                     ),
                     onPressed: ()=> print("Clicked"),
                     style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                       shape:  RoundedRectangleBorder(
                         borderRadius:  BorderRadius.circular(30)
                       )
                     ),
                   ),
                 )

               ],
             ),
           ),
           const SizedBox(
             height: 30,),
           ElevatedButton(
               child: Text(
                 "Sign Up",
                 style: TextStyle(
                     color: Colors.white,
                fontWeight: FontWeight.bold
                 ),
               ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: 20
                  )
                ),
             onPressed: ()=> print("clicked"),
           )

         ],
         )
       ),
    );
  }
}

