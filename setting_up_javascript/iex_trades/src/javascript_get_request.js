function httpGet(ticker)
{
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", "https://api.iextrading.com/1.0/deep/trades?symbols=" + ticker, false);  //false for syncronous request
    xmlHttp.send( null );
    return xmlHttp.responseText;
    
}

function myJsFunction()
{
    var x = document.getElementById('input1').value;
    var trades = httpGet(x);
    trades = trades.toString();
    document.getElementById("out1").innerHTML = trades;
}
