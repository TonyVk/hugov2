$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type === "openGeneral"){
            $('body').fadeIn(500);
            if(!event.data.banka){
                $("#kredit").fadeOut(1);
            }else{
                $("#kredit").fadeIn(1);
            }
        } else if(event.data.type === "balanceHUD") {
            var balance = event.data.balance;
            $('.vb-banking-creditcard-footer-cardholder').html(event.data.player);
            $('.vb-balance-balance').html("$ "+balance);
            $('.vb-banking-tarjetas-mycardcontainer-balance').html("$ "+balance);
            $('.vb-banking-tarjetas-rigthbar-balance').html("$ "+balance);
            $('.vb-banking-myaccount-balance-balance').html("$ "+balance);
            $('.vb-banking-myaccount-faq-balance').html("$ "+balance);
            if (balance.toString().length >= Number(6)) {
                //document.getElementById("vb-banking-tarjetas-mycardcontainer-balance").style.fontSize = "28px"
                //document.getElementById("vb-banking-tarjetas-rigthbar-balance").style.fontSize = "25px"
                //document.getElementById("vb-banking-depositcontainer-balance").style.fontSize = "25px"
                //document.getElementById("vb-banking-transferir-container-balance").style.fontSize = "25px"
                document.getElementById("vb-banking-transferir-myaccount-balance").style.fontSize = "25px"
            }
            var playername = event.data.player
            $('.vb-banking-creditcard-cardholder').html(playername);
            var address = event.data.address
            $('.vb-banking-myaccount-info-address').html('<i class="fal fa-map-marker-alt"></i>&nbsp;&nbsp;&nbsp;</i>Address:&nbsp;&nbsp;'+address+'</span>');
            var walletid = event.data.playerid
            $('.vb-banking-myaccount-info-walletid').html('<i class="fal fa-wallet"></i>&nbsp;&nbsp;&nbsp;</i>Wallet ID:&nbsp;&nbsp;'+walletid+'</span>');
            var transakcije = event.data.transakcije;
            transakcije.sort((a,b) => a.ID - b.ID);
            let velkiHtml = "";
            for(let i = 0; i<transakcije.length; i++){
                let htmlic = `
                <div class="vb-banking-historytransactions-transaction">
                    <span class="vb-transaction-textmarca">`+transakcije[i].Tekst+`</span>
                    <span class="vb-transaction-textprice">$`+transakcije[i].Iznos+`</span>
                </div>`;
                velkiHtml = velkiHtml+htmlic;
            }
            $('.vb-banking-tarjetas-historytransactions').html(velkiHtml);
        } else if (event.data.type === "closeAll"){
            $('body').fadeOut(500);
        } else if(event.data.type === "narediKredit") {
            $('#iznoskr').html("$"+event.data.kredit);
            $('#ratakr').html("$"+event.data.rata);
        }
    });
});

$(document).on('click','#inicio',function(){
    hideall();
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#kredit',function(){
    hideall();
    $(".vb-banking-container-kredit").fadeIn(500);
})

$(document).on('click','#mycards',function(){
    hideall();
    $(".vb-banking-bigcontainertarjetas").fadeIn(500);
})

$(document).on('click','#nauciButton',function(){
    hideall();
    $(".vb-banking-bigcontainertarjetas").fadeIn(500);
})

$(document).on('click','#meterpastica',function(){
    hideall();
    $(".vb-banking-bigcontainerdepositar").fadeIn(500);
})

$(document).on('click','#depositar',function(){
    hideall();
    $(".vb-banking-bigcontainerdepositar").fadeIn(500);
})

$(document).on('click','#transfer',function(){
    hideall();
    $(".vb-banking-bigcontainertransfer").fadeIn(500);
})

$(document).on('click','#myaccount',function(){
    hideall();
    $(".vb-banking-bigcontainermyaccount").fadeIn(500);
})

$(document).on('click','#faq',function(){
    hideall();
    $(".vb-banking-bigcontainerfaq").fadeIn(500);
})

$(document).on('click','#kredit25',function(e){
    hideall();
    e.preventDefault();
    $.post('http://esx_banka/kredit', JSON.stringify({
        amount: 25000
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#kredit50',function(e){
    hideall();
    e.preventDefault();
    $.post('http://esx_banka/kredit', JSON.stringify({
        amount: 50000
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#kredit75',function(e){
    hideall();
    e.preventDefault();
    $.post('http://esx_banka/kredit', JSON.stringify({
        amount: 75000
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#kredit100',function(e){
    hideall();
    e.preventDefault();
    $.post('http://esx_banka/kredit', JSON.stringify({
        amount: 100000
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#zatvoriKredit',function(e){
    hideall();
    e.preventDefault();
    $.post('http://esx_banka/vratikredit', JSON.stringify({
        
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#closebanking',function(){
    hideall();
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#withdraw',function(e){
    e.preventDefault();
    hideall();
    $.post('http://esx_banka/withdraw', JSON.stringify({
        amountw: $("#withdrawnumber").val()
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#depositarpasta',function(e){
    e.preventDefault();
    hideall();
    $.post('http://esx_banka/deposit', JSON.stringify({
        amount: $("#cantidaddepositar").val()
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

$(document).on('click','#transferirpasta',function(e){
    e.preventDefault();
    hideall();
    $.post('http://esx_banka/transfer', JSON.stringify({
        to: $("#iddestinatario").val(),
        amountt: $("#cantidadtransfer").val()
    }));
    $('body').fadeOut(500);
    $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
    $(".vb-banking-container-inicio").fadeIn(500);
})

function hideall() {
    $(".vb-banking-container-inicio").hide();
    $(".vb-banking-bigcontainertarjetas").hide();
    $(".vb-banking-bigcontainerdepositar").hide();
    $(".vb-banking-bigcontainertransfer").hide();
    $(".vb-banking-bigcontainermyaccount").hide();
    $(".vb-banking-bigcontainerfaq").hide();
    $(".vb-banking-container-kredit").hide();
}

document.onkeyup = function(data){
    if (data.which == 27){
        hideall();
        $('body').fadeOut(500);
        $.post('http://esx_banka/NUIFocusOff', JSON.stringify({}));
        $(".vb-banking-container-inicio").fadeIn(500);
    }
}