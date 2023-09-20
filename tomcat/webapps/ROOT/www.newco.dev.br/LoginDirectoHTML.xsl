<?xml version="1.0" encoding="iso-8859-1"?>
<!-- 
	Acceso directo al área privada 
	Ultima revisión: ET 27ene21 16:50
	
	http://www.newco.dev.br/LoginDirecto.xsql?IDUSUARIOEXT=MVMOHSJD&ACCION=NUEVOPEDIDO&HOJADEGASTOS=A3546567&NUMCEDULA=461340000&NOMBREPACIENTE=Pedro%20Prueba&HABITACION=705
	
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="iso-8859-1" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script type="text/javascript">
	var v_IDSesion='<xsl:value-of select="/Acceso/ACCESO_OK/SES_ID"/>';
	var v_Dominio='http://www.newco.dev.br/';
	var Accion	='<xsl:value-of select="/Acceso/ACCION"/>';
	var HojaDeGastos	='<xsl:value-of select="/Acceso/HOJADEGASTOS"/>';
	var NumCedula	='<xsl:value-of select="/Acceso/NUMCEDULA"/>';
	var NombrePaciente	='<xsl:value-of select="/Acceso/NOMBREPACIENTE"/>';
	var Habitacion	='<xsl:value-of select="/Acceso/HABITACION"/>';
	
	function Redirigir()
	{
		if (v_IDSesion=='')
			alert('Código externo de usuario incorrecto, no se ha podido acceder a la plataforma');
		else
		{
			SetCookie('SES_ID', v_IDSesion);
			
			var Dest=v_Dominio+"MenusYDerechos/Main2017.xsql?ACCION="+Accion+"&amp;"+"HOJADEGASTOS="+encodeURIComponent(HojaDeGastos)+"&amp;"
						+"NUMCEDULA="+encodeURIComponent(NumCedula)+"&amp;"+"NOMBREPACIENTE="+encodeURIComponent(NombrePaciente)+"&amp;"+"HABITACION="+encodeURIComponent(Habitacion)
			
			//alert('LoginDirecto. Redirigir Dest:'+Dest);
			
			document.location.href=Dest;
		}
	}

	// Creacion de una cookie con nombre sName y valor sValue
	function SetCookie(sName, sValue)
	{ 
		//solodebug 	console.log('SetCookie name:'+sName+' value:'+sValue);
		document.cookie = sName + "=" + escape(sValue) + ";host="+v_Dominio+";path=/;SameSite=Strict;";	
	}
		
	</script>
</head>
<body onload="javascript:Redirigir();">
</body>
</html>
</xsl:template>
</xsl:stylesheet>
