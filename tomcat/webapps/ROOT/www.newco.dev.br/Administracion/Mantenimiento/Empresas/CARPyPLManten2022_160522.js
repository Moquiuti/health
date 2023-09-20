//	JS Mantenimiento de carpetas y plantillas de un usuario. Nuevo disenno 2022.
//	Ultima revision: ET 16may22 12:07 CARPyPLManten2022_160522.js


/*
   recorro todos las carpetas y todas las plantillas, 
   para cada carpeta si TODOS las plantillas tienen permisos guardo
   en un hidden <ACCION>_TODOS_<ID> el valor true, esto es para cuando se pulse el link "Todas"
   saber que accion tiene que realizar dar o quitar privilegios
*/

function inicializarDerechosPorPlantilla(form){
  for(i=0;i<arrayPlantillas.length;i++){
    var tienePermisosLect=1;
    var tienePermisosEscr=1;
    for(j=1;j<arrayPlantillas[i].length;j++){
      if(form.elements['LECT_'+arrayPlantillas[i][j]].checked==false)
        tienePermisosLect=0;
      if(form.elements['ESCR_'+arrayPlantillas[i][j]].checked==false)
        tienePermisosEscr=0;   
    }
    
	//16may22  form.elements['LECT_TODOS_'+arrayPlantillas[i][0]].value=tienePermisosLect;
    //16may22  form.elements['ESCR_TODOS_'+arrayPlantillas[i][0]].value=tienePermisosEscr;
  }
}


/*

  si es un check de plantilla recibe la acion LECT / ESCR, el ID de la plantilla, y a quien afecta 'ESTE'   
  si es un check de carpeta recibe la acion LECT / ESCR, el ID de la carpeta, y a quien afecta 'CARPETA'
      afecta a la carpeta y a las plantillas que contiene
      actualizamos el valor de la siguiente accion a realizar con el valor del check

  si es un link (Todas) recibe la accion LECT / ESCR, el ID de la carpeta, y a quien afecta 'TODOS'
     afecta solo a las plantillas no a las carpetas
     el valor de la siguiente accion a realizar se va alternando ==> dar / quitar


*/

