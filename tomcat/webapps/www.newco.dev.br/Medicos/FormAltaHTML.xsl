<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 |	
 |
 |	
 |	
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl"/>
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Formulario de alta de empresas</title>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
        <!--

          var msgError='', 
          msgErrorStd=' \n\nPor favor, corrija el error antes de enviar el formulario.';

          function validarFormulario(form){
		  	msgError='';
            for(var n=0;n<=form.length;n++){
			
              switch (n){	  
	        case 0:// titulo
	          var error='\'Titulo\'.';
	          if(form.elements[n].value==''){
	          msgError=msgError+'\n'+error;
                  }
	        break;  
		      	    	  
	        case 1:// cargo
	          var error='\'Cargo\'.';
	          if(form.elements[n].value==''){
	          		msgError=msgError+'\n'+error;
		  }
		break;       
	             
                case 2:// nombre 
	          var error='\'Nombre\'.';
	          if(validarNoNulo(form.elements[n])==false){
	          		msgError=msgError+'\n'+error;
	          }
	        break;
		  
	        case 3:// apellido 1
	          var error='\'Primer Apellido\'.';
	          if(validarNoNulo(form.elements[n])==false){
	          		msgError=msgError+'\n'+error;
	          }
	        break;
		  	  
		  
	        case 4:// apellido 2
	          var error='\'Segundo Apellido\'.';
	          if(validarNoNulo(form.elements[n])==false){
	          		msgError=msgError+'\n'+error;
	          }
	        break;
		  	  
	        case 5: // numero de colegiado 
	          var error='\'Número de colegiado\'.';
	          if(document.forms[0].elements[0].value.search('Dr.|H')==0 || 
	             document.forms[0].elements[0].value.search('Dra.|H')==0)
	            if(validarNoNulo(form.elements[n])==false)
	          		msgError=msgError+'\n'+error;
	        break;
	
	        case 6: // NIF
	          var error='\'NIF\'.';
	          if(validarNoNulo(form.elements[n])==false)
	          	msgError=msgError+'\n'+error;
	        break; 
 
	        case 7:// tipo centro
	          var error='\'Tipo de centro\'.';
	          if(form.elements[n].value==''){
	          	msgError=msgError+'\n'+error;
	          }
	        break;
		
                case 8:// nombre del centro
	          var error='\'Nombre\' del Centro Sanitario o Consulta privada';
	          if(validarNoNulo(form.elements[n])==false){
	          	msgError=msgError+'\n'+error;
	          } 
	        break; 
		  
                case 9: // NIF centro 
	          var error='\'NIF\' del Centro Sanitario o Consulta privada. ';
	          if(validarNoNulo(form.elements[n])==false)
	          	msgError=msgError+'\n'+error;
	        break;  
		    
	        case 10://telf fijo
	          var error='\'Teléfono\' del Centro Sanitario o Consulta privada.';
	          if(validarNoNulo(form.elements[n])==false)
	          	msgError=msgError+'\n'+error;
	        break;  
		  
	        case 11://fax		 
	        break;
		     
	        case 12://mail
                  var error='\'e-mail\'  del Centro Sanitario o Consulta privada.';
	          if(validarEsMail(form.elements[n])==false)
	          	msgError=msgError+'\n'+error;
	        break; 
		  
	        case 13://direccion
                  var error='\'Dirección\' del Centro Sanitario o Consulta Privada';
                  if(validarNoNulo(form.elements[n])==false){
	          	msgError=msgError+'\n'+error;
	          }
	        break; 
		  
	        case 14://poblacion 
	          var error='\'Población\' del Centro Sanitario o Consulta Privada';
                  if(validarNoNulo(form.elements[n])==false){
	          	msgError=msgError+'\n'+error;
	          }
	        break;
		   
	        case 15:// provincia
	          var error='\'Provincia\' del Centro Sanitario o Consulta privada';
                  if(form.elements[n].value==''){
	          	msgError=msgError+'\n'+error;
	          }
                break; 
			
	        case 16://cod postal
	          var error='\'Código postal\' del Centro Sanitario o Consulta privada.';
	          if(validarNoNulo(form.elements[n])==false)
	          	msgError=msgError+'\n'+error;
	        break;
	        
		  /***************
	        case 17://desplegable especialidad
                  var error='\'Especialidad\' del Centro Sanitario o Consulta privada.';
	          if(validarNoNulo(form.elements[form.elements[n].name+'_OTROS'])==false){
		    if(validarNoNulo(form.elements[n])==false){
	          	msgError=msgError+'\n'+error;
		    }
	          }
                break; 	  				
                ***********/
				
	        case 21://Como conocio MedicalVM
                  var error='\'Como conoció MedicalVM\' ';
	          if(validarNoNulo(form.elements[n])==false){
	          	msgError=msgError+'\n'+error;
		    }
			
                break; 	  				
              }//switch
            }//for  

			if (msgError!='')
			{
				msgError='Los siguientes campos son obligatorios:\n' + msgError + '\n'+ msgErrorStd;
				return false;
			}
            return true;
          }
          
