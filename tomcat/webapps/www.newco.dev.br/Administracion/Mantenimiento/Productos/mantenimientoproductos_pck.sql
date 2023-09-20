CREATE OR REPLACE PACKAGE Mantenimientoproductos_Pck IS
/*
	Mantenimiento del catálogo de productos de los proveedores
	Declaraciones en mantenimientoproductos.sql
	
	Buscador/listado extraido a mantenimientoproductos_seg_pck.sql
	
	Ultima revisión: ET 8mar23 18:11
*/

	TYPE ref_cursor IS REF CURSOR; -- RETURN EMPRESAS%rowtype;

	TYPE TRegEmpresasPrecio IS RECORD (
		EMP_ID 			EMPRESAS.EMP_ID%TYPE,
		EMP_NOMBRE 		EMPRESAS.EMP_nombre%TYPE
		--EMP_NOMBRE_NORM EMPRESAS.EMP_nombre_NORM%TYPE
	);

	--	Expandir precio, no incluye a la empresa padre
	PROCEDURE ExpandirManteniendoMargen
	(
		p_IDUsuario			NUMBER,	--	Usuario responsable de la expansión
		p_IDPais			NUMBER,	--	País para el que se expande (para no volverla a informar)
		p_IDEmpresa			NUMBER,	--	Empresa desde la que se expande (para no volverla a informar)
		p_IDProducto		NUMBER,
		p_Precio			NUMBER
	);

	--	XML con toda la info del producto
	PROCEDURE MostrarProducto
	( 
		p_PRO_ID 					NUMBER, 
		p_US_ID 					NUMBER,
		p_MostrarTarifas			VARCHAR2 DEFAULT 'S' 	--7dic20
	);

	--	Datos particulares del producto para un cliente en formato XML
	PROCEDURE DatosCliente_XML
	(
		p_IDProducto				NUMBER,
		p_IDCliente					NUMBER,
		p_NombreCortoCliente		VARCHAR2,
		p_IDPais					NUMBER,
		p_IDIdioma					NUMBER,
		p_IDProveedor				NUMBER,
		p_IDDOcumento				NUMBER,
		p_MarcaOfertas				VARCHAR2,	
		p_CampoIDOfertas			VARCHAR2,	
		p_FiltroOfertas				VARCHAR2
	);
	
	--	Mantenimiento de producto
	PROCEDURE ModificarProducto_prov
	(
		p_IDUsuario					VARCHAR2,
		p_PRO_ID					VARCHAR2,
		p_IDPROVEEDOR				NUMBER,
		p_PRO_NOMBRE				VARCHAR2,
		p_PRO_MARCA					VARCHAR2,
		p_PRO_UNIDADBASICA			VARCHAR2,
		p_PRO_UNIDADESPORLOTE		VARCHAR2,
		p_PRO_REFERENCIA			VARCHAR2,
		p_PRO_IDTIPOIVA				VARCHAR2,
    	p_CADENA_IMAGENES           VARCHAR2,
    	p_CADENA_IMAGENES_BORRADAS  VARCHAR2,
		p_SolicitarBorrado  		VARCHAR2,
		p_FechaAccion				VARCHAR2,
		p_IDFichaTecnica			VARCHAR2,
		p_PRO_OCULTO				VARCHAR2,
		p_PRO_CATEGORIA				VARCHAR2,
		p_PRO_REFESTANDAR			VARCHAR2,
		p_ListaCambios				VARCHAR2 DEFAULT NULL,			--	7feb14
		p_PRO_REQUIEREPRESUPUESTO	VARCHAR2 DEFAULT NULL,			--	29set14
    	p_PRO_CODEXPEDIENTE 		VARCHAR2 DEFAULT NULL,			--	15ene18	nuevos campos Colombia
		p_PRO_CODCUM				VARCHAR2 DEFAULT NULL,
		p_PRO_CODINVIMA				VARCHAR2 DEFAULT NULL,
		p_PRO_FECHACADINVIMA		VARCHAR2 DEFAULT NULL,
		p_PRO_CLASIFICACIONRIESGO	VARCHAR2 DEFAULT NULL,
		p_PRO_REGULADO				VARCHAR2 DEFAULT NULL,
		p_PRO_CODIUM				VARCHAR2 DEFAULT NULL,			--	13feb20 nuevo campo Colombia
		p_PRO_REGISTROSANITARIO		VARCHAR2 DEFAULT NULL			--	08feb22 nuevo campo Colombia
	);


	--	Modifica los datos de un producto en el catalogo de proveedores
	FUNCTION ModificarProducto_prov
	(
		p_IDUsuario					VARCHAR2,
		p_PRO_ID					VARCHAR2,									--	NULL para nuevo producto
		p_IDPROVEEDOR				NUMBER,
		p_PRO_NOMBRE				VARCHAR2,
		p_PRO_MARCA					VARCHAR2,
		p_PRO_UNIDADBASICA			VARCHAR2,
		p_PRO_UNIDADESPORLOTE		VARCHAR2,
		p_PRO_REFERENCIA			VARCHAR2,
		p_PRO_IDTIPOIVA				VARCHAR2,
    	p_CADENA_IMAGENES           VARCHAR2,
    	p_CADENA_IMAGENES_BORRADAS  VARCHAR2,
		p_SolicitarBorrado  		VARCHAR2,
		p_FechaAccion				VARCHAR2,
		p_IDFichaTecnica			VARCHAR2,
		p_PRO_OCULTO				VARCHAR2,
		p_PRO_CATEGORIA				VARCHAR2,
		p_PRO_REFESTANDAR			VARCHAR2,
		p_ListaCambios				VARCHAR2 DEFAULT NULL,			--	7feb14
		p_PRO_REQUIEREPRESUPUESTO	VARCHAR2 DEFAULT NULL,			--	29set14
    	p_PRO_CODEXPEDIENTE 		VARCHAR2 DEFAULT NULL,			--	15ene18	nuevos campos Colombia
		p_PRO_CODCUM				VARCHAR2 DEFAULT NULL,
		p_PRO_CODINVIMA				VARCHAR2 DEFAULT NULL,
		p_PRO_FECHACADINVIMA		VARCHAR2 DEFAULT NULL,
		p_PRO_CLASIFICACIONRIESGO	VARCHAR2 DEFAULT NULL,
		p_PRO_REGULADO				VARCHAR2 DEFAULT NULL,
		p_PRO_CODIUM				VARCHAR2 DEFAULT NULL,			--	13feb20 nuevo campo Colombia
		p_PRO_REGISTROSANITARIO		VARCHAR2 DEFAULT NULL			--	08feb22 nuevo campo Colombia
	) RETURN NUMBER;

	--	Copia un producto
	FUNCTION CopiarProducto
	(
		p_IDProducto				NUMBER
	)	RETURN NUMBER;

	--	Copia un producto, sus especialidades y, opcionalmente, las tarifas a otra empresa
	--	Necesario para fusiones de empresas
	FUNCTION CopiarProductoEnOtraEmpresa
	(
		p_IDProducto				NUMBER,
		p_IDEmpresaDest				NUMBER,
		p_CopiarTarifas				VARCHAR2	DEFAULT 'N'

	)	RETURN 	NUMBER;

	--	24nov22 Actualiza los campos normalizados en los nombres de UN producto
	PROCEDURE NormalizarProducto
	(
		p_IDProducto		NUMBER
	);

	--	Actualiza los campos normalizados en los nombres de productos para todos los productos
	PROCEDURE NormalizarProductos;

	PROCEDURE BorrarEnCatalogoPrivado
	(
      p_IDUsuario		NUMBER,
      p_IDProducto		NUMBER
    );

	--	Borrar un producto
	PROCEDURE BorrarProducto
	(
		p_IDUsuario		NUMBER,
		p_IDProducto	NUMBER
	);

	--	Borrar un producto, separamos función
	FUNCTION BorrarProducto
	(
		p_IDUsuario		NUMBER,
		p_IDProducto	NUMBER
	) RETURN VARCHAR2;

	--	Desplegable de tipos de IVA
	PROCEDURE TiposIVA_XML
	(
		p_Marca			VARCHAR2,
		p_NombreCampo	VARCHAR2,
		p_Actual		NUMBER,
		p_IDPais		NUMBER DEFAULT NULL
	);

	--	Mantenimiento de imagenes de un producto
	PROCEDURE CambiarImagenes
	(
		p_IDUsuario				NUMBER,
		p_IDProducto			NUMBER,
		p_CadenaImagenes		VARCHAR2,
		p_CadenaBorrar			VARCHAR2
	);

	--	Los usuarios de MVM pueden aceptar o rechazar los cambios propuestos por un proveedor sobre un producto
	PROCEDURE TratarCambiosProveedor
	(
		p_IDUsuario				NUMBER,
		p_ListaCambios			VARCHAR2
	);
	
	--	Informa el log de solicitudes de cambios en productos
	PROCEDURE GuardarSolicitudCambio
	(
		p_IDUsuario				NUMBER,
		p_IDProducto			NUMBER,
		p_Estado				VARCHAR2,
		p_Comentarios			VARCHAR2
	);

	--	Procesa el cambio en los datos de un producto solicitado por un proveedor
	PROCEDURE ProcesarCambio
	(
		p_IDUsuario				NUMBER,
		p_IDPais				NUMBER,			--	12abr12	Multipaís
		p_IDEmpresaCatalogo		NUMBER,			--	12abr12	Multipaís
		p_IDProducto			NUMBER
	);

	--	Descarta el cambio en los datos de un producto solicitado por un proveedor
	PROCEDURE DescartarCambio_XML
	(
		p_IDUsuario				NUMBER,
		p_IDPais				NUMBER,			--	12abr12	Multipaís
		p_IDEmpresaCatalogo		NUMBER,			--	12abr12	Multipaís
		p_IDProducto			NUMBER
	);

	--	Asocia todos los productos de un proveedor a una oferta
	PROCEDURE AsociarOfertaATodos_XML
	(
		p_IDUsuario				NUMBER,
		p_IDProveedor			NUMBER,
		p_IDDocumento			NUMBER,
		p_IDTipo				VARCHAR2		--	tipo de oferta
	);

	--	Asocia todos los productos de un proveedor a una oferta
	PROCEDURE AsociarFechaAOferta_XML
	(
		p_IDUsuario				NUMBER,
		p_IDEmpresa				NUMBER,
		p_IDDocumento			NUMBER,
		p_Fecha					VARCHAR2,
		p_FechaFinal			VARCHAR2	DEFAULT NULL
	);

	--	Inicializa la "fecha oferta" para todas las ref. estándar que tengan emplantillado un producto
	PROCEDURE AsignaFechaOferta
	(
		p_IDProducto			NUMBER
	);

	--	Inicializa la "fecha oferta" para todas las ref. estándar que tengan emplantillado un producto
	PROCEDURE AsignaFechaOfertaTodos
	(
		p_IDCliente				NUMBER,	--	27dic13
		p_IDProveedor			NUMBER
	);

	--	Devuelve la unidad basica y unidades por lote personalizados de un producto
	PROCEDURE Empaquetamiento_XML
	(
		p_IDUsuario				NUMBER,
		p_IDProducto			NUMBER,
		p_IncluirCabecera		VARCHAR2,
		p_IncluirClientes		VARCHAR2
	);

	--	Guarda la unidad basica y unidades por lote personalizados de un producto para un cliente
	FUNCTION NuevoEmpaquetamiento
	(
		p_IDUsuario				NUMBER,
		p_IDProducto			NUMBER,
		p_IDCliente				NUMBER,
		p_UnidadBasica			VARCHAR2,
		p_UnidadesPorLote		NUMBER,
		p_ForzarSiExiste		VARCHAR2 DEFAULT 'N'
	) RETURN VARCHAR2;

	--	30jul19 Permitimos modificar/crear empaquetamiento en un único paso
	FUNCTION ModificarEmpaquetamiento
	(
		p_IDUsuario				NUMBER,
		p_IDProducto			NUMBER,
		p_IDCliente				NUMBER,
		p_UnidadBasica			VARCHAR2,
		p_UnidadesPorLote		NUMBER
	) RETURN VARCHAR2;

	--	Guarda la unidad basica y unidades por lote personalizados de un producto para un cliente
	FUNCTION EliminarEmpaquetamiento
	(
		p_IDUsuario				NUMBER,
		p_IDProducto			NUMBER,
		p_IDCliente				NUMBER,
		p_ComprobarDerechos		VARCHAR2	DEFAULT 'S'	--	Desde las licitaciones no comprobaremos derechos
	) RETURN VARCHAR2;

	--	Actualiza la fecha límite de la oferta para una tarifa
	FUNCTION ActualizaFechaLimite
	(
		p_IDUsuario			NUMBER,
		p_IDProducto		NUMBER,
		p_IDCliente			NUMBER,
		p_FechaLimite		VARCHAR2,
		p_Propagar			VARCHAR2	DEFAULT 'S'
	) RETURN VARCHAR2;

	--	2abr19 Comprueba que un producto no tiene precios 
	FUNCTION ProductoConPrecios
	(
		p_IDProducto		NUMBER
	) RETURN VARCHAR2;

	--	Constantes correspondientes a las empresas que tienen ofertas y precios particulares	
	c_ASPE			NUMBER(5):=7576;	
	c_Recoletas 	NUMBER(5):=13396;						--	17ago17
END; 
/
SHOW ERRORS;






























































































CREATE OR REPLACE PACKAGE BODY Mantenimientoproductos_Pck AS

--	Ficha de producto en XML para mantenimiento
PROCEDURE MostrarProducto
(
	p_PRO_ID 					NUMBER,
	p_US_ID 					NUMBER,
	p_MostrarTarifas			VARCHAR2 DEFAULT 'S' 				--	7dic20
)
IS

    CURSOR cProducto (paramProID PRODUCTOS.pro_id%TYPE) IS
	    SELECT  pro_id,
				pro_nombre,
				pro_descripcion,
				pro_marca,
				pro_fabricante,
				emp_id,
				NVL(emp_nombrecortopublico, emp_nombre) proveedor,			--	21abr15
				--	25nov13	EMP_IDLOGOTIPO,			--	19set13
				EMP_IDLOGOTIPODOC,		--	25nov13
				pro_unidadbasica,
				pro_unidadesporlote,
				pro_referencia,
				PRO_HOMOLOGADO,
				PRO_CERTIFICADOS,
				pro_enlace,
				pro_imagen,
				pro_idtipoiva,
				PRO_IDTIPOPRODUCTO,
				PRO_ENLACECERTIFICADO,
				PRO_ENLACEFICHA,
                PRO_NUMFOTOS,
				PRO_FECHAALTA,				--	28abr11
				PRO_IDUSUARIOALTA,			--	28abr11
				PRO_IDDOCUMENTO,
				PRO_IDOFERTAASISA,			--	20mar12	Oferta ASISA
				PRO_IDOFERTAFNCP,			--	9jul12	Oferta ASPE
				PRO_IDOFERTAVIAMED,			--	9jul12	Oferta VIAMED
				PRO_IDOFERTATEKNON,			--	9jul12	Oferta TEKNON
				PRO_IDPROVEEDOR,
				PRO_IDFICHATECNICA,			--	31may11	Ficha técnica
				PRO_OCULTO,					--	5set11	Producto oculto
				PRO_CATEGORIA,				--	5oct11	Categoría: "F" Farmacia, NULL normal
				PRO_REFESTANDAR,			--	9nov11	Ref. estándar propuesta
				PRO_STATUS,					--	10abr12	Para productos devueltos
				PRO_REQUIEREPRESUPUESTO,	--	29set14 Requiere presupuesto
				PRO_CODEXPEDIENTE,			--	15ene18 Campos específicos para Colombia
				PRO_CODCUM,					--	15ene18
				PRO_CODINVIMA	,			--	15ene18
				PRO_FECHACADINVIMA	,		--	15ene18
				PRO_CLASIFICACIONRIESGO,	--	15ene18
				PRO_REGULADO,				--	15ene18
				NVL(PRO_FECHACAMBIO,PRO_FECHAALTA) FECHACAMBIO, 			--	15ene18 Fecha del último cambio aplciado al producto
				PRO_CODIUM					--	13feb20
		FROM PRODUCTOS, EMPRESAS		--	11jun09	ET	NOMENCLATOR,
		WHERE PRO_IDPROVEEDOR=EMP_ID
		  AND ((PRO_STATUS IS NULL) OR (PRO_STATUS='D'))	--	También mostramos el producto "devuelto" al proveedor
		  AND (EMP_STATUS IS NULL OR EMP_STATUS='C')
		  AND PRO_ID=paramProID;

	CURSOR cTiposProductos IS
		SELECT tpr_id, tpr_nombre FROM TIPOSPRODUCTOS;

	-- cursor con los proveedores del sistema
	CURSOR cProveedores(IDPais NUMBER) IS
		SELECT 		*
			FROM 	EMPRESAS,TIPOSEMPRESAS
			WHERE 	EMP_IDTIPO=TE_ID
			AND 	EMP_STATUS IS NULL
			AND 	TE_ROL='VENDEDOR'
			AND 	EMP_IDPAIS=IDPais		--	3ene12
			ORDER BY UPPER(NVL(EMP_NOMBRECORTOPUBLICO,EMP_NOMBRE));		--	15jun18
		
	--	Datos del usuario
	CURSOR cResponsable(IDUsuario NUMBER) IS
		SELECT 		US_ID, US_NOMBRE||' '||US_APELLIDO1  NOMBRE
			FROM 	USUARIOS
			WHERE	US_ID=IDUsuario;
	
	--	Aprovechamos el resumen de consumos para extraer los datos de alli
	CURSOR cConsumo(IDCLiente NUMBER, IDProducto NUMBER) IS
		SELECT 		NVL(SUM(EIS_RC_CONSUMO),0) TOTAL
			FROM 	EIS_RESUMENCONSUMOS 
			WHERE 	EIS_RC_IDPRODUCTO=IDProducto 
			AND 	EIS_RC_IDEMPRESA=IDCLiente
			AND		EIS_RC_IDCENTRO IS NULL;	--17mar14 La tabla EIS_RESUMENCONSUMOS también incluye la info por centro
			
	--	Consumo "no ASISA"
	CURSOR cConsumoMVM(IDPais NUMBER, IDProducto NUMBER) IS
		SELECT 		NVL(SUM(EIS_RC_CONSUMO),0) TOTAL
			FROM 	EIS_RESUMENCONSUMOS, EMPRESAS 
			WHERE 	EIS_RC_IDEMPRESA=EMP_ID
			AND 	EIS_RC_IDPRODUCTO=IDProducto
			AND		EIS_RC_IDCENTRO IS NULL		--17mar14 La tabla EIS_RESUMENCONSUMOS también incluye la info por centro
			AND		EMP_IDPAIS=IDPais
			AND		NVL(EMP_NOEXPANDIR,'N')='N';
			
		
	--	Comentarios MVM para solicitudes devueltas
	CURSOR cUltimoComentario(IDProducto NUMBER) IS
		SELECT 		A.PHC_COMENTARIOS COMENTARIO
			FROM	PRODUCTOS_HISTCAMBIOS A
			WHERE	A.PHC_FECHARESPUESTA=
				(SELECT MAX(B.PHC_FECHARESPUESTA) FROM PRODUCTOS_HISTCAMBIOS B WHERE B.PHC_ID=IDProducto);

	--	Empresas especiales
	CURSOR cEmpresasEspeciales(IDPais NUMBER, IDEmpresa NUMBER) IS
		SELECT		EMP_ID, EMP_NOMBRECORTOPUBLICO, EE_MARCAOFERTA
			FROM	EMPRESAS, EMPRESASESPECIALES
			WHERE	EE_IDEMPRESA=EMP_ID
			AND		EMP_STATUS IS NULL
			AND 	NVL(EMP_BLOQUEADA,'N')='N'
			AND		NVL(EE_OCULTA,'N')		='N'							--	29abr14
			AND		EMP_IDPAIS				=IDPais 						--	Filtramos por país
			AND 	((IDEmpresa IS NULL) OR (EMP_ID=IDEmpresa));			--	15ene18 para usuario CDC, solo verás precio de su empresa
		
	/*	
	--	22oct20	CAmbio en el mantenimiento, devolvemos solo los datos de TARIFAS
	CURSOR cTarifas(IDProducto NUMBER, IDEmpresa NUMBER) IS
		SELECT		TARIFAS.*,NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE) CLIENTE
			FROM	TARIFAS, EMPRESAS
			WHERE	TRF_IDCLIENTE=EMP_ID
			AND 	TRF_IDPRODUCTO=IDProducto
			AND 	((IDEmpresa IS NULL) OR(TRF_IDCLIENTE=IDEmpresa));
	*/
	
		
    vTipoIVA 					TIPOSIVA.TIVA_TIPO%TYPE;
	cur 						REF_CURSOR;
	vDummy 						NUMBER;
	CodigoEmpresa 				EMPRESAS.emp_id%TYPE;
	CodigoEmpresaUsuario 		EMPRESAS.emp_id%TYPE;
	vTarifa						TARIFAS.TRF_IMPORTE%TYPE;

	v_IDEmpresaDelUsuario		EMPRESAS.emp_id%TYPE;
	v_IDEmpresaMVM 				EMPRESAS.emp_id%TYPE;
	v_IDEmpresaFiltro 			EMPRESAS.emp_id%TYPE;						--	22oct20
	v_idproveedor	 			EMPRESAS.emp_id%TYPE;
	v_IDLogoActual		 		EMPRESAS.EMP_IDLOGOTIPODOC%TYPE;
	v_Multidivisas				VARCHAR2(1);												--	7dic20 Empresa multidivisas

	v_nom_nivel 				NOMENCLATOR.NOM_NIVEL%TYPE;
	v_nom_codigocompleto 		NOMENCLATOR.NOM_CODIGOCOMPLETO%TYPE;

	v_IDPais					EMPRESAS.emp_idpais%TYPE;
	v_IDIdioma					IDIOMAS.ID_ID%TYPE;
	v_Admin						VARCHAR2(1):='N';											--	24nov15	Admin en cliente
	v_AdminMVMi					VARCHAR2(1):='N';											--	1feb12	Admin de MVM España u otro país
	v_UsuarioCdC				VARCHAR2(1):='N';											--	13ene18	usuario CdC, podra modifcar los datos para su empresa
	
	v_IDOfertaDelProducto		DOCUMENTOS.DOC_ID%TYPE;											--	11feb14

	v_UnidadBasica				PRO_UNIDADESPORLOTE.PRO_UL_UNIDADBASICA%TYPE;					--	22ene18 Empaquetamiento privado
	v_UnidadesPorLote			PRO_UNIDADESPORLOTE.PRO_UL_UNIDADESPORLOTE%TYPE;				--	22ene18 Empaquetamiento privado
	
	v_IDDocumento				DOCUMENTOS.DOC_ID%TYPE; 										--	2nov20 Documento asociado a la tarifa

	v_Rol						TIPOSEMPRESAS.TE_ROL%TYPE;	--	13ene18
