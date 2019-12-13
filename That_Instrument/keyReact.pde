/*
 * キー押下時の処理
*/


//--コントローラによって変更が加わった場合
void keyTyped(){
    //
    int base = 0;
    int buselidx[]  = selidx.clone(); //まず退避
    switch (key) {
        //--A～D 上一列目
        case 'a':
        case 'b':
        case 'c':
        case 'd':
            base = int('a');
            selidx[0] = key - base;
            break;
        
        //--E～H 上一列目
        case 'e':
        case 'f':
        case 'g':
        case 'h':
            base = int('e');
            selidx[1] = key - base;
            break;

        //--I～L 上一列目
        case 'i':
        case 'j':
        case 'k':
        case 'l':
            base = int('i');
            selidx[2] = key - base;
            break;

        //--M～P 上一列目
        case 'm':
        case 'n':
        case 'o':
        case 'p':
            base = int('m');
            selidx[3] = key - base;
            break;
    }

    //--変更は加わっているか?
    boolean rst = false;
    for(int i = 0; i < selidx.length; i++){
        if(selidx[i] != buselidx[i]){
            rst = true;
        }
    }

    //--スイッチによって選択状態が変化したらスパークルを発生させる
    if(rst){
        //--
        int efcID = 0;
        int bases[] = {'a', 'e', 'i', 'm'};
        for (int i = 0; i < 4; i++) {
            if(base == bases[i]) efcID = i;
        }

        manager.box3DEffect(efColor[efcID]);
        
        mix();
    }

}