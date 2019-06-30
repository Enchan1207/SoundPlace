//--楽曲セル
class Cell{
  PImage icon;
  String title, composer;
  
  //--
  Cell(String path, String title, String composer){
    this.icon = loadImage(path);
    this.title = title;
    this.composer = composer;
  }
}
