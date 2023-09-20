<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
 | ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 |
 | Fichero.......: TRFMantenHTML.xsl
 | Autor.........: Montse
 | Fecha.........:
 | Descripcion...: Asignar tarifas Privadas/Publicas
 | Funcionamiento: 
 |
 |Modificaciones:
 |   Fecha:21/06/2001      Autor:Olivier Jean          Modificacion: poner "valign=top" para que los titulos quedan alineados arriba de la celda
 |   Fecha:22/06/2001      Autor:Olivier Jean          Modificacion: javascript para impedir "Error base de datos"
 |
 |
 | Situacion: __Normal__
 |
 |(c) 2001 MedicalVM
 |///////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 +-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" /> 
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>
  <xsl:template match="/">  
    <html>
      <head> 
	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
        <script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
        </script>
        <script type="text/javascript">
        <!--
        var tarifasIniciales;
        
        Actualitza_Cookie('TRFManten','Iniciar');        
        
        
        var msg_CantidadRepetida = "Existe una cantidad repetida.";
        var msg_LineaErronea  = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0130' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
        var msg_LineaErronea2 = ']]></xsl:text><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0120' and @lang=$lang]" disable-output-escaping="yes"/><xsl:text disable-output-escaping="yes"><![CDATA[';
        //
        //
        //
        
        function Actua(formu,cantidad,importe,divisa){
          if (AntiFormateaVisValores(formu,'CANTIDAD','IMPORTE')==true){
            if (RevisarCantidades(formu,cantidad)==0){
              if (agrupaArrayTRF(formu,cantidad,importe,divisa)==true){    
                SubmitForm(formu);
              }
            }
          }
        }
        
        
        function guardarCambiosTarifas(form,cantidad,importe,divisa){ 

          var tarifasActuales;
          if (AntiFormateaVisValores(form,'CANTIDAD','IMPORTE')==true)
            if (RevisarCantidades(form,cantidad)==0)
              if(agrupaArrayTRF(form,cantidad,importe,divisa)==true)
                tarifasActuales=devuelveAgrupaArrayTRF(form,cantidad,importe,divisa)        
          if(tarifasIniciales!=tarifasActuales){
            Cambio(form,form.elements['LISTA_EMPRESAS']);   
          }
          else
            alert('No hay cambios que guardar');
        }
        
        function montarCadenaValores(form,cantidad,importe,divisa){
          if (AntiFormateaVisValores(form,'CANTIDAD','IMPORTE')==true){
            if (RevisarCantidades(form,cantidad)==0){
             if (agrupaArrayTRF(form,cantidad,importe,divisa)==true){
               cadenaTarifas=form.elements['aceptarTOTAL'].value;
             }
            }
          }
        }
        
        /*
           funcion que retorna a la pagina anterior, monta la ristra de parametros de llamada
           para saber que informacion de tarifas se habia mostrado antes, que proveedor era, etc..
           Recojo todos los valores del campo hidden PRMEXTRA y voy montando la cadena.
        */
        function retornaSituacionAnterior(form){
          montarVariablesExtras(form); 
        }
        
        
        function valoresIniciales(form,cantidad,importe,divisa){
          tarifasIniciales=devuelveAgrupaArrayTRF(form,cantidad,importe,divisa);
        }
        
        
        function devuelveAgrupaArrayTRF(formu,NombreCampo1,NombreCampo2,NombreCampo3){        
          seleccion = new Array;
          var primeraVez = 0;
	  for(i=0; i<formu.elements.length; i++){
	    if (formu.elements[i].name.substring(0,12)==NombreCampo3){
	      num_linia=formu.elements[i].name.substr(12,formu.elements[i].name.length-12);
	      
	      //Miro que no haya una pareja de campos que uno este vacio y el otro lleno.
	      if (formu.elements['CANTIDAD'+num_linia].value!="" && formu.elements['IMPORTE'+num_linia].value==""){
	        alert(msg_LineaErronea);
	        formu.elements['IMPORTE'+num_linia].focus();
	        return false;
	      }
	      else if (formu.elements['CANTIDAD'+num_linia].value=="" && formu.elements['IMPORTE'+num_linia].value!=""){
	        alert(msg_LineaErronea2);
	        formu.elements['CANTIDAD'+num_linia].focus();
	        return false;	        	      
	      }
	      //Si los dos estan llenos miro que sus datos sean correctos: numericos y mayores de cero	      
	      else{
	        if (formu.elements[NombreCampo1+num_linia].value!="" && formu.elements[NombreCampo2+num_linia].value!=""){
	              //Aqui llegamos si los datos introducido son correctos.
	              //Construimos el Array, solo con los elementos no borrados 
	              //si la linea no esta seleeccionada para ser borrada
	              if (formu.elements['eliminar'+num_linia].checked==false){
	                if (primeraVez==0){
                          seleccion='('+formu.elements[NombreCampo1+num_linia].value+','+formu.elements[NombreCampo2+num_linia].value+','+formu.elements[NombreCampo3+num_linia].options[formu.elements[NombreCampo3+num_linia].selectedIndex].value+')';
                          primeraVez=1;
                        }
                        else{
                          if (primeraVez>0){         
                            seleccion=seleccion+',('+formu.elements[NombreCampo1+num_linia].value+','+formu.elements[NombreCampo2+num_linia].value+','+formu.elements[NombreCampo3+num_linia].options[formu.elements[NombreCampo3+num_linia].selectedIndex].value+')';
                          }
                        }                    
                    }
                }
              }
            }
          }
          return seleccion;
        }        
        
        
        function montarVariablesExtras(form){
          var cadenaCompleta=form.elements['SALTAR'].value+'?';
    
            var objAct=form.elements['PRMEXTRA'];
            if(objAct.value.charAt(0)=='('){
              var encontrado=0;
              var indiceInicial=0;
              var subVariable
              for(var i=0;i<objAct.value.length;i++)
                if(objAct.value.charAt(i)==')'){
                  encontrado=i;
                  if(indiceInicial==0)
                    subVariable=objAct.value.substring(indiceInicial+1,i);
                  else
                    subVariable=objAct.value.substring(indiceInicial+3,i);
                  cadenaCompleta=tratarSubVariable(subVariable,cadenaCompleta);
                  indiceInicial=i;
                }
            }
          location.href=cadenaCompleta;
        } 
        
        function tratarSubVariable(obj,cadena){
          var encontrado=false;
          for(var n=0;n<obj.length && !encontrado;n++){
            if(obj.charAt(n)==','){
              separador=n;
              encontrado=true;
            }
          }
          var subVarNom=obj.substring(0,n-1);
          var subVarValor=obj.substring(n,obj.length);
          cadena+=subVarNom+'='+subVarValor+'&';
          return cadena;
        }                           
        
        
        // Esta funcion se llama al cambiar le empresa en el combo de arrib
        function Cambio(form,obj) {
          //alert('en el combo...');
          //alert(form.elements['aceptarTOTALviejo'].value);
          //alert(obj.options[obj.selectedIndex].value);
          document.forms[0].elements['RELOAD'].value = 'S';
          document.forms[0].elements['RELOAD_EMPID'].value=obj.options[obj.selectedIndex].value;
          Actua (document.forms[0],'TRF_CANTIDAD','TRF_IMPORTE','TRF_IDDIVISA');
          //form.elements['aceptarTOTALviejo'].value=form.elements['aceptarTOTAL'].value;
          //alert(form.elements['aceptarTOTALviejo'].value);
          //alert('saliendo del combo...');
        }
        
        // Mira que no haya cantidades repetidas
        function RevisarCantidades (formu, NombreCampo) {
          var longNombreCampo = NombreCampo.length;
                for (i=0;i<formu.elements.length;i++) {
                  if ((formu.elements[i].name.substring(0,longNombreCampo) == NombreCampo)
                       && (formu.elements[i].value != ""))
                   {
                   // Revisamos todos los campos con el mismo nombre
                   for (j=0;j<formu.elements.length;j++) {
                    if ((formu.elements[j].name.substring(0,longNombreCampo) == NombreCampo)
                         && (i!=j)
                         && (formu.elements[j].value != "")) {
                         // Tenemos un campo con el mismo nombre y que no es el que
                         //   tenemos seleccionado en el primer bucle
                         if (formu.elements[i].value == formu.elements[j].value){
                            alert(msg_CantidadRepetida);
                            formu.elements[i].focus();
                            return 1;    
                         }
                    }
                   }
                  }
                 }
                 return 0;
        }

        // NombreCampo1: TRF_CANTIDAD
        // NombreCampo2: TRF_IMPORTE
        // NombreCampo3: TRF_DIVISA 
        //
        // Valida que si hay CANTIDAD haya IMPORTE y viceversa
        // Cuando CANTIDAD e IMPORTE existen los valida (numericos)
        // Construye array 'aceptarTOTAL' de las lineas no vacias con poniendo los tres campos.
        // Ej (CANTIDAD1,IMPORTE1,DIVISA1),(CANTIDAD2,IMPORTE2,DIVISA2),...
 
	function agrupaArrayTRF(formu,NombreCampo1,NombreCampo2,NombreCampo3){        
          seleccion = new Array;
          var primeraVez = 0;
	  for(i=0; i<formu.elements.length; i++){
	    if (formu.elements[i].name.substring(0,12)==NombreCampo3){
	      num_linia=formu.elements[i].name.substr(12,formu.elements[i].name.length-12);
	      
	      //Miro que no haya una pareja de campos que uno este vacio y el otro lleno.
	      if (formu.elements['CANTIDAD'+num_linia].value!="" && formu.elements['IMPORTE'+num_linia].value==""){
	        alert(msg_LineaErronea);
	        formu.elements['IMPORTE'+num_linia].focus();
	        return false;
	      }
	      else if (formu.elements['CANTIDAD'+num_linia].value=="" && formu.elements['IMPORTE'+num_linia].value!=""){
	        alert(msg_LineaErronea2);
	        formu.elements['CANTIDAD'+num_linia].focus();
	        return false;	        	      
	      }
	      //Si los dos estan llenos miro que sus datos sean correctos: numericos y mayores de cero	      
	      else{
	        if (formu.elements[NombreCampo1+num_linia].value!="" && formu.elements[NombreCampo2+num_linia].value!=""){
	              //Aqui llegamos si los datos introducido son correctos.
	              //Construimos el Array, solo con los elementos no borrados 
	              //si la linea no esta seleeccionada para ser borrada
	              if (formu.elements['eliminar'+num_linia].checked==false){
	                if (primeraVez==0){
                          seleccion='('+formu.elements[NombreCampo1+num_linia].value+','+formu.elements[NombreCampo2+num_linia].value+','+formu.elements[NombreCampo3+num_linia].options[formu.elements[NombreCampo3+num_linia].selectedIndex].value+')';
                          primeraVez=1;
                        }
                        else{
                          if (primeraVez>0){         
                            seleccion=seleccion+',('+formu.elements[NombreCampo1+num_linia].value+','+formu.elements[NombreCampo2+num_linia].value+','+formu.elements[NombreCampo3+num_linia].options[formu.elements[NombreCampo3+num_linia].selectedIndex].value+')';
                          }
                        }                    
                    }
                }
              }
            }
          }
          formu.elements['aceptarTOTAL'].value=seleccion;
          return true;
        }        
        
        ]]></xsl:text>function FormateaValores(){
          <xsl:for-each select="Tarifas/TARIFAS/TARIFAS_ROW">
            <xsl:if test="not(TRF_CANTIDAD[.=''])">
              //document.forms[0].elements['TRF_CANTIDAD<xsl:value-of select="@NUM"/>'].value=FormateaVis('<xsl:value-of select="TRF_CANTIDAD"/>');
              document.forms[0].elements['CANTIDAD<xsl:value-of select="@NUM"/>'].value=FormateaVis('<xsl:value-of select="TRF_CANTIDAD"/>');
            </xsl:if>
            <xsl:if test="not(TRF_IMPORTE[.=''])">
              //document.forms[0].elements['TRF_IMPORTE<xsl:value-of select="@NUM"/>'].value=FormateaVis('<xsl:value-of select="TRF_IMPORTE"/>');             
              document.forms[0].elements['IMPORTE<xsl:value-of select="@NUM"/>'].value=FormateaVis('<xsl:value-of select="TRF_IMPORTE"/>');
            </xsl:if>
          </xsl:for-each>
          valoresIniciales(document.forms[0],'TRF_CANTIDAD','TRF_IMPORTE','TRF_IDDIVISA');
        }<xsl:text disable-output-escaping="yes"><![CDATA[
        
        //del campo de visualizacion pasamos al hidden
        function AntiFormateaVisValores(formu,cantidad,importe){

          var error = 0;
          var longCantidad = cantidad.length;
          var longImporte = importe.length;                  
	  for(j=0; j<formu.length; j++){
	    if (formu.elements[j].name.substring(0,longCantidad)==cantidad && formu.elements[j].value!=""){
               num_linia=formu.elements[j].name.substr(8,formu.elements[j].name.length-8);
	       formu.elements['TRF_CANTIDAD'+num_linia].value=AntiformateaVis(formu.elements[j].value,formu.elements[j]);
	       if (isNaN(formu.elements['TRF_CANTIDAD'+num_linia].value)) error =1;
	    }
	    if (formu.elements[j].name.substring(0,longImporte)==importe && formu.elements[j].value!=""){
               num_linia=formu.elements[j].name.substr(7,formu.elements[j].name.length-7);
	       formu.elements['TRF_IMPORTE'+num_linia].value=AntiformateaVis(formu.elements[j].value,formu.elements[j]);
	       if (isNaN(formu.elements['TRF_IMPORTE'+num_linia].value)) error =1;
	    }	    
	  }
	  if (error==0) {
	  
	    return true;
	  }
	  else return false;
        }                              
        
      //-->
      </script>              
      ]]></xsl:text>
    </head>

    <body bgcolor="#EEFFFF" onLoad="FormateaValores();Actualitza_Cookie('TRFManten','Terminar');">
      <xsl:choose>
        <xsl:when test="//Status">
          <xsl:apply-templates select="//Status"/>
        </xsl:when>
        <xsl:when test="//xsql-error">
          <xsl:apply-templates select="//xsql-error"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="Tarifas"/>          
        </xsl:otherwise>
      </xsl:choose>
    </body>
  </html>
