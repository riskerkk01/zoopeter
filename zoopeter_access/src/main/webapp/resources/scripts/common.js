function EmailCheck(email)
{
    var emailPattern = /[-!#$%&'*+/^_~{}|0-9a-zA-Z]+(.[-!#$%&'*+/^_~{}|0-9a-zA-Z]+)*@[-!#$%&'*+/^_~{}|0-9a-zA-Z]+(.[-!#$%&amp;'*+/^_~{}|0-9a-zA-Z]+)*/;
    var result = email.match(emailPattern); 
    if(result == null)
    {
        return false;
    }
    else return true;
}

function SetCookie(cKey, cValue)  // name,pwd
{
    var date = new Date(); // 오늘 날짜
    var validity = 30; 
    date.setDate(date.getDate() + validity);
    document.cookie = cKey + '=' + escape(cValue) + ';path=/; expires=' + date.toGMTString();
}

function DelCookie(cKey) {
    // 동일한 키(name)값으로
    // 1. 만료날짜 과거로 쿠키저장
    // 2. 만료날짜 설정 않는다. 
    //    브라우저가 닫힐 때 제명이 된다    

    var date = new Date(); // 오늘 날짜 
    var validity = -1; 
    date.setDate(date.getDate() + validity);
    document.cookie = cKey + "=;path=/;expires=" + date.toGMTString();
}

function GetCookie(cKey) {
    var allcookies = document.cookie;  
    var cookies = allcookies.split("; ");
    for (var i = 0; i < cookies.length; i++) {
        var keyValues = cookies[i].split("=");
        if (keyValues[0] == cKey) {
            return unescape(keyValues[1]);
        }   
    }   
    return ""; 
}
function Toggle(id)
{
    $('#'+id).toggle();
}
function MyCheckNumber(obj)
{
	var num = obj.value;
	var newval = $.trim(num).replace(/\D/g, '');
	obj.value = newval;
}
function MyCheckNumberLimit(obj,p1,p2)
{
	var num = obj.value;
	var newval = $.trim(num).replace(/\D/g, '');
	if( newval < p1 ) newval = p1;
	if( newval > p2 ) newval = p2;
	obj.value = newval;
}
