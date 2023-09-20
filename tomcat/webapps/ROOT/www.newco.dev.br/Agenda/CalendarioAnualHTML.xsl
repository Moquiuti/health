<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Presenta un AÑO completo del CALENDARIO a un usuario
	
	(c) may 2003 ET

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
        <title>Calendario de MedicalVM</title>

	<xsl:text disable-output-escaping="yes"><![CDATA[
	<link rel="stylesheet" href="http://www.newco.dev.br/General/Estilos.css" type="text/css">
	<script type="text/javascript" src="http://www.newco.dev.br/General/general.js">
	</script>
	<script type="text/javascript">
	<!--
	
	
	
	// montamos un array con los anyos posibles  
	
	var arrayAnyos=new Array();
	
	]]></xsl:text>
	  
	  <xsl:for-each select="/CalendarioAnual/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
	    arrayAnyos[arrayAnyos.length]='<xsl:value-of select="ID"/>';
	  </xsl:for-each>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	
	// montamos una variable con los anyos por los que hemos pasado
	
	
	
	]]></xsl:text>
	  
	  var AnyosVisitados='<xsl:value-of select="/CalendarioAnual/ANYOS_VISITADOS"/>';
	  
	  <xsl:variable name="anyoActual"><xsl:value-of select="/CalendarioAnual/CALENDARIOANUAL/@Anyo"/></xsl:variable>
	  <xsl:variable name="anyosVisitados"><xsl:value-of select="/CalendarioAnual/ANYOS_VISITADOS"/></xsl:variable>
	  
	  
	  // si no hemos pasado por este anyo lo incluimos
	  <xsl:if test="not(contains($anyosVisitados,$anyoActual))">
	    AnyosVisitados=AnyosVisitados+'<xsl:value-of select="/CalendarioAnual/CALENDARIOANUAL/@Anyo"/>'+'|';
	  </xsl:if>
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	
	
	var arrayEstilos=new Array();
	
	//	Funciones de Javascript

	
	function obtenerClasePorDefectoDelDia(objDia){
    for(var n=0;n<arrayEstilos.length;n++){
      if(arrayEstilos[n][0]==objDia){
        return (arrayEstilos[n][1]);
      }
    }    
  }
	
	
	//	Cambia la clase del "anchor" correspondiente al dia modificado
	function Pulsado(ControlPulsado)
	{
	  var bgcolorEstiloPorDefecto;
	  var clasePorDefecto;
	  
	  clasePorDefecto=obtenerClasePorDefectoDelDia(document.getElementById(ControlPulsado).name);
	  
	  //if(clasePorDefecto=='claro'){
	  //  bgcolorEstiloPorDefecto='#EEFFFF';
	  //  fontColorEstiloPorDefecto;
	  //  fontWeightEstiloPorDefecto;
	  //  document.getElementById(ControlPulsado).style.color='black';
	  //}
	  ////else{
	  //  bgcolorEstiloPorDefecto='#EBEBEB';
	  //}
	    
	    
		if (document.getElementById(ControlPulsado).className=='diasVacaciones'){
			document.getElementById(ControlPulsado).className=clasePorDefecto;
			document.getElementById(ControlPulsado).style.color='black';
			document.getElementById(ControlPulsado).style.fontWeight='normal';
			document.getElementById(ControlPulsado).blur();
		}
		else{
			document.getElementById(ControlPulsado).className='diasVacaciones';
			document.getElementById(ControlPulsado).style.color='red';
			document.getElementById(ControlPulsado).style.fontWeight='bold';
			document.getElementById(ControlPulsado).blur();
	  }
	}
	
	// funcion para montar la cadena de resultados
	function montarCadenaResultados(){

	  ]]></xsl:text>
	    var anyoActual='<xsl:value-of select="//CalendarioAnual/CALENDARIOANUAL/@Anyo"/>';
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	  
	  /* quitamos las vacaciones de este anyo y las volvemos a montar, junto con los demas anyos*/
	  
	    var arrayResultadoTmp=document.forms['form1'].elements['RESULTADO'].value.split('|');
	    
	  
	    var Resultado='';
	    
	    for(var n=0;n<arrayResultadoTmp.length;n++){
	      if(arrayResultadoTmp[n]!=''){
	        if(!existeSubCadena(arrayResultadoTmp[n], anyoActual)){
	          Resultado+=arrayResultadoTmp[n]+'|';
	        }
	      }
	    }

       /* tratamos las de este anyo */	  

		for (i=0;i<document.anchors.length;++i)
		{
			if (document.anchors[i].className=="diasVacaciones")
				Resultado=Resultado+document.anchors[i].name+'|';
		}
		
		return Resultado;
	  
	}
	
	

	//	Guarda los cambios creando una cadena a partir de los "anchor" correspondientes a los dias modificados
	function Guardar()
	{
		
    document.forms[0].elements['ANYOS_VISITADOS'].value=AnyosVisitados;
		document.forms[0].elements['RESULTADO'].value=montarCadenaResultados();
		
		//	Envia el formulario

		SubmitForm(document.forms[0]);
		
	}
	
	function CerrarVentana(){
	  ]]></xsl:text>
	    <xsl:choose>
	      <xsl:when test="/CalendarioAnual/VENTANA='NUEVA'">
	        window.close();
	      </xsl:when>
	      <xsl:otherwise>
	        document.location.href='about:blank';
	      </xsl:otherwise>
	    </xsl:choose>
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	}
	
	function IncrementarAnyo(incremento){
  
	  ]]></xsl:text>
	    var idusuarioAgenda='<xsl:value-of select="CalendarioAnual/IDUSUARIOAGENDA"/>';
	    var accion='<xsl:value-of select="CalendarioAnual/CALENDARIOANUAL/@Accion"/>';
	    var titulo='<xsl:value-of select="CalendarioAnual/CALENDARIOANUAL/@Titulo"/>';
	    var ventana='<xsl:value-of select="CalendarioAnual/VENTANA"/>';
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	  
	  // montamos la cadena
	  document.forms[0].elements['RESULTADO'].value=montarCadenaResultados();
	  
	  // calculamos el anyo destino
	  var anyoDestino=Number(obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 3))+Number(incremento);
	  document.forms['form1'].elements['FECHAACTIVA'].value=obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 1)+'/'+obtenerSubCadena(document.forms['form1'].elements['FECHAACTIVA'].value, 2)+'/'+anyoDestino;
	  
	  document.location.href='http://www.newco.dev.br/Agenda/CalendarioAnual.xsql?ACCION='+accion+'&TITULO='+titulo+'&FECHAACTIVA='+document.forms['form1'].elements['FECHAACTIVA'].value+'&IDUSUARIOAGENDA='+idusuarioAgenda+'&RESULTADO_TMP='+document.forms['form1'].elements['RESULTADO'].value+'&ANYOS_VISITADOS='+AnyosVisitados+'&VENTANA='+ventana;
	}
	
	
	//-->
	</script>
        ]]></xsl:text>
        
      </head>  
        <xsl:choose>
          <xsl:when test="//xsql-error"> 
          <P class="tituloform">     
            <xsl:apply-templates select="//xsql-error"/>
          </P>
          </xsl:when>
          <xsl:otherwise>
          
           
          