</xsl:template>

<!--
 |  Templates
 +-->

<xsl:template match="Tarifas">
  <form method="post" name="form_tarifas" action="TRFMantenSave.xsql">
    <!--Campos ocultos-->
    <xsl:apply-templates select="TARIFAS/SALTAR"/>
    <xsl:apply-templates select="TARIFAS/PRMEXTRA"/>
    <xsl:apply-templates select="TARIFAS/LISTAANTES"/>    
    <xsl:apply-templates select="EMP_ID"/>
    <xsl:apply-templates select="PRO_ID"/>
    <xsl:apply-templates select="MO_ID"/>
    <input type="hidden" name="RELOAD"/>
    <input type="hidden" name="RELOAD_EMPID"/>
    <input type="hidden" name="eliminarTOTAL"/>
    <input type="hidden" name="aceptarTOTAL"/>
    <input type="hidden" name="aceptarTOTALviejo"/>        
    
  <table width="100%" border="0" cellspacing="0" cellpadding="5" >	
    <tr valign="top" align="center" bgcolor="#EEFFFF">     
      <td> 
        <xsl:apply-templates select="Comun/button[1]"/>
      </td>
      <td colspan="2" valign="top"> 
        <xsl:apply-templates select="Comun/button[2]"/>
      </td>
      <td> 
        <xsl:apply-templates select="Comun/button[3]"/>
      </td>                
    </tr>
    <!-- Titulo : Asignar precio Privado / publico -->
    <tr valign="top" align="center" bgcolor="#EEFFFF">
      <td colspan="4"><p class="tituloPag">
      <xsl:choose>
        <xsl:when test="//TRF_IDCLIENTE=0"><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0200' and @lang=$lang]" disable-output-escaping="yes"/></xsl:when>
        <xsl:otherwise>
	        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0210' and @lang=$lang]" disable-output-escaping="yes"/>
	        <u><xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0220' and @lang=$lang]" disable-output-escaping="yes"/></u>
	        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0230' and @lang=$lang]" disable-output-escaping="yes"/>
	        <xsl:value-of select="Cliente/EMP_NOMBRE" disable-output-escaping="yes"/>
        </xsl:otherwise>
      </xsl:choose>
      </p></td>
      </tr>
      <tr valign="top" align="center">
        <td colspan="4">      
        <xsl:variable name="IDAct" select="EMP_ID"/>
        <xsl:variable name="NUM_FILA" select="@ID"/>        
        <xsl:apply-templates select="//field[@name='LISTA_EMPRESAS']"/>
        </td>
      </tr>
    <tr bgcolor="#CCCCCC">
      <!--<td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0070' and @lang=$lang]" disable-output-escaping="yes"/>      
      </p></td>-->
      <td colspan="4"><p class="titulofORM">
        <xsl:value-of select="TARIFAS/PRODUCTO/PRO_NOMBRE" disable-output-escaping="yes"/>      
        </p></td>
    </tr>        
    <tr valign="top">
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0100' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </p></td>    
      <td colspan="3">
        <xsl:value-of select="TARIFAS/PRODUCTO/PRO_DESCRIPCION" disable-output-escaping="yes"/>      
      </td></tr>      
    <tr>
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0040' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </p></td>
      <td colspan="3">
        <xsl:value-of select="TARIFAS/PRODUCTO/NOM_NOMBRECOMPLETO" disable-output-escaping="yes"/>      
      </td>
    </tr>
    <tr valign="top">
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0160' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </p></td>    
      <td>
        <xsl:value-of select="TARIFAS/PRODUCTO/PRO_MARCA" disable-output-escaping="yes"/>      
      </td>
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0170' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </p></td>    
      <td>
        <xsl:value-of select="TARIFAS/PRODUCTO/PRO_FABRICANTE" disable-output-escaping="yes"/>      
      </td></tr>
    <tr>
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0180' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </p></td>
      <td colspan="3">
        <xsl:apply-templates select="TARIFAS/PRODUCTO/REFERENCIA_PROVEEDOR"/>      
      </td>
    </tr>          
    <tr>
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0080' and @lang=$lang]" disable-output-escaping="yes"/>:    
      </p></td>
      <td>
        <xsl:apply-templates select="TARIFAS/PRODUCTO/PRO_UNIDADBASICA"/>      
      </td>
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0090' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </p></td>
      <td>
        <xsl:apply-templates select="TARIFAS/PRODUCTO/PRO_UNIDADESPORLOTE"/>      
      </td>
    </tr>
    <tr>
      <td valign="top"><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0190' and @lang=$lang]" disable-output-escaping="yes"/>:      
      </p></td>
      <td colspan="3">
        <xsl:apply-templates select="TARIFAS/PRODUCTO/PRO_TIPOIVA"/>      
      </td>
    </tr>    
    <tr bgcolor="#EEFFFF"><td colspan="4">&nbsp;</td></tr>    
    <tr bgcolor="#CCCCCC"> 
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0110' and @lang=$lang]" disable-output-escaping="yes"/>      
      </p></td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0010' and @lang=$lang]" disable-output-escaping="yes"/>     
      </p></td>
      <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0020' and @lang=$lang]" disable-output-escaping="yes"/>
        </p></td>
     <td><p class="tituloCamp">
        <xsl:value-of select="document('http://www.newco.dev.br/General/messages.xml')/messages/msg[@id='TRF-0030' and @lang=$lang]" disable-output-escaping="yes"/>
        </p></td>
    </tr>
    <xsl:for-each select="TARIFAS/TARIFAS_ROW">	
    <tr>
      <td><input type="checkbox" name="eliminar{@NUM}" value="{@NUM}"/></td>
      <td>         
        <xsl:apply-templates select="TRF_CANTIDAD"/> 
        </td>
      <td>         
        <xsl:apply-templates select="TRF_IMPORTE"/> 
        </td>
       <td>         
        <xsl:variable name="IDAct" select="TRF_IDDIVISA"/>
        <xsl:variable name="NUM_FILA" select="@NUM"/>        
        <xsl:apply-templates select="../../Comun/field"/>
       </td>
    </tr>
    </xsl:for-each>	
    <tr valign="top" align="center" bgcolor="#EEFFFF">    
      <td> 
        <xsl:apply-templates select="Comun/button[1]"/>
      </td>
      <td colspan="2" valign="top"> 
        <xsl:apply-templates select="Comun/button[2]"/>     
      </td>
      <td> 
        <xsl:apply-templates select="Comun/button[3]"/>
      </td>                 
    </tr>
  </table>
