import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_mobil_app/constants/color.dart';
import 'package:todo_mobil_app/constants/tasktype.dart';
import 'package:todo_mobil_app/model/task.dart';
import 'package:todo_mobil_app/model/todo.dart';
import 'package:todo_mobil_app/service/todo_service.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask});

  //* Passing function as parameter
  //! bir alttaki wdigettan bir üstteki widgeta fonk çıkarmak için.
  final void Function(Task newTask) addNewTask;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  //textfield içinde ki yazdığımız inputları alabilmemiz için --> TextEditingController
  //Textfield içine girilen değerler titleController ile kontrol ediliyor olacak.
  TextEditingController titleController = TextEditingController();
  //Textfield içine girilen date değerleri dateController ile kontrol ediliyor olacak.
  TextEditingController UserIdController = TextEditingController();
  //Textfield içine girilen time değerleri timeController ile kontrol ediliyor olacak.
  TextEditingController timeController = TextEditingController();
  //Textfield içine girilen description değerleri descriptionController ile kontrol ediliyor olacak.
  TextEditingController descriptionController = TextEditingController();

  TodoService todoService = TodoService();

  Tasktype taskType = Tasktype.notes; //default olarak notes tipinde olacak
  @override
  Widget build(BuildContext context) {
    //ekran yüksekliği ve genişliğini sabit olarak tutmak
    double deviceHeight = MediaQuery.of(context)
        .size
        .height; //MediaQuery.of(context) size-->telefonun yüksekliğini     verecek.
    double deviceWidht = MediaQuery.of(context).size.width;
    return SafeArea(
      //bildirim paneline taşmaması için --> safeArea
      child: Scaffold(
        backgroundColor: HexColor(backgrounColor),
        body: SingleChildScrollView(
          //tüm ekranın scroll edilmesi için
          child: Column(
            children: [
              Container(
                //container boyutu için
                width: deviceWidht,
                height: deviceHeight / 10, //ekran yüksekliğin 10 de 1 i
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  image: DecorationImage(
                    image:
                        AssetImage("lib/assets/images/add_new_task_header.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        //buton işlev --sayfa çıkarma-pop
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Add New Task",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Task Title"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextField(
                  controller: titleController, //! TİTLE DEĞER KONTROLÜ
                  decoration: const InputDecoration(
                      //decoration--> textfield içindeki text stilini düzenlememize yarayacak.
                      //filled --> içerisindeki rengin boyanmasını sağlar.
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Category"),
                    GestureDetector(
                      onTap: () {
                        //scaffoldMessenger--> ıcon seçildiği zaman en alt kısımda uyarı çıkmasını sağlar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 400),
                            content: Text("Kategori Seçildi"),
                          ),
                        );
                        setState(() {
                          //?! seçili Mİ Durum kontrol
                          taskType = Tasktype.notes;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_1.png"),
                    ), // dokunuşları kontrol etmemizi sağlar. --> gestureDedector //tuşa tek basmada-uzun süreli basma da-
                    GestureDetector(
                      onTap: () {
                        //scaffoldMessenger--> ıcon seçildiği zaman en alt kısımda uyarı çıkmasını sağlar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 400),
                            content: Text("Kategori Seçildi"),
                          ),
                        );
                        setState(() {
                          //?! seçili Mİ Durum kontrol
                          taskType = Tasktype.calender;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_2.png"),
                    ), // dokunuşları kontrol etmemizi sağlar. --> gestureDedector //tuşa tek basmada-uzun süreli basma da-
                    GestureDetector(
                      onTap: () {
                        //scaffoldMessenger--> ıcon seçildiği zaman en alt kısımda uyarı çıkmasını sağlar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 400),
                            content: Text("Kategori Seçildi"),
                          ),
                        );
                        setState(() {
                          //?! seçili Mİ Durum kontrol
                          taskType = Tasktype.contest;
                        });
                      },
                      child: Image.asset("lib/assets/images/category_3.png"),
                    ), // dokunuşları kontrol etmemizi sağlar. --> gestureDedector //tuşa tek basmada-uzun süreli basma da-
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Date"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20), //yandan 20 birim boşluk
                            child: TextField(
                              controller:
                                  UserIdController, //! UserId DEĞER KONTROLÜ
                              decoration: const InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Time"),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20), //yandan 20 birim boşluk
                            child: TextField(
                              controller:
                                  timeController, //! TİME DEĞER KONTROLÜ
                              decoration: const InputDecoration(
                                  filled: true, fillColor: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Description"), //NOTES
              ),
              SizedBox(
                height: 300,
                child: TextField(
                  controller:
                      descriptionController, //! DESCRİPTİON DEĞER KONTROLÜ
                  expands: true, //yazdıkça expends olması
                  maxLines: null, //istediği kadar satır ekle
                  decoration: const InputDecoration(
                      filled: true, fillColor: Colors.white, isDense: true),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  saveTodo();
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveTodo() {
    Todo newTodo = Todo(
      id: -1,
      todo: titleController.text,
      completed: false,
      userId: int.parse(UserIdController.text),
    );
    todoService.addTodo(newTodo);
  }
}