<body leftMargin="0" topMargin="0" marginheight="0" marginwidth="0" class="blanco">
	<!--	Solo creamos el formulario si tiene una accion definida	-->
	<xsl:if test="/CalendarioAnual/CALENDARIOANUAL/@Accion">
		<form method="POST" name="form1">
			<xsl:attribute name="action"><xsl:value-of select="/CalendarioAnual/CALENDARIOANUAL/@Accion"/></xsl:attribute>
			<input type="hidden" name="RESULTADO" value="{/CalendarioAnual/RESULTADO_TMP}"/>
			<input type="hidden" name="FECHAACTIVA" value="{/CalendarioAnual/FECHAACTIVA}"/>
			<input type="hidden" name="ANYOS_VISITADOS"/>
			
			
			<input type="hidden" name="ANYO">
				<xsl:attribute name="value"><xsl:value-of select="/CalendarioAnual/CALENDARIOANUAL/@Anyo"/></xsl:attribute>
			</input>
		</form>
	</xsl:if>
	<!-- botones de siguiente / anterior -->

	<table width="100%" align="center" border="0">
    <tr>
      <!-- solo mostramos el de anterior si no estamos al inicio del rango -->
      <xsl:for-each select="/CalendarioAnual/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
	      <xsl:if test="position()=1">
	        <td width="25%" align="center" valign="bottom">
	          <xsl:if test="not(ID=//CalendarioAnual/CALENDARIOANUAL/@Anyo)">
              <xsl:call-template name="botonPersonalizado">
	              <xsl:with-param name="funcion">IncrementarAnyo(-1);</xsl:with-param>
	              <xsl:with-param name="label">Anterior</xsl:with-param>
	              <xsl:with-param name="status">Ir al año anterior</xsl:with-param>
	              <xsl:with-param name="ancho">120px</xsl:with-param>
	              <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	              <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
	          </xsl:if>
	        </td> 
	      </xsl:if>
	    </xsl:for-each>
	    
	    <td align="center" width="*">
	      <p class="tituloPag" align="center"><br/>
		      <xsl:value-of select="/CalendarioAnual/CALENDARIOANUAL/USUARIOAGENDA"/>&nbsp;(<xsl:value-of select="/CalendarioAnual/CALENDARIOANUAL/@Anyo"/>:&nbsp;<xsl:value-of select="CalendarioAnual/CALENDARIOANUAL/@Titulo"/>)
		      <!--	Falta incluir el titulo de la pagina: Vacaciones, copia de tarea, etc.	-->
		      <!--	Falta incluir el nombre del usuario	o desplegable con usuarios	-->
	      </p>
	      <br/>
	    </td>
	    
	    <!-- solo mostramos el de siguiente si no estamos al final del rango -->
	    <xsl:for-each select="/CalendarioAnual/CALENDARIOANUAL/ANYO/field/dropDownList/listElem">
        <xsl:if test="position()=last()">
	        <td width="25%" align="center" valign="bottom">
	          <xsl:if test="not(ID=//CalendarioAnual/CALENDARIOANUAL/@Anyo)">
              <xsl:call-template name="botonPersonalizado">
	              <xsl:with-param name="funcion">IncrementarAnyo(1);</xsl:with-param>
	              <xsl:with-param name="label">Siguiente</xsl:with-param>
	              <xsl:with-param name="status">Ir al año siguiente</xsl:with-param>
	              <xsl:with-param name="ancho">120px</xsl:with-param>
	              <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	              <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
	          </xsl:if>
	        </td>
	      </xsl:if>
	    </xsl:for-each>
    </tr>
  </table>
	
	<table width="95%" border="0" align="center" cellspacing="10" cellpadding="10" class="blanco">
		<xsl:for-each select="/CalendarioAnual/CALENDARIOANUAL/LINEA">
			<tr valign="top">
				<xsl:for-each select="./CALENDARIO">
					<td align="center">
						<table width="160" border="0" align="center" cellspacing="1" cellpadding="1" class="oscuro">
							<xsl:apply-templates select="."/>
						</table>
					</td>				
				</xsl:for-each>	
			</tr>
		</xsl:for-each>	
		<xsl:if test="not(/CalendarioAnual/CALENDARIOANUAL/EDICION)">
		  <tr class="blanco">
        <td colspan="12" align="left" class="blanco">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;
          el color <font color="red">rojo</font> indica los días reservados por el usuario
        </td>
      </tr>
  </xsl:if>
  
  
  
  
		<!--	Sin accion no tiene sentido el boton de enviar formulario	-->
		<xsl:choose>
		  <xsl:when test="/CalendarioAnual/CALENDARIOANUAL/EDICION">
			  <xsl:if test="/CalendarioAnual/CALENDARIOANUAL/@Accion">
				  <tr valign="top">
				    <td align="center" colspan="2">
	            <xsl:call-template name="botonPersonalizado">
	            		  <xsl:with-param name="funcion">CerrarVentana();</xsl:with-param>
	            		  <xsl:with-param name="label">Cancelar</xsl:with-param>
	            		  <xsl:with-param name="status">Cancelar</xsl:with-param>
	            		  <xsl:with-param name="ancho">120px</xsl:with-param>
	            		  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	            		  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
					  </td>		
					  <td align="center" colspan="2">
	            		<xsl:call-template name="botonPersonalizado">
	            		  <xsl:with-param name="funcion">Guardar();</xsl:with-param>
	            		  <xsl:with-param name="label">Guardar los cambios</xsl:with-param>
	            		  <xsl:with-param name="status">Guardar</xsl:with-param>
	            		  <xsl:with-param name="ancho">120px</xsl:with-param>
	            		  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	            		  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            		</xsl:call-template> 
					  </td>				
				  </tr>
				  
			  </xsl:if>
		  </xsl:when>
		  <xsl:otherwise>
		    <tr valign="top">
					  <td align="center" colspan="4">
	            <xsl:call-template name="botonPersonalizado">
	            		  <xsl:with-param name="funcion">CerrarVentana();</xsl:with-param>
	            		  <xsl:with-param name="label">Cerrar la ventana</xsl:with-param>
	            		  <xsl:with-param name="status">Cerrar</xsl:with-param>
	            		  <xsl:with-param name="ancho">120px</xsl:with-param>
	            		  <xsl:with-param name="backgroundBoton">oscuro</xsl:with-param>
	            		  <xsl:with-param name="foregroundBoton">blanco</xsl:with-param>
	            </xsl:call-template> 
					  </td>				
				  </tr>
		  </xsl:otherwise>
		</xsl:choose>
	</table>
