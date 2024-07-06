import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/widgets/custom_text_field.dart';
import 'package:myapp/widgets/error_dialouge.dart';



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

  Position? position;
  List<Placemark>? placeMarks;

  Future<void> _getImage() async{
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async
  {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placeMarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude);
    Placemark pMark = placeMarks![0];   // till here we only get position in lon,lat.

    String completeAddress = "${pMark.subThoroughfare}  ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality},  ${pMark.subAdministrativeArea},  ${pMark.administrativeArea}  ${pMark.postalCode}, ${pMark.country} ";

    locationController.text = completeAddress;
  }

  Future<void> formValidation() async
  {
    if(imageXFile==null)
      {showDialog(
          context: context,
          builder: (c){
            return ErrorDialouge(
             message:  "Please Select an Image",
            );
          }
      );
      }
    else
      {
        if(passwordController.text ==confirmPasswordController.text)
          {
            //Upload image to database
            if(confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.isNotEmpty  && locationController.text.isNotEmpty)
              //checked if form is filled correctly
            {
              //start uploading finally
            }
            else
            {
              showDialog(
                  context: context,
                  builder: (c){
                    return ErrorDialouge(
                      message:  "Please provide the required info.",
                    );
                  }
              );
            }
          }
        else
        {
          showDialog(context: context,
              builder: (c)
          {
            return ErrorDialouge(
              message: "Passwords do not match",
            );
          }
          );
        }
      }
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
           Form(                            // contains the find location button
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
                   data: Icons.email ,
                   controller: emailController,
                   hintText: "Email",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.key ,
                   controller: passwordController,
                   hintText: "Password",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.key ,
                   controller: confirmPasswordController,
                   hintText: "Confirm Password",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.phone ,
                   controller: phoneController,
                   hintText: "Phone",
                   isObscure: false,

                 ),
                 CustomTextField(
                   data: Icons.location_on ,
                   controller: locationController,
                   hintText: "Address",
                   isObscure: false,
                   enabled: true,

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
                     onPressed: ()
                     {
                       getCurrentLocation();
                     },
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
               style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 20
                  )
                ),
             onPressed: ()
             {
                 formValidation();
             },
               child: const Text(
                 "Sign Up",
                 style: TextStyle(
                     color: Colors.white,
                fontWeight: FontWeight.bold
                 ),
               ),
           ) // contains signup button

         ],
         )
       ),
    );
  }
}