//---------declaracion-funciones--------------------------------------	  

function validarNoNulo(obj){
  if(obj.value=="")
    return false
  else
    return true;
}

function validarEsCaracter(obj){
   var cadena=obj.value.toLowerCase();
   for(var n=0;n<cadena.length;n++){
     var car=cadena.substring(n,n+1);
     if((car>='0') && (car<='9'))
       return false;  
   }	
  return true;
}

function validarEsEntero(obj){

  var error=0;
  
  for(var n=0;n<obj.value.length;n++){
    var car=obj.value.substring(n,n+1);
    if((car<"0") || ("9"<car))
      error=1;   
  }	
  if (error==1){
    return false;
  }
  else
    return true;
}

function validarEsMail(obj){
   var cadena=obj.value.toLowerCase();
     for(var n=0;n<cadena.length;n++){
       var car=cadena.substring(n,n+1);
       if(car=='@')
         return true;   
     }	
  return false;
}

function validarTextoNoNulo(obj){
  if(validarNoNulo(obj)==true)
    return validarEsCaracter(obj);		
  else 
    return false;
}

function validarNumericoNoNulo(obj){
  if(validarNoNulo(obj)==true)
    return validarEsEntero(obj);		
  else 
    return false;
}

function validarLongitud(obj, longitud){
  if(obj.value.length==longitud)
    return true;		
  else 
    return false;
}


function Contrato(){
  MostrarPag('http://www.newco.dev.br/Medicos/ContratoWeb.html','Contrato');
}


function MostrarPag(pag,titulo){  
       
         
          if(titulo==null)
            var titulo='MedicalVM';

          if (is_nav){
              ample = top.screen.availWidth-100;
              alcada = top.screen.availHeight-100;
            
              esquerra = (top.screen.availWidth-ample) / 2;
              alt = (top.screen.availHeight-alcada) / 2;
            
              if (ventana && ventana.open){
                ventana.close();            
              }
              
              titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',screenX='+esquerra+',screenY='+alt);
              titulo.focus();
          }else{
              ample = top.screen.availWidth-100;
              alcada = top.screen.availHeight-100;
            
              esquerra = (top.screen.availWidth-ample) / 2;
              alt = (top.screen.availHeight-alcada) / 2;
            
              if (ventana &&  ventana.open && !ventana.closed){
                ventana.close();
              }
              
	      titulo=window.open(pag,titulo,'toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes,width='+ample+',height='+alcada+',top='+alt+',left='+esquerra);
	      titulo.focus();
          }
        }



-->
</script>
]]></xsl:text>
        