function validacionEscrituraLectura(accion,id,tipo,form){

  // ESTE 
  if(tipo=='ESTE'){
    if(accion=='LECT'){
      if(form.elements[accion+'_'+id].checked==false){
        //if(form.elements['ESCR_'+id].disabled==false){
          form.elements['ESCR_'+id].checked=false;
        //}
      }
    }
    else{
      if(form.elements[accion+'_'+id].checked==true){
        if(form.elements['LECT_'+id].disabled==false){
          form.elements['LECT_'+id].checked=true;
        }
      } 
    }
  }
  else{
    if(tipo=='TODOS' || tipo=='CARPETA'){
      /*  
      afecta a TODOS / CARPETA 

       la primera parte de este bloque es comun
       en la segunda, guardar la siguiente accion a realizar, diferenciamos
       entre los casos

      */ 
      var posicionDeLaCarpeta=0;

      /*
        obtengo la posicion de la carpeta en el array
      */

      for(var n=0;n<arrayPlantillas.length;n++){
        if(arrayPlantillas[n][0]==id){
          posicionDeLaCarpeta=n;
        }
      }


       /*
        solo tipo='CARPETAS' 

        si es un check de carpeta, actualizamos la accion a realizar con el valor que queremos realizar ahora, 
        mas adelante, antes de salir de la funcion actualizamos con la accion a realizar la siguiente 
        vez que entremos en la funcion.

      */

      /*if(tipo=='CARPETA'){
        if(form.elements[accion+'_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked==true){
          form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0;
          if(accion=='LECT'){
            alert('mi');
            form.elements['ESCR_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0; 
          }
        }
        else{
          form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;
          if(accion=='ESCR'){
          alert('maaaa');
            form.elements['LECT_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;         
          }
        }
      }*/



      /*
        para todas las plantillas

      */
      if(tipo=='TODOS'){
        for(var i=1;i<arrayPlantillas[posicionDeLaCarpeta].length;i++){
          if(form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value==1){
            if(form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false){
              form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=false;
            }
          }
          else{
            if(form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false){
              form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=true;
              //if(form.elements['LECT_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked==false && form.elements[accion+'_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].disabled==false){
              //  form.elements['LECT_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked=true;
              //}
            }
          }

       /*
          miramos que no haya conflictos con los derechos lectura / escritura
             si no puede leer tampoco puede escribir
             si puede escribir puede leer
       */   

          if(accion=='LECT' && form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked==false){
            //if(form.elements['ESCR_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false)
              form.elements['ESCR_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=false;
          }
          else{
            if(accion=='ESCR' && form.elements[accion+'_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked==true){
              if(form.elements['LECT_'+arrayPlantillas[posicionDeLaCarpeta][i]].disabled==false)
                form.elements['LECT_'+arrayPlantillas[posicionDeLaCarpeta][i]].checked=true;
              //form.elements['LECT_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked=true;
            }
          }
        }
      }

      if(tipo=='CARPETA'){
        if(accion=='LECT'){
          if(form.elements[accion+'_TODOS_CHK_'+id].checked==false){
            //if(form.elements['ESCR_TODOS_CHK_'+id].disabled==false)
              form.elements['ESCR_TODOS_CHK_'+id].checked=false;
          }
        }
        else{
          if(form.elements[accion+'_TODOS_CHK_'+id].checked==true){
            if(form.elements['LECT_TODOS_CHK_'+id].disabled==false)
              form.elements['LECT_TODOS_CHK_'+id].checked=true;
          } 
        }
      }


      /*
          guardamos la siguiente accion a realizar al pulsar el link "Todos" o Check CARPETA
                 dar / quitar alternativamente      
      */




      if(tipo=='TODOS'){
        if(form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value==1){
          form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0;
          if(accion=='LECT')
            form.elements['ESCR_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0; 
        }
        else{
          form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;
          if(accion=='ESCR')
            form.elements['LECT_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;         
        }
      }
     /* else{
        if(form.elements[accion+'_TODOS_CHK_'+arrayPlantillas[posicionDeLaCarpeta][0]].checked==false){
          form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0;
          if(accion=='LECT')
            form.elements['ESCR_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=0; 
        }
        else{
          form.elements[accion+'_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;
          if(accion=='ESCR')
            form.elements['LECT_TODOS_'+arrayPlantillas[posicionDeLaCarpeta][0]].value=1;         
        }
      }*/
    }
    else{

      /*
        carpetas y plantillas
      */


     /*
       obtenemos la accion a realizar ahora. recorremos todos los check
       si alguno esta desactivado la accion es dar derechos. Si todos estan activados
       la accion es quitar derechos
     */

     var accionARealizar

     if(form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value==''){
       form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value=obtenerAccionARealizar(accion,form);
     }

     accionARealizar=form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value;

     for(var n=0;n<form.length;n++){
       if(form.elements[n].type=='checkbox'){
         if(form.elements[n].name.substring(0,4)==accion){
           if(accionARealizar==0){
             if(form.elements[n].disabled==false){
               form.elements[n].checked=false;
               if(accion=='LECT'){
                 form.elements['ESCR'+form.elements[n].name.substring(4,form.elements[n].name.length)].checked=false;
               }
             }

           }
           else{
             if(form.elements[n].disabled==false){
               form.elements[n].checked=true;
               if(accion=='ESCR'){
                 form.elements['LECT'+form.elements[n].name.substring(4,form.elements[n].name.length)].checked=true;
               }
             }
           }
         }
       }
     }

         /* 

         asignamos la siguiente accion a realizar a nivel de ABSOLUTAMENTE_TODOS  
         y tenemos en cuenta los derechos de escritura / lectura

         */

     if(accionARealizar==0){
       form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value=1;
       if(form.elements['LECT_ABSOLUTAMENTE_TODOS'].value==1) 
         form.elements['ESCR_ABSOLUTAMENTE_TODOS'].value=1;
     } 
     else{
       form.elements[accion+'_ABSOLUTAMENTE_TODOS'].value=0; 
        if(form.elements['ESCR_ABSOLUTAMENTE_TODOS'].value==0) 
          form.elements['LECT_ABSOLUTAMENTE_TODOS'].value=0;
     }

     /* para cada bloque de plantillas tambien hemos de actualizar con la siguiente accion a realizar */

     for(var n=0;n<form.length;n++){
       //if(form.elements[n].type=='checkbox'){
         if(form.elements[n].name.substring(5,10)=='TODOS' && form.elements[n].name.substring(11,14)!='CHK'){
           if(form.elements[n].name.substring(0,4)=='LECT'){
             if(form.elements['LECT_ABSOLUTAMENTE_TODOS'].value==0)
               form.elements[n].value=1;
             else
               form.elements[n].value=0;
           }
           else{
             if(form.elements[n].name.substring(0,4)=='ESCR'){
               if(form.elements['ESCR_ABSOLUTAMENTE_TODOS'].value==0)  
                 form.elements[n].value=1;
               else
                 form.elements[n].value=0;
             }  
           }
         }
       //}
     }


    }
  }

}


function obtenerAccionARealizar(accion, form){
  for(var n=0;n<form.length;n++){
    if(form.elements[n].type=='checkbox'){
      if(form.elements[n].name.substring(0,4)==accion){
        if(form.elements[n].checked==false){
          return 1;
        }
      }
    }
  }
  return 0;
}	


function ValidaySubmit()
{

	var formu=document.forms[0];
	var id;
	var cadenaDerechosCarpetas='';
	var cadenaDerechosPlantillas='';
	var lectura;
	var escritura;

	//	16may22 La cadena de derechos de carpetas solo sera para proveedores
	cadenaDerechosCarpetas=IDCarpetaProvs+'|S|N#';

	for(var i=0;i<formu.length;i++){
	  	if(formu.elements[i].value=='PLANTILLA_LECT'){
    		id=obtenerId(formu.elements[i].name);
    		if(formu.elements['LECT_'+id].checked==true){
    		  lectura='S';
    		}
    		else{
    		  lectura='N';
    		}

    		if(formu.elements['ESCR_'+id].checked==true){
    		  escritura='S';
    		}
    		else{
    		  escritura='N';
    		} 
			if ((lectura!=formu.elements['LECT_ORIG_'+id].value)||(escritura!=formu.elements['ESCR_ORIG_'+id].value))
        		cadenaDerechosPlantillas+=id+'|'+lectura+'|'+escritura+'#';
	  }
	/*  16may22
	else{
    	if(formu.elements[i].value=='CARPETA_LECT'){
    	  id=formu.elements[i].name.substring(15,formu.elements[i].name.length);
    	  if(formu.elements['LECT_TODOS_CHK_'+id].checked==true){
        	lectura='S';
    	  }
    	  else{
        	lectura='N';
    	  }

    	  if(formu.elements['ESCR_TODOS_CHK_'+id].checked==true){
        	escritura='S';
    	  }
    	  else{
        	escritura='N';
    	  } 
		 if ((lectura!=formu.elements['LECT_TODOS_ORIG_'+id].value)||(escritura!=formu.elements['ESCR_TODOS_ORIG_'+id].value))
        	cadenaDerechosCarpetas+=id+'|'+lectura+'|'+escritura+'#';
    	}
	  }*/
	}

	formu.elements['DERECHOSPLANTILLAS'].value=cadenaDerechosPlantillas;
	formu.elements['DERECHOSCARPETAS'].value=cadenaDerechosCarpetas;

	//solodebug	alert('CarpyPLMante. cadenaDerechosPlantillas:'+cadenaDerechosPlantillas+ 'cadenaDerechosCarpetas:'+cadenaDerechosCarpetas);

	jQuery("#ACCION").val("MODIFICAR");
	SubmitForm(formu);
}

//16may22 Marca todos los checks de lectura
function TodosLectura()
{
	var formu=document.forms[0];
	var activado='N';
	var Marcar;
	for(var i=0;i<formu.length;i++)
	{
	  	if(formu.elements[i].value=='PLANTILLA_LECT')
		{
    		var id=obtenerId(formu.elements[i].name);
			if (activado=='N')
			{
				Marcar=(formu.elements['LECT_'+id].checked)?false:true;
				activado='S';
			}
			if(formu.elements['LECT_'+id].checked!=Marcar) formu.elements['LECT_'+id].checked=Marcar;
		}
	}
}














