import 'dart:async';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/widgets/custom_text_field.dart';
import 'package:myapp/widgets/error_dialouge.dart';
import 'package:myapp/widgets/loading.dart';



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


  String userImageUrl = "";

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

////seller = = suser

  Future uploadUserData(User currentUser) async
  {
    FirebaseFirestore.instance.collection("suser").doc(currentUser.uid).set({
      'suserUID':currentUser.uid,
      'suserEmail': currentUser.email,
      'suserName':nameController.text.trim(),
      //'suserAvatar': ,

    });
  }


  Future<void> uploadFileToStorage(File file, String folderName) async {
    try {
      final storage = FirebaseStorage.instance;
      final Reference storageRef = storage.ref().child('$folderName/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(file);


      await uploadTask.whenComplete(() {
        print('File uploaded successfully');
      });
    } catch (e) {
      print('Error uploading file: $e');
    }
  }




  Future<void> formValidation() async
  {
    if(imageXFile==null)
      {showDialog(
          context: context,
          builder: (c){
            return const ErrorDialouge(
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
              showDialog(
                context: context,
                builder: (c)
                  {
                    return const loading(
                      message: ("Registering account"),
                    );
                  }
              );

              File image2u = File(imageXFile!.path);
              Firebase.initializeApp();
              uploadFileToStorage(image2u,'Utest2');
              return;


              /*String fileName = DateTime.now().millisecondsSinceEpoch.toString();
              storage.Reference reference = storage.FirebaseStorage.instance.ref().child("susers").child(fileName);
              storage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
              storage.TaskSnapshot taskSnapshots =  uploadTask.whenComplete(() {});
              await taskSnapshots.ref.getDownloadURL().then((url) {
               userImageUrl = url;*/

                //uploadFile();
                // upload to firebase
             // });




            }
            else
            {
              showDialog(
                  context: context,
                  builder: (c){
                    return const ErrorDialouge(
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
            return const ErrorDialouge(
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
                 //uploadFile();
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

