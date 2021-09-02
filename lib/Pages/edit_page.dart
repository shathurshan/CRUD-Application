import 'package:crud_app/Pages/edit_form_page.dart';
import 'package:crud_app/validations/db.dart';
import 'package:flutter/material.dart';

import 'app_bar.dart';

class EditPage extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final String documentId;
  EditPage({
    required this.currentTitle,
    required this.currentDescription,
    required this.documentId,
  });

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const AppBarNew(
            sectionName: ' CRUD',
          ),
          actions: [
            _isDeleting
                ? const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 10.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });
                      await DataBase.deleteItem(
                        docId: widget.documentId,
                      );
                      setState(() {
                        _isDeleting = false;
                      });
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                  ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                child: EditItemForm(
                  titleFocusNode: _titleFocusNode,
                  descriptionFocusNode: _descriptionFocusNode,
                  currentTitle: widget.currentTitle,
                  currentDescription: widget.currentDescription,
                  documentId: widget.documentId,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
