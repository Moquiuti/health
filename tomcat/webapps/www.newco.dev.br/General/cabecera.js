// JavaScript Document
		//estilo desde cookie
function cogeStyle(){
	if (document.getElementById("logoPage")){
		//alert('mi');
		var k= window.parent.frames[0].document.styleSheets[0].href;
		SetCookie('STYLE',k);
	}
}
				
			//js de cabeceraHTML.xsl
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
        	    }

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
			
 