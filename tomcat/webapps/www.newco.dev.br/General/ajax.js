var XMLHttpFactories = [
	function() { return new XMLHttpRequest() },
	function() { return new ActiveXObject("Msxml2.XMLHTTP") },
	function() { return new ActiveXObject("Msxml3.XMLHTTP") },
	function() { return new ActiveXObject("Microsoft.XMLHTTP") }
];


function sendRequest(url, callback, postData, params) {
	var cache = new Date().getTime();
	var req = createXMLHTTPObject();
	if (!req) return;
	var method = (postData) ? "POST" : "GET";
	req.open(method, url, true);
  	req.setRequestHeader("User-Agent", "XMLHTTP/1.0");
	if (postData) {
		postData += '&date=' + cache;
		req.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8");
	}
	req.onreadystatechange = function () {
		if (req.readyState != 4) return;
		if (req.status != 200 && req.status != 304) {
			alert('HTTP error ' + req.status);
			return;
		}
		if (params && params.length > 0)
			callback(req, params);
		else
			callback(req);
	}
	if (req.readyState == 4) return;
	req.send(postData);
}


function createXMLHTTPObject() {
	var xmlhttp = false;
	for (var i=0; i < XMLHttpFactories.length; i++) {
		try {
			xmlhttp = XMLHttpFactories[i]();
		}
		catch (e) {
			continue;
		}
		break;
	}
	return xmlhttp;
}


function handleRequest(req) {
	var response = req.responseText.evalJSON();
	// var writeroot = [some element];
	// writeroot.innerHTML = req.responseText;
	return true;
}

function handleFormRequest(req,params) {
	var num = new String(''); 
	num=params;
	
	//se no exsiste =>ok, si no es el push de liquidaciones
	if (!document.getElementById("push")){
		var innerText = new String(''); 
		if (req.responseText.substr(0, 1) != '{' && req.responseText.substr(0, 1) != '[') {
			innerText += '<p>Se ha producido un error, si se repite por favor contacta con</p>';
			//innerText += '<a href="mailto:tecnico@' + location.hostname.replace('www.','') + '?subject=JSON%20Error">tecnico@' + location.hostname.replace('www.','') + '</a>';
		}
		else {
			var response = eval('(' + req.responseText + ')');	
			// innerText += (response.title != '') ? '<p>' + response.title + '</p><p>&nbsp;</p>' : '';
			innerText += (response.message != '') ? '<p>' + response.message + '</p>' : '';
			if (response.recomendacion){
				if (response.recomendacion.texto) innerText+='<p><strong>' + response.recomendacion.texto;
				if (response.recomendacion.urlRecomendado) innerText+='<a href="'+response.recomendacion.urlRecomendado+'">' + response.recomendacion.NombreRecomendado + '</a></strong></p>';
				else {innerText+='</strong></p>'}
			}
			if (document.getElementById("push") || document.getElementById("manForo") || document.getElementById("nuevoForo")){ }
			else{
			innerText += (response.error != '') ? '<p>&nbsp;</p><p>' + response.error + '</p>' : '';
			innerText += (response.email != '') ? '<a href="mailto:' + response.email + '">' + response.email + '</a>' : '';
			}
			if (response.message == 'Muchas gracias por incluir tu comentario sobre este anuncio' && response.comment) {			
				insertNewComment(response.comment);
			}	
		}
	}
	else{
		
		var innerText = new String(''); 
		var response = eval('(' + req.responseText + ')');	
		//alert('response '+response);
		innerText += (response.message != '') ? '<p style="margin:0px 0px 0px 30px; color:#000000; font-weight:bold; width:auto;">' + response.message + '</p>' : '';		
		document.getElementById('pushButton').style.display='block';
	}
	if (document.getElementById('waitImage')) document.getElementById('waitImage').style.display = 'none';
	if (document.getElementById('waitText')) document.getElementById('waitText').innerHTML = innerText;
	if (document.getElementById('sendMessageReceive')) document.getElementById('sendMessageReceive').innerHTML = innerText;
	if (document.getElementById('sendOfferReceive')) document.getElementById('sendOfferReceive').innerHTML = innerText;
	
	// Para Colaboradores y Especialistas de MatS
	if (num){
		if (document.getElementById('colab_'+num) && document.getElementById('colab_'+num).style.display == 'block'){
			if (document.getElementById('waitImageC_'+num)) document.getElementById('waitImageC_'+num).style.display = 'none';
			if (document.getElementById('waitTextC_'+num)) document.getElementById('waitTextC_'+num).innerHTML = innerText;
		}
		if (document.getElementById('espec_'+num) && document.getElementById('espec_'+num).style.display == 'block'){
			if (document.getElementById('waitImageE_'+num)) document.getElementById('waitImageE_'+num).style.display = 'none';
			if (document.getElementById('waitTextE_'+num)) document.getElementById('waitTextE_'+num).innerHTML = innerText;
		}
	}
		
	
	return true;	
}