BEGIN

	--	EMpresa e IDioma los cargamos de una sola vez
	SELECT		EMP_ID, US_IDIDIOMA, EMP_IDPAIS, EMP_IDLOGOTIPODOC, DECODE(US_USUARIOGERENTE,1,'S','N'), NVL(US_CENTRALCOMPRAS,'N'), TE_ROL, NVL(EMP_MULTIDIVISAS,'N')
		INTO	v_IDEmpresaDelUsuario, v_IDIdioma, v_IDPais, v_IDLogoActual, v_Admin, v_UsuarioCdC, v_Rol, v_Multidivisas
		FROM	USUARIOS, CENTROS, EMPRESAS, TIPOSEMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		EMP_IDTIPO=TE_ID
		AND		US_ID=p_US_ID;
	
	v_IDEmpresaMVM:=TO_NUMBER(utilidades_pck.Parametro('IDMVM_'||v_IDPais));

	HTP.P(Utilidades_Pck.CabeceraXML
		||	'<PRODUCTO>'
		||	'<FECHA>'	||TO_CHAR(SYSDATE,'dd/mm/yyyy') 	||'</FECHA>'
		||	'<ROL>' 	||v_Rol 							||'</ROL>'					--	15ene18
		);

	--	8mar23 Marca para permitir editar tarifas
	IF v_Admin='S' OR (v_UsuarioCdC='S' AND v_Rol='COMPRADOR') THEN
    	HTP.P('<EDICION/>');
	ELSE
    	HTP.P('<SOLO_LECTURA/>');
	END IF;		

	--	ADMIN
	IF v_Admin='S' THEN
    	HTP.P('<ADMIN/>');
    END IF;

	--	11dic18	CdC puede editar datos privados de su empresa
	IF v_UsuarioCdC='S' THEN
    	HTP.P('<CDC/>');
    END IF;

	IF v_IDEmpresaDelUsuario=v_IDEmpresaMVM THEN
    	HTP.P('<ADMIN_MVM/>');
		v_AdminMVMi:='S';
    END IF;


	HTP.P(		'<IDPAIS>'				||	v_IDPais					||'</IDPAIS>'
			||	'<IDIDIOMA>'			||	v_IDIdioma					||'</IDIDIOMA>'
			||	'<EMP_MULTIDIVISAS>'	||	v_Multidivisas				||'</EMP_MULTIDIVISAS>'
			||	'<USUARIO>'
			||	'<US_ID>'				||	p_US_ID						||'</US_ID>'
			||	'<EMP_ID>'				||	v_IDEmpresaDelUsuario		||'</EMP_ID>'
			||	'<URL_LOGOTIPO>'		||	mvm.ScapeHTMLString(Personalizacion_pck.URLLogotipo(v_IDLogoActual))	||'</URL_LOGOTIPO>'
			||	'</USUARIO>');

	--	3nov20 Incluimos desplegable de divisas
	divisas_pck.DesplegableDivisas_XML (0, 'DIVISAS', v_IDIdioma);

	-- si no existe el producto devolvemos el desplegable de proveedores
	IF p_PRO_ID IS NULL THEN
		HTP.P('<NUEVO/>'			--	11dic18 marca XML para indciar nuevo producto, facilita la gestión en el XSL
			||'<PROVEEDORES>'
			||'<field name="IDPROVEEDOR" current="">'
			||'<dropDownList>'
			||'<listElem>'
			||'<ID></ID>'
			||'<listItem>'|| Utilidades_pck.TextoMensaje(v_IDIdioma,'MANTPROD_SELECCIONARPROV')||'</listItem>'
			||'</listElem>');
		FOR Proveedor IN cProveedores(v_IDPais) LOOP
			HTP.P('<listElem>'
				||'<ID>'		||Proveedor.EMP_ID							||'</ID>'
				||'<listItem>'	||Mvm.ScapeHTMLString(NVL(Proveedor.EMP_NOMBRECORTOPUBLICO,Proveedor.EMP_NOMBRE))	||'</listItem>'	--	21abr15
				||'</listElem>');
		END LOOP;
		HTP.P('</dropDownList>'
			||'</field>'
	    	||'</PROVEEDORES>');

		HTP.P('<PRO_UNIDADBASICA>1 unidad</PRO_UNIDADBASICA>');

		--	22abr15	Pasamos el tipo de IVA por defecto al 21%
		--	7feb18	Tipo de IVA por defecto: 21% españa, 0% Brasil, 0% Colombia
		
		SELECT DECODE(v_IDPais,34,21,55,100,57,200) INTO vTipoIVA FROM DUAL;
		TiposIVA_XML('IVA', 'PRO_IDTIPOIVA',  vTipoIVA, v_IDPais);	

		--		Desplegable con las ofertas de un proveedor
		--	11feb14	Recuperamos la info para las empresas especiales del país		
		--	4nov20 Los vendedores no pueden editar precios IF v_AdminMVMi='S' OR v_Admin='S' OR v_Rol='VENDEDOR' THEN
		IF v_AdminMVMi='S' OR v_Admin='S' OR v_Rol='VENDEDOR' THEN
		
			--	11mar14	Recuperamos la info para las empresas especiales del país
			FOR e IN cEmpresasEspeciales(v_IDPais, NULL) LOOP
			
				DatosCliente_XML(p_PRO_ID, e.EMP_ID, e.EMP_NOMBRECORTOPUBLICO, v_IDPais, v_IDIdioma,  v_IDEmpresaDelUsuario, NULL, 'OFERTAS', 'IDOFERTA', e.EE_MARCAOFERTA);

			END LOOP;
			
		ELSE

			--	Si es usuario CDC, solo para su empresa
			FOR e IN cEmpresasEspeciales(v_IDPais, v_IDEmpresaDelUsuario) LOOP

				DatosCliente_XML(p_PRO_ID, e.EMP_ID, e.EMP_NOMBRECORTOPUBLICO, v_IDPais, v_IDIdioma,  v_IDEmpresaDelUsuario, NULL, 'OFERTAS', 'IDOFERTA', e.EE_MARCAOFERTA);

			END LOOP;

		END IF;

		--31mar14	END IF;

		/*	Documentación en mantenimiento de documentos
		--	30may11	Desplegable con las ficha técnicas de un proveedor
		documentos_pck.ListaOfertasDelProveedor_XML
		(
			v_IDEmpresaDelUsuario,				--	ID del proveedor
			v_IDIdioma,
			'FICHAS_TECNICAS',
			'IDFICHATECNICA',
			NULL,
			'FT'
		);
		*/

	END IF;

	FOR r IN cProducto (p_PRO_ID) LOOP
		
		--	8abr11	Comprobamos derechos del usuario: MVM o usuario del proveedor
		--	26nov15	Tambien para el usuario ADMIN en un cliente
		--	13ene18	Tambien usuario CDC (solo vera los datos correspondientes a su empresa)
		IF v_AdminMVMi='S' OR v_Admin='S' OR v_UsuarioCdC='S' OR v_IDEmpresaDelUsuario=r.emp_id THEN
		
			HTP.P('<PRO_ID>'                	||r.pro_id             							||'</PRO_ID>'
				||  '<PRO_STATUS>' 	 			||r.PRO_STATUS	 								||'</PRO_STATUS>'
				||	'<PRO_NOMBRE>'          	 ||Mvm.ScapeHTMLString(r.pro_nombre)			||'</PRO_NOMBRE>'
				||  '<PRO_DESCRIPCION>'  		 ||Mvm.ScapeHTMLString(r.pro_descripcion )		||'</PRO_DESCRIPCION>'
				||  '<PRO_MARCA>'			 	||Mvm.ScapeHTMLString(r.pro_marca )				||'</PRO_MARCA>'
				||	'<PRO_FABRICANTE>'       	||Mvm.ScapeHTMLString(r.pro_fabricante)			||'</PRO_FABRICANTE>'

				||	'<PROVEEDOR>'			 	||Mvm.ScapeHTMLString(r.proveedor)				||'</PROVEEDOR>'
				||  '<IDPROVEEDOR>'  		 	||r.emp_id 										||'</IDPROVEEDOR>'

				||	'<REFERENCIA_PROVEEDOR>' 	||Mvm.ScapeHTMLString(r.pro_referencia)			||'</REFERENCIA_PROVEEDOR>'

				||	'<PRO_HOMOLOGADO>'       	||r.PRO_HOMOLOGADO								||'</PRO_HOMOLOGADO>'
				||  '<PRO_CERTIFICADOS>' 	 	||r.PRO_CERTIFICADOS							||'</PRO_CERTIFICADOS>'
				||  '<PRO_OCULTO>' 	 		 	||r.PRO_OCULTO	 								||'</PRO_OCULTO>'
				||  '<PRO_CATEGORIA>' 	 	 	||NVL(r.PRO_CATEGORIA,'N')						||'</PRO_CATEGORIA>'
				||  '<PRO_REQUIEREPRESUPUESTO>' ||NVL(r.PRO_REQUIEREPRESUPUESTO,'N')			||'</PRO_REQUIEREPRESUPUESTO>'
				||	'<REFERENCIA_ESTANDAR>' 	||Mvm.ScapeHTMLString(r.PRO_REFESTANDAR)		||'</REFERENCIA_ESTANDAR>'
				||	'<URL_LOGOTIPO>'			||mvm.ScapeHTMLString(Personalizacion_pck.URLLogotipo(r.EMP_IDLOGOTIPODOC))||'</URL_LOGOTIPO>'	--19set13
				--	15ene18 Campos específicos para Colombia
				||	'<PRO_CODEXPEDIENTE>' 		||Mvm.ScapeHTMLString(r.PRO_CODEXPEDIENTE)		||'</PRO_CODEXPEDIENTE>'
				||	'<PRO_CODCUM>' 				||Mvm.ScapeHTMLString(r.PRO_CODCUM)				||'</PRO_CODCUM>'
				||	'<PRO_CODINVIMA>' 			||Mvm.ScapeHTMLString(r.PRO_CODINVIMA)			||'</PRO_CODINVIMA>'
				||	'<PRO_CLASIFICACIONRIESGO>' ||Mvm.ScapeHTMLString(r.PRO_CLASIFICACIONRIESGO)||'</PRO_CLASIFICACIONRIESGO>'
				||  '<PRO_REGULADO>' 	 	 	||NVL(r.PRO_REGULADO,'N')						||'</PRO_REGULADO>'
				||	'<PRO_CODIUM>' 				||Mvm.ScapeHTMLString(r.PRO_CODIUM)				||'</PRO_CODIUM>'								--	13feb20
				||  '<PRO_FECHACADINVIMA>' 	 	||Mvm.ScapeHTMLString(r.PRO_FECHACADINVIMA)	||'</PRO_FECHACADINVIMA>'
				||  '<FECHACAMBIO>' 	 	 	||TO_CHAR(r.FECHACAMBIO,'dd/mm/yyyy hh24:mi:ss')	||'</FECHACAMBIO>'
				);
				
			IF	r.PRO_ENLACECERTIFICADO IS NOT NULL THEN
				HTP.P('<PRO_ENLACECERTIFICADO>' ||r.PRO_ENLACECERTIFICADO    ||'</PRO_ENLACECERTIFICADO>');
			END IF;
			IF	r.PRO_ENLACEFICHA IS NOT NULL THEN
				HTP.P('<PRO_ENLACEFICHA>'		||r.PRO_ENLACEFICHA    ||'</PRO_ENLACEFICHA>');
			END IF;

			-- Tipo de IVA del producto

			vTipoIVA := Tiposiva_Pck.BuscarTipoIVA ( r.PRO_IDTIPOIVA );
			IF vTipoIVA  IS NOT NULL THEN
				HTP.P('<PRO_TIPOIVA>'||vTipoIVA||'%</PRO_TIPOIVA>');
				HTP.P('<PRO_IDTIPOIVA>'||r.PRO_IDTIPOIVA||'</PRO_IDTIPOIVA>');
			END IF;

			TiposIVA_XML('IVA', 'PRO_IDTIPOIVA',  r.PRO_IDTIPOIVA, v_IDPais);	--9set10

			HTP.P('<TIPOSPRODUCTOS>'
				||'<field label="Tipo Producto" name="LLP_TIPO_PRODUCTO" current="'|| r.PRO_IDTIPOPRODUCTO ||'">'
				||'<dropDownList>');
			FOR TipoProducto IN cTiposProductos  LOOP
				HTP.P('<listElem>'
					||'<ID>'			|| TipoProducto.TPR_ID  	||'</ID>'
					||'<listItem>'		|| TipoProducto.TPR_NOMBRE	||'</listItem>'
					||'</listElem>');
			END LOOP; -- Bucle para el indicador (Solo 1 registro )
			HTP.P('</dropDownList>'
				||'</field>'
				||'</TIPOSPRODUCTOS>');


			--	22ene18 EMpaquetamiento privado paara usuarios no administradores	
			IF v_AdminMVMi='S' OR v_Admin='S'OR v_IDEmpresaDelUsuario=r.emp_id THEN

				HTP.P(	'<PRO_UNIDADBASICA>'     	||Mvm.ScapeHTMLString(r.pro_unidadbasica )		||'</PRO_UNIDADBASICA>'
					||  '<PRO_UNIDADESPORLOTE>'  	||r.pro_unidadesporlote 						||'</PRO_UNIDADESPORLOTE>');
			
				--solodebug utilidades_pck.debug('MostrarProducto. EMPAQUETAMIENTO GENERAL. AdminMVMi:'||v_AdminMVMi||' Admin:'||v_Admin||' UdBasica'||r.pro_unidadbasica ||' UdesLote:'||r.pro_unidadesporlote);
			ELSE
				
				PRODUCTOS_PCK.Empaquetamiento(v_IDEmpresaDelUsuario, r.pro_id, v_UnidadBasica, v_UnidadesPorLote);
				
				--solodebug utilidades_pck.debug('MostrarProducto. EMPAQUETAMIENTO PRIVADO. UdBasica'||v_UnidadBasica||' UdesLote:'||v_UnidadesPorLote);
			
				HTP.P(	'<PRO_UNIDADBASICA>'     	||Mvm.ScapeHTMLString(v_UnidadBasica)			||'</PRO_UNIDADBASICA>'
					||  '<PRO_UNIDADESPORLOTE>'  	||v_UnidadesPorLote 							||'</PRO_UNIDADESPORLOTE>');
			
			END IF;
			


			--	11feb14	Recuperamos la info para las empresas especiales del país
			IF p_MostrarTarifas	='S' THEN
				IF v_AdminMVMi='S' OR v_Admin='S'OR v_IDEmpresaDelUsuario=r.emp_id THEN

					HTP.P(	'<DESPLEGABLEEMPRESAS/>'	);

					FOR e IN cEmpresasEspeciales(v_IDPais, NULL) LOOP

						v_IDOfertaDelProducto:=Documentos_pck.IDDocumentoDelProducto(r.pro_id, e.EMP_ID, e.EE_MARCAOFERTA);

						DatosCliente_XML(r.pro_id, e.EMP_ID, e.EMP_NOMBRECORTOPUBLICO, v_IDPais, v_IDIdioma,  r.PRO_IDPROVEEDOR, v_IDOfertaDelProducto, 'OFERTAS', 'IDOFERTA', e.EE_MARCAOFERTA);

					END LOOP;

					v_IDEmpresaFiltro:=NULL;
				ELSE

					--	Si es usuario CDC, solo para su empresa
					FOR e IN cEmpresasEspeciales(v_IDPais, v_IDEmpresaDelUsuario) LOOP

						v_IDOfertaDelProducto:=Documentos_pck.IDDocumentoDelProducto(r.pro_id, e.EMP_ID, e.EE_MARCAOFERTA);

						DatosCliente_XML(r.pro_id, e.EMP_ID, e.EMP_NOMBRECORTOPUBLICO, v_IDPais, v_IDIdioma,  r.PRO_IDPROVEEDOR, v_IDOfertaDelProducto, 'OFERTAS', 'IDOFERTA', e.EE_MARCAOFERTA);

					END LOOP;

					v_IDEmpresaFiltro:=v_IDEmpresaDelUsuario;
				END IF;

				/*
				--	22oct20 Listado de tarifas con todos los campos relevantes
				HTP.P(	'<TARIFAS>'	);
				FOR t IN cTarifas(r.pro_id, v_IDEmpresaFiltro) LOOP
					HTP.P(	'<TARIFA>'	
						||	'<IDCLIENTE>'	  				||Mvm.ScapeHTMLString(t.TRF_IDCLIENTE)			||'</IDCLIENTE>'					--26oct20
						||	'<CLIENTE>'	  					||Mvm.ScapeHTMLString(t.CLIENTE)				||'</CLIENTE>'
						||	'<TRF_IMPORTE>'					||formato.sinformato(t.TRF_IMPORTE,NULL)		||'</TRF_IMPORTE>'
						||	'<TRF_IDDIVISA>'				||t.TRF_IDDIVISA 								||'</TRF_IDDIVISA>'					--	3nov20
						||	'<IMPORTE_CONFORMATO>'			||FORMATO.FOrmato(t.TRF_IMPORTE,0,'L')			||'</IMPORTE_CONFORMATO>'
						||	'<TRF_FECHA>'					||TO_CHAR(t.TRF_FECHA,'dd/mm/yyyy')				||'</TRF_FECHA>'
						||	'<ANTIGUEDAD_TARIFA>'			||TO_CHAR(FLOOR(SYSDATE-t.TRF_FECHA))			||'</ANTIGUEDAD_TARIFA>'
						||	'<TRF_FECHAINICIO>'				||TO_CHAR(t.TRF_FECHAINICIO,'dd/mm/yyyy')		||'</TRF_FECHAINICIO>'
						||	'<TRF_FECHALIMITE>'				||TO_CHAR(t.TRF_FECHALIMITE,'dd/mm/yyyy')		||'</TRF_FECHALIMITE>'
						||	'<TRF_NOMBREDOCUMENTO>'	  		||Mvm.ScapeHTMLString(t.TRF_NOMBREDOCUMENTO)	||'</TRF_NOMBREDOCUMENTO>'
						||	'<TRF_BONIF_CANTIDADDECOMPRA>' 	||TO_CHAR(t.TRF_BONIF_CANTIDADDECOMPRA)			||'</TRF_BONIF_CANTIDADDECOMPRA>'	--	3nov20
						||	'<TRF_BONIF_CANTIDADGRATUITA>' 	||TO_CHAR(t.TRF_BONIF_CANTIDADGRATUITA)			||'</TRF_BONIF_CANTIDADGRATUITA>'	--	3nov20
						||	'<TRF_IDTIPONEGOCIACION>'		||t.TRF_IDTIPONEGOCIACION 						||'</TRF_IDTIPONEGOCIACION>'		--	3nov20
						);

					--	26oct20 Desplegable de tipos de negociación
					tarifas_pck.DespTiposNegociacion_XML(t.TRF_IDCLIENTE, t.TRF_IDTIPONEGOCIACION);

					--	7oct20 Si está informado el tipo de negociación, también la devolvemos
					IF t.TRF_IDTIPONEGOCIACION IS NOT NULL THEN
						HTP.P('<TIPONEGOCIACION>'		||	Mvm.ScapeHTMLString(tarifas_pck.NombreTipoNegociacion(t.TRF_IDTIPONEGOCIACION))	||'</TIPONEGOCIACION>');
					END IF;


					--	2nov20 Documento de oferta o contrato asociado al producto
					v_IDDocumento:=documentos_pck.IDDocumentoDelProducto(r.pro_id,t.TRF_IDCLIENTE,'OFERTAS_Y_CONTRATOS');

					utilidades_pck.debug('documentos_pck.mostrardocumento. IDProd:'||r.pro_id||' IDCli:'||t.TRF_IDCLIENTE||' IDDocumento:'||v_IDDocumento);

					IF v_IDDocumento IS NOT NULL THEN
						documentos_pck.MostrarDocumento_XML(v_IDDocumento, 'DOCUMENTO', 'N', v_IDIdioma);
					END IF;



					--	Documentos OFERTA y CONTRATO (según derechos del usuario disponibles para este proveedor)
					/ *documentos_pck.ListaOfertasDelProveedor_XML
					(
						r.PRO_IDPROVEEDOR,							--	ID del proveedor
						v_IDEmpresaFiltro,							--	ID del cliente (NULL para todos)
						v_IDIdioma,
						'DOCUMENTOS',								--	p_MarcaOfertas
						'IDDOCUMENTO',										--	p_CampoIDOfertas
						DOCUMENTOS_PCK.IDDocumentoDelProducto(r.pro_id,t.TRF_IDCLIENTE,'OFERTAS_Y_CONTRATOS'),							--	p_IDDOcumento
						'OFERTAS_Y_CONTRATOS',						--	p_TipoDocumento
						'N'
					);* /

					HTP.P('</TARIFA>');
				END LOOP;
				HTP.P(	'</TARIFAS>'	);
				*/

				--	26oct20 Listado genérico
				documentos_pck.ListaOfertasDelProveedor_XML
				(
					r.PRO_IDPROVEEDOR,								--	ID del proveedor
					v_IDEmpresaFiltro,
					--	ID del cliente (NULL si es admin)
					v_IDIdioma,
					'DOCUMENTOS',									--	p_CampoIDOfertas,
					'IDDOCUMENTO',									--	p_CampoIDOfertas
					NULL,											--	p_IDDOcumento,
					'OFERTAS_Y_CONTRATOS',							--	p_TipoDocumento
					'N'
				);

				--	6nov20 Para empresas "maestro" utilizaremos un desplegable de selecciones geo. Por ahora solo para Brasil
				IF v_IDPais=55 THEN
					eisselecciones_pck.DesplegableSelecciones_XML
					(
						p_US_ID,
						v_IDEmpresaFiltro, 							--	8jul16	El usuario ADMIN puede consultar para otras empresas
						'IDSELECCIONGEO', 								--	p_MarcaXML,
						NULL,										--	p_IDSeleccion,
						'EMP2',
						v_IDIdioma,
						'S',										--	p_SinExcluir
						'T',										--	p_IncluirNinguno,	
						'AREAGEO'									--	p_IDClasificacion
					);
				END IF;
			END IF; 		--	IF MostrarTerifas='S'


			--	Desplegable de tipos de negociacion, para clientes o usuarios MVM
			/*
			IF v_AdminMVMi='S' OR v_Admin='S' OR  v_IDEmpresaDelUsuario=r.emp_id THEN
				tarifas_pck.DespTiposNegociacion_XML(r.emp_id, t.TRF_IDTIPONEGOCIACION);
			END IF;
			*/
        	
			IF r.PRO_NUMFOTOS>0 THEN
            	IMAGENES_PCK.FotosProducto_XML(r.PRO_ID,'N');
        	END IF;


			/*
			--	26may11	Desplegable con las ficha técnicas de un proveedor
			documentos_pck.ListaOfertasDelProveedor_XML
			(
				r.PRO_IDPROVEEDOR,				--	ID del proveedor
				v_IDIdioma,
				'FICHAS_TECNICAS',
				'IDFICHATECNICA',
				r.PRO_IDFICHATECNICA,
				'FT'
			);
			*/

		/*	29jun18 Documentación en mantenimiento de documentos

			--	28jun18 Devuelve toda la documentacion asociada a un producto, separando la obligatoria de la opcional
			documentos_pck.DocumentosDelProducto_XML(r.PRO_ID,'DOCUMENTACION',NULL,'N');
			
			--	29mar12	Documentos comerciales, solo para administradores
			IF v_AdminMVMi='S' THEN
				--	Desplegable con todos los documentos comerciales asociados a un proveedor
				documentos_pck.ListaOfertasDelProveedor_XML
				(
					r.PRO_IDPROVEEDOR,				--	ID del proveedor
					v_IDIdioma,
					'DOCUMENTOS_COMERCIALES_PROV',
					'IDODCUMENTOCOMERCIAL',
					r.PRO_IDFICHATECNICA,
					'CO'
				);
				
				--documentos_pck.DocumentosDelProducto_XML(r.PRO_ID,'DOCUMENTOS_COMERCIALES_PROD','CO','N');
			END IF;
		*/		
			
			
			--
			--
			--	PEndiente: si no es admin, solo mostramos el empaquetamiento privado para su empresa
			--
			--
			
			
			
			
			--	27jun13	Indicamos si el producto tiene empaquetamiento privado
			IF PRODUCTOS_PCK.EmpaquetamientoPrivado(r.PRO_ID)='S' THEN
				HTP.P('<EMPAQUETAMIENTO_PRIVADO/>');
			END IF;
					
			--	28abr11	Responsable del alta del producto y fecha de alta
			HTP.P('<ALTA>'||TO_CHAR(r.PRO_FECHAALTA,'dd/mm/yyyy hh24:mi:ss')||'</ALTA>');
			FOR u IN cResponsable(r.PRO_IDUSUARIOALTA) LOOP
				HTP.P(	'<USUARIO>'
					||	'<ID>'		||u.US_ID		||'</ID>'
					||	'<NOMBRE>'	||mvm.ScapeHTMLSTring(u.NOMBRE)	||'</NOMBRE>'
					||	'</USUARIO>');
			END LOOP;
			
			--	10abr12	Último comentario para productos "devueltos"
			IF r.PRO_STATUS='D' THEN
				FOR rCom IN cUltimoComentario(r.PRO_ID) LOOP
					HTP.P('<COMENTARIO>'	||mvm.ScapeHTMLSTring(rCom.COMENTARIO)	||'</COMENTARIO>');
				END LOOP;
			END IF;
			
		END IF;
		
	END LOOP;
	HTP.P('</PRODUCTO>');


EXCEPTION
	WHEN OTHERS THEN
		HTP.P('<PRODUCTO/>');
		Mvm.StatusDBError; -- // // MVM.StatusDBError ( 'G-1024' );
		Mvm.InsertDBError ('MantenimientoProductos_PCK.MostrarProducto','IDProducto:'||p_PRO_ID||' SQLERRM:'||SQLERRM);
END;


--	5set13	Datos particulares del producto para un cliente en formato XML
PROCEDURE DatosCliente_XML
(
	p_IDProducto				NUMBER,
	p_IDCliente					NUMBER,
	p_NombreCortoCliente		VARCHAR2,
	p_IDPais					NUMBER,
	p_IDIdioma					NUMBER,
	p_IDProveedor				NUMBER,
	p_IDDOcumento				NUMBER,
	p_MarcaOfertas				VARCHAR2,	
	p_CampoIDOfertas			VARCHAR2,	
	p_FiltroOfertas				VARCHAR2
)
IS
	
	--	Necesitamos la fecha de la tarifa 
	CURSOR cTarifa(IDProducto NUMBER, IDCliente NUMBER) IS
		SELECT		TARIFAS.*,  													--	7oct20 Nuevos campos
					NVL(TRF_FECHALIMITE, TRF_FECHA+365) FECHALIMITE					--	4set13: fecha limite
			FROM 	TARIFAS
			WHERE	TRF_IDPRODUCTO=IDProducto
			AND		TRF_IDCLIENTE=IDCliente;
		
	--	17feb12	Comprueba si el producto está incluido en alguna plantilla de empresa activa que no sea ASISA	
	CURSOR cEnPlantillaMVM(IDPais NUMBER, IDProducto NUMBER) IS
		SELECT		count(*)	Total
			FROM 	PRODUCTOSLINEASPLANTILLAS, LINEASPLANTILLAS, PLANTILLAS, EMPRESAS
			WHERE	PL_IDEMPRESA=EMP_ID
			AND		LIP_IDPLANTILLA=PL_ID
			AND		PLP_IDLINEAPLANTILLA=LIP_ID
			AND 	EMP_STATUS IS NULL
			AND 	PL_STATUS IS NULL
			AND		PL_IDPROVEEDOR IS NOT NULL		--	solo interesan plantillas por proveedor
			AND		NVL(EMP_NOEXPANDIR,'N')='N'		--12feb13
			AND		EMP_IDPAIS=IDPais				--12feb13
			AND		PLP_IDPRODUCTO=IDProducto;

	--	21feb12	Aprovechamos el resumen de consumos para extraer los datos de alli
	CURSOR cConsumo(IDCLiente NUMBER, IDProducto NUMBER) IS
		SELECT 		NVL(SUM(EIS_RC_CONSUMO),0) TOTAL
			FROM 	EIS_RESUMENCONSUMOS 
			WHERE 	EIS_RC_IDPRODUCTO=IDProducto 
			AND 	EIS_RC_IDEMPRESA=IDCLiente
			AND 	EIS_RC_IDCENTRO IS NULL;		--17mar14 La tabla EIS_RESUMENCONSUMOS también incluye la info por centro

	--	17feb12	Consumo MVM
	CURSOR cConsumoMVM(IDPais NUMBER, IDProducto NUMBER) IS
		SELECT 		NVL(SUM(EIS_RC_CONSUMO),0) TOTAL
			FROM 	EIS_RESUMENCONSUMOS, EMPRESAS 
			WHERE 	EIS_RC_IDEMPRESA=EMP_ID
			AND 	EIS_RC_IDPRODUCTO=IDProducto
			AND 	EIS_RC_IDCENTRO IS NULL			--17mar14 La tabla EIS_RESUMENCONSUMOS también incluye la info por centro
			AND		EMP_IDPAIS=IDPais
			AND		NVL(EMP_NOEXPANDIR,'N')='N';


	v_IDDocumento				DOCUMENTOS.DOC_ID%TYPE; 										--	2nov20 Documento asociado a la tarifa
	v_IDDivisaDefecto			DIVISAS.DIV_ID%TYPE;											--	7dic20 Divisa por defecto de la empresa
	v_Parametros				VARCHAR2(1000);
