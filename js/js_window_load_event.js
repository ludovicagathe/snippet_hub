function my_load_fn(){
    //do onload work
}
if(window.addEventListener){
    window.addEventListener('load',my_load_fn,false); //W3C
}
else{
    window.attachEvent('onload',my_load_fn); //IE
}