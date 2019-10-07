/*
 * キー押下時の処理
*/


//--コントローラによって変更が加わった場合
void keyTyped(){
    //
    int base = 0;
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

    for(int i = 0; i < 4; i++){
        print(selidx[i] + ":");
    }
    println();
    mix();
}