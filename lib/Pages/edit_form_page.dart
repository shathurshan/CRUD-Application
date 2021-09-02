import 'package:crud_app/validations/custom_form_field.dart';
import 'package:crud_app/validations/db.dart';
import 'package:crud_app/validations/validator.dart';
import 'package:flutter/material.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final String currentTitle;
  final String currentDescription;
  final String documentId;

  const EditItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
    required this.currentTitle,
    required this.currentDescription,
    required this.documentId,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descreptionController = TextEditingController();

  String updateTitle = '';
  String updateDescription = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: addItemFormKey,
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
                    initialValue: widget.currentTitle,
                    isLabelEnabled: false,
                    controller: _titleController,
                    focusNode: widget.titleFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      Validator.validateFiels(
                        value: value,
                      );
                      updateTitle = value;
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
                    maxLines: 10,
                    isLabelEnabled: false,
                    initialValue: widget.currentDescription,
                    controller: _descreptionController,
                    focusNode: widget.descriptionFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    validator: (value) {
                      Validator.validateFiels(
                        value: value,
                      );
                      updateDescription = value;
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

                          await DataBase.updateItem(
                            docId: widget.documentId,
                            title: updateTitle,
                            description: updateDescription,
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
                          "Update Data",
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
    );
  }
}
