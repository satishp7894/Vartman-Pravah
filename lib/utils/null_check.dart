
class NullCheck{
  textNullCheck(String string){
    if(string != null || string.isEmpty){
    return  string ;
    }else{
      return  "" ;
    }
  }
}