BEGIN	
	v_Parametros:='IDProducto:'||p_IDProducto||' IDCliente:'||p_IDCliente||' NombreCortoCliente:'||p_NombreCortoCliente||' IDPais:'||p_IDPais||' IDIdioma:'||p_IDIdioma||' IDProveedor:'||p_IDProveedor
				||' IDDOcumento:'||p_IDDOcumento||' MarcaOfertas:'||p_MarcaOfertas||' CampoIDOfertas:'||p_CampoIDOfertas||' FiltroOfertas:'||p_FiltroOfertas;
				
 	--solodebug utilidades_pck.debug('MantenimientoProductos_PCK.DatosCliente_XML. '||v_Parametros);


	HTP.P(
			'<DATOS_CLIENTE ID="'||p_IDCliente||'">'
		||	'<EMP_ID>'					||p_IDCliente										||'</EMP_ID>'
		||	'<NOMBRE_CORTO>'			||p_NombreCortoCliente  							||'</NOMBRE_CORTO>'
		||	'<IDCLIENTE>'				||p_IDCliente										||'</IDCLIENTE>'									--	4nov20
		||	'<CLIENTE>' 				||p_NombreCortoCliente  							||'</CLIENTE>'										--	4nov20
		||	'<TIPO>'					||p_FiltroOfertas 									||'</TIPO>'
		||	'<TARIFAS_POR_AREAGEO>'		||empresas_pck.TarifasPorAreaGeo(p_IDCliente) 		||'</TARIFAS_POR_AREAGEO>'				--	6nov20
		);							--	27mar14
					
	FOR t IN cTarifa(p_IDProducto, p_IDCliente) LOOP

		HTP.P( '<TARIFA>'			--6nov20	
			--6nov20	|| '<TARIFA>' 						||t.TRF_IMPORTE  								||'</TARIFA>'
			--6nov20	||	'<TARIFA_CONFORMATO>'			||FORMATO.FOrmato(t.TRF_IMPORTE,0,'L')			||'</TARIFA_CONFORMATO>'
			||	'<FECHA_TARIFA>'				||TO_CHAR(t.TRF_FECHA,'dd/mm/yyyy')			||'</FECHA_TARIFA>'
			||	'<FECHA_LIMITE>'				||TO_CHAR(t.FECHALIMITE,'dd/mm/yyyy')			||'</FECHA_LIMITE>'
			||	'<ANTIGUEDAD_TARIFA>'			||TO_CHAR(FLOOR(SYSDATE-t.TRF_FECHA))			||'</ANTIGUEDAD_TARIFA>'
			--	7oct20 Nuevos campos
			||	'<TRF_IMPORTE>' 				||formato.sinformato(t.TRF_IMPORTE,NULL) 		||'</TRF_IMPORTE>'					--	4nov20
			||	'<TRF_FECHAINICIO>'				||TO_CHAR(t.TRF_FECHAINICIO,'dd/mm/yyyy')		||'</TRF_FECHAINICIO>'
			||	'<TRF_FECHALIMITE>'				||TO_CHAR(t.TRF_FECHALIMITE,'dd/mm/yyyy')		||'</TRF_FECHALIMITE>'
			||	'<TRF_NOMBREDOCUMENTO>'	  		||Mvm.ScapeHTMLString(t.TRF_NOMBREDOCUMENTO)	||'</TRF_NOMBREDOCUMENTO>'
			||	'<TRF_BONIF_CANTIDADDECOMPRA>' 	||TO_CHAR(t.TRF_BONIF_CANTIDADDECOMPRA)			||'</TRF_BONIF_CANTIDADDECOMPRA>'	--	4nov20
			||	'<TRF_BONIF_CANTIDADGRATUITA>' 	||TO_CHAR(t.TRF_BONIF_CANTIDADGRATUITA)			||'</TRF_BONIF_CANTIDADGRATUITA>'	--	4nov20
			||	'<TRF_IDTIPONEGOCIACION>'		||t.TRF_IDTIPONEGOCIACION 						||'</TRF_IDTIPONEGOCIACION>'		--	4nov20
			||	'<TRF_IDSELECCIONGEO>'			||t.TRF_IDSELECCIONGEO							||'</TRF_IDSELECCIONGEO>'			--	6nov20
			);

		--	7dic20 Datos correspondientes a la divisa
		IF t.TRF_IDDIVISA=0 THEN
			divisas_pck.Divisa_XML(empresas_pck.IDDivisa(p_IDCliente));
		ELSE
			divisas_pck.Divisa_XML(t.TRF_IDDIVISA);
		END IF;
		
		--	7oct20 Si está informado el tipo de negociación, también la devolvemos
		IF t.TRF_IDTIPONEGOCIACION IS NOT NULL THEN
			HTP.P('<TIPONEGOCIACION>'		||	Mvm.ScapeHTMLString(tarifas_pck.NombreTipoNegociacion(t.TRF_IDTIPONEGOCIACION))	||'</TIPONEGOCIACION>');
		END IF;

		--	6nov20 Si está informada la selección GEO, también la devolvemos
		IF t.TRF_IDSELECCIONGEO IS NOT NULL THEN
			HTP.P('<SELECCIONGEO>'		||	Mvm.ScapeHTMLString(eisselecciones_pck.NombreSeleccion(t.TRF_IDSELECCIONGEO))	||'</SELECCIONGEO>');
		END IF;

		--	22oct20 Desplegable de tipos de negociación
		tarifas_pck.DespTiposNegociacion_XML(p_IDCliente, t.TRF_IDTIPONEGOCIACION);
		
		--	2nov20 Documento de oferta o contrato asociado al producto
		v_IDDocumento:=documentos_pck.IDDocumentoDelProducto(p_IDProducto,t.TRF_IDCLIENTE,'OFERTAS_Y_CONTRATOS');

		IF v_IDDocumento IS NOT NULL THEN
			documentos_pck.MostrarDocumento_XML(v_IDDocumento, 'DOCUMENTO', 'N', p_IDIdioma);
		END IF;

		HTP.P('</TARIFA>');
	END LOOP;

	--23feb16	IF p_IDCliente IN (Mvm.BuscarParametro(0), Mvm.BuscarParametro(200)) THEN
	IF p_IDCliente=TO_NUMBER(utilidades_pck.Parametro('IDMVM_'||p_IDPais)) THEN
		--	Emplantillado en MVM
		FOR rEnPlantilla IN cEnPlantillaMVM(p_IDPais, p_IDProducto) LOOP
			IF rEnPlantilla.Total>0 THEN
				HTP.P('<EMPLANTILLADO/>');
			END IF;
		END LOOP;

  		--	Consumo
		FOR rConsumo IN cConsumoMVM(p_IDPais, p_IDProducto) LOOP
			HTP.P(	'<CONSUMO>'|| FORMATO.FOrmato(rConsumo.Total,0,'C')	||'</CONSUMO>');
		END LOOP;
	ELSE
		--	Emplantillado en el cliente
		IF CARPETASYPLANTILLAS_PCK.EnPlantillasDeEmpresa(p_IDCliente, p_IDProducto) IS NOT NULL THEN
			HTP.P('<EMPLANTILLADO/>');
		END IF;

  		--	Consumo en el cliente
		FOR rConsumo IN cConsumo(p_IDCliente, p_IDProducto) LOOP
			HTP.P(	'<CONSUMO>'|| FORMATO.FOrmato(rConsumo.Total,0,'C')	||'</CONSUMO>');
		END LOOP;

	END IF;
	
	--	Desplegable con las ofertas de un proveedor
	documentos_pck.ListaOfertasDelProveedor_XML
	(
		p_IDProveedor,				--	ID del proveedor
		p_IDCliente,				--	IDCliente
		p_IDIdioma,
		p_MarcaOfertas,
		p_CampoIDOfertas,
		p_IDDOcumento,
		p_FiltroOfertas
	);

	IF p_IDDOcumento<>-1 THEN
		Documentos_pck.MostrarDocumento_XML(p_IDDOcumento,'OFERTA','N', p_IDIdioma);
	END IF;


	HTP.P(	'</DATOS_CLIENTE>');

EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.DatosCliente_XML',v_Parametros||' SQLERRM:'||SQLERRM);
END;


--	Mantenimiento de producto
PROCEDURE ModificarProducto_prov
(
	p_IDUsuario					VARCHAR2,
	p_PRO_ID					VARCHAR2,
	p_IDPROVEEDOR				NUMBER,
	p_PRO_NOMBRE				VARCHAR2,
	p_PRO_MARCA					VARCHAR2,
	p_PRO_UNIDADBASICA			VARCHAR2,
	p_PRO_UNIDADESPORLOTE		VARCHAR2,
	p_PRO_REFERENCIA			VARCHAR2,
	p_PRO_IDTIPOIVA				VARCHAR2,
    p_CADENA_IMAGENES           VARCHAR2,
    p_CADENA_IMAGENES_BORRADAS  VARCHAR2,
	p_SolicitarBorrado  		VARCHAR2,
	p_FechaAccion				VARCHAR2,
	p_IDFichaTecnica			VARCHAR2,
	p_PRO_OCULTO				VARCHAR2,
	p_PRO_CATEGORIA				VARCHAR2,
	p_PRO_REFESTANDAR			VARCHAR2,
	p_ListaCambios				VARCHAR2 DEFAULT NULL,			--	7feb14
	p_PRO_REQUIEREPRESUPUESTO	VARCHAR2 DEFAULT NULL,			--	29set14
    p_PRO_CODEXPEDIENTE 		VARCHAR2 DEFAULT NULL,			--	15ene18	nuevos campos Colombia
	p_PRO_CODCUM				VARCHAR2 DEFAULT NULL,
	p_PRO_CODINVIMA				VARCHAR2 DEFAULT NULL,
	p_PRO_FECHACADINVIMA		VARCHAR2 DEFAULT NULL,
	p_PRO_CLASIFICACIONRIESGO	VARCHAR2 DEFAULT NULL,
	p_PRO_REGULADO				VARCHAR2 DEFAULT NULL,
	p_PRO_CODIUM				VARCHAR2 DEFAULT NULL,			--	13feb20 nuevo campo Colombia
	p_PRO_REGISTROSANITARIO		VARCHAR2 DEFAULT NULL			--	08feb22 nuevo campo Colombia
)
IS
	v_IDProducto			NUMBER;
BEGIN

	v_IDProducto:= ModificarProducto_prov
		(
			p_IDUsuario				,
			p_PRO_ID				,
			p_IDPROVEEDOR	,
			p_PRO_NOMBRE			,
			p_PRO_MARCA				,
			p_PRO_UNIDADBASICA		,
			p_PRO_UNIDADESPORLOTE	,
			p_PRO_REFERENCIA		,
			p_PRO_IDTIPOIVA			,
            p_CADENA_IMAGENES,
            p_CADENA_IMAGENES_BORRADAS,
			p_SolicitarBorrado,
			p_FechaAccion,
			p_IDFichaTecnica,
			p_PRO_OCULTO,
			p_PRO_CATEGORIA,
			p_PRO_REFESTANDAR,
			p_ListaCambios,							--	7feb14
			p_PRO_REQUIEREPRESUPUESTO,				--	29set14
    		p_PRO_CODEXPEDIENTE,					--	15ene18	nuevos campos Colombia
			p_PRO_CODCUM,
			p_PRO_CODINVIMA,
			p_PRO_FECHACADINVIMA,
			p_PRO_CLASIFICACIONRIESGO,
			p_PRO_REGULADO,
			p_PRO_CODIUM,
			p_PRO_REGISTROSANITARIO					--	8feb22
		);

	IF v_IDProducto = -1 THEN
		HTP.P('<ERROR msg="La referencia '||p_PRO_REFERENCIA||' está siendo utilizada por otro producto de este proveedor o hay una solicitud de cambio en curso para este producto." titulo="Error"/>');
	ELSIF v_IDProducto = -2 THEN
		HTP.P('<ERROR msg="Error desconocido, por favor contacte con el equipo técnico de MedicalVM" titulo="Error"/>');
	ELSE
		HTP.P('<OK/>');
	END IF;
END;


--	Modifica los datos de un producto en el catalogo de proveedores
FUNCTION ModificarProducto_prov
(
	p_IDUsuario					VARCHAR2,
	p_PRO_ID					VARCHAR2,									--	NULL para nuevo producto
	p_IDPROVEEDOR				NUMBER,
	p_PRO_NOMBRE				VARCHAR2,
	p_PRO_MARCA					VARCHAR2,
	p_PRO_UNIDADBASICA			VARCHAR2,
	p_PRO_UNIDADESPORLOTE		VARCHAR2,
	p_PRO_REFERENCIA			VARCHAR2,
	p_PRO_IDTIPOIVA				VARCHAR2,
    p_CADENA_IMAGENES           VARCHAR2,
    p_CADENA_IMAGENES_BORRADAS  VARCHAR2,
	p_SolicitarBorrado  		VARCHAR2,
	p_FechaAccion				VARCHAR2,
	p_IDFichaTecnica			VARCHAR2,
	p_PRO_OCULTO				VARCHAR2,
	p_PRO_CATEGORIA				VARCHAR2,
	p_PRO_REFESTANDAR			VARCHAR2,
	p_ListaCambios				VARCHAR2 DEFAULT NULL,			--	7feb14
	p_PRO_REQUIEREPRESUPUESTO	VARCHAR2 DEFAULT NULL,			--	29set14
    p_PRO_CODEXPEDIENTE 		VARCHAR2 DEFAULT NULL,			--	15ene18	nuevos campos Colombia
	p_PRO_CODCUM				VARCHAR2 DEFAULT NULL,
	p_PRO_CODINVIMA				VARCHAR2 DEFAULT NULL,
	p_PRO_FECHACADINVIMA		VARCHAR2 DEFAULT NULL,
	p_PRO_CLASIFICACIONRIESGO	VARCHAR2 DEFAULT NULL,
	p_PRO_REGULADO				VARCHAR2 DEFAULT NULL,
	p_PRO_CODIUM				VARCHAR2 DEFAULT NULL,			--	13feb20 nuevo campo Colombia
	p_PRO_REGISTROSANITARIO		VARCHAR2 DEFAULT NULL			--	08feb22 nuevo campo Colombia
) RETURN NUMBER
IS

	CURSOR cOtrosCambios(IDProducto NUMBER) IS
		SELECT		PRO_ID
			FROM	PRODUCTOS
			WHERE	PRO_STATUS IN ('M','B')	--	Borrar o modificar
			AND		PRO_IDPADRE=IDProducto;

	--	9may13	Hacemos la consulta por un cursor, es más eficiente ya que permite info de error más precisa
	/*CURSOR cMismaReferencia(IDProveedor NUMBER, IDProducto NUMBER, Referencia VARCHAR2) IS
		SELECT		PRO_ID, PRO_STATUS	
			FROM 	PRODUCTOS
			WHERE 	(NVL(PRO_STATUS,'N')NOT IN ('B','D')) --	13feb13 Comprobamos que no existan solicitudes de cambios
			AND 	UPPER(pro_referencia)=UPPER(trim(REPLACE(Referencia,CHR(13)||CHR(10),'')))
			AND 	PRO_IDPROVEEDOR	=	IDProveedor
			AND 	PRO_ID			<>	NVL(IDProducto,-1);		--	PRO_ID diferente
*/
				
	v_IDProducto				PRODUCTOS.pro_id%TYPE;
	v_IDOtroProducto			PRODUCTOS.pro_id%TYPE;
	v_EstadoOtro				PRODUCTOS.PRO_STATUS%TYPE;
	v_IDEmpresaDelUsuario		EMPRESAS.emp_id%TYPE;
	v_Rol						TIPOSEMPRESAS.TE_ROL%TYPE;			--	15ene18

	--v_PrecioPublico				NUMBER;
	--7abr14	v_PRO_HOMOLOGADO			NUMBER(1);

	v_ReferenciaAnterior 		PRODUCTOS.PRO_REFERENCIA%TYPE;

	v_Existe 					NUMBER;
	v_Estado					PRODUCTOS.PRO_STATUS%TYPE;
	v_Oculto					PRODUCTOS.PRO_OCULTO%TYPE;

	--	MVM y MVM B
	v_IDEmpresaMVM						EMPRESAS.emp_id%TYPE;
	--v_IDEmpresaMVM B						EMPRESAS.emp_id%TYPE;
	v_IDPais					EMPRESAS.EMP_IDPAIS%TYPE;

	--	10feb14	Variable necesarias para gestionar la nueva lista de cambios
	v_ListaEmpresasEspeciales	VARCHAR2(3000);
	v_NumEmpresasEspeciales		INTEGER;
	v_CountCambios				INTEGER;
	v_Cadena					VARCHAR2(3000);
	v_IDCliente					VARCHAR2(100);
	v_Tarifa				 	TARIFAS.TRF_IMPORTE%TYPE;
	v_IDOferta				 	VARCHAR2(100);
	v_Marca						EMPRESASESPECIALES.EE_MARCAOFERTA%TYPE;	--	2abr14
	
	v_IDTipoIVA					TIPOSIVA.TIVA_ID%TYPE;			--	5mar15	Si hay cambio del tipo de IVA lo propoagamos a los productos estándar
	
	v_Admin						VARCHAR2(1);					--	24nov15	Permitimos al usuario ADMIN (en cliente) crear/modificar en el catálogo de proveedores

	v_UnidadBasica				PRO_UNIDADESPORLOTE.PRO_UL_UNIDADBASICA%TYPE;					--	15ene18 Empaquetamiento privado
	v_UnidadesPorLote			PRO_UNIDADESPORLOTE.PRO_UL_UNIDADESPORLOTE%TYPE;				--	15ene18 Empaquetamiento privado

	v_Status					VARCHAR2(3000);
	v_Acciones					VARCHAR2(3000); 				--24mar17	Para informar en LOGADMINISTRACION de las acciones realizadas
	v_Parametros				VARCHAR2(3000);					--9jul17

	PRODUCTO_DUPLICADO 			EXCEPTION;

