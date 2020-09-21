import 'package:flutter/material.dart';
import 'package:student_management/core/extension/int_extension.dart';
import 'package:student_management/ui/widgets/my_text_form_field.dart';

/// 修改个性签名的界面
class DYXDetailsUpdatePersonalSignaturePage extends StatefulWidget {
  static const String routeName = "/detailsUpdatePersonalSignature";
  final String personalSignature;


  DYXDetailsUpdatePersonalSignaturePage(this.personalSignature);

  @override
  _DYXDetailsUpdatePersonalSignatureState createState() => _DYXDetailsUpdatePersonalSignatureState();
}

class _DYXDetailsUpdatePersonalSignatureState extends State<DYXDetailsUpdatePersonalSignaturePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.personalSignature;
    return Scaffold(
      appBar: AppBar(
        title: Text('修改个性签名'),
        actions: <Widget>[
          Container(
            alignment: AlignmentDirectional.center,
            child: FlatButton(
              child: Text('保存', style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),),
              onPressed: () {
                Navigator.pop<dynamic>(context, _controller.text);
              },
            )
          )

        ],
      ),
      body: TextFormField(
        controller: _controller,
        maxLines: 4,
        maxLength: 66,
        autofocus: true,
      ),
    );
  }
}