</form>
</xsl:template>


<!--CAMPS OCULTS-->

<xsl:template match="SALTAR">
  <input type="hidden" name="SALTAR">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="PRMEXTRA">
  <input type="hidden" name="PRMEXTRA">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="LISTAANTES">
  <input type="hidden" name="LISTAANTES">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>      
  </input>
</xsl:template>

<xsl:template match="PRO_ID">
  <input type="hidden" name="PRO_ID">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>      
  </input>
</xsl:template> 

<xsl:template match="MO_ID">
  <input type="hidden" name="MO_ID">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>      
  </input>
</xsl:template> 

<xsl:template match="EMP_ID">
  <input type="hidden" name="EMP_ID">
    <xsl:attribute name="value"><xsl:value-of select="."/> </xsl:attribute>      
  </input>
</xsl:template>   

<xsl:template match="TRF_CANTIDAD">
  <input type="text" style="text-align:right;">
    <xsl:attribute name="name">CANTIDAD<xsl:value-of select="../@NUM"/></xsl:attribute>      
  </input>
  <input type="hidden">
    <xsl:attribute name="name">TRF_CANTIDAD<xsl:value-of select="../@NUM"/></xsl:attribute>
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>  
  </input>
</xsl:template>

<xsl:template match="TRF_IMPORTE">
  <input type="text" style="text-align:right;">
    <xsl:attribute name="name">IMPORTE<xsl:value-of select="../@NUM"/></xsl:attribute>   
  </input>
  <input type="hidden">
    <xsl:attribute name="name">TRF_IMPORTE<xsl:value-of select="../@NUM"/></xsl:attribute>  
    <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute> 
  </input>  
