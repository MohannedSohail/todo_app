import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

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
  bool readOnly = false,
  bool showCursor = false,
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
    inputFormatters: inputFormatter,

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

Widget buildTaskItem(
    Map map, context, bool isVisibleDoneButton, bool isVisibleArchivedButton) {
  return Dismissible(
    key: Key(map['id'].toString()),
    secondaryBackground: Container(
      color: Colors.red,
      child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          )),
    ),
    background: Container(
      color: Colors.red,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          )),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteARecordsInDatabase(id: map['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 45,
            child: Text("${map['time']}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17)),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${map['title']}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 4,
                ),
                Text("${map['date']}", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Visibility(
            visible: isVisibleDoneButton,
            child: IconButton(
                onPressed: () {
                  AppCubit.get(context).updateSomeRecordsInDatabase(
                      status: "done", id: map['id']);
                },
                icon: Icon(Icons.check_box, color: Colors.green)),
          ),
          Visibility(
            visible: isVisibleArchivedButton,
            child: IconButton(
                onPressed: () {
                  AppCubit.get(context).updateSomeRecordsInDatabase(
                      status: "archive", id: map['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.blue,
                )),
          ),
        ],
      ),
    ),
  );
}

Widget appNoData(
    {required IconData icon, Color color = Colors.blue, required String txt}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 100, color: color),
        SizedBox(
          height: 10,
        ),
        Text(txt, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
