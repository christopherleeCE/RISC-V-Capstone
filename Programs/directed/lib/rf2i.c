#include "drysoup.h"

//preforms a raw byte for byte cast from float to int, used to pass a float into the ret of int main
int rf2i(float fnum){
    return *(int*)&(float){fnum};
}