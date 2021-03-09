abstract class BaseModel<T>{
  // convert to object
  T toClass(Map<String, dynamic> map);

  // object to map
  Map<String, dynamic> toMap();

  List<T> toClassArray(List<Map<String, dynamic>> list){
    if (list == null){
      return null;
    }
    List<T> newList = List();
    for(var map in list){
      newList.add(toClass(map));
    }
    return newList;
  }

  List<Map<String, dynamic>> toMapArray(List<T> list){
    if (list == null){
      return null;
    }
    List<Map<String, dynamic>> mapList = new List();
    for(var object in list){
      mapList.add((object as BaseModel<T>).toMap());
    }
    return mapList;
  }
}