import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spell_check_app/services/SpellCheck.dart';

class SpellCheckForm extends StatefulWidget {
  const SpellCheckForm({
    Key key,
  }) : super(key: key);

  @override
  _SpellCheckFormState createState() => _SpellCheckFormState();
}

class _SpellCheckFormState extends State<SpellCheckForm> {
  TextEditingController _textEditingController = TextEditingController();
  String _textCorrected;
  bool _loading = false;

  handleClickButton() async {
    setState(() {
      _loading = true;
    });
    final SpellCheckService service = SpellCheckService(Methods.POST,
        path: '/dev/spellcheck', body: {'text': _textEditingController.text});
    final String response = await service.doRequest();
    final data = json.decode(response);

    setState(() {
      _textCorrected = data['text'];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Check your',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'SpaceGrotesk',
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'spelling',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'SpaceGrotesk',
                        color: Color(0xff9b9bff),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: 'Write here...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                      ),
                      SizedBox(height: 40),
                      ButtonTheme(
                        padding: EdgeInsets.only(
                            top: 25, bottom: 15, left: 15, right: 15),
                        minWidth: 120,
                        child: FlatButton(
                          onPressed: () => handleClickButton(),
                          child: Text(
                            'Check it!',
                            style: TextStyle(fontSize: 50),
                          ),
                          color: Colors.black,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xff9b9bff),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: !_loading
                  ? Text(
                      _textCorrected ?? ' ',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    )
                  : Container(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