BEGIN
	--23feb17	v_IDEmpresaMVM	:=Mvm.BuscarParametro(0);
	--23feb17	v_IDEmpresaMVM B	:=Mvm.BuscarParametro(2 0 0);
	
	v_Parametros:=' IDUsuario:'||p_IDUsuario
			||' IDProducto:'||p_PRO_ID
			||' IDProveedor:'||p_IDPROVEEDOR
			||' Referencia:'||p_PRO_REFERENCIA
			||' Nombre:'||p_PRO_NOMBRE
			||' IDTIPOIVA:'||p_PRO_IDTIPOIVA
			||' Borrar:'||p_SolicitarBorrado
			||' Cad.Imagenes:'|| p_CADENA_IMAGENES 
			||' Cad.Imagenes(Borrar):'|| p_CADENA_IMAGENES_BORRADAS 
			||' p_FechaAccion:'||p_FechaAccion	
			||' p_PRO_OCULTO:'||p_PRO_OCULTO
			||' p_IDFichaTecnica:'||p_IDFichaTecnica
			||'	p_PRO_CATEGORIA:'||p_PRO_CATEGORIA
			||' p_ListaCambios:'||p_ListaCambios
	    	||' p_PRO_CODEXPEDIENTE:'||p_PRO_CODEXPEDIENTE			--	15ene18	nuevos campos Colombia
			||' p_PRO_CODCUM:'||p_PRO_CODCUM
			||' p_PRO_CODINVIMA:'||p_PRO_CODINVIMA
			||' p_PRO_FECHACADINVIMA:'||p_PRO_FECHACADINVIMA
			||' p_PRO_CLASIFICACIONRIESGO:'||p_PRO_CLASIFICACIONRIESGO
			||' p_PRO_REGULADO:'||p_PRO_REGULADO
			||' p_PRO_CODIUM:'||p_PRO_CODIUM
			||' p_PRO_REGISTROSANITARIO:'||p_PRO_REGISTROSANITARIO
			;
		
	--v_Status:=v_Parametros;
			
	v_Acciones:=' IDUsuario:'||p_IDUsuario
			||' IDProducto:'||p_PRO_ID
			||' IDProveedor:'||p_IDPROVEEDOR
			||' Referencia:'||p_PRO_REFERENCIA
			||' Nombre:'||p_PRO_NOMBRE||'.';
			

	productos_pck.debug(p_PRO_ID, 'MantenimientoProductos_PCK.ModificarProducto_prov (INICIO):'||v_Parametros);
	--solodebug 	utilidades_pck.debug('MantenimientoProductos_PCK.ModificarProducto_prov (INICIO):'||v_Parametros);

	--
	--	Falta comprobar el usuario
	--

	-- Buscamos el código de empresa correspondiente al usuario
	--	9ene12	También el IDPais
	v_Status:=v_Status||'.Buscando centro.';
	SELECT 		EMP_ID, EMP_IDPAIS, DECODE(US_USUARIOGERENTE,1,'S','N'), TE_ROL
		INTO 	v_IDEmpresaDelUsuario, v_IDPais, v_Admin, v_Rol
		FROM 	CENTROS, USUARIOS, EMPRESAS, TIPOSEMPRESAS
		WHERE 	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		EMP_IDTIPO=TE_ID
		AND		US_ID=p_IDUsuario;
	
	v_IDEmpresaMVM	:=TO_NUMBER(utilidades_pck.Parametro('IDMVM_'||v_IDPais));

	/*IF p_PRO_HOMOLOGADO='on' OR p_PRO_HOMOLOGADO='1' THEN
		v_PRO_HOMOLOGADO:=1;
	ELSE
		v_PRO_HOMOLOGADO:=0;
	END IF;*/

	--	28oct22 COmpletamos LOGS
	v_Status:=v_Status||' IDEmpresaDelUsuario:'||v_IDEmpresaDelUsuario||' IDPais:'||v_IDPais||'. Comprobando si existe.';

	--	11abr12 Comprobamos el estado del producto (si el PRO_ID no es nulo)
	IF p_PRO_ID IS NOT NULL THEN
		SELECT		PRO_STATUS, PRO_IDTIPOIVA
			INTO 	v_Estado, v_IDTipoIVA
			FROM 	PRODUCTOS
			WHERE	PRO_ID=p_PRO_ID;
		v_Status:=v_Status||'Producto existente, ID:'||p_PRO_ID||' estado:'||NVL(v_Estado,'NULL')||'.';
	ELSE
		v_Status:=v_Status||'Producto NUEVO.';
	END IF;

	--utilidades_pck.debug('ModificarProducto_prov IDProducto:'||p_PRO_ID||' Estado:'||v_Estado);
	--	21jul16 En Brasil no controlamos las referencias de proveedor
	--	28oct22 IF NVL(v_Estado,'O')<>'D' AND v_IDPais=34 THEN
	IF NVL(v_Estado,'O')<>'D' AND v_IDPais<>55 THEN

		/*
		v_Existe:=0;
		FOR r IN cMismaReferencia(p_IDPROVEEDOR,p_PRO_ID,p_PRO_REFERENCIA) LOOP
			v_IDOtroProducto	:=r.PRO_ID;
			v_EstadoOtro		:=r.PRO_STATUS;
			v_Existe			:=1;
		END LOOP;
	
		IF v_Existe>0 THEN
		
			v_Status:=v_Status||' Encontrado IDProducto '||v_IDOtroProducto||' en estado '||NVL(v_EstadoOtro,'NULL')||' con la misma referencia.';
		
			RAISE PRODUCTO_DUPLICADO;
		END IF;
		*/
		SELECT		MIN(PRO_ID), MIN(PRO_STATUS)
			INTO	v_IDOtroProducto, v_EstadoOtro
			FROM 	PRODUCTOS
			WHERE 	PRO_IDPROVEEDOR	= p_IDProveedor
			AND 	(NVL(PRO_STATUS,'N')NOT IN ('B','D')) --	13feb13 Comprobamos que no existan solicitudes de cambios
			AND 	UPPER(pro_referencia)=UPPER(normalizar_pck.LimpiarCadena(p_PRO_REFERENCIA))
			AND 	PRO_ID			<>	NVL(p_PRO_ID,-1);		--	PRO_ID diferente
	
		IF v_IDOtroProducto IS NOT NULL THEN
		
			v_Status:=v_Status||' Encontrado IDProducto '||v_IDOtroProducto||' del proveedor '||p_IDProveedor||' en estado '||NVL(v_EstadoOtro,'NULL')||' con la misma referencia.';
		
			Mvm.InsertDBError ('MantenimientoProductos_PCK.ModificarProducto_prov',v_Parametros||'. estado:'||v_Status);
		
			RAISE PRODUCTO_DUPLICADO;			--28oct22 Esta linea habia sido desactivada. La recuperamos.
			
		END IF;
		
	END IF;

	
	--23feb17	IF (p_PRO_ID IS NULL) OR ((v_IDEmpresa<>v_IDEmpresaMVM AND v_IDEmpresa<>v_IDEmpresaMVM B AND v_Admin='N') AND (v_Estado IS NULL)) THEN	
	IF (p_PRO_ID IS NULL) OR (v_Rol='VENDEDOR') THEN	
	
		--
		--	El producto todavia no existe o solicita el cambio el proveedor (pero no es un producto devuelto)
		--
  		SELECT 		productos_seq.NEXTVAL
  			INTO 	v_IDProducto
  			FROM 	dual;

		v_Status:=v_Status||'Insertando nuevo producto:'||v_IDProducto||'.';

		--	Los cambios de proveedor tienen un estado diferente
		--23feb17	IF v_IDEmpresa=v_IDEmpresaMVM OR v_IDEmpresa=v_IDEmpresaMVM B OR v_Admin='S' THEN
		--22ene18	IF v_IDEmpresaDelUsuario=v_IDEmpresaMVM OR v_Admin='S' THEN
		IF (v_Rol='COMPRADOR') THEN
			
			v_Estado:=NULL;
			SELECT DECODE(p_PRO_OCULTO,'S','S','N') INTO v_Oculto FROM DUAL;
			
		ELSE
			--	18nov11		v_Oculto:='S';
			v_Oculto:='N';
			IF p_PRO_ID IS NULL THEN
				v_Estado:='N';
			ELSE
				IF NVL(p_SolicitarBorrado,'N')='N' THEN
					v_Estado:='M';
					
					--	Por defecto no se oculten los productos nuevos, así que recuperamos su estado original
					SELECT 		PRO_OCULTO
						INTO 	v_Oculto
						FROM 	PRODUCTOS
						WHERE	PRO_ID=p_PRO_ID;
					
				ELSE
					v_Estado:='X';
				END IF;
			END IF;
		END IF;
		
		
		--utilidades_pck.debug('ModificarProducto_prov IDProducto:'||p_PRO_ID||' Referencia:'||p_PRO_REFERENCIA||' NOMBRE:'||p_PRO_NOMBRE||' Imagenes:'
		--		||p_CADENA_IMAGENES||' SolicitarBorrado:'||p_SolicitarBorrado||' Estado:'||v_Estado||'. INSERT.');
		
		--	18nov11	ET Si es una solicitud de modificación de producto, eliminamos las anteriores que hayan para el mismo producto
		--	Al ser solicitudes, no estarán emplantilladas ni incluidas en BUSC_PRODUCTOS
		--	24nov15	Usuarios ADMIN también pueden crear/modificar productos
		--	23feb17	IF (v_IDEmpresa<>v_IDEmpresaMVM AND v_IDEmpresa<>v_IDEmpresaMVM B AND v_Admin='N') THEN
		IF (v_IDEmpresaDelUsuario<>v_IDEmpresaMVM  AND v_Admin='N') THEN
			UPDATE	PRODUCTOS
				SET		PRO_STATUS='B'
				WHERE	PRO_STATUS IN ('M','X')	--	Borrar o modificar
				AND		PRO_IDPADRE=p_PRO_ID;
		END IF;
		
		--	29abr11	Primera a mayuscula para los campos de texto
		v_Status:=v_Status||'. INSERT NUEVO.';
		
		INSERT INTO PRODUCTOS (
			PRO_ID,
			PRO_IDPROVEEDOR,
			PRO_NOMBRE,
			PRO_MARCA,
			PRO_UNIDADBASICA,
			PRO_UNIDADESPORLOTE,
			PRO_REFERENCIA,
			PRO_IDTIPOIVA,
			pro_nombre_norm,		--	Se sigue utilizando en las ordenaciones
			pro_marca_norm,
			PRO_FECHAALTA,
			PRO_ORIGEN,
			PRO_STATUS,
			PRO_IDUSUARIOALTA,
			PRO_REFERENCIA_NORM,
			PRO_IDPADRE	,			--	20abr11	Guardamos el ID del producto
			PRO_FECHAACCION,		--	27abr11 Fecha de acción
			PRO_IDFICHATECNICA,		--	26may11	Guardamos el ID de la ficha técnica
			PRO_OCULTO,
			PRO_CATEGORIA,
			PRO_REFESTANDAR,
			PRO_REQUIEREPRESUPUESTO,
    		PRO_CODEXPEDIENTE,			--	15ene18	nuevos campos Colombia
			PRO_CODCUM,
			PRO_CODINVIMA,
			PRO_FECHACADINVIMA,
			PRO_CLASIFICACIONRIESGO,
			PRO_REGULADO,
			PRO_CODIUM,
			PRO_FECHACAMBIO,
			PRO_REGISTROSANITARIO,							--8feb22
			PRO_TEXTO_NORM									--4dic13
		)
   		VALUES 
		(
			v_IDProducto,
			p_idproveedor,
			Utilidades_pck.PrimeraAMayusculas(NORMALIZAR_PCK.LimpiarCadena(SUBSTR(p_PRO_NOMBRE,1,500))),				--	16ago17 Protegemos contra cadenas demasiado grandes
			TRIM(SUBSTR(p_PRO_MARCA,1,100)),														--	16ago17 Protegemos contra cadenas demasiado grandes
			LOWER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_UNIDADBASICA)),
			p_PRO_UNIDADESPORLOTE,
			UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_REFERENCIA)),
			p_PRO_IDTIPOIVA,
			SUBSTR(Normalizar_Pck.NormalizarString ( p_pro_nombre ),1,3000),							--	16ago17 Protegemos contra cadenas demasiado grandes
			SUBSTR(Normalizar_Pck.NormalizarString ( p_pro_marca ),1,100),							--	16ago17 Protegemos contra cadenas demasiado grandes
			SYSDATE,
			'ModificarProducto_prov',
			v_Estado,
			p_IDUsuario,
			normalizar_pck.NormalizarID(p_PRO_REFERENCIA),
			p_PRO_ID,			--	20abr11
			TO_DATE(p_FechaAccion,'dd/mm/yyyy'),
			DECODE(p_IDFichaTecnica,-1, NULL, p_IDFichaTecnica),
			v_Oculto,
			SUBSTR(p_PRO_CATEGORIA,1,1),
			Normalizar_Pck.NormalizarString(p_PRO_REFESTANDAR),
			p_PRO_REQUIEREPRESUPUESTO,
    		p_PRO_CODEXPEDIENTE,			--	15ene18	nuevos campos Colombia
			p_PRO_CODCUM,
			p_PRO_CODINVIMA,
			p_PRO_FECHACADINVIMA,
			p_PRO_CLASIFICACIONRIESGO,
			p_PRO_REGULADO,
			p_PRO_CODIUM,
			SYSDATE,
			p_PRO_REGISTROSANITARIO,			--	8feb22
			SUBSTR(normalizar_pck.NormalizarID(p_PRO_REFERENCIA)||' '||normalizar_pck.NormalizarID(p_PRO_REFESTANDAR)||' '||normalizar_pck.NormalizarString(p_PRO_NOMBRE||' '||p_PRO_MARCA),1,1000)	--	24feb22 annadimos SUBST
		);

		v_Status:=v_Status||' Imagenes.';
        
		-- guardamos las imagenes
		IF p_CADENA_IMAGENES IS NOT NULL THEN
    		Imagenes_Pck.guardarFotos(
    		p_CADENA_IMAGENES,
    		NULL,
    		v_IDProducto,
    		NULL,
    		NULL,
			'S'
    		);
		END IF;
		

		--	9nov11	Si es un nuevo producto creado por MVM actualizamos en la tabla de referencias asociadas
		IF v_IDEmpresaDelUsuario=1 THEN

			v_Status:=v_Status||' AsociarReferenciaEstandar.';
			
			CatalogoAutomatico_pck.AsociarReferenciaEstandar(v_IDProducto, Normalizar_Pck.NormalizarStringBusquedaDB(p_PRO_REFESTANDAR));
		END IF;
        
	ELSE	
		--
		--	El producto ya existe
		--	11abr12	Puede ser un producto "devuelto" al proveedor
		--
		v_IDProducto:=p_PRO_ID;
		
		IF v_IDEmpresaDelUsuario=1 THEN
			GuardarSolicitudCambio(p_IDUsuario, v_IDProducto, 'A', 'Producto cambiado por usuario de MVM');
		END IF;

		v_Status:='Comprobando referencia:'||v_IDProducto||'.';

		SELECT 		PRO_REFERENCIA
			INTO 	v_ReferenciaAnterior
			FROM 	PRODUCTOS
	    	WHERE 	PRO_ID=v_IDProducto;

		v_Status:=v_Status||' Actualizando producto';
		
		--	11abr12 Si es un producto devuelto volvemos a pasarlo como solicitud
		IF v_Estado='D' THEN
			v_Estado:='M';
		ELSE
			v_Estado:=NULL;
		END IF;

		v_Status:=v_Status||'. UPDATE. IDProducto:'||v_IDProducto||' Estado:'||v_Estado;
		
		--	15ene17 Si no estamos como admin, miramos si tiene empaquetamiento privado para este cliente
		IF  v_IDEmpresaDelUsuario<>v_IDEmpresaMVM AND v_Admin='N' THEN

			PRODUCTOS_PCK.Empaquetamiento(v_IDEmpresaDelUsuario, v_IDProducto, v_UnidadBasica, v_UnidadesPorLote);
			
			v_Status:=v_Status||' Nuevo empaquetamiento privado:'||MantenimientoProductos_PCK.NuevoEmpaquetamiento(p_IDUsuario, v_IDProducto, v_IDEmpresaDelUsuario, LOWER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_UNIDADBASICA)),p_PRO_UNIDADESPORLOTE,'S');

			--utilidades_pck.debug('ModificarProducto_prov IDProducto:'||p_PRO_ID||'. '||v_Status);
			--	Primera a mayuscula para los campos de texto
			UPDATE	PRODUCTOS SET
				PRO_NOMBRE				=Utilidades_pck.PrimeraAMayusculas(NORMALIZAR_PCK.LimpiarCadena(p_PRO_NOMBRE)),
				PRO_MARCA				=NORMALIZAR_PCK.LimpiarCadena(SUBSTR(p_PRO_MARCA,1,100)),					--	22nov11	Utilidades_pck.PrimeraAMayusculas(p_PRO_MARCA),
				--11dic18	PRO_UNIDADBASICA		=v_UnidadBasica,
				--11dic18	PRO_UNIDADESPORLOTE		=v_UnidadesPorLote,
				PRO_REFERENCIA			=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_REFERENCIA)),
				PRO_IDTIPOIVA			=p_PRO_IDTIPOIVA,
				pro_nombre_norm 		= Normalizar_Pck.NormalizarString ( p_pro_nombre ),
				pro_marca_norm 			= SUBSTR(Normalizar_Pck.NormalizarString (p_pro_marca),1,100),			--	2jun21	Cortamos a 100 caracteres
				PRO_REFERENCIA_NORM		= normalizar_pck.NormalizarID(p_PRO_REFERENCIA),
				PRO_STATUS				=v_Estado,		--15mar11	Por si se recuperan productos desde cargas
				PRO_IDFICHATECNICA		=DECODE(p_IDFichaTecnica,-1, NULL, p_IDFichaTecnica),
				PRO_OCULTO				=DECODE(p_PRO_OCULTO,'S','S','N'),
				PRO_CATEGORIA			=p_PRO_CATEGORIA,
				PRO_REFESTANDAR			=Normalizar_Pck.NormalizarString(p_PRO_REFESTANDAR),
				PRO_REQUIEREPRESUPUESTO	=DECODE(p_PRO_REQUIEREPRESUPUESTO,'S','S','N'),
    			PRO_CODEXPEDIENTE 		=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODEXPEDIENTE)),					--	15ene18	nuevos campos Colombia
				PRO_CODCUM				=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODCUM)),
				PRO_CODINVIMA 			=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODINVIMA)),
				PRO_FECHACADINVIMA		=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_FECHACADINVIMA)),
				PRO_CLASIFICACIONRIESGO =UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CLASIFICACIONRIESGO)),
				PRO_REGULADO			=DECODE(p_PRO_REGULADO,'S','S','N'),
				PRO_CODIUM				=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODIUM)), 						--	13feb20
				PRO_REGISTROSANITARIO	=NVL(p_PRO_REGISTROSANITARIO,PRO_REGISTROSANITARIO),							--	8feb22
				PRO_FECHACAMBIO 		=SYSDATE
			WHERE	PRO_ID=v_IDProducto;

		ELSE
			v_UnidadBasica		:=LOWER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_UNIDADBASICA));
			v_UnidadesPorLote	:=p_PRO_UNIDADESPORLOTE;

			--	Primera a mayuscula para los campos de texto
			UPDATE	PRODUCTOS SET
				PRO_NOMBRE				=Utilidades_pck.PrimeraAMayusculas(NORMALIZAR_PCK.LimpiarCadena(p_PRO_NOMBRE)),
				PRO_MARCA				=NORMALIZAR_PCK.LimpiarCadena(SUBSTR(p_PRO_MARCA,1,100)),						--	22nov11	Utilidades_pck.PrimeraAMayusculas(p_PRO_MARCA),
				PRO_UNIDADBASICA		=v_UnidadBasica,
				PRO_UNIDADESPORLOTE		=v_UnidadesPorLote,
				PRO_REFERENCIA			=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_REFERENCIA)),
				PRO_IDTIPOIVA			=p_PRO_IDTIPOIVA,
				pro_nombre_norm 		= Normalizar_Pck.NormalizarString ( p_pro_nombre ),
				pro_marca_norm 			= SUBSTR(Normalizar_Pck.NormalizarString (p_pro_marca),1,100),					--	2jun21	Cortamos a 100 caracteres
				PRO_REFERENCIA_NORM		= normalizar_pck.NormalizarID(p_PRO_REFERENCIA),
				PRO_STATUS				=v_Estado,		--15mar11	Por si se recuperan productos desde cargas
				PRO_IDFICHATECNICA		=DECODE(p_IDFichaTecnica,-1, NULL, p_IDFichaTecnica),
				PRO_OCULTO				=DECODE(p_PRO_OCULTO,'S','S','N'),
				PRO_CATEGORIA			=p_PRO_CATEGORIA,
				PRO_REFESTANDAR			=Normalizar_Pck.NormalizarString(p_PRO_REFESTANDAR),
				PRO_REQUIEREPRESUPUESTO	=DECODE(p_PRO_REQUIEREPRESUPUESTO,'S','S','N'),
    			PRO_CODEXPEDIENTE 		=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODEXPEDIENTE)),						--	15ene18	nuevos campos Colombia
				PRO_CODCUM				=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODCUM)),
				PRO_CODINVIMA 			=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODINVIMA)),
				PRO_FECHACADINVIMA		=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_FECHACADINVIMA)),
				PRO_CLASIFICACIONRIESGO =UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CLASIFICACIONRIESGO)),
				PRO_REGULADO			=DECODE(p_PRO_REGULADO,'S','S','N'),
				PRO_CODIUM				=UPPER(NORMALIZAR_PCK.LimpiarCadena(p_PRO_CODIUM)), 							--	13feb20
				PRO_REGISTROSANITARIO	=NVL(p_PRO_REGISTROSANITARIO,PRO_REGISTROSANITARIO),							--	8feb22
				PRO_FECHACAMBIO 		=SYSDATE
			WHERE	PRO_ID=v_IDProducto;

		END IF;


		v_Status:='Actualizando catalogo:'||v_IDProducto;

		--	9nov11	Actualizamos en la tabla de referencias asociadas
		CatalogoAutomatico_pck.AsociarReferenciaEstandar(v_IDProducto, Normalizar_Pck.NormalizarStringBusquedaDB(p_PRO_REFESTANDAR));
        
		--	5mar15	Si ha cambiado, actualizamos el tipo de IVA en los catálogos privados
		IF p_PRO_IDTIPOIVA<>v_IDTipoIVA THEN
			UPDATE		CATPRIV_PRODUCTOSESTANDAR
				SET		CP_PRO_IDTIPOIVA=p_PRO_IDTIPOIVA
				WHERE	CP_PRO_ID IN
				(
					SELECT 		CP_PRE_IDPRODUCTOESTANDAR
						FROM 	CATPRIV_PRODUCTOS_PRODESTANDAR 
						WHERE 	CP_PRE_IDPRODUCTO=v_IDProducto
				);
		END IF;
        
		IF p_CADENA_IMAGENES IS NOT NULL OR p_CADENA_IMAGENES_BORRADAS IS NOT NULL THEN
                Imagenes_Pck.guardarFotos(
                p_CADENA_IMAGENES,
                p_CADENA_IMAGENES_BORRADAS,
                v_IDProducto,
                NULL,
                NULL,
	            'S'
                );
        END IF;
/*
		productos_pck.debug
		(
			p_IDUsuario,
			2,
			'MantenimientoProductos_PCK.ModificarProducto_prov',
			v_IDProducto,
			'Cambiado producto UdBasica:'||p_PRO_UNIDADBASICA||' marca:'||p_PRO_MARCA||' caja:'||p_PRO_UNIDADESPORLOTE||' tipoiva:'||p_PRO_IDTIPOIVA	--7abr14	||' precio:'||p_PRO_PRECIOMVM
		);*/


		productos_pck.debug (p_PRO_ID, 'ModificarProducto_prov IDProducto:'||p_PRO_ID||' UPDATE.''Cambiado producto UdBasica:'||p_PRO_UNIDADBASICA||' marca:'||p_PRO_MARCA||' caja:'||p_PRO_UNIDADESPORLOTE||' tipoiva:'||p_PRO_IDTIPOIVA);
		
		--utilidades_pck.debug('ModificarProducto_prov IDProducto:'||p_PRO_ID||' UPDATE.');
      

	END IF;

	v_Status:=v_Status||'. Normalizar.';
	UPDATE PRODUCTOS SET
			PRO_TEXTO_NORM=normalizar_pck.NormalizarID(PRO_REFERENCIA)||' '||normalizar_pck.NormalizarID(PRO_REFESTANDAR)||' '||normalizar_pck.NormalizarString(PRO_NOMBRE||' '||PRO_MARCA)
		WHERE	PRO_ID=v_IDProducto;

	v_Status:=v_Status||' Producto insertado, ultimas actualizaciones';


	--	2abr14	Recorremos la lista de cambios en tarifas y ofertas y vamos asociándolos a las empresas correspondientes
	IF	p_ListaCambios IS NOT NULL THEN

		v_Status:=v_Status||'. Cambios en tarifas.';
	
		--utilidades_pck.debug('ModificarProducto_prov IDProducto:'||p_PRO_ID||' Procesando lista de cambios:'||p_ListaCambios);
	
		v_ListaEmpresasEspeciales:=Empresas_PCK.ListaIDEmpresasEspeciales(v_IDPais);
		
		v_NumEmpresasEspeciales:=utilidades_pck.PieceCount(v_ListaEmpresasEspeciales,'|');
		--utilidades_pck.debug('ModificarProducto_prov IDProducto:'||p_PRO_ID||' ListaEmpresasEspeciales:'||v_ListaEmpresasEspeciales||' NumEmpresasEspeciales:'||v_NumEmpresasEspeciales);
		
		v_CountCambios:=0;

		FOR I IN 0..Utilidades_Pck.PieceCount(p_ListaCambios,'#')-2 LOOP

			v_Cadena:=Utilidades_Pck.Piece(p_ListaCambios,'#',I);
			v_Status:='Cadena:'||v_Cadena;

			--utilidades_pck.debug('Mantenimiento productos, procesando cambios:'||v_Cadena);

			v_IDCliente:=Utilidades_Pck.Piece(v_Cadena,'|',0);
			v_Tarifa:=Utilidades_Pck.tonumber(Utilidades_Pck.Piece(v_Cadena,'|',1));
			v_IDOferta:=Utilidades_Pck.Piece(v_Cadena,'|',2);

			--debug!!!	utilidades_pck.debug('ModificarProducto_prov IDProducto:'||v_IDProducto||' Procesando cambio '||I||': IDCliente:'||v_IDCliente||' v_Tarifa:'||v_Tarifa||' IDOferta:'||v_IDOferta);

			IF INSTR(v_ListaEmpresasEspeciales, v_IDCliente)=0 THEN
				--	Esta comprobación debería no ser necesaria
				Mvm.InsertDBError ('MantenimientoProductos_PCK.ModificarProducto_prov','IDUsuario:'||p_IDUsuario||' PRO_ID='||p_PRO_ID||' ListaCambios:'||p_ListaCambios||'. Error: IDCLIENTE:'||v_IDCliente||' no está en lista empresas especiales:'||v_ListaEmpresasEspeciales); 
			ELSE
				
				v_CountCambios:=v_CountCambios+1;

				--------	TARIFA		---------
				IF Empresas_Pck.NuevoModelo(v_IDCliente)='N' THEN
					--debug!!!	utilidades_pck.debug('ModificarProducto_prov IDProducto:'||v_IDProducto||' Procesando cambio '||I||' Viejo modelo. Actualizando tarifa IDCliente:'||v_IDCliente||' v_Tarifa:'||v_Tarifa);
					--	Si es empresa de "viejo modelo", solo actualizamos tarifa base
					Tarifas_Pck.ActualizacionTarifaBase(p_IDUsuario, v_IDCliente, v_IDProducto, v_Tarifa, 0,'U');
				ELSE
					--	Si es empresa de "nuevo modelo", actualizamos tarifa base y precio de referencia
					--debug!!!	utilidades_pck.debug('ModificarProducto_prov IDProducto:'||v_IDProducto||' Procesando cambio '||I||' Nuevo modelo. Actualizando tarifa IDCliente:'||v_IDCliente||' v_Tarifa:'||v_Tarifa);
					Tarifas_Pck.NuevaTarifaManteniendoMargen(p_IDUsuario, v_IDCliente, v_IDProducto, v_Tarifa, 0,'U');
				END IF;

				--	12abr12	Para cambios directo en ASISA, actualizamos precios en los programas
				IF v_Estado=NULL THEN
					Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(v_IDProducto, v_IDCliente);
				END IF;

				--23feb17	IF v_IDCliente=v_IDEmpresaMVM OR v_IDCliente=v_IDEmpresaMVM B THEN
				IF v_IDCliente=v_IDEmpresaMVM THEN
					--debug!!!	utilidades_pck.debug('ModificarProducto_prov IDProducto:'||v_IDProducto||' Procesando cambio '||I||' MVM. Expandiendo tarifa '||I||': IDCliente:'||v_IDCliente||' v_Tarifa:'||v_Tarifa);
					ExpandirManteniendoMargen(p_IDUsuario, v_IDPais, v_IDCliente, v_IDProducto, v_Tarifa);
				END IF;

				--------	OFERTA		---------
				v_Marca:=Empresas_PCK.MarcaEmpresaEspecial(v_IDCliente);

				IF NVL(v_IDOferta,'-1')<>'-1' THEN
					--debug!!!	utilidades_pck.debug('ModificarProducto_prov IDProducto:'||v_IDProducto||' Procesando cambio '||I||' Actalizando oferta IDCliente:'||v_IDCliente||' IDOferta:'||v_IDOferta);
					documentos_pck.QuitarDocumentosAProducto(p_IDUsuario,v_IDProducto,v_IDCliente,v_Marca);
					documentos_pck.AsociarDocumentoAProducto(p_IDUsuario,v_IDOferta,v_IDCliente,v_IDProducto);
				ELSE
					--debug!!!	utilidades_pck.debug('ModificarProducto_prov IDProducto:'||v_IDProducto||' Procesando cambio '||I||' Quitando oferta IDCliente:'||v_IDCliente);
					documentos_pck.QuitarDocumentosAProducto(p_IDUsuario,v_IDProducto,v_IDCliente,v_Marca);
				END IF;
			END IF;

		END LOOP;
		
		IF v_Admin='S' AND v_CountCambios<>v_NumEmpresasEspeciales THEN --	11dic18 Solo controlamos este error si es un usuario admin
			Mvm.InsertDBError ('MantenimientoProductos_PCK.ModificarProducto_prov','IDUsuario:'||p_IDUsuario||' PRO_ID='||p_PRO_ID||' ListaCambios:'||p_ListaCambios||'. Error: Número de cambios:'||v_CountCambios||' no coincide con número de empresas especiales:'||v_NumEmpresasEspeciales); 
		END IF;
		
	ELSE		
		--	la cadena de cambios acaba con '#' por lo que el ultimo elemento no hay que contarlo
		--	12jun14	En el caso de que se llame desde licitaciones, no se pasa lista de cambios
		--	Mvm.InsertDBError ('MantenimientoProductos_PCK.ModificarProducto_prov','IDUsuario:'||p_IDUsuario||' PRO_ID='||p_PRO_ID||' Lista de cambios en tarifas y ofertas no informada'); 
		NULL;
	END IF;	
	
	-- Actualizamos la tabla de resumen del buscador de productos
	Buscador_Pck.GuardarProducto ( v_IDProducto, 'S');
	
	-- Inicializamos la "FECHA OFERTA" en los clientes en los que el producto esté catalogado
	AsignaFechaOferta(v_IDProducto);

	-- Revisamos los programs que incluyan este producto
	Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(v_IDProducto);

	--	24mar17 Faltaba informar en el log
/*	productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.ModificarProducto_prov',
		v_IDProducto,
		v_Acciones	
	);*/

	productos_pck.debug(v_IDProducto,'MantenimientoProductos_PCK.ModificarProducto_prov. '||v_Parametros||'. estado:'||v_Status);
	--utilidades_pck.debug('MantenimientoProductos_PCK.ModificarProducto_prov. '||v_Parametros||'. estado:'||v_Status);

	RETURN v_IDProducto;

EXCEPTION
	WHEN PRODUCTO_DUPLICADO THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.ModificarProducto_prov',v_Parametros||'. estado:'||v_Status||' Ya existe un producto con la referencia: '||p_pro_referencia||' o hay una solicitud de cambio en curso para este producto. '); --et 3feb06 no se informaba
		RETURN -1;
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.ModificarProducto_prov',v_Parametros||'. estado:'||v_Status||' SQLERRM:'||SQLERRM);
		RETURN -2;
END;	--MantenimientoProductos_PCK.ModificarProducto


--	11abr12	Expandir precio, no incluye a la empresa padre
--	 9jul12 tampoco se expande a ASPE
PROCEDURE	ExpandirManteniendoMargen
(
	p_IDUsuario			NUMBER,	--	Usuario responsable de la expansión
	p_IDPais			NUMBER,	--	País para el que se expande (para no volverla a informar)
	p_IDEmpresa			NUMBER,	--	Empresa desde la que se expande (para no volverla a informar)
	p_IDProducto		NUMBER,
	p_Precio			NUMBER
)
IS
	--	11abr12	Expansión de precios
	CURSOR cEmpresas_CP(IDPais NUMBER, IDEmpresa NUMBER, IDProducto NUMBER) IS
		SELECT 		*
			FROM 	EMPRESAS, TIPOSEMPRESAS
			WHERE 	EMP_IDTIPO=TE_ID
			AND		TE_ROL='COMPRADOR'			--	27jun12	Solo se expanden los precios a los clientes del país
			--13feb13	AND		EMP_CATPRIV_PADRE<>EMP_ID	--	Catalogo dependiente de otra empresa (en principio del catálogo MVM o MVM B)
			AND 	EMP_ID<>IDEmpresa
			AND 	EMP_STATUS IS NULL			--	17feb10
			AND		EMP_NOEXPANDIR IS NULL		--	21ene09	ET	En ParaMiClinica no hay que expandir precios
			--AND		EMP_ID<>1640				--	11may11	ET	No se expanden precios a ASISA -> están incluidos en EMP_NOEXPANDIR
			--AND		EMP_ID<>7576				--	 9jul12 ET	Tampoco se expande a ASPE -> están incluidos en EMP_NOEXPANDIR
			--AND		EMP_ID NOT _I_N_ (SELECT TRF_IDCLIENTE FROM TARIFAS WHERE TRF_ORIGEN='P' AND TRF_IDPRODUCTO=IDProducto)	--	26abr11	Quitamos precios exclusivos-->19jul12 ya no existen "precios exclusivos"
			AND 	(SELECT EE_IDEMPRESA FROM EMPRESASESPECIALES WHERE EE_IDEMPRESA=EMP_ID) IS NULL	--	3abr14	Tampoco hay que exopandir a las "empresas especiales"
			AND		EMP_IDPAIS=IDPais;
			
			
	v_PrecioAnterior		TARIFAS.TRF_IMPORTE%TYPE;
BEGIN

	--utilidades_pck.debug('MantenimientoProductos_PCK.ExpandirManteniendoMargen. IDUsuario:'||p_IDUsuario||' IDPais:'||p_IDPais||' IDEmpresa:'||p_IDEmpresa||'p_IDProducto='||p_IDProducto);

	--actualizamos los precios
	FOR rEmpresa IN cEmpresas_CP(p_IDPais, p_IDEmpresa, p_IDProducto) LOOP
	
		--utilidades_pck.debug('MantenimientoProductos_PCK.ExpandirManteniendoMargen IDProducto='||p_IDProducto||' IDEmpresa:'||rEmpresa.emp_id);

		--	12abr12	Precio anterior, para ver si hay que avisar de los cambios
		v_PrecioAnterior:=Tarifas_Pck.Tarifa(p_IDProducto,rEmpresa.emp_id,0);

		-- Si el producto está emplantillado, mantenemos margen y revisamos programas
		IF v_PrecioAnterior IS NOT NULL AND v_PrecioAnterior<>p_Precio AND CATALOGOPRIVADO_PCK.IdentificadorProdEstandar(rEmpresa.emp_id,p_IDProducto) IS NOT NULL THEN

			--utilidades_pck.debug('MantenimientoProductos_PCK.ExpandirManteniendoMargen EMPLANTILLADO - IDProducto='||p_IDProducto||' IDEmpresa:'||rEmpresa.emp_id);

			--11nov10	Tarifas_Pck.ActualizacionTarifaBase(p_IDUsuario, rEmpresa.emp_id,v_IDProducto,v_Precio,0, 'E');
			--	27jun12	Solo cambiamos tarifa si se ha cambiado la tarifa para esta empresa
			Tarifas_Pck.NuevaTarifaManteniendoMargen(p_IDUsuario, rEmpresa.emp_id, p_IDProducto, p_Precio, 0, 'E');

			Mensajeria_Pck.aviso_cambio_prod_programas(p_IDProducto,rEmpresa.emp_id);

			--	27jun12	Solo recalculamos programas si se ha cambiado la tarifa para esta empresa
			Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(p_IDProducto, rEmpresa.emp_id);
		END IF;
		
		--	5feb13	Si el precio no estaba definido o es diferente, pero el producto no está emplantillado
		IF v_PrecioAnterior IS NULL OR v_PrecioAnterior<>p_Precio THEN

			--utilidades_pck.debug('MantenimientoProductos_PCK.ExpandirManteniendoMargen NO EMPLANTILLADO - IDProducto='||p_IDProducto||' IDEmpresa:'||rEmpresa.emp_id);

			Tarifas_Pck.ActualizacionTarifaBase(p_IDUsuario, rEmpresa.emp_id, p_IDProducto, p_Precio, 0, 'E');
		END IF;

	END LOOP;

EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.ExpandirManteniendoMargen','IDUsuario:'||p_IDUsuario||' IDPais:'||' IDEmpresa:'||p_IDEmpresa||'p_IDProducto='||p_IDProducto||' SQLERRM:'||SQLERRM);
END;	--ExpandirPrecio


--		Copia un producto y sus especialidades. Las tarifas no se copian para evitar errores.
FUNCTION CopiarProducto
(
	p_IDProducto				NUMBER
)	RETURN 					NUMBER
IS
	v_IDProductoCopia		PRODUCTOS.PRO_ID%TYPE;
	v_RefEstandar			PRODUCTOS.PRO_REFESTANDAR%TYPE;	--9nov11
	v_RefProveedor			PRODUCTOS.PRO_REFERENCIA%TYPE;	--13ene14
	v_IDOtraCopia			PRODUCTOS.PRO_ID%TYPE;			--13ene14
	--v_Longitud				INTEGER;						--13ene14
	--v_UltCar				VARCHAR2(1);					--13ene14
	--v_IDProveedor			PRODUCTOS.PRO_IDPROVEEDOR%TYPE;	--13ene14