function insertNewComment(comment) {
	
	if (!document.getElementById("commentBox")) {
		var AFB = document.getElementById("anuncioFurtherBox");
		var AF = document.createElement("div");
		var CB = document.createElement("div");
		Element.extend(AF);
		Element.extend(CB);
		AF.addClassName("anuncioFurther");
		AF.innerHTML = '<p>Opiniones sobre este anuncio:</p>';
		AF.hide();
		CB.setAttribute("id", "commentBox");
		AFB.insertBefore(CB, document.getElementById("commentLink"));
		AFB.insertBefore(AF, document.getElementById("commentBox"));
		new Effect.Appear(AF);
	}
	
	var commentBox = document.getElementById("commentBox");
	var AD = document.createElement("div");
	var ADStars = document.createElement("div");
	var ADTitle = document.createElement("div");
	var ADInfo = document.createElement("div");
	var ADText = document.createElement("div");
	Element.extend(AD);
	Element.extend(ADStars);
	Element.extend(ADTitle);
	Element.extend(ADInfo);
	Element.extend(ADText);
	AD.addClassName("anuncioDesc");
	AD.addClassName("comment");
	AD.hide();
	if (comment.value != '-1') {
		ADStars.addClassName("anuncioDescStars");
		ADStars.innerHTML = '<img src="http://www.paraelcole.com/Images/stars' + comment.value + '.gif"/>';
	}
	ADTitle.addClassName("anuncioDescTitle");
	ADTitle.innerHTML = '<p>' + comment.title + '&nbsp;</p>';
	ADInfo.addClassName("anuncioDescInfo");
	ADInfo.innerHTML = '<p>de <span class="strong">' + comment.name + '</span> el ' + comment.date + '</p>';
	ADText.addClassName("anuncioDescText");
	ADText.innerHTML = '<p>' + comment.text + '</p>';
	AD.appendChild(ADStars);
	AD.appendChild(ADTitle);
	AD.appendChild(ADInfo);
	AD.appendChild(ADText);
	commentBox.insertBefore(AD, commentBox.firstChild);
	// commentBox.scrollTo();
	new Effect.Appear(AD);

	return true;
}


function setSelects(id, type, value) {
	document.getElementById(id).disabled = true;
	if (isNaN(parseInt(value))) {
		document.getElementById(id).innerHTML = '<option value="">No iniciado</option>';
		return false;
	}
	document.getElementById(id).innerHTML = '<option value="">Loading ...</option>';
	var post = new String('');
	var params = new Array();
	
	switch (type) {
		case 'countries':
			break;
		case 'provinces':
			post = 'IDPAIS=' + value;
			break;
		case 'cities':
			post = 'IDPROVINCIA=' + value;
			break;
		default:
			break;
	}
	for (var i = 0; i < arguments.length; i++) {
		params[params.length] = arguments[i];
	}
	sendRequest("location.xsql", handleSelects, post, params);
	return false;
}


function handleSelects(req, params) {
	if (req.responseText.substr(0, 1) != '{' && req.responseText.substr(0, 1) != '[') {
		// innerText += '<p>Se ha producido un error, si se repite por favor contacta con</p>';
		// innerText += '<a href="mailto:tecnico@' + location.hostname.replace('www.','') + '?subject=JSON%20Error">tecnico@' + location.hostname.replace('www.','') + '</a>';
	}
	else {
		var resp = eval('(' + req.responseText + ')');
		var elem = document.getElementById(params[0]);
		var data;
		switch (params[1]) {
			case 'countries':
				data = resp.countries;
				break;
			case 'provinces':
				data = resp.provinces;
				break;
			case 'cities':
				data = resp.cities;
				break;
			default:
				break;
		}
		elem.innerHTML = '';
		for (var i = 0; i < data.length; i++) {
			var opt = document.createElement('option');
			opt.value = data[i].id;
			opt.innerHTML = data[i].name;
			elem.appendChild(opt);
		} 
		elem.disabled = false;
	}
	return true;
}

