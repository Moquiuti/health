	function Submit(form){
	  if (form.LLP_CATEGORIA.selectedIndex <= 0){
	    form.LLP_CATEGORIA.value = -1;
	    form.LLP_FAMILIA.value = -1;
	    form.LLP_SUBFAMILIA.value = -1;	        	        
          } 
          else{
            form.LLP_CATEGORIA.value = form.LLP_CATEGORIA.options[form.LLP_CATEGORIA.selectedIndex].value;
            if (form.LLP_FAMILIA.selectedIndex <= 0){
	      form.LLP_FAMILIA.value = -1;
	      form.LLP_SUBFAMILIA.value = -1;	        	        
            }else{
              form.LLP_FAMILIA.value = form.LLP_FAMILIA.options[form.LLP_FAMILIA.selectedIndex].value;;            
              if (form.LLP_SUBFAMILIA.selectedIndex <= 0){
	        form.LLP_SUBFAMILIA.value = -1;	        	        
              }
              else{
                form.LLP_SUBFAMILIA.value = form.LLP_SUBFAMILIA.options[form.LLP_SUBFAMILIA.selectedIndex].value;;            
              }
            } 
          }
          SubmitForm(form);
	}
	
	//Seleccionamos en combo la opcion selecc
	function seleccionarCombo(combo, selecc){
	  for (i=1;i<combo.options.length;i++){	  
	    if (combo.options[i].value == selecc){
	      combo.selectedIndex = i;
	      break;  
	    }
          }
        }	
	
	//Anyadimos en el combo (sel) la opcion llamada 'text' con valor 'value' y sin seleccionar.
	function addOption(sel,text,value){
	  var defaultSelected = false;
	  var selected = false;	    
	  sel.options[sel.length] = new Option(text, value, defaultSelected, selected);
	} 

	//function deleteOption(sel,posicion) {
	//  sel.options[posicion] = null;
	//}
	function deleteOptions(Object){
	  for (var i=Object.options.length-1;i>0;i--){
	    Object.options[i] = null;
	  }   
	}
		
