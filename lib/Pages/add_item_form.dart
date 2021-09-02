import 'package:crud_app/validations/custom_form_field.dart';
import 'package:crud_app/validations/db.dart';
import 'package:crud_app/validations/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  const AddItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descreptionController = TextEditingController();

  String getTitle = '';
  String getDescription = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: addItemFormKey,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * .5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Text(
                        "Title",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomFormField(
                        initialValue: "",
                        isLabelEnabled: false,
                        controller: _titleController,
                        focusNode: widget.titleFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validator: (value) {
                          Validator.validateFiels(
                            value: value,
                          );
                          getTitle = value;
                        },
                        label: "Titile",
                        hint: "Write Your Title",
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      CustomFormField(
                        initialValue: "",
                        maxLines: 10,
                        isLabelEnabled: false,
                        controller: _descreptionController,
                        focusNode: widget.descriptionFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validator: (value) {
                          Validator.validateFiels(
                            value: value,
                          );
                          getDescription = value;
                        },
                        label: "Description",
                        hint: "Write Your Description",
                      ),
                    ],
                  ),
                ),
                _isProcessing
                    ? const Padding(
                        padding: EdgeInsets.all(
                          16.0,
                        ),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                        ),
                      )
                    : Container(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orangeAccent),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            widget.titleFocusNode.unfocus();
                            widget.descriptionFocusNode.unfocus();
        
                            if (addItemFormKey.currentState!.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });
        
                              await DataBase.addItem(
                                title: getTitle,
                                description: getDescription,
                              );
        
                              setState(() {
                                _isProcessing = false;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                              top: 16.0,
                              bottom: 16.0,
                            ),
                            child: Text(
                              "Add Data",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