</body>
  

</xsl:otherwise>
</xsl:choose>
</html>
</xsl:template>

<!--	"Template" correspondiente al calendario de un mes		-->
<xsl:template match="CALENDARIO">
	<tr>
		<td align="center" class="oscuro" colspan="8" >
			<xsl:value-of select="./@Mes"/>
		</td>
	</tr>
	<tr class="oscuro">
		<td width="9%" align="center">&nbsp;</td>
		<td width="13%" align="center">L</td>
		<td width="13%" align="center">M</td>
		<td width="13%" align="center">X</td>
		<td width="13%" align="center">J</td>
		<td width="13%" align="center">V</td>
		<td width="13%" align="center">S</td>	
		<td width="13%" align="center">D</td>
	</tr>
	<xsl:for-each select="./SEMANA">
		<tr>
			<!--	Semana		-->
			<td align="center" class="oscuro" >
				S<xsl:value-of select="./@Numero"/>
			</td>
			<xsl:for-each select="./DIA">
				<td align="center" valign="top">
				
					<xsl:attribute name="class">
						<!--<xsl:choose>
							<xsl:when test="./@Laborable='S'">claro</xsl:when>
							<xsl:otherwise>grisclaro</xsl:otherwise>
						</xsl:choose>-->
						<!-- 
						  en edicion, mantenemos, las classes, claro - laborable, oscuro - fin de semana. 
						  si es solo lectura, rojo - vacaciones )  -->
						
						    <xsl:choose>
							    <xsl:when test="./@Clase">
							      <xsl:value-of select="./@Clase"/>
							    </xsl:when>
							    <xsl:otherwise>grisclaro</xsl:otherwise>
						    </xsl:choose>
						  
					</xsl:attribute>
					<xsl:if test="./@Vacaciones='S'">
				  </xsl:if>
					<xsl:choose>
				    <xsl:when test="//CalendarioAnual/CALENDARIOANUAL/EDICION">
					    
						    
						    <xsl:variable name="anyosVisitados"><xsl:value-of select="//CalendarioAnual/ANYOS_VISITADOS"/></xsl:variable>
						    <xsl:variable name="anyoActual"><xsl:value-of select="//CalendarioAnual/CALENDARIOANUAL/@Anyo"/></xsl:variable>
					    
					    <a 	onMouseOver="window.status='Marcar este día';return true;" 
						      onMouseOut="window.status='';return true;" >
						    <xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						    <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:attribute>
						    <xsl:attribute name="href">javascript:Pulsado('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>');</xsl:attribute>
						    
						    <!-- cuando no hayamos pasado por este anyo utilizamos los de la BD, si no los temporales-->
						    <xsl:choose>
						      <xsl:when test="contains($anyosVisitados,$anyoActual)">
						        <xsl:variable name="resultado_tmp"><xsl:value-of select="//CalendarioAnual/RESULTADO_TMP"/></xsl:variable>
						        <xsl:variable name="diaActual">FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/></xsl:variable>
						        <xsl:if test="contains($resultado_tmp,$diaActual)">
						          <xsl:attribute name="class">diasVacaciones</xsl:attribute>
						          <xsl:attribute name="style">color:red;font-weight:bold;</xsl:attribute>
						        </xsl:if>
						      </xsl:when>
						      <xsl:otherwise>
						        <xsl:if test="./@Vacaciones='S'">
						          <xsl:attribute name="class">diasVacaciones</xsl:attribute>
						          <xsl:attribute name="style">color:red;font-weight:bold;</xsl:attribute>
						        </xsl:if>
						      </xsl:otherwise>
						    </xsl:choose>
						    <xsl:value-of select="./@Numero"/>
					    </a>
					  </xsl:when>
					  <xsl:otherwise>
						  <xsl:choose>
						    <xsl:when test="./@Vacaciones='S'">
						      <font color="red">
					          <b><xsl:value-of select="./@Numero"/></b>
					        </font>
						    </xsl:when>
						    <xsl:otherwise> 
						      <xsl:value-of select="./@Numero"/>
						    </xsl:otherwise>
						  </xsl:choose>
					  </xsl:otherwise>
				  </xsl:choose>
					<script type="text/javascript">
				    arrayEstilos[arrayEstilos.length]=new Array('FECHA_<xsl:value-of select="./@Numero"/>/<xsl:value-of select="../../@Numero"/>/<xsl:value-of select="../../@Anyo"/>','<xsl:choose><xsl:when test="./@Clase"><xsl:value-of select="./@Clase"/></xsl:when><xsl:otherwise>grisclaro</xsl:otherwise></xsl:choose>');
					</script>
				</td>
			</xsl:for-each>	
		</tr>
	</xsl:for-each>	
</xsl:template>

 
</xsl:stylesheet>
