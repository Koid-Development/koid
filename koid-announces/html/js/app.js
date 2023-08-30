$(function(){
    window.addEventListener("message", function(event){
		if(event.data.AnuncioShowing){
			AnuncioAppear(event.data);
		}
    })
})
var colaAnuncio = [];
var anuncioShowing = false;
function AnuncioAppear(data) {
	if(!this.anuncioShowing && this.colaAnuncio.length == 0) {
		this.anuncioShowing = true;
		this.showAnuncioDesign(data);
	} else {
		this.colaAnuncio.push(data);
	}
}
function showAnuncioDesign(data) {
	var then = this;
	$('.anuncio').css({'background-image': "url('https://images.forasterosroleplay.es/paneles/new/"+data.job+".png')"});
	$('.anunciotext').css({color: `${data.letter}`})
	$('.anunciotext').text(data.msg);
	$(".anuncio").fadeIn("slow")
	setTimeout(function(){
		$(".anuncio").fadeOut("slow");
		if(then.colaAnuncio.length > 0) {
			var data = then.colaAnuncio.pop();
			then.showAnuncioDesign(data);
		} else {
			then.anuncioShowing = false;
		}
	}, 10000);

}

function ShowAnuncio() {
	setTimeout(function(){
		$("anuncio").css({left: "0px", right: "15px"})
	}, 10000);
}

function Flush() {
	$("anuncio").css({right: "-15px"})
}