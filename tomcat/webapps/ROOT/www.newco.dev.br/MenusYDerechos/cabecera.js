// JavaScript Document
				
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
                        var browserName=navigator.appName; 
                        if (browserName=="Microsoft Internet Explorer") { 
                            jQuery(".menuBox a").css('font-size','16px');
                            jQuery(".menuBox a").css('font-family','Arial');
                            jQuery(".menuBox a").css('font-weight','bold');
                            jQuery(".menuBox a").css('padding-left','7px');
                            jQuery(".menuBox a").css('padding-right','7px');
                            jQuery(".menuBox a").css('padding-top','7px');
                            jQuery(".menuBox a").css('padding-bottom','7px');
                            
                            jQuery(".nombreCentro").css('font-size','12px');
                            jQuery(".nombreCentro").css('font-family','Arial');
                            
                            jQuery(".menu").css('padding-top','8px');
                            jQuery(".menu").css('padding-left','0px');
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
			
 