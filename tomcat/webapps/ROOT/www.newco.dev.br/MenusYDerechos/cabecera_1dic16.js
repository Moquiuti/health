// JavaScript Document
// Revisado ET 18ago16 11:38
// Revisado PS 17nov16 09:26
//	Ultima revisión: 19dic16 15:43

//js de cabeceraHTML.xsl
/*
function CatalogoPrivado(){
  var objFrame=new Object();
  objFrame=obtenerFrame(top,'mainFrame');
  objFrame.location.href='http://www.newco.dev.br/ProcesosCdC/CatalogoPrivado/Unica.htm';
}

function comprobarResolucion(){
	var ancho=screen.width;
	if(parseInt(ancho)<1024){
		MostrarAlerta('Aviso','ALT-0020');
	}

    var browserName=navigator.appName; 
    //alert('mi '+browserName);
    if (browserName=="Microsoft Internet Explorer") { 
        jQuery(".menuBox a").css('font-size','16px');
        jQuery(".menuBox a").css('font-size','16px');
        jQuery(".menuBox a").css('font-family','Arial');
        jQuery(".menuBox a").css('font-weight','bold');
        jQuery(".menuBox a").css('padding-left','7px');
        jQuery(".menuBox a").css('padding-right','7px');
        jQuery(".menuBox a").css('padding-top','7px');
        jQuery(".menuBox a").css('padding-bottom','7px');

        jQuery(".nombreCentro").css('font-size','12px');
        jQuery(".nombreCentro").css('font-family','Arial');
        jQuery(".usuario").css('margin-top','4px');

        jQuery(".menu").css('padding-top','8px');
        jQuery(".menu").css('padding-left','0px');
    }//fin de if browsername
    else if (/MSIE (\d+\.\d+);/.test(navigator.userAgent)){ //test for MSIE x.x;
        var ieversion=new Number(RegExp.$1) // capture x.x portion and store as a number
        if (ieversion>=5){
                //alert(ieversion);
                jQuery(".menuBox a").css('font-size','16px');
                jQuery(".menuBox a").css('font-family','Arial');
                jQuery(".menuBox a").css('font-weight','bold');
                jQuery(".menuBox a").css('padding-left','7px');
                jQuery(".menuBox a").css('padding-right','7px');
                jQuery(".menuBox a").css('padding-top','7px');
                jQuery(".menuBox a").css('padding-bottom','7px');

                jQuery(".nombreCentro").css('font-size','12px');
                jQuery(".nombreCentro").css('font-family','Arial');
                jQuery(".usuario").css('margin-top','4px');

                jQuery(".menu").css('padding-top','8px');
                jQuery(".menu").css('padding-left','0px');
        }                          
   }//fin else if ieversion

}
*/
/* PS 17nov16
function PresentaFrames()
{
  var Msg='Mostrando los frames '+window.parent.name+'\n';
  for (j=0;j<window.parent.frames.length;j++)
  {
        Msg=Msg+'Form '+j+':'+window.parent.frames[j].name+'\n';			
	  for (k=0;k<window.parent.frames[j].frames.length;k++)
	  {
        	Msg=Msg+'Form '+k+':'+window.parent.frames[j].frames[k].name+'\n';			
	  }  
  }  
  alert (Msg);    
}

function existeFrame(NombreFrame)
{
	var Res=false;
	for (j=0;j<window.parent.frames.length;j++)
	{
		if (window.parent.frames[j].name==NombreFrame)
			Res=true;
		else		
		  for (k=0;k<window.parent.frames[j].frames.length;k++)
		  {
        	if (window.parent.frames[j].frames[k].name==NombreFrame)
				Res=true;			
		  }  
	}  
	return(Res);    
}
*/
//	Imprime el frame interno (hay que tener cuidado pues puede tener nombres diferentes
function imprimir()
{
	//PresentaFrames();
	if (existeFrame('areaTrabajo'))
	{
		window.parent.mainFrame.areaTrabajo.print();	
		//window.print();	
	}
	else
		if (existeFrame('Trabajo'))
		{
			window.parent.mainFrame.Trabajo.print();	
			//window.print();	
		}
		else
		{
			window.parent.mainFrame.print();	
			//window.print();	
		}
}

function getCookie2(name){
	var cookies = document.cookie.split(';');
	for(var i=0; i<cookies.length; i++){
		cookie = cookies[i].split('=');
		if(jQuery.trim(cookie[0]) == jQuery.trim(name)){
			if(cookie.length==2)
				return jQuery.trim(cookie[1]);
			else
				return '';
		}
	}
	return '';
}

//	Cierra la sesión, vuelve a la página de inicio
function CerrarSesion(){
    
    //caduco cookie cuando cierro sesion
    if(getCookie2('SES_ID')!='')
            document.cookie = 'SES_ID=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';
    if(getCookie2('US_ID')!='')
            document.cookie = 'US_ID=; path=/; host=' + location.hostname + ';expires=Thu, 01 Jan 1970 00:00:01 GMT';

    //	19dic16	Volvemos a la página de inicio
    window.parent.location.href='http://www.newco.dev.br/index.xsql';
       
}
