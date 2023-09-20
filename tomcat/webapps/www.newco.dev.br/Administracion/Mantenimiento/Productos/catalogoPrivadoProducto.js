function Buscar()
		{
			var form = document.forms['catalogo'];
			var idEmpresa = form.elements['IDEMPRESA'].value;
                        var origen = form.elements['ORIGEN'].value;
                        var inputSol = form.elements['INPUT_SOL'].value;
			var dataSol = "ORIGEN="+origen+"&INPUT_SOL="+inputSol;
                        
			//si busco desde el manten reducido, catalogo de producto
			if (idEmpresa != '' && origen != 'SOLICITUD'){
				document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?ORIGEN="+origen;
				SubmitForm(document.forms['catalogo']);
			}
                        if (origen == 'SOLICITUD'){
				document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProductoEmpresa.xsql?"+dataSol;
				SubmitForm(document.forms['catalogo']);
			}
			else{
				document.forms['catalogo'].action="http://www.newco.dev.br/Administracion/Mantenimiento/Productos/CatalogoPrivadoProducto.xsql";
				SubmitForm(document.forms['catalogo']);
			}
		}
		
		function InsertarMantenimientoReducido(ref)
		{
		 	var objFrameTop=new Object();    
            objFrameTop=window.opener.top;
            var FrameOpenerName=window.opener.name;
            var objFrame=new Object();
            
            objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
			//alert (objFrameTop.name);
			//alert (objFrame.name);
			//inserto ref en campo input referencia
			var formMant = objFrame.document.forms['form1'];
			formMant.elements['REFERENCIACLIENTE'].value = ref;
			
			//alert(formMant.elements['PRO_REF_ESTANDAR'].value);
			window.close();
		 }
		 
		function InsertarPROManten(ref,precio,udba)
		{
		 	var objFrameTop=new Object();    
            objFrameTop=window.opener.top;
            var FrameOpenerName=window.opener.name;
            var objFrame=new Object();
            
            objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
			//alert (objFrameTop.name);
			//alert (objFrame.name);
			objFrame.document.getElementById('refPrecioObjetivo').style.display = 'none';
			//inserto ref en campo input referencia
			var formMant = objFrame.document.forms['form1'];
			formMant.elements['PRO_REF_ESTANDAR'].value = ref;
			
			if (precio != ''){
				formMant.elements['PRECIO_CAT_PRIV'].value = precio;
				
				formMant.elements['UDBA_CAT_PRIV'].value = udba;
				
				objFrame.document.getElementById('refPrecioObjetivo').style.display = 'block';
			}
			else{ objFrame.document.getElementById('refPrecioObjetivo').style.display = 'none'; }
			//alert(formMant.elements['PRO_REF_ESTANDAR'].value);
			window.close();
		 }
            
            //insertar la ref producto en campo input de nueva evaluacion producto
            function InsertarPROEvaluacion(ref){
                var objFrameTop=new Object();    
                objFrameTop=window.opener.top;
                var FrameOpenerName=window.opener.name;
                var objFrame=new Object();

                objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
			//alert (objFrameTop.name);
			//alert (objFrame.name);
			//inserto ref en campo input referencia
			var form = objFrame.document.forms['EvaluacionProducto'];
			form.elements['REF_PROD'].value = ref;
                        objFrame.document.getElementById("botonBuscarEval").style.display = 'none';
                        objFrame.document.getElementById("botonRecuperarProd").style.display = 'block';
			
			window.close();
		 }
            
            //insertar la ref producto en campo input de una solicitud
            function InsertarPROSolicitud(ref,inputSol){
                var objFrameTop=new Object();    
                objFrameTop=window.opener.top;
                var FrameOpenerName=window.opener.name;
                var objFrame=new Object();

                objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
			//alert (objFrameTop.name);
			//alert (objFrame.name);
			//inserto ref en campo input referencia
			var form = objFrame.document.forms['SolicitudCatalogacion'];
			form.elements[inputSol].value = ref;
                        //objFrame.document.getElementById("botonBuscarEval").style.display = 'none';
                        //objFrame.document.getElementById("botonRecuperarProd").style.display = 'block';
			
			window.close();
		 }
		 
            //insertar la ref producto en campo input grande de licitacion de productos
            function InsertarPROLicitacion(ref){
                var objFrameTop=new Object();    
                objFrameTop=window.opener.top;
                var FrameOpenerName=window.opener.name;
                var objFrame=new Object();

                objFrame=obtenerFrame(objFrameTop,FrameOpenerName);
			//alert (objFrameTop.name);
			//alert (objFrame.name);
            
			//inserto ref en campo input referencia
			var form = objFrame.document.forms['RefProductos'];
            
                        //compruebo si el producto ya esta insertado
                        if (form.elements['LIC_LISTA_REFPRODUCTO'].value.match(ref)){ 
                            alert(document.forms['mensajeJS'].elements['REF_YA_INSERTADA'].value);                            
                        }
                        else{ form.elements['LIC_LISTA_REFPRODUCTO'].value += ref+'\n'; }
		 }


