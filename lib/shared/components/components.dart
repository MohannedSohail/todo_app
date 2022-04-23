import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Container defaultButton(
    {double? width = double.infinity,
      Color color = Colors.blue,
      Gradient? gradient,
      bool isUpperCase = true,
      double? radius,
      double? fontSize,
      required VoidCallback function,
      required String txt}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius!)),
    child: MaterialButton(
      onPressed: function,
      child: Text(isUpperCase ? txt.toUpperCase() : txt,
          style: TextStyle(color: Colors.white, fontSize: fontSize)),
    ),
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
   TextInputType? type,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  required FormFieldValidator validator,
  required String labelTxt,
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixOnPressed,
  bool obscureText = false,
  List<TextInputFormatter>? inputFormatter,
  GestureTapCallback? onTap,
  bool readOnly=false,
  bool showCursor=false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: obscureText,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validator,
    onTap: onTap,
    readOnly: readOnly,
    showCursor: showCursor,

    // ADD LIMIT TO (TextFormField)
    // inputFormatters: [
    //   LengthLimitingTextInputFormatter(5),
    //   FilteringTextInputFormatter.digitsOnly
    // ],
      inputFormatters:inputFormatter,


    decoration: InputDecoration(
        labelText: labelTxt,
        prefixIcon: Icon(prefixIcon),
        suffixIcon:
        IconButton(icon: Icon(suffixIcon), onPressed: suffixOnPressed),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )),
  );




}


Widget buildTaskItem(Map map){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 45,
          child: Text("${map['time']}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17)),
        ),

        SizedBox(
          width: 30,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${map['title']}",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold)),
            SizedBox(height: 4,),
            Text("${map['date']}",style: TextStyle(color: Colors.grey)),

          ],
        ),
      ],
    ),
  );
}
