var flip = function(ele){
  ele.classList.toggle('flipped');
}
var move = 10;

var moveBoss = function(){
  ele = document.querySelector('#boss');

  if(ele.width + ele.offsetLeft >= (window.innerWidth + 200) ||
      ele.offsetLeft < -200){
    move = move * -1;
    flip(ele);
  }

  ele.style.left = (ele.offsetLeft + move) + "px";
  //ele.style.height= Math.max(150,Math.sin((ele.offsetLeft/(window.innerWidth + 200))*Math.PI)*480);
};

setInterval(moveBoss, 100);