BEGIN

	SELECT 		productos_seq.NEXTVAL
		INTO 	v_IDProductoCopia
		FROM 	dual;

	--	9nov11	Recuperamos la ref. estándar, la necesitaremos luego
	SELECT		PRO_REFESTANDAR, PRO_REFERENCIA
		INTO	v_RefEstandar, v_RefProveedor
		FROM	PRODUCTOS
		WHERE	PRO_ID=p_IDProducto;
		
	--	13ene14	Crea la nueva ref. proveedor
	v_RefProveedor:=Utilidades_pck.piece(v_RefProveedor,'_',0)||'_'||v_IDProductoCopia;

	--	Insertamos
	INSERT INTO PRODUCTOS 
	(
		PRO_ID,
		--10jun09	ET	PRO_IDNOMENCLATOR,
		--10jun09	ET	 PRO_IDTIPOPRODUCTO,
		PRO_IDPROVEEDOR,
		PRO_NOMBRE,
		PRO_MARCA,
		PRO_FABRICANTE,
		PRO_CODIGOINTERNACIONAL,
		PRO_NOMBREINTERNACIONAL,
		PRO_UNIDADBASICA,
		PRO_UNIDADESPORLOTE,
		PRO_REFERENCIA,
		PRO_DESCRIPCION,
		PRO_ENLACE,
		PRO_IMAGEN,
		PRO_HOMOLOGADO,
		PRO_CERTIFICADOS,
		PRO_IDTIPOIVA,
		pro_nombre_norm,
		pro_descripcion_norm,
		pro_marca_norm,
		pro_fabricante_norm,
		PRO_CATEGORIA,
		PRO_OCULTO,
		PRO_FECHAALTA,
		PRO_ORIGEN,
		PRO_REFESTANDAR,			--	9nov11
		--	9jul12	Incorporamos ofertas y documentos
		PRO_IDDOCUMENTO,		--	5may11	Guardamos el ID de la oferta asociada al cambio
		PRO_IDOFERTAASISA,		--	20mar12	Guardamos el ID de la oferta ASISA por separado
		PRO_IDOFERTAFNCP,		--	9jul12	Guardamos el ID de la oferta ASPE por separado
		PRO_IDOFERTAVIAMED,		--	18ene13	Guardamos el ID de la oferta VIAMED por separado
		PRO_IDOFERTATEKNON,		--	18ene13	Guardamos el ID de la oferta TEKNON por separado
		PRO_IDFICHATECNICA,		--	26may11	Guardamos el ID de la ficha técnica
		PRO_TEXTO_NORM			--	3dic13
	)
   	SELECT
		v_IDProductoCopia,
		--10jun09	ET	PRO_IDNOMENCLATOR,
		--10jun09	ET	PRO_IDTIPOPRODUCTO,
		PRO_IDPROVEEDOR,
		PRO_NOMBRE,
		PRO_MARCA,
		PRO_FABRICANTE,
		PRO_CODIGOINTERNACIONAL,
		PRO_NOMBREINTERNACIONAL,
		PRO_UNIDADBASICA,
		PRO_UNIDADESPORLOTE,
		v_RefProveedor,	--	los productos copiados no deben llevar referencia, 13ene14 repetimos ref. + "COPIA"
		PRO_DESCRIPCION,
		PRO_ENLACE,
		PRO_IMAGEN,
		PRO_HOMOLOGADO,
		PRO_CERTIFICADOS,
		PRO_IDTIPOIVA,
		pro_nombre_norm,
		pro_descripcion_norm,
		pro_marca_norm,
		pro_fabricante_norm,
		PRO_CATEGORIA,
		PRO_OCULTO,
		SYSDATE,
		'CopiarProducto',
		PRO_REFESTANDAR,
		--	9jul12	Incorporamos ofertas y documentos
		PRO_IDDOCUMENTO,		--	5may11	Guardamos el ID de la oferta asociada al cambio
		PRO_IDOFERTAASISA,		--	20mar12	Guardamos el ID de la oferta ASISA por separado
		PRO_IDOFERTAFNCP,		--	9jul12	Guardamos el ID de la oferta ASPE por separado
		PRO_IDOFERTAVIAMED,		--	18ene13	Guardamos el ID de la oferta VIAMED por separado
		PRO_IDOFERTATEKNON,		--	18ene13	Guardamos el ID de la oferta TEKNON por separado
		PRO_IDFICHATECNICA,		--	26may11	Guardamos el ID de la ficha técnica
		PRO_TEXTO_NORM			--	3dic13
		FROM 	PRODUCTOS
		WHERE	PRO_ID=p_IDProducto;

/*	13ene14
	-- Copiamos las especialidades de este producto
	INSERT 		INTO ESPECIALIDADESPRODUCTOS	(ESPPRO_IDPRODUCTO, ESPPRO_IDESPECIALIDAD)
	SELECT		v_IDProductoCopia, ESPPRO_IDESPECIALIDAD
		FROM 	ESPECIALIDADESPRODUCTOS
		WHERE	ESPPRO_IDPRODUCTO=p_IDProducto;
	*/	
	--	3dic13	Copiamos también las ofertas desde PRODUCTOS_DOCUMENTOS
	INSERT INTO PRODUCTOS_DOCUMENTOS (PROD_IDPRODUCTO, PROD_IDDOCUMENTO, PROD_IDEMPRESA, PROD_IDUSUARIO, PROD_FECHA)
		SELECT 		v_IDProductoCopia,PROD_IDDOCUMENTO, PROD_IDEMPRESA, PROD_IDUSUARIO, SYSDATE
			FROM 	PRODUCTOS_DOCUMENTOS 
			WHERE 	PROD_IDPRODUCTO=p_IDProducto;

	Imagenes_Pck.CopiarFotos(p_IDProducto, v_IDProductoCopia);

	--	ET	Actualizamos la tabla de resumen del buscador de productos
	Buscador_Pck.GuardarProducto ( v_IDProductoCopia, 'S');

	--	9nov11	Actualizamos en la tabla de referencias asociadas
	CatalogoAutomatico_pck.AsociarReferenciaEstandar(v_IDProductoCopia, v_RefEstandar);

	RETURN	v_IDProductoCopia;

EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.CopiarProducto','IDProducto:'||p_IDProducto||' SQLERRM:'||SQLERRM);
		RETURN NULL;
END;	--MantenimientoProductos_PCK.CopiarProducto


--		Copia un producto, sus especialidades y, opcionalmente, las tarifas a otra empresa. Necesario para fusiones de empresas
FUNCTION CopiarProductoEnOtraEmpresa
(
	p_IDProducto				NUMBER,
	p_IDEmpresaDest				NUMBER,
	p_CopiarTarifas				VARCHAR2	DEFAULT 'N'

)	RETURN 	NUMBER
IS

	CURSOR cOfertas (IDProducto NUMBER) IS
		SELECT
				PRO_IDDOCUMENTO,		--	5may11	Guardamos el ID de la oferta asociada al cambio
				PRO_IDOFERTAASISA,		--	20mar12	Guardamos el ID de la oferta ASISA por separado
				PRO_IDOFERTAFNCP,		--	9jul12	Guardamos el ID de la oferta ASPE por separado
				PRO_IDOFERTAVIAMED,		--	18ene13	Guardamos el ID de la oferta VIAMED por separado
				PRO_IDOFERTATEKNON,		--	18ene13	Guardamos el ID de la oferta TEKNON por separado
				PRO_IDFICHATECNICA		--	26may11	Guardamos el ID de la ficha técnica
		FROM 	PRODUCTOS
		WHERE	PRO_ID=IDProducto;


	v_IDProductoCopia			PRODUCTOS.pro_id%TYPE;
	v_Referencia				PRODUCTOS.PRO_REFERENCIA%TYPE;
	v_IDProveedor				PRODUCTOS.PRO_IDPROVEEDOR%TYPE;
	v_MensajeError				VARCHAR2(1000):=NULL;
	status 						VARCHAR2(1000);

	v_Parametros 				VARCHAR2(1000);
BEGIN
	v_Parametros:='IDProducto:'||p_IDProducto||' IDEmpresaDest:'||p_IDEmpresaDest||' CopiarTarifas:'||p_CopiarTarifas;

	status:='inicio';

	--	Comprobamos si existe la referencia en el proveedor destino
	SELECT 		PRO_REFERENCIA, PRO_IDPROVEEDOR
		INTO 	v_Referencia, v_IDProveedor
		FROM 	PRODUCTOS
		WHERE	PRO_ID=p_IDProducto;

	--	Validaciones antes de copiar
	IF v_IDProveedor = p_IDEmpresaDest THEN

		--	no permitimos copiar productos en el mismo proveedor
		v_MensajeError:='ERROR: No se puede copiar al mismo proveedor';

	ELSIF v_Referencia IS NULL THEN

		--	no permitimos copiar productos sin referencia
		v_MensajeError:='ERROR: El producto a copiar no tiene referencia';

	ELSE
		--	comprobamos si existe la referencia en el proveedor
		BEGIN
			SELECT 		PRO_ID
				INTO 	v_IDProductoCopia
				FROM 	PRODUCTOS
				WHERE	PRO_IDPROVEEDOR=p_IDEmpresaDest
				AND		NVL(PRO_REFERENCIA,'-1')=v_Referencia;

				v_MensajeError:='ERROR: Ya existe la referencia '||v_Referencia;

		EXCEPTION
			WHEN OTHERS THEN
				NULL;	--	por aqui todo va bien ;-)
		END;
	END IF;


	IF v_MensajeError IS NOT NULL THEN

		--	Guardamos constancia del error
		/*productos_pck.debug
		(
			NULL,
			'ERROR COPIANDO',
			'MantenimientoProductos_PCK',
			v_IDProductoCopia,
			'CopiarProductoEnOtraEmpresa PRO_ID='||p_IDProducto||' en la empresa '||p_IDEmpresaDest||' '||v_MensajeError
		);*/
		
		productos_pck.debug(p_IDProducto,'MantenimientoProductos_PCK. CopiarProductoEnOtraEmpresa. '||v_Parametros||' IDProductoCopia:'||v_IDProductoCopia||' '||v_MensajeError);
		productos_pck.debug(v_IDProductoCopia,'MantenimientoProductos_PCK. CopiarProductoEnOtraEmpresa. '||v_Parametros||' IDProductoCopia:'||v_IDProductoCopia||' '||v_MensajeError);
		
		v_IDProductoCopia:=NULL;
	ELSE
		SELECT		productos_seq.NEXTVAL
			INTO 	v_IDProductoCopia
			FROM 	dual;

		status:='insertando producto';

		INSERT INTO PRODUCTOS
		(
			PRO_ID,
			PRO_IDPROVEEDOR,
			PRO_NOMBRE,
			PRO_MARCA,
			PRO_FABRICANTE,
			PRO_CODIGOINTERNACIONAL,
			PRO_NOMBREINTERNACIONAL,
			PRO_UNIDADBASICA,
			PRO_UNIDADESPORLOTE,
			PRO_REFERENCIA,
			PRO_DESCRIPCION,
			PRO_ENLACE,
			PRO_IMAGEN,
			PRO_HOMOLOGADO,
			PRO_CERTIFICADOS,
			PRO_IDTIPOIVA,
			pro_nombre_norm,
			pro_descripcion_norm,
			pro_marca_norm,
			pro_fabricante_norm,
			PRO_CATEGORIA,
			PRO_REFESTANDAR,
			PRO_OCULTO,
			PRO_FECHAALTA,
			PRO_ORIGEN,
			PRO_TEXTO_NORM	
		)
   		SELECT
			v_IDProductoCopia,
			p_IDEmpresaDest,			--	copiado a la nueva empresa
			PRO_NOMBRE,
			PRO_MARCA,
			PRO_FABRICANTE,
			PRO_CODIGOINTERNACIONAL,
			PRO_NOMBREINTERNACIONAL,
			PRO_UNIDADBASICA,
			PRO_UNIDADESPORLOTE,
			PRO_REFERENCIA,
			PRO_DESCRIPCION,
			PRO_ENLACE,
			PRO_IMAGEN,
			PRO_HOMOLOGADO,
			PRO_CERTIFICADOS,
			PRO_IDTIPOIVA,
			pro_nombre_norm,
			pro_descripcion_norm,
			pro_marca_norm,
			pro_fabricante_norm,
			PRO_CATEGORIA,
			PRO_REFESTANDAR,
			PRO_OCULTO,
			SYSDATE,
			'copia de '||p_IDProducto,
			PRO_TEXTO_NORM
		FROM 	PRODUCTOS
		WHERE	PRO_ID=p_IDProducto;


		--	Copiamos los empaquetamientos particulares
		INSERT INTO PRO_UNIDADESPORLOTE
		(
			PRO_UL_IDUSUARIO,
			PRO_UL_FECHA,
			PRO_UL_IDPRODUCTO,
			PRO_UL_IDCLIENTE,
			PRO_UL_UNIDADBASICA, 
			PRO_UL_UNIDADESPORLOTE
		)
		SELECT	PRO_UL_IDUSUARIO,PRO_UL_FECHA,v_IDProductoCopia,PRO_UL_IDCLIENTE,PRO_UL_UNIDADBASICA, PRO_UL_UNIDADESPORLOTE
			FROM	PRO_UNIDADESPORLOTE
			WHERE	PRO_UL_IDPRODUCTO= p_IDProducto;


		IF p_CopiarTarifas='S' THEN
			status:='insertando tarifas';
			--	Copiamos las tarifas
			INSERT INTO TARIFAS(TRF_IDPRODUCTO, TRF_IDCLIENTE, TRF_IDUSUARIO, TRF_CANTIDAD, TRF_IMPORTE ,TRF_IDDIVISA, TRF_FECHA)
			SELECT v_IDProductoCopia, TRF_IDCLIENTE, TRF_IDUSUARIO, TRF_CANTIDAD, TRF_IMPORTE ,TRF_IDDIVISA, SYSDATE
 				 FROM TARIFAS
 				 WHERE TRF_IDPRODUCTO = p_IDProducto;


			--	3dic13	Incorporamos ofertas y documentos
			FOR o IN cOfertas(p_IDProducto) LOOP

				UPDATE PRODUCTOS SET
							PRO_IDDOCUMENTO=o.PRO_IDDOCUMENTO,		--	5may11	Guardamos el ID de la oferta asociada al cambio
							PRO_IDOFERTAASISA=o.PRO_IDOFERTAASISA,		--	20mar12	Guardamos el ID de la oferta ASISA por separado
							PRO_IDOFERTAFNCP=o.PRO_IDOFERTAFNCP,		--	9jul12	Guardamos el ID de la oferta ASPE por separado
							PRO_IDOFERTAVIAMED=o.PRO_IDOFERTAVIAMED,		--	18ene13	Guardamos el ID de la oferta VIAMED por separado
							PRO_IDOFERTATEKNON=o.PRO_IDOFERTATEKNON,		--	18ene13	Guardamos el ID de la oferta TEKNON por separado
							PRO_IDFICHATECNICA=o.PRO_IDFICHATECNICA	--	26may11	Guardamos el ID de la ficha técnica
					WHERE	PRO_ID=v_IDProductoCopia;

			END LOOP;
			
			
			--	Copiamos también las ofertas desde PRODUCTOS_DOCUMENTOS
			INSERT INTO PRODUCTOS_DOCUMENTOS (PROD_IDPRODUCTO, PROD_IDDOCUMENTO, PROD_IDEMPRESA, PROD_IDUSUARIO, PROD_FECHA)
				SELECT 		v_IDProductoCopia,PROD_IDDOCUMENTO, PROD_IDEMPRESA, PROD_IDUSUARIO, PROD_FECHA
					FROM 	PRODUCTOS_DOCUMENTOS 
					WHERE 	PROD_IDPRODUCTO=p_IDProducto;
					
			--	Copiamos tambien las fotos
			INSERT INTO	IMAGENES	
    		(
				IMG_ID,
				IMG_IDPRODUCTO,
				IMG_IDEMPRESA,
				IMG_IDUSUARIO,
				IMG_IMAGENGRANDE,
				IMG_IMAGENPEQUENYA,
				IMG_ESTADO,
				IMG_ORDEN,
				IMG_TAGS
    		)
			SELECT 			
				imagenes_seq.NEXTVAL,
				v_IDProductoCopia,
				p_IDEmpresaDest,
				IMG_IDUSUARIO,
				IMG_IMAGENGRANDE,
				IMG_IMAGENPEQUENYA,
				IMG_ESTADO,
				IMG_ORDEN,
				IMG_TAGS
    		FROM 		IMAGENES
				WHERE	IMG_IDTIPO='PRODUCTO'	
				AND 	IMG_IDPRODUCTO=p_IDProducto;

		END IF;

		--	ET	Actualizamos la tabla de resumen del buscador de productos
		Buscador_Pck.GuardarProducto ( v_IDProductoCopia, 'S');

		--	 Alcopiar a otra empresa NO copiamos 

		--	Guardamos constancia del cambio realizado
		/*productos_pck.debug
		(
			NULL,
			'COPIAR',
			'MantenimientoProductos_PCK',
			v_IDProductoCopia,
			'CopiarProductoEnOtraEmpresa PRO_ID='||p_IDProducto||' en la empresa '||p_IDEmpresaDest||' copiado a '||v_IDProductoCopia
		);*/
		
		productos_pck.debug(p_IDProducto,'MantenimientoProductos_PCK. CopiarProductoEnOtraEmpresa. '||v_Parametros||' copiado a '||v_IDProductoCopia);
		productos_pck.debug(v_IDProductoCopia,'MantenimientoProductos_PCK. CopiarProductoEnOtraEmpresa. '||v_Parametros||' copiado a '||v_IDProductoCopia);

	END IF;

	RETURN	v_IDProductoCopia;

EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.CopiarProductoEnOtraEmpresa',v_Parametros||' Status:'||status||' SQLERRM:'||SQLERRM);
		RETURN NULL;

END;	--MantenimientoProductos_PCK.CopiarProductoEnOtraEmpresa


--	24nov22Actualiza los campos normalizados en los nombres de UN producto
PROCEDURE NormalizarProducto
(
	p_IDProducto		NUMBER
)
IS
	v_SQL		VARCHAR2(1000);
BEGIN

	UPDATE PRODUCTOS
	SET
		pro_nombre_norm			=SUBSTR(Normalizar_Pck.NormalizarString ( pro_nombre ),1,1000),
		pro_descripcion_norm	=SUBSTR(Normalizar_Pck.NormalizarString ( pro_descripcion ),1,2000),
		pro_marca_norm			=SUBSTR(Normalizar_Pck.NormalizarString ( pro_marca ),1,100),
		pro_fabricante_norm		=SUBSTR(Normalizar_Pck.NormalizarString ( pro_fabricante ),1,100),
		PRO_TEXTO_NORM			=normalizar_pck.NormalizarID(PRO_REFERENCIA)||' '||normalizar_pck.NormalizarID(PRO_REFESTANDAR)||' '||normalizar_pck.NormalizarString(PRO_NOMBRE||' '||PRO_MARCA)
	WHERE PRO_ID=p_IDProducto;

	--	9may12	Los índices y sinonimos hay que generarlos a partir de los campos ya normalizados
	Buscador_PCK.GuardarProducto(p_IDProducto, 'S', 'S');
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.NormalizarProducto','IDProducto:'||p_IDProducto||' SQLERRM:'||SQLERRM);
END;	--MantenimientoProductos_PCK.NormalizarProductos






--	Actualiza los campos normalizados en los nombres de productos para todos los productos
--	ET 27/8/2003
--	4dic13	Borramos y volvemos a crear el índice
PROCEDURE NormalizarProductos
IS
	v_SQL		VARCHAR2(1000);
BEGIN
	v_SQL:='DROP INDEX PRO_TEXTO_NORM';
	EXECUTE IMMEDIATE v_SQL;
	
	UPDATE PRODUCTOS
	SET
		pro_nombre_norm			=SUBSTR(Normalizar_Pck.NormalizarString ( pro_nombre ),1,1000),
		pro_descripcion_norm	=SUBSTR(Normalizar_Pck.NormalizarString ( pro_descripcion ),1,2000),
		pro_marca_norm			=SUBSTR(Normalizar_Pck.NormalizarString ( pro_marca ),1,100),
		pro_fabricante_norm		=SUBSTR(Normalizar_Pck.NormalizarString ( pro_fabricante ),1,100),
		PRO_TEXTO_NORM			=normalizar_pck.NormalizarID(PRO_REFERENCIA)||' '||normalizar_pck.NormalizarID(PRO_REFESTANDAR)||' '||normalizar_pck.NormalizarString(PRO_NOMBRE||' '||PRO_MARCA)
	WHERE PRO_STATUS IS NULL;
	
	v_SQL:='CREATE INDEX PRO_TEXTO_NORM ON PRODUCTOS(PRO_TEXTO_NORM) INDEXTYPE IS CTXSYS.CTXCAT'
        	||' PARAMETERS (''index set PRO_TEXTO_NORM_SET'')';
	EXECUTE IMMEDIATE v_SQL;
	

	--	9may12	Los índices y sinonimos hay que generarlos a partir de los campos ya normalizados
	Buscador_PCK.GuardarTodosProductos;
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.NormalizarProductos','SQLERRM:'||SQLERRM);
END;	--MantenimientoProductos_PCK.NormalizarProductos


--	27ene12 Este procedimiento todavía utilizaba las antiguas tablas del catalogo privado
PROCEDURE BorrarEnCatalogoPrivado
(
    p_IDUsuario 	NUMBER,
    p_IDProducto	NUMBER
)
IS

    -- CURSOR CON LA INFO DEL proveedor_cp AFECTADO
	 /*27ene12 
	CURSOR cPROVEEDOR_CP(IDPRODUCTO NUMBER) IS
	SELECT *
        FROM CATPRIV_PROVEEDORES
       WHERE CP_PV_IDPRODUCTO=IDPRODUCTO
		AND CP_PV_IDPRODUCTO IS NOT NULL;*/

	-- CURSOR CON LA INFO DEL historico AFECTADO
	/*27ene12CURSOR cHISTORICO(IDPRODUCTO NUMBER) IS
	  SELECT *
        FROM CATPRIV_HISTORICOPORCENTRO
       WHERE CP_H_IDPRODUCTO=IDPRODUCTO
		AND CP_H_IDPRODUCTO IS NOT NULL;*/

	-- CURSOR CON LAS PLANTILLAS QUE CONTIENEN EL PRODUCTO
	CURSOR cProductoLineaPlantilla(IDProducto NUMBER) IS
		SELECT	*
		FROM 	PRODUCTOSLINEASPLANTILLAS,
		        LINEASPLANTILLAS,
				PLANTILLAS,
				CARPETAS
		WHERE	plp_idlineaplantilla=lip_id
			AND plp_IDProducto=IDProducto
			AND LIP_IDPLANTILLA=PL_ID
			AND pl_idcarpeta=carp_id;

	v_Count			INTEGER;

BEGIN

	SELECT 		count(*)
		INTO	v_Count
		FROM 	CATPRIV_PRODUCTOS_PRODESTANDAR
		WHERE 	CP_PRE_IDPRODUCTO=p_IDProducto;

	IF v_Count>0 THEN

		Mensajeria_Pck.AVISO_PROD_BORRADO_CATPRIV(p_IDUsuario,p_IDProducto);

		DELETE 	CATPRIV_PRODUCTOS_PRODESTANDAR
		WHERE 	CP_PRE_IDPRODUCTO=p_IDProducto;
	
	END IF;

   /*27ene12  FOR r IN cClientes(p_IDProducto) LOOP

		-- ENVIAMOS UN MAIL CON LA INFO DEL PRODUCTO BORRADO,
		-- LO MARCAMOS COMO NO ADJ Y LE QUITAMOS EL ENLACE
		Mensajeria_Pck.AVISO_PROD_BORRADO_CATPRIV(p_IDUsuario,p_IDProducto);

		DELETE CATPRIV_PRODUCTOS_PRODESTANDAR
		WHERE CP_PRE_IDPRODUCTO=r.CP_PRE_IDPRODUCTO;

		UPDATE CATPRIV_PROVEEDORES
		SET CP_PV_IDPRODUCTO=NULL,
		CP_PV_ADJUDICADO='N'
		WHERE CP_PV_ID=rPRODUCTO.CP_PV_ID;

	END LOOP;

	-- HACEMOS LO PROPIO CON EL HISTORICO
		FOR rPRODUCTO IN cHISTORICO(p_IDProducto) LOOP

		UPDATE CATPRIV_HISTORICOPORCENTRO
		SET CP_H_IDPRODUCTO=NULL
		WHERE CP_H_ID=rPRODUCTO.CP_H_ID;

	END LOOP;*/

	-- BORRAMOS EL PRODUCTO DE LAS PLANTILLAS
	FOR rPRODUCTO IN cProductoLineaPlantilla(p_IDProducto) LOOP
		Mvm_V3_Pck.BorrarProductoDePlantilla(p_IDUsuario,rPRODUCTO.PL_ID,p_IDProducto);
		Catalogoprivado_Pck.borrarPlantSinoContieneNada(rPRODUCTO.PL_ID);
		Catalogoprivado_Pck.borrarCarpSinoContieneNada(rPRODUCTO.CARP_ID);
	END LOOP;


EXCEPTION
    WHEN OTHERS THEN
	  Mvm.InsertDBError ('MantenimientoProductos_PCK.BorrarEnCatalogoPrivado:p_IDUsuario: '||p_IDUsuario||' p_IDProducto: '||p_IDProducto,NULL,'',SQLERRM);

END;

--	17set09	Borrar un producto
PROCEDURE BorrarProducto
(
	p_IDUsuario		NUMBER,
	p_IDProducto	NUMBER
)
IS
	v_Res		VARCHAR2(100);
BEGIN
	v_Res:=BorrarProducto(p_IDUsuario, p_IDProducto);
END;

--	Borrar un producto
--	2abr19	Permitimos a un comprador borrar un producto si solo tiene precios para él
FUNCTION BorrarProducto
(
	p_IDUsuario		NUMBER,
	p_IDProducto	NUMBER
) RETURN VARCHAR2
IS
	
	v_IDEmpresaDelUsuario		EMPRESAS.EMP_ID%TYPE;
	v_Derechos					VARCHAR2(100);

	v_Status					VARCHAR2(1000);
	v_Res						VARCHAR2(1000);
	v_Parametros				VARCHAR2(1000);
