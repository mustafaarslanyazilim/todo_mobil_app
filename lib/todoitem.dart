//Card olan widgetı Custom Widget çevirme
//Eğer bir kod setini birden fazla input için kullanıyorsanız büyük ihtimalle
//o kod setini bir custom widget haline çevirebilirsiniz.

import 'package:flutter/material.dart';
import 'package:todo_mobil_app/model/todo.dart';

class todoItem extends StatefulWidget {
  //required girilmesi zorunlu değer
  const todoItem({
    super.key,
    required this.task,
  });
  //customWidget içerisinde property kullanımı
  final Todo task; //title yerine Task -- final Task task -- yerine Todo task

  @override
  State<todoItem> createState() => _todoItemState();
}

class _todoItemState extends State<todoItem> {
  //bool tipinde chechBox için bir değişken oluşturacağız.
  bool isChecked = false;
  //bu ischecked değerini build içinde kullanamayız çünkü
  //ischecked değerini her çağırdığımız da build metodu yeniden build edecek
  //ve isChecked= false değerini her build de yeniden alacak

  @override
  Widget build(BuildContext context) {
    //bu todoItem ı biz main.dart içinde Card widget yerine kullanacağımız için
    //materilApp içine scafold koyup uygulamayı ağarlaştırmıyoruz.
    return Card(
      color: widget.task.completed! == true ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        //Card'ın kenarlardan içe doğru boşluk alması için
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, //smetric olarak soldan ve sağdan boşluk ver
          //ve widget aralarında küçük boşluklar verecek
          children: [
            /* //Todo Firebase işlemlerinde düzelt
            widget.task.type == Tasktype.notes
                ? Image.asset("lib/assets/images/category_1.png")
                : widget.task.type == Tasktype.contest
                    ? Image.asset("lib/assets/images/category_3.png")
                    : Image.asset("lib/assets/images/category_2.png"),

            */
            Image.asset("lib/assets/images/category_1.png"),
            Expanded(
              //bu resimlerin ve textlerin hizalanmasını sağlar.
              child: Column(
                children: [
                  Text(
                    widget.task.todo!,
                    //! todo[index] di önceden  //todo liste olan index değerlerini çekecek.
                    style: TextStyle(
                        decoration: widget.task.completed!
                            ? TextDecoration.lineThrough //üsü çizgili
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "User: ${widget.task.userId!}", //description --> title altındaki alt açıklama
                    style: TextStyle(
                      decoration: widget.task.completed!
                          ? TextDecoration.lineThrough //üstü çiz
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
                value: isChecked,
                onChanged: (value) => {
                      setState(
                        () {
                          //iscompleted neyse tersine eşitle true-->false, false-->true
                          //chech kısmı tiklendiğinde sayflar da ileri geri olsa bile tik hala eskisi gibi kalcak. bunu sağladı
                          widget.task.completed = !widget.task.completed!;
                          isChecked =
                              value!; // ! varsa sadece Value varsa bu satırı işleme al demek.
                        },
                      ),
                    }),
          ],
        ),
      ),
    );
  }
}