<STYLE>
      .tituloPagForm {
	COLOR: #015e4b; 
	FONT-FAMILY: Arial, Helvetica, Swiss, Geneva, Sans; 
	FONT-SIZE: 14pt; 
	FONT-WEIGHT: bold
        }
        
      .tituloForm {
	COLOR: #015e4b; 
	FONT-SIZE: 10pt; 
	FONT-WEIGHT: bold
      }
      
      .subTituloForm {
	COLOR: #018167; 
	FONT-SIZE: 9pt; 
	FONT-WEIGHT: bold
      }
      
      .textoForm {
	COLOR: #000000; 
	FONT-SIZE: 10pt; 
	FONT-WEIGHT: bold
      }
      
      .textoLegal {
	COLOR: #000000; 
	FONT-SIZE: 8pt
      }
      
      .camposObligatorios { 
        COLOR: #FF0000; 
        FONT-SIZE: 10pt; 
        FONT-WEIGHT: bold }
        
      .contactarTitulo {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        color: #015E4B; 
        font-size: 7pt; 
        font-weight: bold;}
  
      .contactarNombre {
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 7pt; 
        font-weight: bold;}   
        
      .pequenya{
        font-family: Verdana, Arial, Helvetica, sans-serif;
        font-size: 7pt;}
  
  
</STYLE>
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>     
<body bgColor="#ffffff" leftMargin="0" topMargin="0" marginheight="0" marginwidth="0">
<!--<form action="FormAltaSave.xsql" method="POST" name="form1">-->
<!--
       comentamos FormALtaSave para que nomuestre la aceptacion del contrato
       y modificamos FormCantratoSave.xsql
-->
<form action="./FormAltaEmpresaSave.xsql" method="POST" name="form1">
  <table border="0" width="100%">
    <tr> 
      <td class="tituloPagform" height="44" colspan="2"> 
        <div align="center">Alta de Empresas</div>
      </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <table width="100%" align="center">
          <tr align="center"> 
            <td class="textoform">&nbsp;</td>
            <td class="textoform">&nbsp; </td>
          </tr>
          <tr align="center"> 
            <td>&nbsp;</td>
            <td>&nbsp; </td>
          </tr>
        </table>
        <table width="75%" align="center">
          <tr> 
            <td class="textoLegal">Este formulario le permitirá solicitar el alta en MedicalVM. Deberá introducir sus datos personales y los datos de 
