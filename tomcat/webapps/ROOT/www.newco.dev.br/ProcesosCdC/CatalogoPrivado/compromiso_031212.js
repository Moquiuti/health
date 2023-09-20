//	ültima revisión: 11jun12

//enseño o no los botones de quitar compromiso o de compromiso
function verBoton(val)
{
	if (val == 'QUITAR'){
		document.getElementById('botonQuitarCompromiso').style.display = 'block';
		document.getElementById('comeQuitarCompromiso').style.display = 'block';
		document.getElementById('botonConfirmarCompromiso').style.display = 'none';
		}
	if (val == 'SEL'){
		document.getElementById('botonConfirmarCompromiso').style.display = 'block';
		document.getElementById('botonQuitarCompromiso').style.display = 'none';
		document.getElementById('comeQuitarCompromiso').style.display = 'none';
		}
}


//	Envía el formulario
function Enviar()
{
	//alert(document.forms[0].elements["ACCION"].value+':'+document.forms[0].elements["PARAMETROS"].value);
	SubmitForm(document.forms[0]);
}


//	Nueva entrada de seguimiento
function ConfirmarCompromiso()
{
	document.forms[0].elements["ACCION"].value='COMPROMISOS';
	
	var Lista='';
	
	//	Recorremos los checkboxes concatenando los que estén activos
	for  (var i=0; i < document.forms[0].elements.length; i++)
	{
		if (Piece(document.forms[0].elements[i].name,'_',0)=='CK-COMPROMISO')
			if (document.forms[0].elements[i].checked==true)
				Lista=Lista+Piece(document.forms[0].elements[i].name,'_',1)+'|'
	}
	
	document.forms[0].elements["PARAMETROS"].value=Lista;

	//alert(Lista);
	Enviar();
}


//	Nueva entrada de seguimiento
function QuitarCompromisos()
{
	document.forms[0].elements["ACCION"].value='QUITAR';
	
	var Lista='';
	
	//	Recorremos los checkboxes concatenando los que estén activos
	for  (var i=0; i < document.forms[0].elements.length; i++)
	{
		if (Piece(document.forms[0].elements[i].name,'_',0)=='CK-QUITARCOMPROMISO')
			if (document.forms[0].elements[i].checked==true)
				Lista=Lista+Piece(document.forms[0].elements[i].name,'_',1)+'|'
	}
	
	document.forms[0].elements["PARAMETROS"].value=Lista;
	//alert(Lista);
	if (document.forms[0].elements['COMENTARIOS'].value != ''){ Enviar(); }
	else {alert('Tiene que informar el motivo de la de-selección'); }
	
	
}


//	Marca o desmarca todos los checks de "selección" de una subfamilia
function MarcarSubfamilia(IDSubfamilia)
{
	
	var Activar='?';
	
	//	Recorremos los checkboxes concatenando los que estén activos
	for  (var i=0; i < document.forms[0].elements.length; i++)
	{
		if ((Piece(document.forms[0].elements[i].name,'_',0)=='CK-COMPROMISO')&&(Piece(document.forms[0].elements[i].name,'_',2)==IDSubfamilia))
		{
			if (Activar=='?')
			{
				if (document.forms[0].elements[i].checked==true) 
					Activar=false;
				else 
					Activar=true;
			}
		
			document.forms[0].elements[i].checked=Activar;
		}
	}
}



//	Marca o desmarca todos los checks de "quitar selección" de una subfamilia
function MarcarSubfamiliaQuitar(IDSubfamilia)
{
	
	var Activar='?';
	
	//	Recorremos los checkboxes concatenando los que estén activos
	for  (var i=0; i < document.forms[0].elements.length; i++)
	{
		if ((Piece(document.forms[0].elements[i].name,'_',0)=='CK-QUITARCOMPROMISO')&&(Piece(document.forms[0].elements[i].name,'_',2)==IDSubfamilia))
		{
			if (Activar=='?')
			{
				if (document.forms[0].elements[i].checked==true) 
					Activar=false;
				else 
					Activar=true;
			}
		
			document.forms[0].elements[i].checked=Activar;
		}
	}
}