BEGIN
	v_Parametros:='IDUsuario:'||p_IDUsuario||'. IDProducto:'||p_IDProducto;
	
	v_IDEmpresaDelUsuario	:=usuarios_pck.IDEmpresa(p_IDUsuario);
	v_Derechos				:=usuarios_pck.DerechosUsuario(p_IDUsuario);
	
	IF v_Derechos IN ('MVM','EMPRESA') OR usuarios_pck.UsuarioCentralDeCompras(p_IDUsuario) THEN

		DELETE		TARIFAS
			WHERE	TRF_IDPRODUCTO	=p_IDProducto
			AND 	TRF_IDCLIENTE	=v_IDEmpresaDelUsuario;

		--	Borrar producto de todas las plantillas de esta empresa
		MVM_V3_PCK.BorrarProd_PlantEnEmp(p_IDUsuario, v_IDEmpresaDelUsuario, p_IDProducto);
		
		v_Status:='Producto borrado y eliminado de las plantillas de la empresa '||v_IDEmpresaDelUsuario;
		
		v_Res:='OK';

		--	Comprobar derechos usuario
		IF v_Derechos='MVM' OR ProductoConPrecios(p_IDProducto)='N' THEN
			--	Borrar producto
			UPDATE 		PRODUCTOS
				SET 	PRO_STATUS='B',
						PRO_FECHABAJA=SYSDATE,				--	Controlamos las bajas
						PRO_IDUSUARIOBAJA=p_IDUsuario		--	Controlamos las bajas
				WHERE	PRO_ID=p_IDProducto;

			--	Eliminar del buscador
			DELETE 		BUSC_PRODUCTOS
				WHERE 	BPRO_ID=p_IDProducto;


			--	Borrar producto de todas las plantillas de todas las empresas
			MVM_V3_PCK.BorrarProd_PlantTodasEmp(p_IDUsuario, p_IDProducto);

			v_Status:='Producto borrado y eliminado de todas las plantillas.';

		END IF;

	ELSE
		
		v_Res:='ERROR|No es usuario MVM';
		v_Status:='Sin derechos';
		Mvm.InsertDBError ('MantenimientoProductos_PCK.BorrarProducto',v_Parametros||' Usuario sin derechos.');

	END IF;
	
	productos_pck.debug(p_IDProducto, 'MantenimientoProductos_PCK.BorrarProducto. '||v_Parametros||' Res:'||v_Res||' Status:'||v_Status);
	RETURN v_Res;

EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.BorrarProducto','p_IDUsuario: '||p_IDUsuario||' p_IDProducto: '||p_IDProducto||' Status:'||v_Status||' SQLERRM:'||SQLERRM);
		RETURN 'ERROR|Error desconocido';
END;



--	9set10	Desplegable de tipos de IVA
PROCEDURE TiposIVA_XML
(
	p_Marca			VARCHAR2,
	p_NombreCampo	VARCHAR2,
	p_Actual		NUMBER,
	p_IDPais		NUMBER DEFAULT NULL
)
IS

	-- cursor con los tipos de iva
	CURSOR cTiposIva(IDPais NUMBER) IS
		SELECT 		tiva_id, tiva_TIPO
			FROM	TIPOSIVA
			WHERE	TIVA_ANTIGUO IS NULL							--	9set10	Filtramos tipos de IVA antiguos
			AND		((IDPais IS NULL) OR (TIVA_IDPAIS=IDPais))
			ORDER BY tiva_TIPO; 									--	28jun18 Ordenamos por el tipo de IVA

	v_Texto			VARCHAR2(3000);
BEGIN
		v_Texto:=	'<'||p_Marca||'>'
				||	'<field label="Iva" name="'||p_NombreCampo||'" current="'|| p_Actual ||'">'
				||	'<dropDownList>';
		FOR TipoIva IN cTiposIva(p_IDPais)  LOOP
			v_Texto:=v_Texto||'<listElem>'
							||'<ID>'		|| TipoIva.TIVA_ID 		||'</ID>'
							||'<listItem>'	|| TipoIva.TIVA_TIPO 	||'%</listItem>'
							||'</listElem>';
		END LOOP; -- Bucle para el indicador (Solo 1 registro )
		v_Texto:=v_Texto||'</dropDownList>'
						||'</field>'
						||'</'||p_Marca||'>';

		HTP.P(v_Texto);
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.TiposIVA_XML','Marca: '||p_Marca||' NombreCampo: '||p_NombreCampo||' Actual: '||p_Actual||' SQLERRM:'||SQLERRM);
END;


--	22feb11	ET	Mantenimiento de imagenes de un producto
PROCEDURE CambiarImagenes
(
	p_IDUsuario				NUMBER,
	p_IDProducto			NUMBER,
	p_CadenaImagenes		VARCHAR2,
	p_CadenaBorrar			VARCHAR2
)
IS
	v_Parametros		VARCHAR2(3000);
BEGIN
	v_Parametros:='IDUsuario: '||p_IDUsuario||' IDProducto: '||p_IDProducto||' Imagenes: '||p_CadenaImagenes||' Borrar: '||p_CadenaBorrar;
	
	IF p_CadenaImagenes IS NOT NULL OR p_CadenaBorrar IS NOT NULL THEN
		Imagenes_Pck.guardarFotos
		(
			p_CadenaImagenes,
			p_CadenaBorrar,
			p_IDProducto,
			NULL,
			NULL,
			'S'
		);
		
		--	Guardamos constancia del error
		/*productos_pck.debug
		(
			p_IDUsuario,
			2,
			'MantenimientoProductos_PCK',
			p_IDProducto,
			' Imagenes: '||p_CadenaImagenes||' Borrar: '||p_CadenaBorrar
		);*/
		
		productos_pck.debug(p_IDProducto, 'MantenimientoProductos_PCK.CambiarImagenes. '||v_Parametros);
		
	END IF;

EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.CambiarImagenes',v_Parametros||' SQLERRM:'||SQLERRM);
END;

--	28mar11	ET	Destacar un producto para una empresa
/*
PROCEDURE Destacar
(
	p_IDUsuario				NUMBER,
	p_IDProducto			NUMBER,
	p_IDEmpresa				NUMBER,
	p_Destacar				VARCHAR2	--	'S'/'N'
)
IS
BEGIN
	--utilidades_pck.debug ('MantenimientoProductos_PCK.Destacar IDUsuario: '||p_IDUsuario||' IDProducto: '||p_IDProducto||' IDEmpresa: '||p_IDEmpresa||' Destacar: '||p_Destacar);
	IF NVL(p_Destacar,'N')='S' THEN
		BEGIN
			INSERT INTO PRODUCTOSDESTACADOS
			(
				PD_IDPRODUCTO,
				PD_IDEMPRESA,
				PD_IDUSUARIO,
				PD_FECHA,
				PD_DESTACADO
			)
			VALUES
			(
				p_IDProducto,
				p_IDEmpresa,
				p_IDUsuario,
				SYSDATE,
				'S'
			);
		EXCEPTION
			WHEN OTHERS THEN
				NULL;		--	Si ya existe la entrada no pasa nada
		END;
	ELSE
		BEGIN
			DELETE		PRODUCTOSDESTACADOS
				WHERE	PD_IDPRODUCTO=p_IDProducto
				AND		PD_IDEMPRESA=p_IDEmpresa;
		EXCEPTION
			WHEN OTHERS THEN
				NULL;		--	Si no existe la entrada no pasa nada
		END;
	END IF;	
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.Destacar','IDUsuario: '||p_IDUsuario||' IDProducto: '||p_IDProducto||' IDEmpresa: '||p_IDEmpresa||' Destacar: '||p_Destacar||' SQLERRM:'||SQLERRM);
END;


--	8jul11	ET	Copiar los destacados de una empresa a otro (en principio, de MVM a nuevos clientes)
--	EXEC MantenimientoProductos_PCK.CopiarDestacados(1,1,[DEST]);
PROCEDURE CopiarDestacados
(
	p_IDUsuario				NUMBER,
	p_IDEmpresaOrigen		NUMBER,
	p_IDEmpresaDestino		NUMBER
)
IS
BEGIN
	--utilidades_pck.debug ('MantenimientoProductos_PCK.CopiarDestacados IDUsuario: '||p_IDUsuario||' IDEmpresaOrigen: '||p_IDEmpresaOrigen||' IDEmpresaDestino: '||p_IDEmpresaDestino);

	DELETE 		PRODUCTOSDESTACADOS
		WHERE	PD_IDEMPRESA=p_IDEmpresaDestino;

	INSERT INTO PRODUCTOSDESTACADOS
	(
		PD_IDPRODUCTO,
		PD_IDEMPRESA,
		PD_IDUSUARIO,
		PD_FECHA,
		PD_DESTACADO
	)
	SELECT
		PD_IDPRODUCTO,
		p_IDEmpresaDestino,
		p_IDUsuario,
		SYSDATE,
		PD_DESTACADO
	FROM 	PRODUCTOSDESTACADOS
		WHERE	PD_IDEMPRESA=p_IDEmpresaOrigen;


	--	Guardamos info en el log de administracion
	productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.CopiarDestacados',
		p_IDEmpresaDestino,
		'Copiados destacados de IDEmpresaOrigen:'||p_IDEmpresaOrigen||' a IDEmpresaDestino:'||p_IDEmpresaDestino
	);

	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.CopiarDestacados','IDUsuario: '||p_IDUsuario||' IDEmpresaOrigen: '||p_IDEmpresaOrigen||' IDEmpresaDestino: '||p_IDEmpresaDestino||' SQLERRM:'||SQLERRM);
END;
*/

--	Los usuarios de MVM pueden aceptar o rechazar los cambios propuestos por un proveedor sobre un producto
PROCEDURE TratarCambiosProveedor
(
	p_IDUsuario				NUMBER,
	p_ListaCambios			VARCHAR2
)
IS
	v_Cadena				VARCHAR2(1000);
	v_Accion				VARCHAR2(1);
	v_Comentarios			VARCHAR2(3000);
	v_Status				VARCHAR2(3000);
	v_IDProducto			NUMBER(10);
	--	12abr12	Multipaís
	v_IDPais				PAISES.PA_ID%TYPE;
	v_IDEmpresaCatalogo		EMPRESAS.EMP_ID%TYPE;
	--v_MVM					EMPRESAS.EMP_ID%TYPE;
	--v_MVM B					EMPRESAS.EMP_ID%TYPE;
	
BEGIN

	v_Status:='Inicio';
	--v_MVM	:=Mvm.BuscarParametro(0);
	--v_MVM B	:=Mvm.BuscarParametro(2 0 0);

	--utilidades_pck.debug ('MantenimientoProductos_PCK.TratarCambiosProveedor IDUsuario: '||p_IDUsuario||' ListaCambios: '||p_ListaCambios);
	
	SELECT 		EMP_ID, EMP_IDPAIS
		INTO	v_IDEmpresaCatalogo, v_IDPais
		FROM	USUARIOS, CENTROS, EMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		US_ID=p_IDUsuario;
		
		/*SELECT 		EMP_ID, EMP_IDPAIS
		FROM	USUARIOS, CENTROS, EMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		US_ID=6316;
		
		SELECT SES_IDUSUARIO FROM SESIONESACTIVAS WHERE SES_ID=3133613806;*/

	--	Comprueba si hay cambios introducidos por los usuarios
	IF	p_ListaCambios IS NOT NULL THEN


		--	la cadena de cambios acaba con '#' por lo que el ultimo elemento no hay que contarlo
		FOR I IN 0..Utilidades_Pck.PieceCount(p_ListaCambios,'#')-2 LOOP
		
			v_Cadena:=Utilidades_Pck.Piece(p_ListaCambios,'#',I);
			v_Status:='Cadena:'||v_Cadena;

			v_IDProducto:=TO_NUMBER(Utilidades_Pck.Piece(v_Cadena,'|',0));
			v_Accion:=Utilidades_Pck.Piece(v_Cadena,'|',1);
			v_Comentarios:=Utilidades_Pck.Piece(v_Cadena,'|',2);
			
			IF v_Accion IN ('A', 'C') THEN
				GuardarSolicitudCambio(p_IDUsuario, v_IDProducto, v_Accion, v_Comentarios);
			END IF;

			IF v_Accion='A' THEN
				--	Aceptar el alta o la modificación
				ProcesarCambio(p_IDUsuario, v_IDPais, v_IDEmpresaCatalogo, v_IDProducto);
			
			ELSIF v_Accion='C' THEN
				GuardarSolicitudCambio(p_IDUsuario, v_IDProducto, v_Accion, v_Comentarios);

				/*	No borramos el registro, lo cambiamos de estado 
				--	Cancelar el alta
				--	Borrar la solicitud de cambio (y la entrada en la tabla de tarifas)
				DELETE CATPRIV_CATALOGOREFERENCIAS WHERE CP_CR_IDPRODUCTO=v_IDProducto;--	17nov11
				DELETE IMAGENES WHERE IMG_IDPRODUCTO=v_IDProducto;
				DELETE TARIFAS WHERE TRF_IDPRODUCTO=v_IDProducto;
				DELETE PRODUCTOS WHERE PRO_ID=v_IDProducto;*/
				
				--	10abr12	Se lo devolvemos al proveedor para que pueda modificarlo
				UPDATE 		PRODUCTOS
					SET		PRO_STATUS='D'
					WHERE 	PRO_ID=v_IDProducto;
			END IF;
		END LOOP;

	END IF;
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.TratarCambiosProveedor','IDUsuario: '||p_IDUsuario||' ListaCambios: '||p_ListaCambios||' SQLERRM:'||SQLERRM);
END;

--	Informa el log de solicitudes de cambios en productos
/*
	Consulta el log de cambios
	
	SELECT 		TO_CHAR(PHC_FECHARESPUESTA,'dd/mm/yyyy hh24:mi:ss')||':'||SOL.US_USUARIO||':'||RES.US_USUARIO||':'||SUBSTR(EMP_NOMBRE,1,20)||':'||SUBSTR(PHC_REFERENCIA,1,15)||':'||SUBSTR(PHC_NOMBRE,1,20)||':'||PHC_STATUS LOG
		FROM	PRODUCTOS_HISTCAMBIOS, EMPRESAS, USUARIOS SOL, USUARIOS RES
		WHERE	PHC_IDPROVEEDOR=EMP_ID
		AND		PHC_IDUSUARIOSOLICITUD=SOL.US_ID
		AND		PHC_IDUSUARIORESPUESTA=RES.US_ID
		AND		PHC_FECHARESPUESTA>SYSDATE-2
		ORDER BY PHC_FECHARESPUESTA;
		
*/
PROCEDURE GuardarSolicitudCambio
(
	p_IDUsuario				NUMBER,
	p_IDProducto			NUMBER,
	p_Estado				VARCHAR2,
	p_Comentarios			VARCHAR2
)
IS
BEGIN
	
	INSERT INTO PRODUCTOS_HISTCAMBIOS
	(
		PHC_ID,
		PHC_IDUSUARIOSOLICITUD,
		PHC_IDUSUARIORESPUESTA,
		PHC_IDPROVEEDOR,
		PHC_IDTIPOPRODUCTO,
		PHC_NOMBRE,
		PHC_MARCA,
		PHC_FABRICANTE,
		PHC_UNIDADBASICA,
		PHC_UNIDADESPORLOTE,
		PHC_REFERENCIA,
		PHC_IDTIPOIVA,
		PHC_COMENTARIOS,
		PHC_FECHASOLICITUD,
		PHC_FECHARESPUESTA,
		PHC_ORIGEN,
		PHC_STATUS,
		PHC_NUMFOTOS,
		PHC_TARIFA,
		PHC_IDDOCUMENTO,
		PHC_IDOFERTAASISA,
		PHC_OCULTO,
		PHC_CATEGORIA,
		PHC_REFESTANDAR
	)
	SELECT
		PRO_ID,
		PRO_IDUSUARIOALTA,
		p_IDUsuario,
		PRO_IDPROVEEDOR,
		PRO_IDTIPOPRODUCTO,
		PRO_NOMBRE,
		PRO_MARCA,
		PRO_FABRICANTE,
		PRO_UNIDADBASICA,
		PRO_UNIDADESPORLOTE,
		PRO_REFERENCIA,
		PRO_IDTIPOIVA,
		p_Comentarios,
		PRO_FECHAALTA,
		SYSDATE,
		PRO_ORIGEN,
		p_Estado,
		PRO_NUMFOTOS,
		tarifas_pck.Tarifa(p_IDProducto, 1, 0),
		PRO_IDDOCUMENTO,
		PRO_IDOFERTAASISA,
		PRO_OCULTO,
		PRO_CATEGORIA,
		PRO_REFESTANDAR
	FROM 	PRODUCTOS
	WHERE 	PRO_ID=p_IDProducto;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.GuardarSolicitudCambio','IDUsuario: '||p_IDUsuario||' IDProducto: '||p_IDProducto||' Estado:'||p_Estado||' Comentarios:'||p_Comentarios||' SQLERRM:'||SQLERRM);
END;

--	Procesa el cambio en los datos de un producto solicitado por un proveedor
PROCEDURE ProcesarCambio
(
	p_IDUsuario				NUMBER,
	p_IDPais				NUMBER,			--	12abr12	Multipaís
	p_IDEmpresaCatalogo		NUMBER,			--	12abr12	Multipaís
	p_IDProducto			NUMBER
)
IS
	CURSOR cProducto(IDProducto NUMBER) IS
		SELECT * FROM PRODUCTOS WHERE PRO_ID=IDProducto;

	CURSOR cTarifas(IDEmpresaCatalogo NUMBER, IDProducto NUMBER) IS
		SELECT * 
		FROM 		TARIFAS 
			WHERE 	TRF_IDPRODUCTO=IDProducto
			AND 	TRF_IDCLIENTE=IDEmpresaCatalogo				--forzaremos la tarifa para MVM
			AND		TRF_IDCLIENTE<>1640;						--15abr11	No se cambia el precio para ASISA

	--	3abr14	Parametrizamos la actualización de los cambios introducidos por el proveedor
	CURSOR cEmpresasEspeciales(IDPais NUMBER) IS
		SELECT 		EMP_ID, EMP_NOMBRECORTOPUBLICO, EMPRESASESPECIALES.*
			FROM 	EMPRESASESPECIALES, EMPRESAS
			WHERE	EE_IDEMPRESA	=EMP_ID
			AND		NVL(EE_OCULTA,'N')='N'		--	29abr14
			AND		EMP_IDPAIS		=IDPais;


	v_IDProductoModificado		PRODUCTOS.PRO_ID%TYPE;
	v_Tarifa					TARIFAS.TRF_IMPORTE%TYPE;
	v_Status					VARCHAR2(3000);
BEGIN
	
	FOR r IN cProducto(p_IDProducto) LOOP

		v_Status:='Inicio.';
	
		IF r.PRO_STATUS='N' THEN
		
			v_Status:=v_Status||' NUEVO. Update.';
			
			--	Nuevo producto
			UPDATE PRODUCTOS SET 
					PRO_STATUS=NULL,
					PRO_ORIGEN='Producto aprobado.',
					PRO_FECHAALTA=SYSDATE,
					PRO_IDUSUARIOALTA=p_IDUsuario
				WHERE PRO_ID=r.PRO_ID;

			v_Status:=v_Status||' Guardar para buscador.';
			Buscador_Pck.GuardarProducto(r.PRO_ID,'S');	
			
			--utilidades_pck.debug('Aceptado nuevo producto '||r.PRO_ID);

			v_Status:=v_Status||' Tarifa.';
			v_Tarifa:=tarifas_pck.Tarifa(r.PRO_ID, p_IDEmpresaCatalogo, 0);
			
			--	27jun12	Expandimos la tarifa a TODOS los potenciales clientes, no solo a los que tenían una tarifa creada
			v_Status:=v_Status||' ExpandirManteniendoMargen.';
			ExpandirManteniendoMargen
			(
				p_IDUsuario,
				p_IDPais,
				p_IDEmpresaCatalogo,
				r.PRO_ID,
				v_Tarifa
			);
			
		ELSIF  r.PRO_STATUS='X' THEN
		
			v_Status:=v_Status||' BORRAR. SELECT.';
			
			--	12may11		No estábamos borrando el original, solo la copia!
			--	Busca el producto original
			SELECT 		PRO_IDPADRE
				INTO 	v_IDProductoModificado
				FROM	PRODUCTOS
				WHERE 	PRO_ID=p_IDProducto;	

			v_Status:=v_Status||' BORRAR. GuardarSolicitudCambio.';
			GuardarSolicitudCambio(p_IDUsuario, v_IDProductoModificado, 'O', NULL);		--	20abr11	Guardamos el producto original en el historico de cambios
		
			--	Elimina el producto "copia", ya tenemos la info necesaria en el log y así no llenamos la tabla
			v_Status:=v_Status||' DELETE [1].';
			DELETE IMAGENES WHERE IMG_IDPRODUCTO=v_IDProductoModificado;
			DELETE TARIFAS WHERE TRF_IDPRODUCTO=v_IDProductoModificado;
			DELETE BUSC_PRODUCTOS WHERE BPRO_ID=v_IDProductoModificado;
			DELETE CATPRIV_CATALOGOREFERENCIAS WHERE	CP_CR_IDPRODUCTO=v_IDProductoModificado;--	17nov11

			v_Status:=v_Status||' UPDATE PRODUCTOS.';
			UPDATE PRODUCTOS SET 
					PRO_STATUS='B',
					PRO_ORIGEN='Solicitado borrado '||TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')
				WHERE PRO_ID=v_IDProductoModificado;

			--	Borrar producto
			--	Elimina el producto "copia", ya tenemos la info necesaria en el log y así no llenamos la tabla
			v_Status:=v_Status||' DELETE [2].';
			DELETE IMAGENES WHERE IMG_IDPRODUCTO=r.PRO_ID;
			DELETE TARIFAS WHERE TRF_IDPRODUCTO=r.PRO_ID;
			DELETE BUSC_PRODUCTOS WHERE BPRO_ID=r.PRO_ID;
			
    		DELETE PRODUCTOS_DOCUMENTOS WHERE PROD_IDPRODUCTO=r.PRO_ID;			--	2oct13	Faltaba eliminar documentos
			DELETE PRODUCTOS WHERE PRO_ID=r.PRO_ID;
			DELETE CATPRIV_CATALOGOREFERENCIAS WHERE	CP_CR_IDPRODUCTO=r.PRO_ID;			--	17nov11
			
			--utilidades_pck.debug('Borrado producto '||r.PRO_ID);
		ELSE
		
			v_Status:=v_Status||' ACTUALIZAR. SELECT.';
			
			--	Busca el producto original
			--	20abr11	Antes lo hacíamos a través del IDProv y Referencia, ahora tenemos el campo PRO_IDPADRE
			SELECT 		PRO_IDPADRE
				INTO 	v_IDProductoModificado
				FROM	PRODUCTOS
				WHERE 	PRO_ID=p_IDProducto;	
		
			v_Status:=v_Status||' GuardarSolicitudCambio.';
			GuardarSolicitudCambio(p_IDUsuario, v_IDProductoModificado, 'O', NULL);		--	20abr11	Guardamos el producto original en el historico de cambios
		
			--	Modificar el producto adecuado
			v_Status:=v_Status||' UPDATE PRODUCTOS.';
			UPDATE PRODUCTOS SET
				PRO_NOMBRE				=r.PRO_NOMBRE,
				PRO_MARCA				=r.PRO_MARCA,
				PRO_FABRICANTE			=r.PRO_FABRICANTE,
				PRO_CODIGOINTERNACIONAL	=r.PRO_CODIGOINTERNACIONAL,
				PRO_NOMBREINTERNACIONAL	=r.PRO_NOMBREINTERNACIONAL,
				PRO_UNIDADBASICA		=r.PRO_UNIDADBASICA,
				PRO_UNIDADESPORLOTE		=r.PRO_UNIDADESPORLOTE,
				PRO_REFERENCIA			=r.PRO_REFERENCIA,
				PRO_DESCRIPCION			=r.PRO_DESCRIPCION,
				PRO_ENLACE				=r.PRO_ENLACE,
				PRO_IMAGEN				=r.PRO_IMAGEN,
				PRO_HOMOLOGADO			=r.PRO_HOMOLOGADO,
				PRO_CERTIFICADOS		=r.PRO_CERTIFICADOS,
				PRO_IDTIPOIVA			=r.PRO_IDTIPOIVA,
				pro_nombre_norm 		= Normalizar_Pck.NormalizarString ( r.pro_nombre ),
				pro_descripcion_norm 	= Normalizar_Pck.NormalizarString ( r.pro_descripcion ),
				pro_marca_norm 			= Normalizar_Pck.NormalizarString ( r.pro_marca ),
				pro_fabricante_norm 	= Normalizar_Pck.NormalizarString ( r.pro_fabricante ),
				PRO_REFERENCIA_NORM		= Normalizar_Pck.NormalizarID ( r.PRO_REFERENCIA ),
				PRO_IDDOCUMENTO			= r.PRO_IDDOCUMENTO,
				PRO_IDOFERTAASISA		= r.PRO_IDOFERTAASISA,
				PRO_IDOFERTAFNCP		= r.PRO_IDOFERTAFNCP,
				PRO_IDOFERTAVIAMED		= r.PRO_IDOFERTAVIAMED,
				PRO_IDOFERTATEKNON		= r.PRO_IDOFERTATEKNON,
				PRO_IDFICHATECNICA		= r.PRO_IDFICHATECNICA,
				PRO_CATEGORIA			= r.PRO_CATEGORIA,
				PRO_REFESTANDAR			= r.PRO_REFESTANDAR,
				PRO_OCULTO				= r.PRO_OCULTO
				WHERE	PRO_ID=v_IDProductoModificado;

			--	13set13	
			UPDATE PRODUCTOS SET
				PRO_TEXTO_NORM=normalizar_pck.NormalizarID(PRO_REFERENCIA)||' '||normalizar_pck.NormalizarID(PRO_REFESTANDAR)||' '||normalizar_pck.NormalizarString(PRO_NOMBRE||' '||PRO_MARCA)
				WHERE	PRO_ID=v_IDProductoModificado;

			v_Status:=v_Status||' Guardar para buscador.';
			Buscador_Pck.GuardarProducto(v_IDProductoModificado,'S');	
	
			--	Actualizar precios existentes manteniendo margen
			v_Status:=v_Status||' Tarifa.';
			v_Tarifa:=tarifas_pck.Tarifa(r.PRO_ID, p_IDEmpresaCatalogo, 0);
			
			--	Actualizamos la tarifa para MVM manteniendo margen
			--	11abr12	tarifas_pck.ActualizacionTarifaBase(p_IDUsuario,1, v_IDProductoModificado, v_Tarifa, 0, NULL);
			v_Status:=v_Status||' NuevaTarifaManteniendoMargen.';
			tarifas_pck.NuevaTarifaManteniendoMargen(p_IDUsuario,p_IDEmpresaCatalogo, v_IDProductoModificado, v_Tarifa, 0, NULL);
			
			--	Actualizamos la tarifa para el resto de clientes
			--FOR t IN cTarifas(v_IDProductoModificado) LOOP
			--	tarifas_pck.NuevaTarifaManteniendoMargen(p_IDUsuario, t.TRF_IDCLIENTE, v_IDProductoModificado, v_Tarifa, 0, NULL);
			--END LOOP;
			
			--	11abr12	Expandimos la tarifa a TODOS los potenciales clientes, no solo a los que tenían una tarifa creada
			v_Status:=v_Status||' ExpandirManteniendoMargen.';
			ExpandirManteniendoMargen
			(
				p_IDUsuario,
				p_IDPais,
				p_IDEmpresaCatalogo,
				v_IDProductoModificado,
				v_Tarifa
			);

			/*	Parametrizamos las "empresas especiales"
			--	21mar12	Idem con la tarifa ASISA (solo para España)
			IF p_IDPais=34 THEN
				v_Status:=v_Status||' Tarifa ASISA.';
				v_Tarifa:=tarifas_pck.Tarifa(r.PRO_ID, c_ASISA, 0);
				tarifas_pck.ActualizacionTarifaBase(p_IDUsuario, c_ASISA, v_IDProductoModificado, v_Tarifa, 0, NULL);

				--	12abr12	Para cambios directo en ASISA, actualizamos precios en los programas
				Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(r.PRO_ID, c_ASISA);
			END IF;

			--	9jul12	Idem con la tarifa ASPE (solo para España)
			IF p_IDPais=34 THEN
				v_Status:=v_Status||' Tarifa ASPE.';
				v_Tarifa:=tarifas_pck.Tarifa(r.PRO_ID, c_ASPE, 0);
				tarifas_pck.ActualizacionTarifaBase(p_IDUsuario, c_ASPE, v_IDProductoModificado, v_Tarifa, 0, NULL);

				--	9jul12	Para cambios directo en ASISA, actualizamos precios en los programas
				Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(r.PRO_ID, c_ASPE);
			END IF;


			--	9jul12	Idem con la tarifa VIAMED (solo para España)
			IF p_IDPais=34 THEN
				v_Status:=v_Status||' Tarifa VIAMED.';
				v_Tarifa:=tarifas_pck.Tarifa(r.PRO_ID, c_VIAMED, 0);
				tarifas_pck.ActualizacionTarifaBase(p_IDUsuario, c_VIAMED, v_IDProductoModificado, v_Tarifa, 0, NULL);

				--	9jul12	Para cambios directo en ASISA, actualizamos precios en los programas
				Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(r.PRO_ID, c_VIAMED);
			END IF;


			--	9jul12	Idem con la tarifa TEKNON (solo para España)
			IF p_IDPais=34 THEN
				v_Status:=v_Status||' Tarifa TEKNON.';
				v_Tarifa:=tarifas_pck.Tarifa(r.PRO_ID, c_TEKNON, 0);
				tarifas_pck.ActualizacionTarifaBase(p_IDUsuario, c_TEKNON, v_IDProductoModificado, v_Tarifa, 0, NULL);

				--	9jul12	Para cambios directo en ASISA, actualizamos precios en los programas
				Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(r.PRO_ID, c_TEKNON);
			END IF;
			*/
			
			--	3abr14	Parametrizamos las empresas especiales
			FOR rEmp IN cEmpresasEspeciales(p_IDPais) LOOP
			
				v_Status:=v_Status||' Tarifa '||rEmp.EMP_NOMBRECORTOPUBLICO||'.';
				v_Tarifa:=tarifas_pck.Tarifa(r.PRO_ID, rEmp.EMP_ID, 0);
				tarifas_pck.ActualizacionTarifaBase(p_IDUsuario, rEmp.EMP_ID, v_IDProductoModificado, v_Tarifa, 0, NULL);

				--	9jul12	Para cambios directo en ASISA, actualizamos precios en los programas
				Pedidosprogramados_Pck.RECALCULAR_PRECIOS_PROGRAMAS(r.PRO_ID, rEmp.EMP_ID);
			
			END LOOP;
		
			--	Copiar las imágenes del producto antiguo al nuevo (18nov11: solo si el nuevo tiene imágenes)
			--	16abr12	Copiamos siempre, para quitar si corresponde	IF Imagenes_Pck.TieneFotos(r.PRO_ID)='S' THEN

			--utilidades_pck.debug('MantenimientoProductos_PCK.ProcesarCambio. LLamando a Imagenes_Pck.CopiarFotos('||r.PRO_ID||', '||v_IDProductoModificado||')');
			v_Status:=v_Status||' CopiarFotos.';
			Imagenes_Pck.CopiarFotos(r.PRO_ID, v_IDProductoModificado);
			--END IF;
	
			--	17nov11	Si es un nuevo producto creado por MVM actualizamos en la tabla de referencias asociadas
			v_Status:=v_Status||' AsociarReferenciaEstandar.';
			CatalogoAutomatico_pck.AsociarReferenciaEstandar(v_IDProductoModificado, Normalizar_Pck.NormalizarStringBusquedaDB(r.PRO_REFESTANDAR));
			
			--	30mar12	Copia el contenido de la tabla de documentos
			v_Status:=v_Status||' CopiarDocumentosDelProducto.';
			DOCUMENTOS_PCK.CopiarDocumentosDelProducto(p_IDUsuario, r.PRO_ID, v_IDProductoModificado);
			
			
			--	Elimina el producto "copia", ya tenemos la info necesaria en el log y así no llenamos la tabla
			v_Status:=v_Status||' DELETE.';
			DELETE EIS_RESUMENCONSUMOS	WHERE	EIS_RC_IDPRODUCTO=r.PRO_ID;			--	23jul15
			DELETE CATPRIV_CATALOGOREFERENCIAS WHERE CP_CR_IDPRODUCTO=r.PRO_ID;		--	17nov11
			DELETE IMAGENES WHERE IMG_IDPRODUCTO=r.PRO_ID;
			DELETE TARIFAS WHERE TRF_IDPRODUCTO=r.PRO_ID;
			
    		DELETE PRODUCTOS_DOCUMENTOS WHERE PROD_IDPRODUCTO=r.PRO_ID;				--	2oct13	Faltaba eliminar documentos
			DELETE PRODUCTOS WHERE PRO_ID=r.PRO_ID;
			
			--utilidades_pck.debug('Corregido producto '||v_IDProductoModificado||' desde el '||r.PRO_ID);
		END IF;
	END LOOP;
	
	--utilidades_pck.debug('MantenimientoProductos_PCK.ProcesarCambio:'||v_Status);
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.ProcesarCambio',v_Status||' IDUsuario: '||p_IDUsuario||' IDProducto: '||p_IDProducto||' SQLERRM:'||SQLERRM);
END;



