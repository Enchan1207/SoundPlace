//--楽曲セル
class Cell{
  String icon, title, composer;
  int x, y;
  
  //--
  Cell(String icon, String title, String composer){
    this.icon = icon;
    this.title = title;
    this.composer = composer;
    
    this.x = 50;
    this.y = 50;
  }
  
  //--
  void show(){
    image(loadImage(icon), x, y);
  }
  
  
  
}
