// TODO İÇİNDE BULUNAN JSON DOSYA VERİLERİ
//{"todos":[{"id":1,"todo":"Do something nice for someone you care about","completed":false,"userId":152}
//BUNLARIN PARAMETRELERİNİ ALACAZ--> id- Todo-Completed-userId  -- Toplam da 4 adet parametre

class Todo {
  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  /*
  api çektiğimiz için internetten gelen verilerin her zaman dolu olup olmadığını
  bilemediğimiz için "?" koymamız yani nonlable olabilir demek gerekli. 
  */
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  //?  from Json  /  --api json olarak çekileceği için bu metod
  //* tam olarak gelecek olan veri türünü bilmediğimiz yerlerde veri türünü dynamic olarak gireriz.
  //!           map < key(string) , value(dynamic)  >
  Todo.fromJson(Map<String, dynamic> json) {
    id = json["id"]; // id --> json dan gelecek olan id ye eşitlenecek
    todo = json["todo"]; // todo --> json dan gelen todo ya eşitle
    completed = json["completed"]; //* json dan gelen completed a eşitle
    userId = json["userId"]; //? jsondan gelen userId e eşitle

    //! bir json geldiğinde todo objesine çevirme işlemi yapıldı.
  }

  //?  to Json    /   --json olarak veri göndereceğimiz metod

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {}; //insilaj işini {} hallledecek.
    data["id"] = id;
    data["todo"] = todo;
    data["completed"] = completed;
    data["userId"] = userId;

    return data;
  }
}