--	4mar13	Descarta el cambio en los datos de un producto solicitado por un proveedor
PROCEDURE DescartarCambio_XML
(
	p_IDUsuario				NUMBER,
	p_IDPais				NUMBER,			--	12abr12	Multipaís
	p_IDEmpresaCatalogo		NUMBER,			--	12abr12	Multipaís
	p_IDProducto			NUMBER
)
IS
	CURSOR cProducto(IDProducto NUMBER) IS
		SELECT * FROM PRODUCTOS WHERE PRO_ID=IDProducto;

	CURSOR cTarifas(IDEmpresaCatalogo NUMBER, IDProducto NUMBER) IS
		SELECT * 
		FROM 		TARIFAS 
			WHERE 	TRF_IDPRODUCTO=IDProducto
			AND 	TRF_IDCLIENTE=IDEmpresaCatalogo				--forzaremos la tarifa para MVM
			AND		TRF_IDCLIENTE<>1640;						--15abr11	No se cambia el precio para ASISA

	v_IDProductoModificado		PRODUCTOS.PRO_ID%TYPE;
	v_Tarifa					TARIFAS.TRF_IMPORTE%TYPE;
	v_Status					VARCHAR2(3000);
BEGIN

	v_Status:='Inicio.';

	GuardarSolicitudCambio(p_IDUsuario, p_IDProducto, 'R', NULL);		--	20abr11	Guardamos la solicitud en el historico de cambios

	v_Status:=v_Status||' UPDATE PRODUCTOS.';
	
	UPDATE PRODUCTOS SET 
			PRO_STATUS='B',
			PRO_ORIGEN='Cambio cancelado '||TO_CHAR(SYSDATE,'dd/mm/yyyy hh24:mi:ss')
		WHERE PRO_ID=p_IDProducto;
	
	--utilidades_pck.debug('MantenimientoProductos_PCK.DescartarCambio_XML:'||v_Status);

	HTP.P('<OK msg="Solicitud de cambio en producto '||p_IDProducto||' borrada"/>');
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.DescartarCambio_XML',v_Status||' IDUsuario: '||p_IDUsuario||' IDProducto: '||p_IDProducto||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg="Error desconocido al borrar solicitud de cambio en producto '||p_IDProducto||'"/>');
END;



--	21ene13	Asocia todos los productos de un proveedor a una oferta
PROCEDURE AsociarOfertaATodos_XML
(
	p_IDUsuario				NUMBER,
	p_IDProveedor			NUMBER,
	p_IDDocumento			NUMBER,
	p_IDTipo				VARCHAR2		--	tipo de oferta
)
IS
	CURSOR cDatosEmpresa(Tipo VARCHAR2) IS
		SELECT 		EE_IDEMPRESA, EE_CAMPOOFERTA 
			FROM 	EMPRESASESPECIALES
			WHERE	EE_MARCAOFERTA=Tipo;
			
	v_IDCliente					EMPRESAS.EMP_ID%TYPE;
	v_IDProveedor				EMPRESAS.EMP_ID%TYPE;

	v_IDEmpresaDelUsuario		EMPRESAS.EMP_ID%TYPE;				--23feb17	
	v_IDPais					EMPRESAS.EMP_IDPAIS%TYPE;			--23feb17	

	v_Error						VARCHAR2(1000);
	v_CampoOferta				EMPRESASESPECIALES.EE_CAMPOOFERTA%TYPE;
	v_SQL						VARCHAR2(1000);
	
	v_Parametros				VARCHAR2(3000);
BEGIN

	v_Parametros:='IDUsuario: '||p_IDUsuario||' IDEmpresa: '||p_IDProveedor||' IDDocumento: '||p_IDDocumento||' IDTipo:'||p_IDTipo;

	--	23feb17
	SELECT		EMP_ID, EMP_IDPAIS
		INTO	v_IDEmpresaDelUsuario, v_IDPais
		FROM 	USUARIOS, CENTROS, EMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		US_ID=p_IDUsuario;

	--	Comprobar derechos del usuario
	--IF utilidades_pck.empresadelusuario(p_IDUsuario) NOT IN (Mvm.BuscarParametro(0),Mvm.BuscarParametro(2 0 0)) THEN
	IF v_IDEmpresaDelUsuario <>TO_NUMBER(utilidades_pck.Parametro('IDMVM_'||v_IDPais)) THEN
		v_Error:='Solo los usuarios de MedicalVM pueden utilizar esta opcion.';
	END IF;

	--	Comprobar que el documento pertenece a la empresa
	SELECT		DOC_IDPROVEEDOR
		INTO	v_IDProveedor
		FROM	DOCUMENTOS
		WHERE	DOC_ID=p_IDDocumento;

	IF v_IDProveedor<>p_IDProveedor THEN
		v_Error:='La oferta no pertenece a este proveedor.';
	END IF;

	IF  v_Error IS NULL THEN
	
		FOR r IN cDatosEmpresa(p_IDTipo) LOOP
			v_IDCliente		:=r.EE_IDEMPRESA;
			--22may14	v_CampoOferta	:=r.EE_CAMPOOFERTA;
		END LOOP;
		
		/*	22may14	Ya no utilizamos los campos de la tabla de productos
		v_SQL:=	'UPDATE PRODUCTOS'
			||	'	SET 	'||v_CampoOferta||'='||p_IDDocumento
			||	'	WHERE 	PRO_IDPROVEEDOR=:IDEMPRESA'
			||	'	AND 	PRO_STATUS IS NULL';

		EXECUTE IMMEDIATE v_SQL USING p_IDProveedor;
		*/
		
		--27dic13	AsignaFechaOfertaTodos(p_IDProveedor);
		AsignaFechaOfertaTodos(v_IDCliente, p_IDProveedor);
		
		--	1oct13	Inicializa también la tabla de PRODUCTOS_DOCUMENTOS
		DELETE 		PRODUCTOS_DOCUMENTOS
			WHERE 	PROD_IDEMPRESA		=v_IDCliente
			--27dic13	AND		PROD_IDDOCUMENTO	=p_IDDocumento
			AND 	PROD_IDPRODUCTO IN 
				(
					SELECT 		PRO_ID 
						FROM 	PRODUCTOS
						WHERE	PRO_IDPROVEEDOR=p_IDProveedor
						AND 	PRO_STATUS IS NULL	
				);

	    INSERT INTO PRODUCTOS_DOCUMENTOS(PROD_IDUSUARIO, PROD_IDEMPRESA, PROD_IDDOCUMENTO, PROD_IDPRODUCTO, PROD_FECHA)
		SELECT	p_IDUsuario, v_IDCliente, p_IDDocumento, PRO_ID, SYSDATE
			FROM 	PRODUCTOS
			WHERE	PRO_IDPROVEEDOR=p_IDProveedor
			AND 	PRO_STATUS IS NULL;
	
		--	Guardamos info en el log de administracion
		/*productos_pck.debug
		(
			p_IDUsuario,
			2,
			'MantenimientoProductos_PCK.AsociarOfertaATodos_XML',
			p_IDDocumento,
			'Oferta '||p_IDTipo||' expandida a todos los productos de IDEmpresa:'||p_IDProveedor
		);*/
		
		productos_pck.debug(NULL, 'MantenimientoProductos_PCK.AsociarOfertaATodos_XML. '||v_Parametros);
		
	ELSE
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarOfertaATodos_XML',v_Parametros||'. SIN DERECHOS');
	END IF;
	

	--	Devolver confirmacion
	IF v_Error IS NULL THEN
		HTP.P('<OK/>');
	ELSE
		HTP.P('<ERROR msg='|| v_Error ||'/>');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarOfertaATodos_XML','IDUsuario: '||p_IDUsuario||' IDProveedor: '||p_IDProveedor||' IDDocumento: '||p_IDDocumento||' IDTipo:'||p_IDTipo||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg='||SQLERRM||'/>');
END;


--	21mar13	Asocia todos los productos de un proveedor a una oferta
PROCEDURE AsociarFechaAOferta_XML
(
	p_IDUsuario				NUMBER,
	p_IDEmpresa				NUMBER,
	p_IDDocumento			NUMBER,
	p_Fecha					VARCHAR2,
	p_FechaFinal			VARCHAR2	DEFAULT NULL
)
IS
		
	v_IDEmpresaDelUsuario		EMPRESAS.EMP_ID%TYPE;				--23feb17	
	v_IDPais					EMPRESAS.EMP_IDPAIS%TYPE;			--23feb17	
	
	v_CdC			 			VARCHAR2(1);						--29abr21
	v_Admin						VARCHAR2(1);						--29abr21
	v_GestionaDocProveedores	VARCHAR2(1);						--29abr21
	
	
	v_IDProveedor				EMPRESAS.EMP_ID%TYPE;
	v_Error						VARCHAR2(1000);

	v_Parametros				VARCHAR2(1000);

BEGIN
	v_Parametros:='IDUsuario: '||p_IDUsuario||' IDEmpresa: '||p_IDEmpresa||' IDDocumento: '||p_IDDocumento||' Fecha:'||p_Fecha;
	
	
	--	23feb17
	SELECT		EMP_ID, EMP_IDPAIS, NVL(US_CENTRALCOMPRAS,'N'), DECODE(US_USUARIOGERENTE,1,'S','N'), NVL(EMP_DOC_GESTIONAPROVEEDORES,'N')
		INTO	v_IDEmpresaDelUsuario, v_IDPais, v_CdC, v_Admin, v_GestionaDocProveedores
		FROM 	USUARIOS, CENTROS, EMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		US_ID=p_IDUsuario;


	--	Comprobar derechos del usuario
	--	23feb17	IF utilidades_pck.empresadelusuario(p_IDUsuario) NOT IN (Mvm.BuscarParametro(0),Mvm.BuscarParametro(2 0 0)) THEN
	IF v_IDEmpresaDelUsuario <>TO_NUMBER(utilidades_pck.Parametro('IDMVM_'||v_IDPais)) AND (v_GestionaDocProveedores='N' OR v_CdC='N') AND v_Admin='N' THEN
		v_Error:='Solo los usuarios Admin, MVM o CDC pueden utilizar esta opcion.';
	END IF;
	
	

	--	Comprobar que el documento pertenece a la empresa
	SELECT		DOC_IDPROVEEDOR
		INTO	v_IDProveedor
		FROM	DOCUMENTOS
		WHERE	DOC_ID=p_IDDocumento;

	IF v_IDProveedor<>p_IDEmpresa THEN
		v_Error:='La oferta no pertenece a este proveedor.';
	END IF;

	IF  v_Error IS NULL THEN
	
		DOCUMENTOS_PCK.Fecha(p_IDDocumento, p_Fecha, p_FechaFinal);
	
		--	Guardamos info en el log de administracion
		/*productos_pck.debug
		(
			p_IDUsuario,
			2,
			'MantenimientoProductos_PCK.AsociarFechaAOferta_XML',
			p_IDDocumento,
			'Asignada fecha:'||p_Fecha
		);*/
		
		productos_pck.debug(NULL, 'MantenimientoProductos_PCK.AsociarFechaAOferta_XML'||v_Parametros);
	ELSE
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarFechaAOferta_XML',v_Parametros||'. SIN DERECHOS:'||v_Error);
	END IF;
	

	--	Devolver confirmacion
	IF v_Error IS NULL THEN
		HTP.P('<OK/>');
	ELSE
		HTP.P('<ERROR msg='|| v_Error ||'/>');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarFechaAOferta_XML',v_Parametros||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg='||SQLERRM||'/>');
END;


/*
--	23may11	Asocia todos los productos de un proveedor a una oferta
PROCEDURE AsociarOfertaATodos_XML
(
	p_IDUsuario				NUMBER,
	p_IDEmpresa				NUMBER,
	p_IDDocumento			NUMBER
)
IS
	v_IDProveedor	EMPRESAS.EMP_ID%TYPE;
	v_Error			VARCHAR2(1000);
BEGIN
	--	Comprobar derechos del usuario
	IF utilidades_pck.empresadelusuario(p_IDUsuario)<>1 THEN
		v_Error:='Solo los usuarios de MedicalVM pueden utilizar esta opcion.';
	END IF;
	
	--	Comprobar que el docuemnto pertenece a la empresa
	SELECT		DOC_IDPROVEEDOR
		INTO	v_IDProveedor
		FROM	DOCUMENTOS
		WHERE	DOC_ID=p_IDDocumento;
	
	IF v_IDProveedor<>p_IDEmpresa THEN
		v_Error:='La oferta no pertenece a este proveedor.';
	END IF;
	
	--	Asociar productos
	IF  v_Error IS NULL THEN
		UPDATE PRODUCTOS
			SET 	PRO_IDDOCUMENTO=p_IDDocumento
			WHERE 	PRO_IDPROVEEDOR=p_IDEmpresa
			AND 	PRO_STATUS IS NULL;
	END IF;

	--	Guardamos info en el log de administracion
	productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.AsociarOfertaATodos_XML',
		p_IDDocumento,
		'Oferta expandida a todos los productos de IDEmpresa:'||p_IDEmpresa
	);
	

	--	Devolver confirmacion
	IF v_Error IS NULL THEN
		HTP.P('<OK/>');
	ELSE
		HTP.P('<ERROR msg='|| v_Error ||'/>');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarOfertaATodos_XML','IDUsuario: '||p_IDUsuario||' IDEmpresa: '||p_IDEmpresa||' IDDocumento: '||p_IDDocumento||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg='||SQLERRM||'/>');
END;


--	2abr12	Asocia todos los productos de un proveedor a una oferta ASISA
PROCEDURE AsociarOfertaASISAATodos_XML
(
	p_IDUsuario				NUMBER,
	p_IDEmpresa				NUMBER,
	p_IDDocumento			NUMBER
)
IS
	v_IDProveedor	EMPRESAS.EMP_ID%TYPE;
	v_Error			VARCHAR2(1000);
BEGIN
	--	Comprobar derechos del usuario
	IF utilidades_pck.empresadelusuario(p_IDUsuario)<>1 THEN
		v_Error:='Solo los usuarios de MedicalVM pueden utilizar esta opcion.';
	END IF;
	
	--	Comprobar que el docuemnto pertenece a la empresa
	SELECT		DOC_IDPROVEEDOR
		INTO	v_IDProveedor
		FROM	DOCUMENTOS
		WHERE	DOC_ID=p_IDDocumento;
	
	IF v_IDProveedor<>p_IDEmpresa THEN
		v_Error:='La oferta no pertenece a este proveedor.';
	END IF;
	
	--	Asociar productos
	IF  v_Error IS NULL THEN
		UPDATE PRODUCTOS
			SET 	PRO_IDOFERTAASISA=p_IDDocumento
			WHERE 	PRO_IDPROVEEDOR=p_IDEmpresa
			AND 	PRO_STATUS IS NULL;
	END IF;

	--	Guardamos info en el log de administracion
	productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.AsociarOfertaASISAATodos_XML',
		p_IDDocumento,
		'Oferta ASISA expandida a todos los productos de IDEmpresa:'||p_IDEmpresa
	);
	

	--	Devolver confirmacion
	IF v_Error IS NULL THEN
		HTP.P('<OK/>');
	ELSE
		HTP.P('<ERROR msg='|| v_Error ||'/>');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarOfertaASISAATodos_XML','IDUsuario: '||p_IDUsuario||' IDEmpresa: '||p_IDEmpresa||' IDDocumento: '||p_IDDocumento||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg='||SQLERRM||'/>');
END;

--	9jul12	Asocia todos los productos de un proveedor a una oferta ASPE
PROCEDURE AsociarOfertaASPEATodos_XML
(
	p_IDUsuario				NUMBER,
	p_IDEmpresa				NUMBER,
	p_IDDocumento			NUMBER
)
IS
	v_IDProveedor	EMPRESAS.EMP_ID%TYPE;
	v_Error			VARCHAR2(1000);
BEGIN
	--	Comprobar derechos del usuario
	IF utilidades_pck.empresadelusuario(p_IDUsuario)<>1 THEN
		v_Error:='Solo los usuarios de MedicalVM pueden utilizar esta opcion.';
	END IF;
	
	--	Comprobar que el docuemnto pertenece a la empresa
	SELECT		DOC_IDPROVEEDOR
		INTO	v_IDProveedor
		FROM	DOCUMENTOS
		WHERE	DOC_ID=p_IDDocumento;
	
	IF v_IDProveedor<>p_IDEmpresa THEN
		v_Error:='La oferta no pertenece a este proveedor.';
	END IF;
	
	--	Asociar productos
	IF  v_Error IS NULL THEN
		UPDATE PRODUCTOS
			SET 	PRO_IDOFERTAFNCP=p_IDDocumento
			WHERE 	PRO_IDPROVEEDOR=p_IDEmpresa
			AND 	PRO_STATUS IS NULL;
	END IF;

	--	Guardamos info en el log de administracion
	productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.AsociarOfertaASPEATodos_XML',
		p_IDDocumento,
		'Oferta ASPE expandida a todos los productos de IDEmpresa:'||p_IDEmpresa
	);
	

	--	Devolver confirmacion
	IF v_Error IS NULL THEN
		HTP.P('<OK/>');
	ELSE
		HTP.P('<ERROR msg='|| v_Error ||'/>');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarOfertaASPEATodos_XML','IDUsuario: '||p_IDUsuario||' IDEmpresa: '||p_IDEmpresa||' IDDocumento: '||p_IDDocumento||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg='||SQLERRM||'/>');
END;


--	18ene13	Asocia todos los productos de un proveedor a una oferta Viamed
PROCEDURE AsociarOfertaViamedATodos_XML
(
	p_IDUsuario				NUMBER,
	p_IDEmpresa				NUMBER,
	p_IDDocumento			NUMBER
)
IS
	v_IDProveedor	EMPRESAS.EMP_ID%TYPE;
	v_Error			VARCHAR2(1000);
BEGIN
	--	Comprobar derechos del usuario
	IF utilidades_pck.empresadelusuario(p_IDUsuario)<>1 THEN
		v_Error:='Solo los usuarios de MedicalVM pueden utilizar esta opcion.';
	END IF;
	
	--	Comprobar que el docuemnto pertenece a la empresa
	SELECT		DOC_IDPROVEEDOR
		INTO	v_IDProveedor
		FROM	DOCUMENTOS
		WHERE	DOC_ID=p_IDDocumento;
	
	IF v_IDProveedor<>p_IDEmpresa THEN
		v_Error:='La oferta no pertenece a este proveedor.';
	END IF;
	
	--	Asociar productos
	IF  v_Error IS NULL THEN
		UPDATE PRODUCTOS
			SET 	PRO_IDOFERTAVIAMED=p_IDDocumento
			WHERE 	PRO_IDPROVEEDOR=p_IDEmpresa
			AND 	PRO_STATUS IS NULL;
	END IF;

	--	Guardamos info en el log de administracion
	productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.AsociarOfertaViamedATodos_XML',
		p_IDDocumento,
		'Oferta ASPE expandida a todos los productos de IDEmpresa:'||p_IDEmpresa
	);
	

	--	Devolver confirmacion
	IF v_Error IS NULL THEN
		HTP.P('<OK/>');
	ELSE
		HTP.P('<ERROR msg='|| v_Error ||'/>');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarOfertaViamedATodos_XML','IDUsuario: '||p_IDUsuario||' IDEmpresa: '||p_IDEmpresa||' IDDocumento: '||p_IDDocumento||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg='||SQLERRM||'/>');
END;

--	18ene13	Asocia todos los productos de un proveedor a una oferta ASPE
PROCEDURE AsociarOfertaTeknonATodos_XML
(
	p_IDUsuario				NUMBER,
	p_IDEmpresa				NUMBER,
	p_IDDocumento			NUMBER
)
IS
	v_IDProveedor	EMPRESAS.EMP_ID%TYPE;
	v_Error			VARCHAR2(1000);
BEGIN
	--	Comprobar derechos del usuario
	IF utilidades_pck.empresadelusuario(p_IDUsuario)<>1 THEN
		v_Error:='Solo los usuarios de MedicalVM pueden utilizar esta opcion.';
	END IF;
	
	--	Comprobar que el docuemnto pertenece a la empresa
	SELECT		DOC_IDPROVEEDOR
		INTO	v_IDProveedor
		FROM	DOCUMENTOS
		WHERE	DOC_ID=p_IDDocumento;
	
	IF v_IDProveedor<>p_IDEmpresa THEN
		v_Error:='La oferta no pertenece a este proveedor.';
	END IF;
	
	--	Asociar productos
	IF  v_Error IS NULL THEN
		UPDATE PRODUCTOS
			SET 	PRO_IDOFERTATEKNON=p_IDDocumento
			WHERE 	PRO_IDPROVEEDOR=p_IDEmpresa
			AND 	PRO_STATUS IS NULL;
	END IF;

	--	Guardamos info en el log de administracion
	productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.AsociarOfertaTeknonATodos_XML',
		p_IDDocumento,
		'Oferta Teknon expandida a todos los productos de IDEmpresa:'||p_IDEmpresa
	);
	

	--	Devolver confirmacion
	IF v_Error IS NULL THEN
		HTP.P('<OK/>');
	ELSE
		HTP.P('<ERROR msg='|| v_Error ||'/>');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.AsociarOfertaTeknonATodos_XML','IDUsuario: '||p_IDUsuario||' IDEmpresa: '||p_IDEmpresa||' IDDocumento: '||p_IDDocumento||' SQLERRM:'||SQLERRM);
		HTP.P('<ERROR msg='||SQLERRM||'/>');
END;
*/


