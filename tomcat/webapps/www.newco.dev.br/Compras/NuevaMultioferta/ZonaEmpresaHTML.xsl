<?xml version="1.0" encoding="iso-8859-1" ?>
<!--
	Margen izquierdo del mantenimiento de empresas
	ultima revision: 20ago18 11:30
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href = "http://www.newco.dev.br/General/General.xsl" />
  
  <xsl:output media-type="text/html" method="html" encoding="iso-8859-1"/>
  <xsl:param name="lang" select="@lang"/>  
  <xsl:template match="/">
    <html>
      <head>
      
      <!--style-->
      <xsl:call-template name="estiloIndip"/>
      <!--fin de style-->  
      
      <!--idioma-->
        <xsl:variable name="lang">
            <xsl:value-of select="/Generar/LANG"/>
        </xsl:variable>
        <xsl:value-of select="$lang"/>
        <xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
        <!--idioma fin-->

		<script type="text/javascript" src="http://www.newco.dev.br/General/jquery.js"></script>
		<script type="text/javascript" src="http://www.newco.dev.br/General/basic_180608.js"></script>
     
		<xsl:text disable-output-escaping="yes"><![CDATA[
		<script type="text/javascript">
		
		<!--
		//
		//	Funciones con Empresas
		//
		
		]]></xsl:text>
        
        var msgSinCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinCentro']/node()"/>';
        var msgSinEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinEmpresa']/node()"/>';
        var msgBorrarEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgBorrarEmpresa']/node()"/>';
		var msgBorrarCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgBorrarCentro']/node()"/>';
		var msgBorrarUsuario='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgBorrarUsuario']/node()"/>';
		var msgSinDerechosEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='msgSinDerechosEmpresa']/node()"/>';
        var usuarioConectadoNoEliminar ='<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarioConectadoNoEliminar']/node()"/>';
        var usuarioConPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarioConPedidos']/node()"/>';
        var usuarioConPedidosHistoricos='<xsl:value-of select="document($doc)/translation/texts/item[@name='usuarioConPedidosHistoricos']/node()"/>';
        var centroConPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='centroConPedidos']/node()"/>';
        var empresaConPedidos='<xsl:value-of select="document($doc)/translation/texts/item[@name='empresaConPedidos']/node()"/>';
        var seguroEliminarUsuario='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguroEliminarUsuario']/node()"/>';
        var seguroEliminarCentro='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguroEliminarCentro']/node()"/>';
        var seguroEliminarEmpresa='<xsl:value-of select="document($doc)/translation/texts/item[@name='seguroEliminarEmpresa']/node()"/>';
        var noEmpresaActiva='<xsl:value-of select="document($doc)/translation/texts/item[@name='noEmpresaActiva']/node()"/>';
        var noEmpresaActivaBorrar='<xsl:value-of select="document($doc)/translation/texts/item[@name='noEmpresaActivaBorrar']/node()"/>';
		
		<xsl:choose>
		  <xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">
		    var derechosEmpresa=1;
		  </xsl:when>
		  <xsl:otherwise>
		    var derechosEmpresa=0;
		  </xsl:otherwise>
		</xsl:choose>
		
		<xsl:text disable-output-escaping="yes"><![CDATA[
		
     	function NuevaEmpresa() 
		{
			var IDPais = document.forms[0].elements['IDPAIS'].value;
			var IDUsuario = document.forms[0].elements['IDUSUARIO'].value;
			
			//solodebug	alert('IDPais:'+IDPais+' IDUsuario:'+IDUsuario);

     	   	parent.areaTrabajo.location.href='./EMPNueva.xsql?EMP_IDPAIS='+IDPais+'&IDUSUARIO='+IDUsuario+']]></xsl:text><xsl:if test="//ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION"><xsl:text disable-output-escaping="yes"><![CDATA[&]]></xsl:text>ADMINISTRADORMVM=ADMINISTRADORMVM</xsl:if><xsl:text disable-output-escaping="yes"><![CDATA[';
     	} 

	function EditarEmpresa(){
		var emp_id = document.forms[0].elements['IDEMPRESA'].value;

		if(emp_id==-1)
			alert(noEmpresaActiva);
		else
			parent.areaTrabajo.location.href='./EMPManten.xsql?ID='+emp_id+'&ADMINISTRADORMVM=]]></xsl:text><xsl:if test="//ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">ADMINISTRADORMVM</xsl:if><xsl:text disable-output-escaping="yes"><![CDATA[';
	}
          
     	
     	// No dejamos borrar la última Empresa. De esta forma aseguramos que no nos quedamos sin Empresas.
     	// Comprobamos si tiene pedidos, si tiene no borramos, 29-11-13 - problema de borrar todo viamed viejo
     	
     	function BorrarEmpresa() 
		{
     	]]></xsl:text>
     	var usuarioAdministrador=<xsl:value-of select="ZonaEmpresa/US_ID"/>;
     	<xsl:text disable-output-escaping="yes"><![CDATA[
     	
     	if(sinoSeBorraAsiMismoEnviarCambios('BORRAREMPRESA',usuarioAdministrador)){
     	  var emp_actual = document.forms[0].elements['IDEMPRESA'].value;

	  		if (emp_actual==-1)
	  			alert(noEmpresaActivaBorrar);
			else
			{	
            	//si empresa tiene pedidos no se puede borrar
                jQuery.ajax({
                    //cache:	false,
                    url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmEliminarEmpresa.xsql',
                    type:	"GET",
                    data:	"IDEMPRESA="+emp_actual,
                    //contentType: "application/xhtml+xml",
                    success: function(objeto){
                        var data = eval("(" + objeto + ")");
                        
                        //alert('succes data '+data.confirmEliminarEmpresa.estado);
                        //si tiene pedidos devuelve S
                        if(data.confirmEliminarEmpresa.estado == 'S'){
                            
                            alert(empresaConPedidos);
                        }
                        //si no tiene pedidos envio cambios, elimino empresa
                        else{ 
                            //trozo que comprueba y elimina
                            contestacion = confirm(seguroEliminarEmpresa);
                            if (!contestacion) 
                                return;
                            else
	      					EnviarCambios('BORRAREMPRESA', emp_actual);
                         }
                    },
                    error: function(xhr, errorString, exception) {
                        alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
                    }
                });
     	    	
			}//FIN ELSE ANTES DE AJAX
	  	  } 
     	}//FIN BORRAR EMPRESA
		
		
		//	11ene17	Cambio de pais
		function CambioPaisActual(IDPais)
		{
			//SOLODEBUG	alert('pais_id:'+IDPais);
			
			parent.areaTrabajo.location.href='about:blank';
			
            document.forms[0].elements['ACCION'].value='CAMBIOPAIS';
            document.forms[0].elements['IDNUEVOPAIS'].value=IDPais
            document.forms[0].elements['IDNUEVAEMPRESA'].value='-1';
            document.forms[0].elements['IDNUEVOCENTRO'].value='-1';
            SubmitForm(document.forms[0]);
		}
		
		
        // Hacemos el cambio de la Empresa ACTUAL.
        //esta funcion recibe un parametro (opcionalmente) cuando se llama desde otro frame (nueva Empresa)este parametro es el id de la empresa recien creada.
        //si la funcion tiene parametro lo utilizamos en lugar de  document.forms[0].elements['IDEMPRESA'].value;
        
     	function CambioEmpresaActual(emp_id)
		{
            document.forms[0].elements['ACCION'].value='CAMBIOEMPRESA';
            document.forms[0].elements['IDNUEVOCENTRO'].value=-1;
            if(arguments.length>0)
              document.forms[0].elements['IDNUEVAEMPRESA'].value=arguments[0];
            else
              document.forms[0].elements['IDNUEVAEMPRESA'].value=document.forms[0].elements['IDEMPRESA'].value;
            SubmitForm(document.forms[0]);
        }
	  
	  
	  
		function RecargarEmpresaActual(emp_id)
		{
     	    document.forms[0].elements['ACCION'].value='CAMBIOEMPRESA';
     	    //document.forms[0].elements['IDNUEVOCENTRO'].value=-1;
     	    if(arguments.length>0)
     	      document.forms[0].elements['IDNUEVAEMPRESA'].value=arguments[0];
     	    else
     	      document.forms[0].elements['IDNUEVAEMPRESA'].value=document.forms[0].elements['IDEMPRESA'].value;
	   		 SubmitForm(document.forms[0]);
		}
		
		//
        // Hacemos el cambio de la Centro ACTUAL.
        //
        
        function ActualizarNuevaEmpresa(emp_id){
          parent.areaTrabajo.location='about:blank';
          CambioEmpresaActual(emp_id);
        }
        
     	function CambioCentroActual(emp_id, cen_id)
		{	
	          document.forms[0].elements['ACCION'].value='CAMBIOCENTRO';
     	          if(arguments.length>0){
                    document.forms[0].elements['IDNUEVAEMPRESA'].value=arguments[0];
     	            document.forms[0].elements['IDNUEVOCENTRO'].value=arguments[1];
                    }
     	          else{
                  
                    document.forms[0].elements['IDNUEVAEMPRESA'].value=document.forms[0].elements['IDEMPRESA'].value;
     	            document.forms[0].elements['IDNUEVOCENTRO'].value=document.forms[0].elements['IDCENTRO'].value;
                    }
	          SubmitForm(document.forms[0]);
			  //CambioCentro(document.forms[0].elements['IDNUEVOCENTRO'].value,document.forms[0].elements['IDNUEVAEMPRESA'].value);
		}
		
     	function CambioCentro(cen_id, emp_id){
     	    document.forms[0].elements['ACCION'].value='CAMBIOCENTRO';
     	    document.forms[0].elements['IDNUEVOCENTRO'].value=cen_id;
            document.forms[0].elements['IDNUEVAEMPRESA'].value=emp_id;
			SubmitForm(document.forms[0]);
     	}
     	
     	function EditarCentro()
		{
     	  var cen_id = document.forms[0].elements['IDCENTRO'].value;
     	  var emp_id = document.forms[0].elements['IDEMPRESA'].value;
	  		if (cen_id==-1)
	  			alert(msgSinCentro);
			else
			{
     	  		parent.areaTrabajo.location.href='./CENManten.xsql?ID='+cen_id;
			}
     	} 

    
     	// No dejamos borrar la última Centro. De esta forma aseguramos que no nos quedamos sin Centros.
     	// tb comprobamos si el centro titne pedidos, si tiene no se puede borrar-29-11-13 desp de eliminacion viamed antiguo que creo problemas
        
     	function BorrarCentro() 
		{
     	  var pl_actual = document.forms[0].elements['IDCENTRO'].value;
     	  ]]></xsl:text>
     	  var usuarioAdministrador=<xsl:value-of select="ZonaEmpresa/US_ID"/>;
     	  <xsl:text disable-output-escaping="yes"><![CDATA[
     	  if(sinoSeBorraAsiMismoEnviarCambios('BORRARCENTRO',usuarioAdministrador)){

	  		if (pl_actual==-1)
	  			alert(msgSinCentro);
			else {
                //si centro tiene pedidos no se puede borrar
                jQuery.ajax({
                    //cache:	false,
                    url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmEliminarCentro.xsql',
                    type:	"GET",
                    data:	"IDCENTRO="+pl_actual,
                    //contentType: "application/xhtml+xml",
                    success: function(objeto){
                        var data = eval("(" + objeto + ")");
                        
                        //alert('succes data '+data.confirmEliminarCentro.estado);
                        //si tiene pedidos devuelve S
                        if(data.confirmEliminarCentro.estado == 'S'){
                            
                            alert(centroConPedidos);
                        }
                        //si no tiene pedidos envio cambios, elimino usuario
                        else{ 
                            //trozo que elimina centro previa confirmacion
                            contestacion = confirm(seguroEliminarCentro);
                            if (!contestacion) 
                                return;
                            else
                                EnviarCambios('BORRARCENTRO', pl_actual);
                         }
                    },
                    error: function(xhr, errorString, exception) {
                        alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
                    }
                });
             }  
          }  
			
	  
     	}//FIN FUNCION BORRARCENTRO
     	
     	function CopiarCentro(pl_id) 
		{
     		document.location.href='../Multioferta/PLManten.xsql?PL_ID='+pl_id+'&amp;BOTON=COPIAR';
     	}	
     	
     	function NuevoCentro() 
		{
		if(document.forms[0].elements['IDEMPRESA'].value>0){
     	   	  parent.areaTrabajo.location.href='./CENManten.xsql?EMP_ID='+document.forms[0].elements['IDEMPRESA'].value+'&amp;ID=';
     	   	}
     	   	else{
     	   	  alert(msgSinEmpresa);
     	   	}
     	} 
		
		
		function InsertarProducto(idProducto)
		{ 
		 	var pl_actual = document.forms[0].elements['IDCENTRO'].value;
	  		if (pl_actual==-1)
	  			alert(msgSinCentro);
			else
			{
				EnviarCambios('INSERTARPRODUCTO', idProducto);
			}
		}
     	
              
        function ComprobarAntesBorrarUsuario(idUsuario){
          
          //no puedo borrar mi mismo usuario
              var us_conectado = document.forms[0].elements['US_ID'].value;  
              
              if (us_conectado == idUsuario){ 
                    alert(usuarioConectadoNoEliminar); 
                   
                }
              else{
                //si usuario tiene pedidos historicos o activos no se puede borrar
                  jQuery.ajax({
                      //cache:	false,
                      url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/comprobarAntesEliminarUsuario.xsql',
                      type:	"GET",
                      data:	"IDUSUARIO="+idUsuario,
                      //contentType: "application/xhtml+xml",
                      success: function(objeto){
                          var data = eval("(" + objeto + ")");

                          //alert('succes data '+data.comprobarAntesEliminarUsuario.estado);

                          //si tiene pedidos activos devuelve KO|1
                          if(data.comprobarAntesEliminarUsuario.estado == 'KO|1'){
                              alert(usuarioConPedidos);
                              return false;
                          }
                          //si tiene pedidos historicos devuelve KO|2
                          else if(data.comprobarAntesEliminarUsuario.estado == 'KO|2'){ 
                              alert(usuarioConPedidosHistoricos);
                              return false;
                           }
                          else if (data.comprobarAntesEliminarUsuario.estado == 'OK|'){ 
                              BorrarUsuario('BORRARUSUARIO', idUsuario);
                          }

                      },
                      error: function(xhr, errorString, exception) {
                          alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
                      }
                  });
              }//fin de else
           
     	}//fin comprobar si se puede borrar usuario
              
            
        //comprobamos si el usuario tiene pedidos, si tiene no se puede borrar-29-11-13 desp de eliminacion viamed antiguo que creo problemas
     	function BorrarUsuario(accion, idUsuario){
     	  ]]></xsl:text>
     	var usuarioAdministrador=<xsl:value-of select="ZonaEmpresa/US_ID"/>;
     	<xsl:text disable-output-escaping="yes"><![CDATA[
     	
     	  if(sinoSeBorraAsiMismoEnviarCambios('BORRARUSUARIO',usuarioAdministrador, idUsuario)){
          
          	//si usuario tiene pedidos no se puede borrar
            jQuery.ajax({
                //cache:	false,
                url:	'http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/confirmEliminarUsuario.xsql',
                type:	"GET",
                data:	"IDUSUARIO="+idUsuario,
                //contentType: "application/xhtml+xml",
                success: function(objeto){
                    var data = eval("(" + objeto + ")");
        			
                    //alert('succes data '+data.confirmEliminarUsuario.estado);
                    //si tiene pedidos devuelve S
                    if(data.confirmEliminarUsuario.estado == 'S'){
                    	
                        alert(usuarioConPedidos);
                    }
                    //si no tiene pedidos envio cambios, elimino usuario
                    else{ 
                    	//trozo que comprueba y elimina
                    	if(confirm(seguroEliminarUsuario)){
                  			document.forms[0].elements['IDUSUARIO'].value=idUsuario;
                  			EnviarCambios(accion, idUsuario);
              		 	}
                     }
                },
                error: function(xhr, errorString, exception) {
                    alert("xhr.status="+xhr.status+" error="+errorString+" exception="+exception);
                }
            });
           
     	  }
     	}
     	
     	function EnviarCambios(accion, id)
		{
     	
     	  var centro_actual = document.forms[0].elements['IDCENTRO'].value;

			
     	    document.forms[0].elements['ACCION'].value=accion;
	    	//document.forms[0].elements['IDPRODUCTO'].value=idProducto;
	    	SubmitForm(document.forms[0]);
	    
     	    
     	    //var laUrl=top.mainFrame.Trabajo.zonaTrabajo.location;
     	    //laUrl=String(laUrl);
     	    
     	    /*
     	        si en zonaTrabajo esta cargado el Centro lo recargamos
     	    */
     	    
     	    //if(laUrl.match('LPLista.xsql') && laUrl.match('PL_ID='+pl_actual)){
     	      //top.mainFrame.areaTrabajo.zonaTrabajo.location.href='about:blank';
     	    //}
     	    	
	 }
	  
	  
	  
	function MostrarCentro(){
	  var pl_id = document.forms[0].elements['IDCENTRO'].value;
	  if (pl_id==-1)
	  		alert(msgSinCentro);
		else
		{       var objFrame=new Object();
		        objFrame=obtenerFrame(top,'areaTrabajo');
	  		objFrame.location.href='CambioCentro.xsql?PL_ID='+pl_id+'&SES_ID='+]]></xsl:text><xsl:value-of select="//SES_ID"/><xsl:text disable-output-escaping="yes"><![CDATA[;
		}
	}
	
	
	//funcion para evitar la eliminacion del usuario activo, el centro del usuario activo o la empresa del usuario activo 

	function sinoSeBorraAsiMismoEnviarCambios(accion,idusuarioActivo, idUsuarioaeliminar){
	
	  var msg='Imposible ejecutar accion';
	  
	  if(accion=='BORRAREMPRESA')
	    msg=msgBorrarEmpresa;
	  else
	    if(accion=='BORRARCENTRO')
	      msg=msgBorrarCentro;
	    else
	      if(accion=='BORRARUSUARIO')
	        msg=msgBorrarUsuario;
	
	  if(accion!='BORRARUSUARIO'){
	    for(var n=0;n<document.forms['Centros'].length;n++){
	      if(document.forms['Centros'].elements[n].name.match('IDUSUARIO_') && document.forms['Centros'].elements[n].value==idusuarioActivo){
	        alert(msg);
	        return false;
	      }   
	    }
	  }
	  else{
	    if(idusuarioActivo==idUsuarioaeliminar){
	      alert(msg);
	      return false;
	    }
	  }
	  return true;
	}
	
	
	function NuevoUsuario(){
	  ]]></xsl:text>
     	var usuarioGerente='<xsl:if test="not(/ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION)"><xsl:value-of select="/ZonaEmpresa/AREAEMPRESA/CENTROS/field/@current"/></xsl:if>';
     	<xsl:text disable-output-escaping="yes"><![CDATA[
     	  if(document.forms[0].elements['IDCENTRO'].value>0){
     	// var objFrame=new Object();
	    // objFrame=obtenerFrame(top,'areaTrabajo');
	    // objFrame.location.href='./USManten.xsql?EMP_ID='+document.forms[0].elements['IDEMPRESA'].value+'&ID_USUARIO=0&CEN_ID='+document.forms[0].elements['IDCENTRO'].value+'&GERENTECENTRO='+usuarioGerente;
      parent.areaTrabajo.location.href='./USManten.xsql?EMP_ID='+document.forms[0].elements['IDEMPRESA'].value+'&ID_USUARIO=0&CEN_ID='+document.forms[0].elements['IDCENTRO'].value+'&GERENTECENTRO='+usuarioGerente;
	  }
	  else{
	    alert(msgSinCentro);
	  }
	}
	
	
	function EditarUsuario(url){
	  var emp_id=document.forms[0].elements['IDEMPRESA'].value;  
	  var objFrame=new Object();

    // PS 20170125
	  // objFrame=obtenerFrame(top,'areaTrabajo');
	  //objFrame.location.href=url+'&EMP_ID='+emp_id;
    parent.areaTrabajo.location.href=url+'&EMP_ID='+emp_id;

	}
	
	function ListaCarpetasYPlantillasPorUsuario(idCentro)
	{
   	  if(document.forms[0].elements['IDCENTRO'].value>0)
	  {
     	// var objFrame=new Object();
	    // objFrame=obtenerFrame(top,'areaTrabajo');
	    // objFrame.location.href='./ListadoUsuarios.xsql?CEN_ID='+idCentro;
      parent.areaTrabajo.location.href='./ListadoUsuarios.xsql?CEN_ID='+idCentro;
	  }
	}
	
	function AsignarComerciales()
	{
		//MostrarCampos(document.forms[0]);
   	  if(document.forms[0].elements['IDNUEVAEMPRESA'].value>0)
	  {
     	// var objFrame=new Object();
	    // objFrame=obtenerFrame(top,'areaTrabajo');
	    // objFrame.location.href='./AsignarComerciales.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
      parent.areaTrabajo.location.href='./AsignarComerciales.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
	  }
	}  
            
        function Perfiles()
	{
            //alert(document.forms[0].elements['IDNUEVAEMPRESA'].value);
		//MostrarCampos(document.forms[0]);
   	  if(document.forms[0].elements['IDNUEVAEMPRESA'].value>0)
	  {
     	// var objFrame=new Object();
	    // objFrame=obtenerFrame(top,'areaTrabajo');
	    // objFrame.location.href='./PerfilesUsuarios.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
      parent.areaTrabajo.location.href='./PerfilesUsuarios.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
	  }
	}  
   
    function ListadoEmpresas() 
	{
   		parent.areaTrabajo.location.href='./ListadoEmpresas.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
    } 
	
    function ListadoCentros() 
	{
   		parent.areaTrabajo.location.href='./BuscadorCentros.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
    } 
	
    function ListaTodosUsuarios()
	{
     	// var objFrame=new Object();
	    // objFrame=obtenerFrame(top,'areaTrabajo');
	    // objFrame.location.href='./ListadoCentros.xsql';
      parent.areaTrabajo.location.href='./ListadoCorreosUsuarios.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
	  
	}

    function ControlUsuarios() 
	{
   		parent.areaTrabajo.location.href='./ListaUsuariosControl.xsql?IDPAIS='+document.forms[0].elements['IDPAIS'].value;
    } 

	function FacturacionEspecial()	
	{
   		parent.areaTrabajo.location.href='./FacturacionEspecial.xsql?IDEMPRESA='+document.forms[0].elements['IDNUEVAEMPRESA'].value;
    } 
	

	function Comentarios()	
	{
		parent.areaTrabajo.location.href='http://www.newco.dev.br/Compras/NuevaMultioferta/UltimosComentarios.xsql?IDEMPRESA='+document.forms[0].elements['IDEMPRESA'].value+'&IDCENTRO='+document.forms[0].elements['IDCENTRO'].value;
    } 
	
		-->
		</script>
		]]>
		</xsl:text>
	</head>
	<body class="areaizq">
		<xsl:choose><!-- error -->
		<xsl:when test="//xsql-error">
		 <xsl:apply-templates select="//xsql-error"/>         
		</xsl:when> 
		<xsl:when test="//SESION_CADUCADA">
		<xsl:apply-templates select="//SESION_CADUCADA"/>        
		</xsl:when> 
		<xsl:otherwise>   

			<!--idioma-->                                             
			<xsl:variable name="lang">
			<xsl:choose>   
    			<xsl:when test="/ZonaEmpresa/LANG"><xsl:value-of select="/ZonaEmpresa/LANG" /></xsl:when>
    			<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>       
			</xsl:variable>
			<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
			<!--idioma fin-->
			
			<form action="ZonaEmpresa.xsql" name="Centros" method="POST">
				<input type="hidden" name="ACCION"/>
				<input type="hidden" name="IDUSUARIO" value="{/ZonaEmpresa/AREAEMPRESA/IDUSUARIO}"/>
				<input type="hidden" name="US_ID" value="{/ZonaEmpresa/US_ID}"/>	

				<input type="hidden" name="IDNUEVOPAIS">
		   			<xsl:attribute name="value"><xsl:value-of select="ZonaEmpresa/AREAEMPRESA/IDPAIS"/>
					</xsl:attribute>
				</input>

				<input type="hidden" name="IDNUEVAEMPRESA">
		   			<xsl:attribute name="value"><xsl:value-of select="ZonaEmpresa/AREAEMPRESA/IDEMPRESA"/>
					</xsl:attribute>
				</input>

				<input type="hidden" name="IDNUEVOCENTRO">
		   			<xsl:attribute name="value"><xsl:value-of select="ZonaEmpresa/AREAEMPRESA/IDCENTRO"/>
					</xsl:attribute>
				</input>
                       
			<!-- Este bloque parece repetido
			idioma
			<xsl:variable name="lang">
			<xsl:choose>
			<xsl:when test="/ZonaEmpresa/LANG"><xsl:value-of select="/ZonaEmpresa/LANG" /></xsl:when>
			<xsl:otherwise>spanish</xsl:otherwise>
			</xsl:choose>  
			</xsl:variable>
			<xsl:variable name="doc">http://www.newco.dev.br/General/texts_<xsl:value-of select="$lang"/>.xml</xsl:variable>
			idioma fin-->
           
      
			<!--<table class="plantilla">-->
			<table class="areaizq">
				<xsl:choose>
					<xsl:when test="ZonaEmpresa/AREAEMPRESA/PAISES/field">
            		   <tr style="height:40px;background:#F44810;">
                			<th>&nbsp;</th>
                			<th colspan="3">
								<xsl:call-template name="desplegable">
        							<xsl:with-param name="path" select="ZonaEmpresa/AREAEMPRESA/PAISES/field"></xsl:with-param>
                                	<xsl:with-param name="claSel">select200</xsl:with-param>
                                	<xsl:with-param name="onChange">javascript:CambioPaisActual(this.value);</xsl:with-param>
      				        	</xsl:call-template>
                    		</th>
                    		<th>&nbsp;</th>
                		</tr>
					</xsl:when>
					<xsl:otherwise>
						<input type="hidden" name="IDPAIS" value="{ZonaEmpresa/AREAEMPRESA/IDPAIS}"/>
					</xsl:otherwise>
				</xsl:choose>
			
			
               <tr height="25px">
                	<th>&nbsp;</th>
                	<th colspan="3">
                    	<a href="javascript:ListadoEmpresas();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='empresa_maiu']/node()"/>
                        </a>
                    </th>
                    <th>&nbsp;</th>
                </tr>
                <!--<tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
				<!--<tr>-->
				<tr align="center" style="height:40px;">
                	<td>&nbsp;</td>
                	<td colspan="3" class="textCenter">
						<xsl:choose>
						<xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/field/dropDownList/listElem">
						  <xsl:choose>
				    		<xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">	
                    			<!--<div class="boton" style="margin-left:20px;">
                        			<a href="javascript:ListadoEmpresas();"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_empresas']/node()"/></a>
                        		</div>
								<br/><br />-->

								<xsl:call-template name="desplegable">
        							<xsl:with-param name="path" select="ZonaEmpresa/AREAEMPRESA/EMPRESAS/field"></xsl:with-param>
                                	<xsl:with-param name="claSel">select200</xsl:with-param>
      				        	</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
      				    	   <xsl:for-each select="ZonaEmpresa/AREAEMPRESA/EMPRESAS/field/dropDownList/listElem">
      				        	 <xsl:if test="ID=../../@current">
      				        	   <xsl:value-of select="listItem"/>
      				        	   <input type="hidden" name="IDEMPRESA">
      				            	 <xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
      				        	   </input>
      				        	 </xsl:if>
      				    	   </xsl:for-each>
      				    	 </xsl:otherwise>
      					   </xsl:choose>
						</xsl:when>
						<xsl:otherwise>
                			<xsl:value-of select="document($doc)/translation/texts/item[@name='no_existen_empresas']/node()"/>
							<input type="hidden" name="IDEMPRESA" value="-1"/>
						</xsl:otherwise>			
						</xsl:choose>
					</td>
                	<td>&nbsp;</td>
                </tr>
                <!-- <tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
				<tr>
                 <td>&nbsp;</td>
	   		 	<xsl:choose>
	   		 	  <xsl:when test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">	
						<td>
                        <a href="javascript:NuevaEmpresa();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='nueva']/node()"/>
                   		</a>  
						
						</td>
						<td>
                          <a href="javascript:EditarEmpresa();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='propriedades']/node()"/>
                   		</a>  
						
						</td>
						<td>
                          <a href="javascript:BorrarEmpresa();">
                    	<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
                   		</a>  
							
						</td>
		                   </xsl:when>
		                   <xsl:otherwise>
		                        <td colspan="3" align="center">
									  <a href="javascript:EditarEmpresa();">
                                        <xsl:value-of select="document($doc)/translation/texts/item[@name='propriedades']/node()"/>
                                      </a>  
								</td>
		                   </xsl:otherwise>
		                   </xsl:choose>
                         <td>&nbsp;</td>
					</tr>
					  <tfoot>
                         <tr>
                        <td class="footLeft">&nbsp;</td>
                        <td colspan="3">&nbsp;</td>
                        <td class="footRight">&nbsp;</td>
                        </tr>
                    </tfoot>
			</table><!--fin de tabla empresa-->
			<br/>
            <!--tabla CENTRO-->
			<!--<table class="plantilla">-->
			<table class="areaizq">
			<tr height="25px">
                	<th>&nbsp;</th>
                	<th colspan="3">
                    	<a href="javascript:ListadoCentros();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='centro_maiu']/node()"/>
                        </a>
                        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                        [&nbsp;<a href="javascript:FacturacionEspecial();">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='Fact_especial']/node()"/>
                        </a>&nbsp;]
                    </th>
                    <th>&nbsp;</th>
                </tr>
                <!--  <tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
				<tr style="height:40px;">
                <td>&nbsp;</td>
                <td colspan="3" class="textCenter">
				<xsl:choose>
				  <xsl:when test="ZonaEmpresa/AREAEMPRESA/CENTROS/field/dropDownList/listElem">
				    <xsl:choose>
				      <xsl:when test="ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION">				
						<!--<div class="boton" style="margin-left:20px;">
    						<a href="javascript:ListadoCentros();"><xsl:value-of select="document($doc)/translation/texts/item[@name='listado_centros']/node()"/></a>
						</div>
						<br/><br />-->
				        <xsl:call-template name="desplegable">
        			          <xsl:with-param name="path" select="ZonaEmpresa/AREAEMPRESA/CENTROS/field"/>
                                          <xsl:with-param name="claSel">select200</xsl:with-param>
      			                </xsl:call-template>
      			              </xsl:when>
      			              <xsl:otherwise>
      			                <xsl:for-each select="ZonaEmpresa/AREAEMPRESA/CENTROS/field/dropDownList/listElem">
      				         <xsl:if test="ID=../../@current">
      				           <xsl:value-of select="listItem"/>
      				           <input type="hidden" name="IDCENTRO">
      				             <xsl:attribute name="value"><xsl:value-of select="ID"/></xsl:attribute>
      				           </input>
      				         </xsl:if>
      				       </xsl:for-each>
      			              </xsl:otherwise>
      			            </xsl:choose>
				  </xsl:when>
				  <xsl:otherwise>
					<xsl:value-of select="document($doc)/translation/texts/item[@name='no_existen_centros']/node()"/>
					<input type="hidden" name="IDCENTRO" value="-1"/>
				  </xsl:otherwise>			
				</xsl:choose>
				 <td>&nbsp;</td>
				</td>
                </tr>
                <!-- <tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
				<tr>
                 <td>&nbsp;</td>
	   		 	  <xsl:choose>
	   		 	    <xsl:when test="ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION">		
						<td>
                        <a href="javascript:NuevoCentro();">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                   		</a>  
						
						</td>
						<td>
                        <a href="javascript:EditarCentro();">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='propriedades']/node()"/>
                   		</a>  
						
						</td>
						<td>
                        <a href="javascript:BorrarCentro();">
                    		<xsl:value-of select="document($doc)/translation/texts/item[@name='borrar']/node()"/>
                   		</a>  
					
						</td>
				    </xsl:when>
				    <xsl:otherwise>
				        <td colspan="3">
                            <a href="javascript:EditarCentro();">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='propriedades']/node()"/>
                            </a>  
						</td>
				    </xsl:otherwise>
				    </xsl:choose>
                  <td>&nbsp;</td>
					</tr>
					  <tfoot>
                         <tr>
                        <td class="footLeft">&nbsp;</td>
                        <td colspan="3">&nbsp;</td>
                        <td class="footRight">&nbsp;</td>
                        </tr>
                    </tfoot>
			</table><!--fin de tabla CENTRO-->
            <br/>
            <!--USUARIOS DEL CENTRO-->
			<!--<table class="plantilla">-->
			<table class="areaizq">
                <tr height="25px">
                	<th>&nbsp;</th>
                	<th colspan="3">
                    	<a href="javascript:ListaTodosUsuarios();">
                        <xsl:value-of select="document($doc)/translation/texts/item[@name='usuario_maiu']/node()"/>
                        </a>
                        <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
                        [&nbsp;<a href="javascript:ControlUsuarios();">
                            <xsl:value-of select="document($doc)/translation/texts/item[@name='control']/node()"/>
                        </a>&nbsp;]
                    </th>
                    <th>&nbsp;</th>
                </tr>
                <!--  <tr>
                	<td>&nbsp;</td>
                	<td colspan="3">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>-->
			
               
		   <xsl:choose>
	   		 <xsl:when test="ZonaEmpresa/AREAEMPRESA/USUARIOS/EDICION">	
		          <xsl:choose>
                  <xsl:when test="ZonaEmpresa/AREAEMPRESA/USUARIOS/USUARIO">	
                              
					<!--	Lista de usuarios	-->
          				<xsl:for-each select="ZonaEmpresa/AREAEMPRESA/USUARIOS/USUARIO">
							<tr class="lineBorderBottom">
							     <td colspan="4" class="textLeft noventa">
							    <!--	Link a la ficha del usuario	-->
                                 <xsl:apply-templates select="NOMBRE"/>
								
							  </td>
							  <td class="seis" valign="top">
                              <!--<xsl:value-of select="count(../USUARIO)"/>-->
                              <xsl:if test="count(../USUARIO) &gt; 1">
                                  <!--<a href="javascript:BorrarUsuario('BORRARUSUARIO','{ID}');">-->
                                  <a href="javascript:ComprobarAntesBorrarUsuario('{ID}');">
                                    <img src="/images/2017/trash.png"  style="margin:2px 0px;"/>
                                  </a>
                              </xsl:if>
							  </td>
							</tr>
		  				</xsl:for-each>	    
						<input type="hidden" name="PRODUCTOS" value="CONPRODUCTOS"/>
				</xsl:when>
				<xsl:otherwise>
                    <tr height="20px"><td colspan="5">&nbsp;</td></tr>
					<tr>
                    <td>&nbsp;</td>
					  <td colspan="3" class="botonesLargo">
					    <xsl:call-template name="botonNostyle">
				              <xsl:with-param name="path" select="ZonaEmpresa/button[@label='NuevoUsuario']"/>
				            </xsl:call-template>
					  </td>
                      <td>&nbsp;</td>
					</tr>
                    <!--<tr height="5px"><td colspan="5">&nbsp;</td></tr>-->
                    <tr>
                    <td>&nbsp;</td>
					  <td colspan="3" class="textCenter">
					    <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_existen_usuarios']/node()"/></strong>
					    <input type="hidden" name="USUARIOS" value="-1"/>
					  </td>
                      <td>&nbsp;</td>
					</tr>
				</xsl:otherwise>			
				</xsl:choose>
                    <tr height="20px"><td colspan="5">&nbsp;</td></tr>
                     <tr>
                		<td>&nbsp;</td>			
						<td>
                            <a href="javascript:NuevoUsuario();">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='nuevo']/node()"/>
                            </a> 
                        </td>
                        <td>&nbsp;&nbsp;
                            <a href="javascript:ListaCarpetasYPlantillasPorUsuario('{/ZonaEmpresa/AREAEMPRESA/CENTROS/field/@current}');">
                                <xsl:value-of select="document($doc)/translation/texts/item[@name='plantillas']/node()"/>
                            </a>  
						</td>
                        <td>
                            <a href="javascript:Perfiles();">
                               <xsl:value-of select="document($doc)/translation/texts/item[@name='perfiles']/node()"/>
                            </a>  
                        </td>
                        <td>&nbsp;</td>			
                    </tr>
                    <tr height="5px"><td colspan="5">&nbsp;</td></tr>
                    <tr>
                		<td colspan="2">&nbsp;</td>	
						<td>
                        	<a class="btnNormal" href="javascript:AsignarComerciales();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='vendedores']/node()"/>
                        	</a>  
                    	</td>
                    	<td colspan="2">&nbsp;</td>
                    </tr>
                    <tr height="5px"><td colspan="5">&nbsp;</td></tr>
                    <tr>
                		<td colspan="2">&nbsp;</td>	
						<td>
                        	<a class="btnNormal" href="javascript:Comentarios();">
                            	<xsl:value-of select="document($doc)/translation/texts/item[@name='comentarios']/node()"/>
                        	</a>  
                    	</td>
                    	<td colspan="2">&nbsp;</td>
                    </tr>
		      </xsl:when>
		      <xsl:otherwise>
                <tr height="5px"><td colspan="5">&nbsp;</td></tr>
                <tr>
                      <td>&nbsp;</td>
                      <td colspan="3" class="textCenter">
		               <strong><xsl:value-of select="document($doc)/translation/texts/item[@name='no_tiene_derecho_editar_usuario']/node()"/></strong>
                      </td>
                      <td>&nbsp;</td>
                </tr>
		      </xsl:otherwise>
		  </xsl:choose>
			<tfoot>
             <tr>
            	<td class="footLeft">&nbsp;</td>
            	<td colspan="3">&nbsp;</td>
            	<td class="footRight">&nbsp;</td>
             </tr>
             
            </tfoot>
			</table>
		</form>
	</xsl:otherwise>  
	</xsl:choose>  
	</body>      
