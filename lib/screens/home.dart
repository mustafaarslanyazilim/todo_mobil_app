import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_mobil_app/constants/color.dart';
import 'package:todo_mobil_app/constants/tasktype.dart';
import 'package:todo_mobil_app/model/task.dart';
import 'package:todo_mobil_app/screens/add_new_task.dart';
import 'package:todo_mobil_app/service/todo_service.dart';
import 'package:todo_mobil_app/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> todo = ["Study Lesson", "Run 5K", "Go to Party"];
  //List<String> completed = ["Game meetup", "Take out tash"];

  List<Task> todo = [
    Task(
      type: Tasktype.notes,
      title: "Study Lesson",
      description: "Study COMP117",
      isCompleted: false,
    ),
    Task(
      type: Tasktype.contest,
      title: "Run 5K",
      description: "Run 5 kilometers",
      isCompleted: false,
    ),
    Task(
      type: Tasktype.calender,
      title: "Go to Party",
      description: "Attend to party",
      isCompleted: false,
    ),
  ];

  List<Task> completed = [
    Task(
      type: Tasktype.contest,
      title: "Run 5K",
      description: "Run 5 kilometers",
      isCompleted: false,
    ),
    Task(
      type: Tasktype.calender,
      title: "Go to Party",
      description: "Attend to party",
      isCompleted: false,
    ),
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    //ekran yüksekliği ve genişliğini sabit olarak tutmak
    double deviceHeight = MediaQuery.of(context)
        .size
        .height; //MediaQuery.of(context) size-->telefonun yüksekliğini     verecek.
    double deviceWidht = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        //SafeArea  /üstteki bildirim paneli ve alttaki tuşlara widgetın taşmasını engeller.
        child: Scaffold(
          //tüm uygulamanın renk değişimi için scaffold a ekleme yapıyoruz.
          //uygulamanın tüm teması değişmesi için uygulamanın en üstüne koymak lazım
          backgroundColor: HexColor(backgrounColor), //color.dartdan gelen renk
          body: Column(
            children: [
              //HEADER
              Container(
                //container boyutu için
                width: deviceWidht,
                height: deviceHeight / 3, //yüksekliğin 3 de 1 i

                //bu containera resim eklemek için decaration kullancaz
                decoration: const BoxDecoration(
                  color:
                      Colors.purple, //color ve decaration ayrı ayrı kullanılmaz
                  // o yüzden color ı da decartion içine alıyoruz.
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/header.png"),
                    fit: BoxFit.cover, //resmin bütün alana yayılması için
                  ),
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.0), //yukarıdan boşluk ver
                      child: Text(
                        "Eylül 06, 2024",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Text(
                        "My Todo List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              //Top Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    //Card ların aşağı yukarı kaydırılır olması için
                    child: FutureBuilder(
                      future: todoService.getUncompletedTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator(); //loading image
                        } else {
                          return ListView.builder(
                            primary: false,
                            //scroll edilebilen primary widgetın scrollChildView olmasını istiyoruz.
                            // thisView olmaması için.
                            shrinkWrap:
                                true, //listView.builderın kendine tahsis edilen alanda sınırlı kalmasını sağlayacak.
                            //bunu yapma sebebimiz;
                            //listView ve singleChildScroll ikisi de en maks alanı almaya çalışıyor ve programda hataya neden oluyor.
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              //!*! ! itemCount =>todo.lenght kadar return card edilecek
                              return todoItem(
                                task: snapshot.data![index],
                                //snapshot dan gelen datanın null olmayan halini istiyoruz.
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              //Completed Text
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tamamlandı",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              //Bottom Column

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SingleChildScrollView(
                    //Card ların aşağı yukarı kaydırılır olması için
                    child: FutureBuilder(
                      future: todoService.getCompletedTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator(); //loading image
                        } else {
                          return ListView.builder(
                            primary: false,
                            //scroll edilebilen primary widgetın scrollChildView olmasını istiyoruz.
                            // thisView olmaması için.
                            shrinkWrap:
                                true, //listView.builderın kendine tahsis edilen alanda sınırlı kalmasını sağlayacak.
                            //bunu yapma sebebimiz;
                            //listView ve singleChildScroll ikisi de en maks alanı almaya çalışıyor ve programda hataya neden oluyor.
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              //!*! ! itemCount =>todo.lenght kadar return card edilecek
                              return todoItem(
                                task: snapshot.data![index],
                                //snapshot dan gelen datanın null olmayan halini istiyoruz.
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  //buton işlev-- push ekleme
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNewTaskScreen(
                        addNewTask: (newTask) => addNewTask(newTask),
                      ),
                    ),
                  );
                },
                child: const Text("Yeni Görev Ekle"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
