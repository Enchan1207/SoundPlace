import java.io.*;

//--楽曲リスト
class CellList{
  Cell list[];
  
  //--
  void createCellList(){
    File dir = new File(dataPath(""));
    File files[] = dir.listFiles();
    this.list = new Cell[files.length];
    int fcnt = 0;
    for(int i = 0; i < files.length; i++){
      if(files[i].isDirectory()){
        String info[] = loadStrings(files[i].getAbsolutePath()+"/info.txt");
        list[fcnt] = new Cell(files[i].getAbsolutePath() + "/icon.jpg", info[0], info[1]);
        println("楽曲を取り込みました タイトル:" + info[0] + " 作曲者:" + info[1]);
        fcnt++;
      }
    }
  }
}
