// JavaScript Document
// 2-11-11
 	  var error='La clave nueva tiene que ser igual en clave nueva y repita clave';
	  var msgSinClave='La clave no puede estar en blanco.';
	  
	  function ValidaClave(){
            formu=document.forms[0];        
            
	    if(formu.elements['fClaveNueva'].value==''){
	      alert(msgSinClave);
	    }
	    else{
	      if(formu.elements['fClaveNueva'].value==formu.elements['fClaveNuevaRep'].value){

	        //SubmitForm(formu);

	        formu.method="post";
  			formu.action="CambioClaveSave.xsql";
	        SubmitForm(formu);
            }
	      else{

            }
	    }
	  }
      
	 