--	12mar13	Inicializa la "fecha oferta" para todas las ref. estándar que tengan emplantillado un producto
PROCEDURE AsignaFechaOferta
(
	p_IDProducto			NUMBER
)
IS

	CURSOR cProductosEstandar(IDProducto NUMBER) IS
		SELECT		CP_PRO_ID, CP_PRO_IDEMPRESA, CP_PRE_IDPRODUCTOESTANDAR
			FROM	CATPRIV_PRODUCTOS_PRODESTANDAR, CATPRIV_PRODUCTOSESTANDAR
			WHERE	CP_PRE_IDPRODUCTOESTANDAR=CP_PRO_ID
			AND		CP_PRE_IDPRODUCTO=p_IDProducto;

	v_FechaOferta		DATE;
BEGIN

	FOR r IN cProductosEstandar(p_IDProducto) LOOP

		v_FechaOferta:=Productos_pck.FechaOferta(r.CP_PRO_IDEMPRESA, p_IDProducto);

		IF v_FechaOferta IS NULL THEN
			v_FechaOferta:=Productos_pck.FechaTarifa(r.CP_PRO_IDEMPRESA, p_IDProducto);
		END IF;

		--	Actualizamos la fecha de oferta a este emplantillamiento
		UPDATE		CATPRIV_PRODUCTOSESTANDAR
			SET		CP_PRO_FECHAOFERTA=NVL(v_FechaOferta, SYSDATE)
			WHERE	CP_PRO_ID=r.CP_PRO_ID;
			
	END LOOP;
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.INSERTDBERROR ('MantenimientoProductos_PCK.AsignaFechaOferta','IDProducto: '||p_IDProducto||' SQLERRM:'||SQLERRM);
END;

--	12mar13	Inicializa la "fecha oferta" para todas las ref. estándar que tengan emplantillado un producto
--	27dic13	para un mismo cliente!
PROCEDURE AsignaFechaOfertaTodos
(
	p_IDCliente				NUMBER,	--	27dic13
	p_IDProveedor			NUMBER
)
IS

	CURSOR cProductosEstandar(IDCliente NUMBER, IDProveedor NUMBER) IS
		SELECT		CP_PRO_ID, CP_PRO_IDEMPRESA, CP_PRE_IDPRODUCTOESTANDAR, PRO_ID
			FROM	CATPRIV_PRODUCTOS_PRODESTANDAR, CATPRIV_PRODUCTOSESTANDAR, PRODUCTOS
			WHERE	CP_PRE_IDPRODUCTOESTANDAR	=CP_PRO_ID
			AND		CP_PRE_IDPRODUCTO			=PRO_ID
			AND		CP_PRO_IDEMPRESA			=IDCliente		--	27dic13
			AND		PRO_IDPROVEEDOR				=IDProveedor;

	v_FechaOferta		DATE;
BEGIN

	FOR r IN cProductosEstandar(p_IDCliente, p_IDProveedor) LOOP

		v_FechaOferta:=Productos_pck.FechaOferta(p_IDCliente, r.PRO_ID);

		IF v_FechaOferta IS NULL THEN
			v_FechaOferta:=Productos_pck.FechaTarifa(p_IDCliente, r.PRO_ID);
		END IF;

		--	Actualizamos la fecha de oferta a este emplantillamiento
		UPDATE		CATPRIV_PRODUCTOSESTANDAR
			SET		CP_PRO_FECHAOFERTA=NVL(v_FechaOferta, SYSDATE)
			WHERE	CP_PRO_ID=r.CP_PRO_ID;
			
	END LOOP;
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.INSERTDBERROR ('MantenimientoProductos_PCK.AsignaFechaOfertaTodos','IDCliente:'||p_IDCliente||' IDProveedor: '||p_IDProveedor||' SQLERRM:'||SQLERRM);
END;


--	25jun13	Devuelve la unidad basica y unidades por lote personalizados de un producto
PROCEDURE Empaquetamiento_XML
(
	p_IDUsuario				NUMBER,
	p_IDProducto			NUMBER,
	p_IncluirCabecera		VARCHAR2,
	p_IncluirClientes		VARCHAR2
)
IS
	CURSOR cEmpaquetamientos(IDProducto NUMBER) IS
		SELECT		EMP_ID, NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE) NOMBRE, PRO_UL_UNIDADBASICA, PRO_UL_UNIDADESPORLOTE			--	28set21 Nombre corto
			FROM 	PRO_UNIDADESPORLOTE, EMPRESAS
			WHERE	PRO_UL_IDCLIENTE=EMP_ID
			AND		PRO_UL_IDPRODUCTO=IDProducto
			ORDER BY NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE);

	CURSOR cClientes(v_IDPais NUMBER) IS
		SELECT		EMP_ID, NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE) NOMBRE														--	28set21 Nombre corto
			FROM 	EMPRESAS, TIPOSEMPRESAS
			WHERE	EMP_IDTIPO=TE_ID
			AND		EMP_STATUS IS NULL
			AND		TE_ROL='COMPRADOR'
			AND		EMP_IDPAIS=v_IDPais
			ORDER BY NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE);
			
	v_IDProveedor	EMPRESAS.EMP_ID%TYPE;			--	14mar22
	v_IDEmpresa		EMPRESAS.EMP_ID%TYPE;
	v_Proveedor		EMPRESAS.EMP_NOMBRE%TYPE;		--	14mar22
	v_Empresa		EMPRESAS.EMP_NOMBRE%TYPE;		--	21may19
	v_IDPais		EMPRESAS.EMP_IDPAIS%TYPE;

	v_RefProducto	PRODUCTOS.PRO_REFERENCIA%TYPE;	--4set17
	v_Producto		PRODUCTOS.PRO_NOMBRE%TYPE;		--4set17
	
	v_UsuarioCdC	VARCHAR2(1);					--	21may19
	v_UsuarioMVM	VARCHAR2(1);					--	21may19
	
	v_Parametros	VARCHAR2(1000);
	SIN_DERECHOS	EXCEPTION;
BEGIN		
	v_Parametros:='IDUsuario:'||p_IDUsuario||' IDProducto:'||p_IDProducto||' IncluirCabecera:'||p_IncluirCabecera||' IncluirClientes:'||p_IncluirClientes;
	
	--	Comprobar derechos
	SELECT		EMP_ID, EMP_IDPAIS, NVL(US_CENTRALCOMPRAS,'N'), DECODE(US_USUARIOGERENTE,1,'S','N'), NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE)
		INTO	v_IDEmpresa, v_IDPais, v_UsuarioCdC, v_UsuarioMVM, v_Empresa
		FROM	USUARIOS, CENTROS, EMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		US_ID=p_IDUsuario;
		
		
	--	4set17 Incluimos el nombre del producto
	SELECT		PRO_REFERENCIA, PRO_NOMBRE, EMP_ID, NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE)
		INTO	v_RefProducto, v_Producto, v_IDProveedor, v_Proveedor
		FROM	PRODUCTOS, EMPRESAS
		WHERE	PRO_IDPROVEEDOR=EMP_ID										--	14mar22
		AND		PRO_ID=p_IDProducto;
	
	--23feb17	IF v_IDEmpresa NOT IN (Mvm.BuscarParametro(0), Mvm.BuscarParametro(2 0 0)) THEN
	--	21may19 Permitimos a los usuarios CdC y MVM acceder al mantenimiento de empaquetamiento
	IF v_UsuarioCdC='N' AND v_UsuarioMVM='N' THEN
		RAISE SIN_DERECHOS;
	END IF;
	
	IF p_IncluirCabecera='S' THEN
		HTP.P(Utilidades_Pck.CabeceraXML);
	END IF;


	HTP.P('<EMPAQUETAMIENTOS>'
			|| 	'<IDPRODUCTO>'		|| p_IDProducto									||'</IDPRODUCTO>'
			|| 	'<IDEMPRESA>'		|| v_IDEmpresa									||'</IDEMPRESA>'			--	21may19
			|| 	'<EMPRESA>'			|| mvm.ScapeHTMLString(v_Empresa)				||'</EMPRESA>'				--	21may19
			|| 	'<IDPROVEEDOR>'		|| v_IDProveedor								||'</IDPROVEEDOR>'			--	14mar22
			|| 	'<PROVEEDOR>'		|| mvm.ScapeHTMLString(v_Proveedor)				||'</PROVEEDOR>'			--	14mar22
			|| 	'<PRO_REFERENCIA>'	|| mvm.ScapeHTMLString(v_RefProducto)			||'</PRO_REFERENCIA>'		--	4set17
			|| 	'<PRO_NOMBRE>'		|| mvm.ScapeHTMLString(v_Producto)				||'</PRO_NOMBRE>');			--	4set17
	
	--	21may19 Usuario MVM podrá ver el desplegable de empresas
	IF v_UsuarioMVM='S' THEN
		HTP.P('<ADMIN/>');
	END IF;
	
	FOR r IN cEmpaquetamientos(p_IDProducto) LOOP
		HTP.P('<EMPAQUETAMIENTO>'
			|| 	'<IDPRODUCTO>'		|| p_IDProducto									||'</IDPRODUCTO>'
			|| 	'<IDCLIENTE>'		|| r.EMP_ID										||'</IDCLIENTE>'
			|| 	'<CLIENTE>'			|| mvm.ScapeHTMLString(r.NOMBRE)				||'</CLIENTE>'
			|| 	'<UNIDADBASICA>'	|| mvm.ScapeHTMLString(r.PRO_UL_UNIDADBASICA)	||'</UNIDADBASICA>'
			|| 	'<UNIDADESPORLOTE>'	|| r.PRO_UL_UNIDADESPORLOTE						||'</UNIDADESPORLOTE>'
			||'</EMPAQUETAMIENTO>');
	END LOOP;
	
	IF p_IncluirClientes='S' AND v_UsuarioMVM='S' THEN
		--	Lista de empresas, para conceder derechos
		HTP.P(		'<CLIENTES>'
				||	'<field label="Cliente" name="IDCLIENTE" current="-1">'
				||	'<dropDownList>');
		
		HTP.P(		'<listElem>'	
				|| 	'<ID>-1</ID>'
				|| 	'<listItem>Seleccionar cliente</listItem>'
				||	'</listElem>');
		FOR c IN cClientes(v_IDPais) LOOP
			HTP.P(		'<listElem>'	
					|| 	'<ID>'||c.EMP_ID||'</ID>'
					|| 	'<listItem>'||mvm.ScapeHTMLString(c.NOMBRE)||'</listItem>'
					||	'</listElem>');
		END LOOP;
		HTP.P(		'</dropDownList>'
				||	'</field>'
				||	'</CLIENTES>');
	END IF;
	
	HTP.P('</EMPAQUETAMIENTOS>');

EXCEPTION
	WHEN SIN_DERECHOS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.Empaquetamiento_XML',v_Parametros||' Usuario sin derechos');
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.Empaquetamiento_XML',v_Parametros||' SQLERRM:'||SQLERRM);
END;


--	25jun13	Guarda la unidad basica y unidades por lote personalizados de un producto para un cliente
--	13dic13	Añadimos decodificación ZZ -> 19dic13 Volvemos a quitarla
FUNCTION NuevoEmpaquetamiento
(
	p_IDUsuario				NUMBER,
	p_IDProducto			NUMBER,
	p_IDCliente				NUMBER,
	p_UnidadBasica			VARCHAR2,
	p_UnidadesPorLote		NUMBER,
	p_ForzarSiExiste		VARCHAR2 DEFAULT 'N'
) RETURN VARCHAR2
IS
	v_IDEmpresa		EMPRESAS.EMP_ID%TYPE;
	v_Existe		INTEGER;
	
	v_UsuarioCdC	VARCHAR2(1);		--	21may19
	
	v_Parametros	VARCHAR2(1000);		--	9jul17
	
	SIN_DERECHOS	EXCEPTION;
	YA_EXISTE		EXCEPTION;
BEGIN
	v_Parametros:='IDUsuario:'||p_IDUsuario||' IDProducto:'||p_IDProducto||' IDCliente:'||p_IDCliente||' UnidadBasica:'||p_UnidadBasica||' UnidadesPorLote:'||p_UnidadesPorLote;
	
	--	Comprobar derechos
	SELECT		EMP_ID
		INTO	v_IDEmpresa
		FROM	USUARIOS, CENTROS, EMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		US_ID=p_IDUsuario;
	
	--27feb15	Eliminamos este control, ya que el empaquetamiento puede modificarse desde una licitación
	--IF v_IDEmpresa NOT IN (Mvm.BuscarParametro(0), Mvm.BuscarParametro(2 0 0)) THEN
	--	RAISE SIN_DERECHOS;
	--END IF;

	--	Comprueba que no exista ya
	SELECT 		COUNT(*)
		INTO	v_Existe
		FROM	PRO_UNIDADESPORLOTE
		WHERE	PRO_UL_IDCLIENTE=p_IDCliente
		AND		PRO_UL_IDPRODUCTO=p_IDProducto;

	IF v_Existe>0 THEN

		IF p_ForzarSiExiste='S'  THEN
		
			--	Guarda en el historico
			INSERT INTO PRO_UNIDADESPORLOTE_BACKUP
			(
				PRO_ULB_IDUSUARIO,
				PRO_ULB_FECHA,
				PRO_ULB_IDPRODUCTO,
				PRO_ULB_IDCLIENTE,
				PRO_ULB_UNIDADBASICA, 
				PRO_ULB_UNIDADESPORLOTE
			)
			SELECT 
				PRO_UL_IDUSUARIO,
				PRO_UL_FECHA,
				PRO_UL_IDPRODUCTO,
				PRO_UL_IDCLIENTE,
				PRO_UL_UNIDADBASICA, 
				PRO_UL_UNIDADESPORLOTE
			FROM 	PRO_UNIDADESPORLOTE
			WHERE	PRO_UL_IDCLIENTE=p_IDCliente
			AND		PRO_UL_IDPRODUCTO=p_IDProducto;
		
			--	Actualiza la entrada
			UPDATE PRO_UNIDADESPORLOTE SET
					PRO_UL_FECHA			=SYSDATE,
					PRO_UL_UNIDADBASICA 	=p_UnidadBasica,
					PRO_UL_UNIDADESPORLOTE	=p_UnidadesPorLote
				WHERE	PRO_UL_IDCLIENTE=p_IDCliente
				AND		PRO_UL_IDPRODUCTO=p_IDProducto;
		
		ELSE
			RAISE YA_EXISTE;
		END IF;
	ELSE

		--	Crea la nueva entrada
		INSERT INTO PRO_UNIDADESPORLOTE
		(
			PRO_UL_IDUSUARIO,
			PRO_UL_FECHA,
			PRO_UL_IDPRODUCTO,
			PRO_UL_IDCLIENTE,
			PRO_UL_UNIDADBASICA, 
			PRO_UL_UNIDADESPORLOTE
		)
		VALUES
		(
			p_IDUsuario,
			SYSDATE,
			p_IDProducto,
			p_IDCliente,
			p_UnidadBasica,
			p_UnidadesPorLote
		);

	END IF;
	
	
/*	productos_pck.debug
	(
		p_IDUsuario,
		1,
		'MantenimientoProductos_PCK.NuevoEmpaquetamiento',
		p_IDProducto,
		'Nuevo empaquetamiento: udBasica:'||p_UnidadBasica||' Udes.por lote:'||p_UnidadesPorLote||' para cliente:'||p_IDCliente
	);*/

	productos_pck.debug(p_IDProducto,'Nuevo empaquetamiento. '||v_Parametros);

	RETURN 'OK';
EXCEPTION
	WHEN SIN_DERECHOS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.NuevoEmpaquetamiento',v_Parametros||' ERROR:Usuario sin derechos');
		RETURN 'ERROR';
	WHEN YA_EXISTE THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.NuevoEmpaquetamiento',v_Parametros||' AVISO:Ya existe un empaquetamiento para este producto/Cliente. No se ha guardado el cambio.');
		RETURN 'ERROR';
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.NuevoEmpaquetamiento',v_Parametros||' SQLERRM:'||SQLERRM);
		RETURN 'ERROR';
END;


--	30jul19 Permitimos modificar/crear empaquetamiento en un único paso
FUNCTION ModificarEmpaquetamiento
(
	p_IDUsuario				NUMBER,
	p_IDProducto			NUMBER,
	p_IDCliente				NUMBER,
	p_UnidadBasica			VARCHAR2,
	p_UnidadesPorLote		NUMBER
) RETURN VARCHAR2
IS
	v_UdBasica			PRODUCTOS.PRO_UNIDADBASICA%TYPE;
	v_UdesLote			PRODUCTOS.PRO_UNIDADESPORLOTE%TYPE;
	
	v_Parametros		VARCHAR2(1000);		--	9jul17
	v_Status			VARCHAR2(1000);		--	9jul17
	
BEGIN
	v_Parametros:='IDUsuario:'||p_IDUsuario||'IDProducto:'||p_IDProducto||' IDCliente:'||p_IDCliente||' UnidadBasica:'||p_UnidadBasica||' UnidadesPorLote:'||p_UnidadesPorLote;

	--	Carga los datos actuales (si existe)
	BEGIN
		SELECT 		PRO_UL_UNIDADBASICA, PRO_UL_UNIDADESPORLOTE
			INTO	v_UdBasica,v_UdesLote
			FROM	PRO_UNIDADESPORLOTE
			WHERE	PRO_UL_IDCLIENTE=p_IDCliente
			AND		PRO_UL_IDPRODUCTO=p_IDProducto;


		IF v_UdBasica<>p_UnidadBasica OR v_UdesLote<>p_UnidadesPorLote THEN
			--	Guarda en el historico
			INSERT INTO PRO_UNIDADESPORLOTE_BACKUP
			(
				PRO_ULB_IDUSUARIO,
				PRO_ULB_FECHA,
				PRO_ULB_IDPRODUCTO,
				PRO_ULB_IDCLIENTE,
				PRO_ULB_UNIDADBASICA, 
				PRO_ULB_UNIDADESPORLOTE
			)
			SELECT 
				PRO_UL_IDUSUARIO,
				PRO_UL_FECHA,
				PRO_UL_IDPRODUCTO,
				PRO_UL_IDCLIENTE,
				PRO_UL_UNIDADBASICA, 
				PRO_UL_UNIDADESPORLOTE
			FROM 	PRO_UNIDADESPORLOTE
			WHERE	PRO_UL_IDCLIENTE=p_IDCliente
			AND		PRO_UL_IDPRODUCTO=p_IDProducto;
		
			--	Actualiza la entrada
			UPDATE PRO_UNIDADESPORLOTE SET
					PRO_UL_FECHA			=SYSDATE,
					PRO_UL_UNIDADBASICA 	=p_UnidadBasica,
					PRO_UL_UNIDADESPORLOTE	=p_UnidadesPorLote
				WHERE	PRO_UL_IDCLIENTE	=p_IDCliente
				AND		PRO_UL_IDPRODUCTO	=p_IDProducto;

			v_Status:='Unidad básica ant.:'||v_UdBasica||'. Unidades Por Lote ant.:'||v_UdesLote||' ACTUALIZADO.';

		ELSE
			
			v_Status:='NO REQUIERE ACTUALIZAR.';
		
		END IF;
	EXCEPTION
		WHEN OTHERS THEN
		
			--	Crea la nueva entrada
			INSERT INTO PRO_UNIDADESPORLOTE
			(
				PRO_UL_IDUSUARIO,
				PRO_UL_FECHA,
				PRO_UL_IDPRODUCTO,
				PRO_UL_IDCLIENTE,
				PRO_UL_UNIDADBASICA, 
				PRO_UL_UNIDADESPORLOTE
			)
			VALUES
			(
				p_IDUsuario,
				SYSDATE,
				p_IDProducto,
				p_IDCliente,
				p_UnidadBasica,
				p_UnidadesPorLote
			);

			v_Status:='NUEVO EMPAQUETAMIENTO PRIVADO.';
		
	END;

	IF v_Status<>'NO REQUIERE ACTUALIZAR.' THEN
		productos_pck.debug(p_IDProducto,'Modificar empaquetamiento. '||v_Parametros||' Status:'||v_Status);
	END IF;

	RETURN 'OK';
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.ModificarEmpaquetamiento',v_Parametros||' Status:'||v_Status||' SQLERRM:'||SQLERRM);
		RETURN 'ERROR';
END;



--	Guarda la unidad basica y unidades por lote personalizados de un producto para un cliente
FUNCTION EliminarEmpaquetamiento
(
	p_IDUsuario				NUMBER,
	p_IDProducto			NUMBER,
	p_IDCliente				NUMBER,
	p_ComprobarDerechos		VARCHAR2	DEFAULT 'S'	--	Desde las licitaciones no comprobaremos derechos
) RETURN VARCHAR2
IS
	v_IDEmpresa		EMPRESAS.EMP_ID%TYPE;
	v_IDPais		EMPRESAS.EMP_IDPAIS%TYPE;

	v_UsuarioCdC	VARCHAR2(1);					--	21may19
	v_UsuarioMVM	VARCHAR2(1);					--	21may19

	v_Parametros	VARCHAR2(1000);		--	9jul17

	v_Existe		INTEGER;
	
	SIN_DERECHOS	EXCEPTION;
BEGIN
	v_Parametros:='IDUsuario:'||p_IDUsuario||'IDProducto:'||p_IDProducto||' IDCliente:'||p_IDCliente||' ComprobarDerechos:'||p_ComprobarDerechos;

	--	Comprobar derechos
	SELECT		EMP_ID, EMP_IDPAIS, NVL(US_CENTRALCOMPRAS,'N'), DECODE(US_USUARIOGERENTE,1,'S','N')
		INTO	v_IDEmpresa, v_IDPais, v_UsuarioCdC, v_UsuarioMVM
		FROM	USUARIOS, CENTROS, EMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		US_ID=p_IDUsuario;
	
	--23feb17	IF p_ComprobarDerechos='S' AND v_IDEmpresa NOT IN (Mvm.BuscarParametro(0), Mvm.BuscarParametro(2 0 0)) THEN
	--21may19	IF p_ComprobarDerechos='S' AND v_IDEmpresa<>TO_NUMBER(utilidades_pck.Parametro('IDMVM_'||v_IDPais)) THEN
	IF p_ComprobarDerechos='S' AND v_UsuarioCdC='N' AND  v_UsuarioMVM='N' THEN
		RAISE SIN_DERECHOS;
	END IF;
	
	SELECT 		count(*)
		INTO	v_Existe
		FROM	PRO_UNIDADESPORLOTE
		WHERE	PRO_UL_IDCLIENTE=p_IDCliente
		AND		PRO_UL_IDPRODUCTO=p_IDProducto;
	
	IF v_Existe>0 THEN

		--	Crea la nueva entrada
		INSERT INTO PRO_UNIDADESPORLOTE_BACKUP
		(
			PRO_ULB_IDUSUARIO,
			PRO_ULB_FECHA,
			PRO_ULB_IDPRODUCTO,
			PRO_ULB_IDCLIENTE,
			PRO_ULB_UNIDADBASICA, 
			PRO_ULB_UNIDADESPORLOTE
		)
		SELECT 
			PRO_UL_IDUSUARIO,
			PRO_UL_FECHA,
			PRO_UL_IDPRODUCTO,
			PRO_UL_IDCLIENTE,
			PRO_UL_UNIDADBASICA, 
			PRO_UL_UNIDADESPORLOTE
		FROM 	PRO_UNIDADESPORLOTE
		WHERE	PRO_UL_IDCLIENTE=p_IDCliente
		AND		PRO_UL_IDPRODUCTO=p_IDProducto;

		DELETE		PRO_UNIDADESPORLOTE
			WHERE	PRO_UL_IDCLIENTE=p_IDCliente
			AND		PRO_UL_IDPRODUCTO=p_IDProducto;

/*		productos_pck.debug
		(
			p_IDUsuario,
			3,
			'MantenimientoProductos_PCK.EliminarEmpaquetamiento',
			p_IDProducto,
			'para cliente:'||p_IDCliente
		);*/
		productos_pck.debug(p_IDProducto,'MantenimientoProductos_PCK.EliminarEmpaquetamiento. '||v_Parametros||' Eliminado.');
	ELSE
		productos_pck.debug(p_IDProducto,'MantenimientoProductos_PCK.EliminarEmpaquetamiento. '||v_Parametros||' NO EXISTE.');
	END IF;

	RETURN 'OK';
	
EXCEPTION
	WHEN SIN_DERECHOS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.EliminarEmpaquetamiento',v_Parametros||' ERROR:Usuario sin derechos');
		RETURN 'ERROR';
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.EliminarEmpaquetamiento',v_Parametros||' SQLERRM:'||SQLERRM);
		RETURN 'ERROR';
END;


--	4set13	Actualiza la fecha límite de la oferta para una tarifa
FUNCTION ActualizaFechaLimite
(
	p_IDUsuario			NUMBER,
	p_IDProducto		NUMBER,
	p_IDCliente			NUMBER,
	p_FechaLimite		VARCHAR2,
	p_Propagar			VARCHAR2	DEFAULT 'S'
) RETURN VARCHAR2
IS
	v_Res				VARCHAR2(100);
	v_Parametros		VARCHAR2(1000);
BEGIN
	--utilidades_pck.debug ('MantenimientoProductos_PCK.ActualizaFechaLimite.IDUsuario:'||p_IDUsuario||' IDProducto:'||p_IDProducto||' IDCliente:'||p_IDCliente||' FechaLimite:'||p_FechaLimite);
	v_Parametros:='IDUsuario:'||p_IDUsuario||' IDProducto:'||p_IDProducto||' IDCliente:'||p_IDCliente||' FechaLimite:'||p_FechaLimite;
	
	UPDATE		TARIFAS 
		SET 	TRF_FECHALIMITE=utilidades_pck.Fecha(p_FechaLimite)
		WHERE	TRF_IDPRODUCTO=p_IDProducto
		AND		TRF_IDCLIENTE=p_IDCliente;
		
	IF p_Propagar='S' THEN
		v_Res:=Catalogoprivado_mant_pck.ActualizaFechaLimite(p_IDUsuario, p_IDProducto, p_IDCliente, p_FechaLimite, 'N');
	ELSE
		v_Res:='OK';
	END IF;
	
	/*productos_pck.debug
	(
		p_IDUsuario,
		2,
		'MantenimientoProductos_PCK.ActualizaFechaLimite',
		p_IDProducto,
		'para cliente:'||p_IDCliente
	);*/
	
	productos_pck.debug(p_IDProducto,'MantenimientoProductos_PCK.ActualizaFechaLimite. '||v_Parametros);
	
	RETURN v_Res;
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.ActualizaFechaLimite',v_Parametros||' SQLERRM:'||SQLERRM);
		RETURN 'ERROR';
END;


--	2abr19 Comprueba que un producto no tiene precios 
FUNCTION ProductoConPrecios
(
	p_IDProducto		NUMBER
) RETURN VARCHAR2
IS
	v_Existe			NUMBER(6);
BEGIN

	SELECT		COUNT(*)
		INTO	v_Existe
		FROM	TARIFAS
		WHERE	TRF_IDPRODUCTO	=p_IDProducto;
	
	IF v_Existe=0 THEN
		RETURN 'N';
	ELSE
		RETURN 'S';
	END IF;
	
EXCEPTION
	WHEN OTHERS THEN
		Mvm.InsertDBError ('MantenimientoProductos_PCK.ProductoConPrecios','IDProducto:'||p_IDProducto||' SQLERRM:'||SQLERRM);
		RETURN 'ERROR';
END;




END;	--Package 
/

SHOW ERRORS;
EXIT;