</html>   
</xsl:template>
 
<xsl:template match="PROVEEDOR">
	<table width="100%">
	<tr><td align="left">
	<a class="suave" onmouseover="window.status=' ';return true" onmouseup="window.status=' ';return true" onmousedown="window.status=' ';return true">  
	<xsl:attribute name="href">javascript:MostrarPagPersonalizada('../../Administracion/Mantenimiento/Productos/PRODetalle.xsql?PRO_ID=<xsl:value-of	select="../ID"/>','producto',70,50,0,-50);</xsl:attribute>
	Pedidos:&nbsp;<!--<xsl:value-of select="../PEDIDOSTOTALES"/>&nbsp;(--><xsl:value-of select="../PEDIDOSMES"/><!--)-->
	</a>
	</td>
	<td align="right">
	<a style="color:#000000">
    <xsl:attribute name="href">javascript:MostrarPagPersonalizada('http://www.newco.dev.br/Administracion/Mantenimiento/Empresas/EMPDetalleFrame.xsql?EMP_ID=<xsl:value-of select="../IDPROVEEDOR"/>&amp;VENTANA=NUEVA','empresa',65,58,0,-50)</xsl:attribute> 
    <xsl:attribute name="onMouseOver">window.status='Información sobre la empresa.';return true;</xsl:attribute>
    <xsl:attribute name="class">suave</xsl:attribute>
    <xsl:attribute name="onMouseOut">window.status='';return true;</xsl:attribute>
    <xsl:value-of select="." disable-output-escaping="yes"/>
	</a>
	</td></tr></table>
</xsl:template>

<xsl:template match="NOMBRE">
	<input type="hidden" name="IDUSUARIO_{../ID}" value="{../ID}"/>
	<a style="text-decoration:none;" onmouseover="window.status='Editar usuario';return true" onmouseup="window.status=' ';return true" onmouseout="window.status=' ';return true" onmousedown="window.status=' ';return true">  
	<xsl:attribute name="href">javascript:EditarUsuario('./USManten.xsql?ID_USUARIO=<xsl:value-of select="../ID"/><xsl:if test="not(/ZonaEmpresa/AREAEMPRESA/CENTROS/EDICION)">&amp;GERENTECENTRO=<xsl:value-of select="/ZonaEmpresa/AREAEMPRESA/CENTROS/field/@current"/></xsl:if><xsl:if test="ZonaEmpresa/AREAEMPRESA/EMPRESAS/EDICION">&amp;VER_USUARIO=</xsl:if>');</xsl:attribute>
	<xsl:value-of select="." disable-output-escaping="yes"/></a>
</xsl:template>
 
</xsl:stylesheet>
