//	JS para el mantenimiento de comentarios
//	Ultima revision ET 17may22 10:15 UltimosComentarios2022_170522.js

function Inicio()
{
	//	Muestra el bot�n de copiar comentario si est� definido el destino de la copia
	if (document.forms['form1'].elements['NOMBRE_FORM'].value!='') jQuery('.btnCopiar').show();
}

function CerrarVentana()
{

	var nombreFormRemoto=document.forms['form1'].elements['NOMBRE_FORM'].value;
    var nombreObjetoRemoto=document.forms['form1'].elements['NOMBRE_OBJETO'].value;

	var objFrameTop=new Object();    
    objFrameTop=window.opener.top;

    var FrameOpenerName=window.opener.name;
    var objFrame=new Object();

    objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
    window.close();
    objFrame.document.forms[nombreFormRemoto].elements[nombreObjetoRemoto].focus();
}

function copiarComentarios(IDComentario){
    var objFrameTop=new Object();    

    objFrameTop=window.opener;		//opener: AreaTrabajo

	if (objFrameTop.name=='areaTrabajo')
	{
		var texto=document.forms['form1'].elements['COMENTARIO_'+IDComentario].value;
		var objeto=document.forms['form1'].elements['NOMBRE_OBJETO'].value;

		//console.log('copiarComentarios. Opener:'+objFrameTop.name+' nombre objeto:'+objeto+ ' enviando texto:'+texto);

        objFrameTop.copiarComentarios(objeto,texto.replace(/\\n/g,String.fromCharCode(13,10)));
	}
	//solodebug else console.log('copiarComentarios. Opener:'+objFrameTop.name);

}



function existeElComentario(comentario){
var coment=comentario;
for(var n=0;n<document.forms['form1'].length;n++){
  if(document.forms['form1'].elements[n].type=='hidden' && document.forms['form1'].elements[n].name.substring(0,11)=='COMENTARIO_'){
	if(document.forms['form1'].elements[n].value.trim()==comentario.replace(/\n/g,'\\\\n').trim()){
	  return 1;
	}
  }
}
return 0;
}


function GuardarComentario(form, accion)
{

	document.forms['form1'].elements['COMENTARIO'].value=ScapeHTMLString(document.forms['form1'].elements['NUEVO_COMENTARIO'].value);		//	11oct20 formato HTML para enviar caracteres especiales   

	//solodebug	console.log('GuardarComentario: CLAUSULALEGAL:'+document.forms['form1'].elements['CLAUSULALEGAL'].value);

	if(document.forms['form1'].elements['COMENTARIO'].value.trim()==''){
	  alert(document.forms['MensajesJS'].elements['SIN_COME_PARA_GUARDAR'].value);
	}
	else{
	  if(!existeElComentario(document.forms['form1'].elements['COMENTARIO'].value)){
		form.elements['ACCION'].value=accion;
		SubmitForm(form);
	  }
	  else{
		alert(document.forms['MensajesJS'].elements['COME_YA_EXISTE'].value);
	  }
	}
}


function BorrarComentarios(form, accion)
{
	var cambios='';
	var existe=0;
	for(var n=0;n<form.length;n++){
	  if(form.elements[n].type=='checkbox' && form.elements[n].name.substring(0,14)=='CHKCOMENTARIO_'){
		existe=1;
		if(form.elements[n].checked==true){
        	var id = form.elements[n].name.split('_');
    		cambios+=id[1]+'|'+'dedededed'+'#';
		}
	  }
	}

    if(cambios==''){
      if(!existe){
        alert(document.forms['MensajesJS'].elements['NO_COME_PARA_BORRAR'].value);
      }
      else{
        alert(document.forms['MensajesJS'].elements['COME_PARA_BORRAR'].value);
      }
    }
    else{
      if(confirm(document.forms['MensajesJS'].elements['COME_SEL_BORRAR'].value))
	  {
		form.elements['CAMBIOS'].value=cambios;
		form.elements['ACCION'].value=accion;
		SubmitForm(form);
	  }
	}
}


function GuardarDefecto(form){

    var lung = document.forms['form1'].length;
    var Defecto='';
    var cadenaCome= '';

	form.elements['ACCION'].value='GUARDARPORDEFECTO';			//11oct21
	
	
    for(var i=1; i<lung; i++)
	{
        var formName=form.elements[i].name;

        if (formName.match('CHKDEFECTO')) 
		{
            //alert(form.elements[i].name);
            cadenaCome
            if (form.elements[i].checked==true)
			{
                cadenaCome += form.elements[i].id+'#S|';
            }
            else
			{
                cadenaCome += form.elements[i].id+'#N|';
            }
        }
    } 
	var lunCadena = cadenaCome.length;
	var OkCadenaCome = cadenaCome.substr(0,(lunCadena-1));
	form.elements['DEFECTO_SEL'].value=OkCadenaCome;
	SubmitForm(form);
}


//	20ago18 Cambio de centro para manten comentarios
function CambioCentro()
{
	document.forms['form1'].elements['IDCENTRO'].value=document.forms['form1'].elements['IDCENTROCLIENTE'].value;	   
	SubmitForm(document.forms['form1']);
}


//	18feb21 Cambio en el checkbox "clausula lega"
function ClausulaLegalChange()
{
	console.log('ClausulaLegalChange:'+(document.forms['form1'].elements['chkCLAUSULALEGAL'].checked)?'S':'N');
	if (document.forms['form1'].elements['chkCLAUSULALEGAL'].checked)
	{
		document.forms['form1'].elements['chkINCLUIRSIEMPRE'].checked=false;
		document.forms['form1'].elements['chkINCLUIRSIEMPRE'].disabled=true;
		document.forms['form1'].elements['INCLUIRSIEMPRE'].value='N'
		document.forms['form1'].elements['CLAUSULALEGAL'].value='S';
	}
	else
	{
		document.forms['form1'].elements['chkINCLUIRSIEMPRE'].disabled=false;
		document.forms['form1'].elements['CLAUSULALEGAL'].value='N';
	}
}

//	7oct21 Cambio en el checkbox "incluir siempre"
function IncluirSiempreChange()
{
	console.log('IncluirSiempreChange:'+(document.forms['form1'].elements['chkINCLUIRSIEMPRE'].checked)?'S':'N');
	if (document.forms['form1'].elements['chkINCLUIRSIEMPRE'].checked)
	{
		document.forms['form1'].elements['chkCLAUSULALEGAL'].checked=false;
		document.forms['form1'].elements['chkCLAUSULALEGAL'].disabled=true;
		document.forms['form1'].elements['CLAUSULALEGAL'].value='N';
		document.forms['form1'].elements['INCLUIRSIEMPRE'].value='S'
	}
	else
	{
		document.forms['form1'].elements['chkCLAUSULALEGAL'].disabled=false;
		document.forms['form1'].elements['INCLUIRSIEMPRE'].value='N';
	}
}