</xsl:template>

  <xsl:template match="field">
    <xsl:apply-templates select="dropDownList"/>
  </xsl:template>
  
  <xsl:template match="dropDownList">
    <select>
      <xsl:attribute name="name"><xsl:value-of select="../@name"/><xsl:value-of select="$NUM_FILA"/></xsl:attribute>
      
      <!-- -->
      <xsl:choose>
       <xsl:when test="../@name='LISTA_EMPRESAS'">
        <xsl:attribute name="onChange">javascript:Cambio(document.forms[0],this);</xsl:attribute>
       </xsl:when>
      </xsl:choose>
      <!-- -->
      
      <xsl:for-each select="listElem">
        <xsl:choose>
          <xsl:when test="$IDAct = ID">
            <option selected="selected">
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>                       
   	      [<xsl:value-of select="listItem" disable-output-escaping="yes"/>]
            </option>
          </xsl:when>
          <xsl:otherwise>
            <option>
    	      <xsl:attribute name="value">
     	        <xsl:value-of select="ID"/>
  	      </xsl:attribute>
              <xsl:value-of select="listItem" disable-output-escaping="yes"/>
            </option> 
            </xsl:otherwise>
          </xsl:choose>
      </xsl:for-each>
    </select>
  </xsl:template>
  
  
</xsl:stylesheet>