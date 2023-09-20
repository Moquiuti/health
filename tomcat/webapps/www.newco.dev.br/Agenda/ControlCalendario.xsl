<?xml version="1.0" encoding="iso-8859-1" ?>
<!--

	Presenta un mes del CALENDARIO
	
	(c) may 2003 ET

	Parametros
	"ACTION"			->	Nombre del frame a recargar
	"PULSAR_DIA"		->	Accion a realizar si se pulsa sobre un dia
	"PULSAR_SEMANA"		->	Accion a realizar si se pulsa sobre una semana

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="CALENDARIO">
	<xsl:param name="ACCION"/>
	<xsl:param name="PULSAR_DIA"/>
	<xsl:param name="ACTIVO"/>
	
	<xsl:text disable-output-escaping="yes"><![CDATA[
	
	<script type="text/javascript">
	<!--
	
	var arrayEstilos=new Array();
	
	//	Funciones de Javascript
	function Actualizar(form)
	{
		//	Actualiza la fecha actual
		
		//AsignarDiaPulsado(form,form.elements['DIA'].value);
		obtenerNuevaFecha(form,form.elements['DIA'].value);
		
		//	Envia el formulario
		SubmitForm(form);
	}
	
	function FechaActiva()
	{
		return (document.forms[0].elements['FECHAACTIVA'].value);
	}

	function AsignarFechaActiva(Fecha)
	{
		document.forms[0].elements['FECHAACTIVA'].value=Fecha;
	}

  function obtenerClasePorDefectoDelDia(objDia){
    for(var n=0;n<arrayEstilos.length;n++){
      if(arrayEstilos[n][0]==objDia){
        return (arrayEstilos[n][1]);
      }
    }    
  }
  
  
  function obtenerDiaDeFecha(fecha){

    
    return parseInt(obtenerSubCadena(fecha, 1),10);
  }


 
	
	function AsignarDiaPulsado(form, dia)
	{
	  
		var bgcolorEstiloPorDefecto;
		var diaActivo;
		var clasePorDefecto;  
	  
	  /*
	     desactivamos todos los dias 
	  */
	   
	  
	  
	  for(var n=0;n<document.anchors.length;n++){

	    if(document.anchors[n].name.substring(0,6)=='FECHA_' && document.anchors[n].name.substring(6,document.anchors[n].name.length)!=dia){
	      clasePorDefecto=obtenerClasePorDefectoDelDia(document.getElementById(document.anchors[n].id).name);
	      if(clasePorDefecto=='claro'){
	        bgcolorEstiloPorDefecto='#EEFFFF';
	      }
	      else{
	        bgcolorEstiloPorDefecto='#EBEBEB';
	      }
	      document.getElementById(document.anchors[n].id).className=clasePorDefecto;
	      //document.getElementById(document.anchors[n].id).style.background=bgcolorEstiloPorDefecto;
	      document.getElementById(document.anchors[n].id).style.color='black';
	      document.getElementById(document.anchors[n].id).style.fontWeight='normal';
	    }
	  }
	  document.forms[0].elements['DIA'].value='';
		AsignarFechaActiva('');
	  
	  
	  /*
	    trabajamos con el dia actual
	  */
	  
	  
	  
	  clasePorDefecto=obtenerClasePorDefectoDelDia(document.getElementById(document.getElementById('FECHA_'+dia).id).name);
	  
	   
	  
	  //if(clasePorDefecto=='claro'){
	  //  bgcolorEstiloPorDefecto='#EEFFFF';
	  //}
	  //else{
	  //  bgcolorEstiloPorDefecto='#EBEBEB';
	 // }
	  
	  ]]></xsl:text>
	   <xsl:if test="$ACTIVO!='SIEMPRE'">
	   <xsl:text disable-output-escaping="yes"><![CDATA[
	  
	  if (document.getElementById('FECHA_'+dia).className=='diaActual'){
			document.getElementById('FECHA_'+dia).className=clasePorDefecto;
			//document.getElementById('FECHA_'+dia).style.background=bgcolorEstiloPorDefecto;
			document.getElementById('FECHA_'+dia).style.color='black';
			document.getElementById('FECHA_'+dia).style.fontWeight='normal';
			document.getElementById('FECHA_'+dia).blur();
			document.forms[0].elements['DIA'].value='';
		  AsignarFechaActiva('');
		  diaActivo=0;
		}
		else{
		
		]]></xsl:text>
		</xsl:if>
		<xsl:text disable-output-escaping="yes"><![CDATA[
		
			document.getElementById('FECHA_'+dia).className='diaActual';
			//document.getElementById('FECHA_'+dia).style.background='#A0D8D7';
			document.getElementById('FECHA_'+dia).style.color='blue';
			document.getElementById('FECHA_'+dia).style.fontWeight='bold';
			document.getElementById('FECHA_'+dia).blur();
			document.forms[0].elements['DIA'].value=dia;
		  AsignarFechaActiva(dia+'/'+form.elements['MES'].value+'/'+form.elements['ANYO'].value);
		  diaActivo=1;
		
		]]></xsl:text>
		<xsl:if test="$ACTIVO!='SIEMPRE'">
		<xsl:text disable-output-escaping="yes"><![CDATA[
	  }
	  ]]></xsl:text>
	  </xsl:if>
	  <xsl:text disable-output-escaping="yes"><![CDATA[
	  
	  
		return diaActivo;
	}
	
	
	function obtenerNuevaFecha(form,dia){
		  var vDia;
		  
		  var arrayMeses=new Array(31,28,31,30,31,30,31,31,30,31,30,31);
		  
		  if(dia==''){
		    vDia=new Date();
		    vDia=vDia.getDate();
		    form.elements['DIA'].value=vDia;
		  }
		  else{
		   vDia=dia;
		  }
		  
		  /* controlamos los final de mes */
		  
		  if(arrayMeses[form.elements['MES'].value-1]<vDia){
		    vDia=arrayMeses[form.elements['MES'].value-1];
		  }
		  
		  AsignarFechaActiva(vDia+'/'+form.elements['MES'].value+'/'+form.elements['ANYO'].value);
	}
	
	
	
	//-->
	</script>
        ]]></xsl:text>
	<form method="POST" name="form1">
		<xsl:attribute name="action"><!--CalendarioMensual.xsql-->
			<xsl:value-of select="$ACCION"/>
		</xsl:attribute>
		<input type="hidden" name="FECHAACTIVA">
			<xsl:attribute name="value"><xsl:value-of select="./@Fecha"/></xsl:attribute>
		</input>
		<input type="hidden" name="DIA">
			<xsl:attribute name="value"><xsl:value-of select="./@Dia"/></xsl:attribute>
		</input>
		<table width="200" border="0" align="center" cellspacing="1" cellpadding="1" class="medio">
			<tr class="oscuro">
				<td align="right" colspan="5">
				<xsl:call-template name="desplegable">
    				<xsl:with-param name="path" select="./MES/field">
    				</xsl:with-param>
					<xsl:with-param name="onChange">javascript:Actualizar(document.forms[0]);</xsl:with-param>
				</xsl:call-template>
				</td>				
				<td align="left" colspan="3">
				<xsl:call-template name="desplegable">
    				<xsl:with-param name="path" select="./ANYO/field">
    				</xsl:with-param>
					<xsl:with-param name="onChange">javascript:Actualizar(document.forms[0]);</xsl:with-param>
				</xsl:call-template>				
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
					<td align="center" class="oscuro">
						S<xsl:value-of select="./@Numero"/>
					</td>
					<xsl:for-each select="./DIA">
						<td align="center" valign="top">
							<xsl:attribute name="class">
								<!--<xsl:choose>
									<xsl:when test="./@Laborable='S'">claro</xsl:when>
									<xsl:otherwise>grisclaro</xsl:otherwise>
								</xsl:choose>-->
								<xsl:choose><xsl:when test="./@Clase"><xsl:value-of select="./@Clase"/></xsl:when><xsl:otherwise>grisclaro</xsl:otherwise></xsl:choose>
							</xsl:attribute>
							<xsl:choose>
							<xsl:when test="$PULSAR_DIA!=''">
								<a pepe="as">
								<xsl:attribute name="name">FECHA_<xsl:value-of select="./@Numero"/></xsl:attribute>
						    <xsl:attribute name="id">FECHA_<xsl:value-of select="./@Numero"/></xsl:attribute>
								<xsl:attribute name="href">javascript:if(AsignarDiaPulsado(document.forms[0],<xsl:value-of select="./@Numero"/>,'<xsl:choose><xsl:when test="./@Clase"><xsl:value-of select="./@Clase"/></xsl:when><xsl:otherwise>grisclaro</xsl:otherwise></xsl:choose>'))<xsl:value-of select="$PULSAR_DIA"/>; else frameVacio('AgendaTrabajo');</xsl:attribute>
								<xsl:value-of select="./@Numero"/>
								</a>
								<script type="text/javascript">
								    arrayEstilos[arrayEstilos.length]=new Array('FECHA_<xsl:value-of select="./@Numero"/>','<xsl:choose><xsl:when test="./@Clase"><xsl:value-of select="./@Clase"/></xsl:when><xsl:otherwise>grisclaro</xsl:otherwise></xsl:choose>');
								</script>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="./@Numero"/>
							</xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:for-each>	
				</tr>
			</xsl:for-each>	
		</table>
	</form>
</xsl:template>
</xsl:stylesheet>