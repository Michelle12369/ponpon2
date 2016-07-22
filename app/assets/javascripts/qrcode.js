var inputValue = $("#input");
var submitBtn = $("#submit");
// var refresh =$("#refresh");
function QRCode(content, width, height){
	// 預設寬高為 120x120
	width = !!width ? width : 120 ;
	height = !!height ? height : 120;
	// 編碼
	console.log (content);
	content = encodeURIComponent(content);
	return 'http://chart.apis.google.com/chart?cht=qr&chl=' + content + '&chs=' + width + 'x' + height;
}
window.onload = function(){
	submitBtn.on('click', function(){
		var msg = document.getElementById('content');
		// var msg = "https://i.nccu.edu.tw/Login.aspx?ReturnUrl=/Home.aspx";
		// var imgSrc = QRCode(msg.innerHTML, 240, 240);
		var imgSrc = QRCode(inputValue.val(), 240, 240);
		msg.innerHTML = '<img src="' + imgSrc + '" alt="" />';
	});
};
// refresh.on('click',function(){
// 	window.location.reload()
// });