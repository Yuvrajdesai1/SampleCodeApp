import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nftapp/controllers/product_controller.dart';
import 'package:nftapp/model/product_model.dart';
import 'package:nftapp/utils/theme_manager.dart';
import 'package:nftapp/widgets/cuatom_appbar.dart';
import 'package:nftapp/widgets/custom_button.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../utils/app_const.dart';
import '../../utils/app_textStyle.dart';
import '../../widgets/custom_textField.dart';
import '../../widgets/prefix_icon.dart';
import '../user_screen/setting_screen.dart';

class addIdea extends StatefulWidget {
  @override
  _addIdeaState createState() => _addIdeaState();
}

class _addIdeaState extends State<addIdea> {
  Product product = Product();
  final ImagePicker _picker = ImagePicker();
  ThemeManager _themeManager = ThemeManager();

  ProductController _productController = ProductController();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  File? _image;

  var uuid = Uuid();

  // --------------- image picker ------------
  getImageFromGallery() async {
    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// --------------- appbar -----------------
      appBar: CustomAppBar(
        title: "Create new idea",
        prefixIcon: PrifixIcon(),
        actions: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
                ));
          },
          child: Container(
            margin: EdgeInsets.only(right: width * 0.02),
            child: Icon(Icons.settings),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // --------------- title section ---------------
            Container(
              margin:
                  EdgeInsets.only(top: height * 0.02, bottom: height * 0.005),
              child: Text(
                "Title",
                style: FontUtils.promptRegularStyle.copyWith(
                    fontSize: width * 0.035,
                    color: _themeManager.getGreyFontColor),
              ),
            ),
            CustomTextField(
              isActive: true,
              numberOfLine: 1,
              hintText: "Title",
              controller: _titleController,
              obscureText: false,
              obSecure: false,
              keyboardType: TextInputType.visiblePassword,
              validator: () {
                if (_titleController.text == "") {
                  return "Please enter title";
                } else {
                  return null;
                }
              },
            ),

            // --------------- Description section ---------------

            Container(
              margin:
                  EdgeInsets.only(top: height * 0.02, bottom: height * 0.005),
              child: Text(
                "Description",
                style: FontUtils.promptRegularStyle.copyWith(
                    fontSize: width * 0.035,
                    color: _themeManager.getGreyFontColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: height * 0.04),
              child: CustomTextField(
                isActive: true,
                numberOfLine: 3,
                hintText: "Description",
                controller: _descriptionController,
                obscureText: false,
                obSecure: false,
                keyboardType: TextInputType.visiblePassword,
                validator: () {
                  if (_descriptionController.text == "") {
                    return "Please enter Description";
                  } else {
                    return null;
                  }
                },
              ),
            ),

            // --------------- image upload section ---------------

            GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                strokeWidth: 1,
                color: _themeManager.getLightGreyBorderColor,
                dashPattern: [5],
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: height * 0.2,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        color: _themeManager.getBackgroundColor),
                    child: _image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: height * 0.02),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                        "assets/icons/upload-cloud.png"),
                                    Text(
                                      "Select image",
                                      style: FontUtils.promptSemiBoldStyle
                                          .copyWith(
                                              color:
                                                  _themeManager.getPrimaryColor,
                                              fontSize: width * 0.04),
                                    ),
                                    Text(
                                      "or select files from device",
                                      style: FontUtils.promptRegularStyle
                                          .copyWith(
                                              color: _themeManager
                                                  .getGreyFontColor,
                                              fontSize: width * 0.035),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "max. 50MB",
                                style: FontUtils.promptLightStyle.copyWith(
                                    color: _themeManager.getGreyFontColor,
                                    fontSize: width * 0.035),
                              ),
                            ],
                          )
                        : Image.file(_image!),
                  ),
                ),
              ),
            ),

            // --------------- create idea button ---------------

            Container(
              margin: EdgeInsets.only(top: height * 0.2),
              child: GestureDetector(
                  onTap: () async {
                    String productId = uuid.v1().toString();
                    product = await Product(
                      lastBuyingTime: DateTime.now().toString(),
                      title: _titleController.text,
                      buyerId: FirebaseAuth.instance.currentUser!.uid,
                      ownerUserId: FirebaseAuth.instance.currentUser!.uid,
                      description: _descriptionController.text,
                      createdTime: Timestamp.fromDate(DateTime.now()),
                      imageName: basename(_image!.path),
                      type: "idea",
                      prodId: productId,
                    );
                    _productController
                        .addImageController(_image!, context, product)
                        .whenComplete(() async {
                      Provider.of<ProductController>(context, listen: false)
                          .getAllProductController();
                      Navigator.pop(context);
                    });
                  },
                  child: CustomButton(
                    title: "Create Idea",
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