de su empresa.<!-- Puede incluso dar de alta
dos centros, en cuyo caso se le enviarán dos claves diferentes de acceso a MedicalVM. Seleccione cada centro a dar
de alta marcando la casilla <b>Afiliar este Centro a MedicalVM</b>--><br/><br/></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr bgColor="#a0d8d7"> 
      <td class="tituloform" colspan="2">Datos personales:</td>
    </tr>
    <tr class="textoform"> 
      <td class="textoform" colspan="2"> 
        <table border="0" width="100%">
          <tr> 
            <td class="textoform" width="15%">&nbsp;</td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center"></div>
            </td>
            <td width="25%">&nbsp;</td>
            <td width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center"></div>
            </td>
            <td colspan="2" width="*">&nbsp;</td>
          </tr>
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Título:</div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
              <select name="MED_TITULO">
                <option value="" selected="true">[elija una opcion]</option>
                <option value="Dr.|H">Dr.</option>
                <option value="Dra.|M">Dra.</option>
                <option value="Sr.|H">Sr.</option>
                <option value="Sra.|M">Sra.</option>
              </select>


            </td>
            <td width="15%" class="textoForm" align="right">Cargo:</td>
            <td width="1%" class="camposObligatorios">*</td>
            <td colspan="2" width="*">
             <xsl:variable name="IDAct" select="9"/>
              <xsl:apply-templates select="AltaMedicos/cargo/field/dropDownList">
              </xsl:apply-templates>
            </td>
          </tr>
          
          <tr> 
            <td class="textoform" width="15%"> 
              <div align="right">Nombre: </div>
            </td>
            <td class="camposObligatorios" width="1%"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
              <div align="left"> 
                <INPUT name="MED_NOMBRE" size="25" maxlength="100"/>
              </div>
            </td>
            <td width="15%"> 
              <div align="right" class="textoform"> Primer apellido: </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td colspan="2" width="*"> 
              <div align="left"> 
                <input name="MED_APELLIDO1" size="25" maxlength="100"/>
              </div>
            </td>
          </tr>
          <tr> 
            <td width="15%" height="31"> 
              <div align="right" class="textoform"> Segundo apellido: </div>
            </td>
            <td width="1%" class="camposObligatorios" height="31"> 
              <div align="center">*</div>
            </td>
            <td width="25%" height="31"> 
              <div align="left"> 
                <input name="MED_APELLIDO2" size="25" maxlength="100"/>
              </div>
            </td>
            <td width="15%" class="textoform" height="31"> 
              <div align="right">Número de colegiado:</div>
            </td>
            <td width="1%" class="camposObligatorios" height="31"> 
              <div align="center">*</div>
            </td>
            <td height="31" width="*" rowspan="2" valign="top"> 
              <div align="left"> 
                <input name="MED_NUM_COLEGIADO" size="25" maxlength="20"/>
                <br/>
                <div class="textoLegal">Obligatorio si el título es Dr/a.</div>
              </div>
            </td>
          </tr>
          <tr>
            <td width="15%" height="31"> 
              <div align="right" class="textoform">NIF:</div>
            </td>
            <td width="1%" class="camposObligatorios" height="31"> 
              <div align="center">*</div>
            </td>
            <td width="25%" height="31"> 
              <div align="left"> 
                <input name="MED_NIF" size="25" maxlength="12"/>
              </div>
            </td>
            <td width="15%" class="textoform" height="31"> 
              &nbsp;
            </td>
            <td width="1%" class="camposObligatorios" height="31"> 
              &nbsp;
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr class="textoform"> 
      <td colspan="2"> 
        <div align="right"><span class="camposObligatorios">*</span> Datos obligatorios</div>
      </td>
    </tr>
    <tr class="textoform"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr bgColor="#a0d8d7"> 
      <td class="tituloform" colspan="2">Datos de la empresa:</td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <table border="0" width="100%">
          <tr> 
            <td ALIGN="right" class="textoform" width="15%" height="2">&nbsp;</td>
            <td  class="camposObligatorios" width="1%" height="2"> 
              <div align="center"></div>
            </td>
            <td width="25%" height="2">&nbsp;</td>
            <td width="15%" height="2">&nbsp;</td>
            <td width="1%" height="2"> 
              <div align="center"></div>
            </td>
            <td width="*" height="2">&nbsp;</td>
          </tr>
        
          <tr> 
            <td ALIGN="right" class="textoform" width="15%"> Tipo de centro: </td>
            <td  class="camposObligatorios" width="1%"> 
              <div align="center">* </div>
            </td>
            <td width="%"> 
            <xsl:variable name="IDAct" select="1"/>
            <xsl:apply-templates select="AltaMedicos/centros/field/dropDownList">
              </xsl:apply-templates>
            </td>
            <td width="15%"> 
              &nbsp;
            </td>
            <td width="1%" class="camposObligatorios"> 
              &nbsp;
            </td>
            <td width="*"> 
              &nbsp;
            </td>
          </tr>
          <tr> 
            <td width="15%" height="19">&nbsp;</td>
            <td width="1%" class="camposObligatorios" height="19">&nbsp;</td>
            <td width="25%" height="19">&nbsp;</td>
            <td width="15%" class="textoform" height="19">&nbsp;</td>
            <td width="1%" class="camposObligatorios" height="19">&nbsp;</td>
            <td width="*" height="19">&nbsp;</td>
          </tr>
          <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Nombre Empresa: </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
              <div align="left"> 
                <INPUT name="MED_CEN_NOMBRE1" size="25" maxlength="100"/>
              </div>
            </td>
            <td width="15%"> 
              <div align="right"><span class="textoform">NIF:</span></div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td width="*"> 
              <div align="left"> 
                <input type="text" name="MED_CEN_NIF1" size="25" maxlength="12"/>
              </div>
            </td>
          </tr>
          <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Teléfono: </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
              <div align="left"> 
                <input name="MED_CEN_TELEFONO1" size="25" maxlength="30"/>
              </div>
            </td>
            <td width="15%" class="textoform"> 
              <div align="right">Fax:</div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center"></div>
            </td>
            <td width="*"> 
              <input name="MED_CEN_FAX1" size="25" maxlength="30"/>
            </td>
          </tr>
          <tr> 
            <td width="15%" height="19"> 
              <div align="right" class="textoform">e-mail: </div>
            </td>
            <td width="1%" class="camposObligatorios" height="19"> 
              <div align="center">*</div>
            </td>
            <td width="25%" height="19"> 
              <div align="left"> 
                <input name="MED_CEN_EMAIL1" size="25" maxlength="100"/>
              </div>
            </td>
            <td width="15%" class="textoform" height="19">&nbsp;</td>
            <td width="1%" class="camposObligatorios" height="19">&nbsp;</td>
            <td width="*" height="19">&nbsp;</td>
          </tr>
          <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Dirección: </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
              <div align="left"> 
                <INPUT name="MED_CEN_DIRECCION1" size="25" maxlength="300"/>
              </div>
            </td>
            <td width="15%"> 
              <div align="right" class="textoform">Población: </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td width="*"> 
              <div align="left"> 
                <input name="MED_CEN_POBLACION1" size="25" maxlength="200"/>
              </div>
            </td>
          </tr>
          <tr> 
            <td width="15%"> 
              <div align="right" class="textoform">Provincia: </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td width="25%"> 
              <div align="left"> 
              <xsl:variable name="IDAct" select="'BARCELONA'"/>
               <xsl:apply-templates select="AltaMedicos/provincias/field/dropDownList">
              </xsl:apply-templates>
              </div>
            </td>
            <td width="15%"> 
              <div align="right" class="textoform"> Código postal: </div>
            </td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center">*</div>
            </td>
            <td width="*"> 
              <div align="left"> 
                <input name="MED_CEN_CPOSTAL1" size="25" maxlength="10"/>
              </div>
            </td>
          </tr>
          <tr> 
            <td width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center"></div>
            </td>
            <td width="25%">&nbsp;</td>
            <td width="15%" class="textoform">&nbsp;</td>
            <td width="1%" class="camposObligatorios"> 
              <div align="center"></div>
            </td>
            <td width="*">&nbsp;</td>
          </tr>
          <tr> 
            <td width="15%" height="23"> 
              <div align="right" class="textoform"> Especialidad: </div>
            </td>
            <td width="1%" class="camposObligatorios" height="23"> 
              <div align="center">*</div>
            </td>
            <td width="25%" height="23"> 
              <div align="left"> 
              <xsl:variable name="IDAct" select="'GEN'"/>
                <xsl:apply-templates select="AltaMedicos/especialidades/field/dropDownList">
              </xsl:apply-templates>
              </div>
            </td>
            <td width="15%" height="23"> 
              <div align="right" class="textoform">&nbsp;</div>
            </td>
            <td width="1%" class="camposObligatorios" height="23"> 
              <div align="center">&nbsp;</div>
            </td>
            <td width="*" height="23"> 
              <div align="left"> 
               &nbsp;
              </div>
            </td>
          </tr>
          <tr> 
            <td width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios">&nbsp;</td>
            <td width="25%">&nbsp;</td>
            <td width="15%">&nbsp;</td>
            <td width="1%" class="camposObligatorios">&nbsp;</td>
            <td width="*">&nbsp;</td>
          </tr>
       
        </table>
        <table border="0" width="54%" align="center">
         
          <tr> 
            <td class="textoform" width="89%">Breve descripción de su empresa:</td>
            <td class="textoform" width="11%">Lista opcional de 10 proveedores o clientes habituales:</td>
          </tr>
          <tr> 
            <td width="89%"> 
              <div align="center"> 
                <textarea cols="40" name="MED_CEN_DESCRIPCION1" rows="4"></textarea>    
              </div>
            </td>
            <td width="11%"> 
              <textarea cols="40" name="MED_CEN_LISTA_PROVEEDORES1" rows="4"></textarea>
            </td>
          </tr>
		  <!--
          <tr> 
            <td width="89%">&nbsp;</td>
            <td width="11%" class="textoLegal">En el caso de no tener en su Catálogo 
              dichos proveedores, MedicalVM, iniciará gestiones de afiliación 
              con estas empresas para facilitar sus compras habituales.</td>
          </tr>
		  -->
         
        </table>
        <table width="100%" border="0">
          <tr> 
            <td class="textoform" width="25%" height="34"> 
              <div align="right">¿Cual es su volumen de compra o venta anual? </div>
            </td>
            <td class="camposObligatorios" width="1%" height="34"> 
              <div align="center"></div>
            </td>
            <td width="61%" height="34"> 
              <select name="MED_CEN_VOLUMENCOMPRAANUAL1">
                <option 
              selected="true" 
              value="">[Seleccione importe]</option>
                <option value="-0.5M">Inferior a 500.000 Pts.</option>
                <option value="0.5M-1M">Entre 500.000 y 1.000.000 Pts.</option>
                <option value="1M-2M">Entre 1.000.000 y 2.000.000 Pts.</option>
                <option value="2M-5M">Entre 2.000.000 y 5.000.000 Pts.</option>
                <option value="5M-10M">Entre 5.000.000 y 10.000.000 Pts.</option>
                <option value="10M-20M">Entre 10.000.000 y 20.000.000 Pts.</option>
                <option value="20M-50M">Entre 20.000.000 y 50.000.000 Pts.</option>
                <option value="50M-100M">Entre 50.000.000 y 100.000.000 Pts.</option>
                <option value="1O0M-200M">Entre 100.000.000 y 200.000.000 Pts.</option>
                <option value="200M-500M">Entre 200.000.000 y 500.000.000 Pts.</option>
                <option value="500M-1000M">Entre 500.000.000 y 1.000.000.000 Pts.</option>
                <option value="+1000M">Más de 1.000.000.000 Pts.</option>
              </select>
            </td>
          </tr>
        </table>
        <table width="100%" border="0">
          <tr> 
            <td class="textoform" width="25%" height="34"> 
              <div align="right">¿Como conoció MedicalVM? </div>
            </td>
            <td class="camposObligatorios" width="1%" height="34"> 
              <div align="center">*</div>
            </td>
            <td width="61%" height="34"> 
              <textarea cols="40" name="MED_EXISTENCIA_VM_OTROS" rows="2"></textarea>
            </td>
          </tr>
        </table>
      </td>
    </tr>
	<!--
    <tr bgColor="#a0d8d7"> 
      <td class="tituloform" colspan="2">Otros:</td>
    </tr>
    <tr>
      <td class="textoform" height="160" colspan="2"><br/>
        <table border="0" cellPadding="25" width="100%">
          <tr>
            <td>
              <table border="0" align="center" width="20%">
                <tr>
                  <td class="textoForm">
                    Comentarios:
                  </td>
                </tr>
                <tr>
                  <td>
                    <textarea name="MED_COMENTARIOS" type="textarea" cols="50" rows="5"></textarea>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
	-->
          <tr> 
            <td class="textoLegal"> 
              <div class="textoLegal" style="TEXT-ALIGN: justify">
			  <br/>A los efectos 
                de lo dispuesto en la Ley Orgánica 15/99 de 13 de diciembre de 
                Protección de Datos de Carácter Personal, Medical Virtual Market 
                comunica al Usuario que los datos facilitados para la formalización 
                de los formularios contenidos en esta web site, podrán quedar 
                recogidos en ficheros automatizados cuyo responsable es Medical 
                Virtual Market (Via Augusta, 125 Atico 4, 08021 Barcelona), cuya 
                finalidad es mantener una relación con los interesados para actividades 
                de servicio, culturales, de ocio, de información, de mantenimiento 
                y mejora de esta web site y la realización de acciones comerciales 
                y promocionales especialmente diseñadas para los interesados. 
                En esta misma dirección, los interesados podrán ejercitar el derecho 
                de acceso, rectificación y cancelación de los datos, enviando 
                una solicitud escrita y firmada incluyendo nombre, apellidos y 
                DNI con las instrucciones precisas al efecto.
              </div>
            </td>
          </tr>
  </table>
  <table border="0" width="100%">
    <tr>
      <!--
	  <td width="*">&nbsp;</td>
	  <td width="15%" align="center">
        <input name="BORRAR" type="reset" value="Borrar"/>
      </td>
	  -->
      <td width="15%" align="center">
	    <input  type="button" name="SUBMIT" value="Solicitar Alta" onClick="if(validarFormulario(document.forms[0])==true)SubmitForm(document.forms[0]); else alert(msgError)" />
       <!--
        <input  type="button" name="SUBMIT" value="Solicitar Alta" onClick="if(validarFormulario(document.forms[0])==true) alert('Ok'); else alert(msgError)" />
		-->
       </td>
    </tr>
  </table>
  <br/><br/>
  <table width="95%" border="0" cellpadding="0" cellspacing="5" align="center">                      
			<tr valign="center">
			 <td><p class="contactarTitulo">Para contactar con nosotros:</p></td>
              		 <td><p class="contactarNombre">Alfonso Linares</p></td>
              		 <td><p class="pequenya">telf:</p></td>
              		 <td><p class="pequenya">606.99.36.11</p></td>
              		 <td><p class="pequenya">email:</p></td>
              		 <td><p class="pequenya"><a href="mailto:alinares@medicalvm.com?Subject=Medical Virtual Market">alinares@medicalvm.com</a></p></td>
              		</tr>
              		<tr valign="center">
                         <td colspan="6">
			  <p class="contactarNombre" align="center">
			  La utilización del sistema implica la aceptación de las claúsulas del <a href="javascript:Contrato();">Contrato de
			  Afiliación</a> de MedicalVM.</p>
			 </td>
			</tr>
		       </table>  
  <input type="hidden" name="MED_CEN_AFILIAR1" value="S"/>
  <!--
  <input type="hidden" name="MED_FECHA_NAC" value="1"/>
  <input type="hidden" name="MED_DIRECCION" value="1"/>
  <input type="hidden" name="MED_POBLACION" value="1"/>
  <input type="hidden" name="MED_PROVINCIA" value=""/>
  <input type="hidden" name="MED_CPOSTAL" value="1"/>
  <input type="hidden" name="MED_TF_FIJO" value="1"/>
  <input type="hidden" name="MED_TF_MOVIL" value="1"/>
  <input type="hidden" name="MED_FAX" value="1"/>
  <input type="hidden" name="MED_EMAIL" value="1@"/>
  <input type="hidden" name="MED_ESPECIALIDAD" value="GEN"/>
  <input type="hidden" name="MED_ESPECIALIDAD_OTROS" value="1"/>
  <input type="hidden" name="MED_CEN_PERSONA_CONTACTO1" value="1"/>
  -->
  
  </form>
 </body>
  

 </xsl:otherwise>
 </xsl:choose>
 </html>
 </xsl:template>
 
 <!-- TEMPLATES  TEMPLATES  TEMPLATES  TEMPLATES  TEMPLATES  TEMPLATES  TEMPLATES  TEMPLATES  -->
 
 </xsl:stylesheet>