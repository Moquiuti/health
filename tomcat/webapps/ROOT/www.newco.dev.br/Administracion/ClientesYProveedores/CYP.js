          var turno_clientes=1,turno_proveedores=1,turno_habituales=1;
       	  
           function ValidaUnSoloNumero(nota){
	        // ENSURE CHARACTER IS A DIGIT	     
	      numero = nota.value;
	      if (numero!=""){
	        if (numero < "0" || numero > "9") {
	          alert('Introduczca un valor númerico correcto');
	          nota.focus();
	          return (false);
	        } 
	        else{
	          return (true);
	        }
	      }
           }
           
           function ValidaTodosUnSoloNumero(){
             formu=document.forms[0];
	     var validar=0;           	
	     for (i=0; i<formu.length; i++){
	       if (formu.elements[i].name.substring(0,6)=='NOTAC_'){
	     	  if (ValidaUnSoloNumero(formu.elements[i])==false){
	     	    validar++;
	     	    break;
	     	  }
	       }
	     }
             if (validar==0) return (true);
             else return (false);         	
           }
           	  
	  //
	  //
	  // Construim la llista amb les dades de la pantalla:
	  //  (codi_empresa, Client?, Proveidor?, Habitual?, NotaQ)
	  //
	  // EMPR_?????????, ESCLI_????, ESPRV_????, ESPRH_?????, NOTAC_??????
	  //  
	  // Repasado por Olivier 22/06/2001

	  function ConstruirLlista (formu) {
	    var escli, esprv, esprh,notac;
	    var llista = 'buida';
	    
	    for (i=0; i<formu.length;i++) {
	       if (formu.elements[i].name.substr(0,4) == 'EMPR') { // buscamos un codigo de empresa
	            var codiempresa = formu.elements[i].name.substr(5);
	            // alert ('CodiEmpresa:'+codiempresa);
	            // Fem un bucle buscant les propietats de l''empresa        
	            escli = 'N';
	            esprv = 'N';
	            esprh = 'N';
	            notac = '-1';
	            
        	    if (formu.elements['ESCLI_'+ codiempresa].checked) escli = 'S';
        	    if (formu.elements['ESPRV_'+ codiempresa].checked) esprv = 'S';
        	    if (formu.elements['ESPRH_'+ codiempresa].checked) esprh = 'S';
        	        
        	    //Dejamos -1 cuando no se ha introducido nada
     
        	    if ((formu.elements['NOTAC_'+ codiempresa].value != '') && 
        	               (formu.elements['NOTAC_'+ codiempresa].value != ' ')&& 
        	               (formu.elements['NOTAC_'+ codiempresa].value != '  ')) {
        	           notac = formu.elements['NOTAC_'+ codiempresa].value;}
        	           
	            if (llista != 'buida') llista = llista + ",";
	            else llista = '';
	            llista = llista + "("+codiempresa+","+escli+","+esprv+","+esprh+","+notac+")";
	            
	       } // if EMPR
	    } // Bucle [i] 

           formu.elements['LISTAFINAL'].value=llista;
           
           //alert('Inicial:'+formu.elements['LISTAINICIAL'].value+'\nFinal:'+formu.elements['LISTAFINAL'].value);
	  }
	  
	  function PrimerTurno(){
	    PrimerTurnoProv();
	    PrimerTurnoProvHab();
	    PrimerTurnoClientes();
	  }	  
	  
	  function PrimerTurnoProv(){
              for (j=0; j<document.forms[0].elements.length;j++) {
                if (document.forms[0].elements[j].name.substr(0,6) == 'ESPRV_') {
        	  if (document.forms[0].elements[j].checked==false){
        	    turno_proveedores=0;
        	    break;
        	  }
	        }
	      }
	  }	  
	
	  function PrimerTurnoProvHab(){
              for (j=0; j<document.forms[0].elements.length;j++) {
                if (document.forms[0].elements[j].name.substr(0,6) == 'ESPRH_') {
        	  if (document.forms[0].elements[j].checked==false){
        	    turno_habituales=0;
        	    break;
        	  }
	        }
	      }
	  }
	  function PrimerTurnoClientes(){
              for (j=0; j<document.forms[0].elements.length;j++) {
                if (document.forms[0].elements[j].name.substr(0,6) == 'ESCLI_') {
        	  if (document.forms[0].elements[j].checked==false){
        	    turno_clientes=0;
        	    break;
        	  }
	        }
	      }
	  }	  
	
	  function SelHabituales(casilla){
	    if (casilla.checked==true){
	      identificador = casilla.name.substr(6,casilla.name.length-6);
	      casilla.form.elements['ESPRV_'+identificador].checked=true;
	    }
	  }
		  
	  function TodosClientes(formu){
	    if (turno_clientes == 0){
              for (j=0; j<formu.elements.length;j++) {
                if (formu.elements[j].name.substr(0,6) == 'ESCLI_') {
        	  formu.elements[j].checked=true;
	        }
	      }
	    }else{
              for (j=0; j<formu.elements.length;j++) {
                if (formu.elements[j].name.substr(0,6) == 'ESCLI_') {
        	  formu.elements[j].checked=false;
	        }
	      }	    
	    } 
	    turno_clientes=!turno_clientes;
	  }
	  
	  function TodosProveedores(formu){
	    if (turno_proveedores == 0){	  
              for (j=0; j<formu.elements.length;j++) {
                if (formu.elements[j].name.substr(0,6) == 'ESPRV_') {
        	  formu.elements[j].checked=true;
        	  formu.elements[j].focus=true;        	  
	        }
	      }
	    }else{
              for (j=0; j<formu.elements.length;j++) {
                if (formu.elements[j].name.substr(0,6) == 'ESPRV_') {
        	  formu.elements[j].checked=false;
	        }
	      }	    
	    }
	    turno_proveedores=!turno_proveedores;
	  }
	  	  
	  function TodosProveedoresHabituales(formu){
	    if (turno_habituales == 0){	  
              for (j=0; j<formu.elements.length;j++) {
                if (formu.elements[j].name.substr(0,6) == 'ESPRH_') {
        	  identificador = formu.elements[j].name.substr(6,formu.elements[j].name.length-6);
        	  formu.elements[j].checked=true;
        	  formu.elements['ESPRV_'+identificador].checked=true;
        	  turno_proveedores=1;        	  
	        }
	      }
	    }else{
              for (j=0; j<formu.elements.length;j++) {
                if (formu.elements[j].name.substr(0,6) == 'ESPRH_') {
        	  formu.elements[j].checked=false;
	        }
	      }	    
	    }
	    turno_habituales=!turno_habituales;
	  }
	  
 	  
