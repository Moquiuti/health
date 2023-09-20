CREATE OR REPLACE PACKAGE EIS_PCK IS

/*

	Package:		EIS_PCK

	Descripción:	Funciones y procedimientos necesarios para el módulo de análisis
					de indicadores del sistema

	Responsable:	Eduardo Torrellas

	Modificaciones:

	23/10/2001		Pruebas con los valores de los filtros
	27/3/2002		Creamos las tablas de resumen que aceleraran y estandarizaran las consultas
	12/9/2002		Filtro y Agrupacion por estado de oferta/pedido/incidencia
	16/9/2002		Filtro y Agrupacion por referencia de producto
	17/9/2002		Consultas predefinidas
	16/10/2002		Incluir restriccion SQL en las consultas predefinidas
	30/10/2002		Sustituimos el sistema de calculo basado en una unica consulta por una
					tabla intermedia que permite realizar los calculos de porcentajes (y
					mas adelante, ratios)
	4/11/2002		Incorporamos un grafico en formato SVG
	12/11/2002		Ratio sobre indicadores de pedidos
(*)	2/12/2002		Ratio sobre numero de camas y sobre facturacion objetivo
	4/12/2002		Corregido Error: XML mal formado al intentar presentar la lista de registros (consecuencia de cambios por los ratios)
	5/12/2002		Adaptar la altura del grafico al numero de elementos en la Leyenda
	5/12/2002		Corregido Error: En el grafico de barras aparece una serie mas de las que en realidad existen
	9/12/2002		Corregido Error: No se presentaba correctamente la ultima serie de datos NumSeries<TotalGrupos -> NumSeries<=TotalGrupos
	7/1/2003		Correcciones para el cambio de año: Acceso a traves de un desplegable de cuadros de mando sin seleccion previa
	14/1/2003		Opcion de presentar los ultimos 12 meses en lugar de un año concreto
	14/1/2003		Creamos dos campos para que usuarios no administradores puedan acceder al EIS con privilegios
						US_EIS_ACCESOGERENTE: Todos los datos
						US_EIS_ACCESOCENTRO: Todo en su centro
	22/1/2003		Incluimos el campo "familia de productos" ya que sin el fallaba el listado de registros
	22/1/2003		Definimos algunos indicadores correspondientes a la "Gestion del Catalogo Privado"
	11/2/2003		Sustituimos en EIS.sql el parametro "EMPRESA2" por el centro cliente para ofertas, pedidos e incidencias recibidos.
	13/2/2003		Las consultas predefinidas trabajan sobre los ultimos 12 meses.
	18/2/2003		La consulta por referencia debe presentar el nombre del producto
	18/2/2003		Permitir filtrar por un campo de texto
	17/3/2003		Marcamos en rojo las tendencias negativas - solo para administradores -
	18/3/2003		Agrupar y filtrar por tipo de incidencia y gravedad de la incidencia
	23/4/2003		Ficha individual para un concepto que muestra los valores, medias y posicion relativa
						Por ejemplo, permite establecer un ranking de proveedores.
					Nueva opción de presentación en la tabla de datos: Presentar la posicion relativa
	21/5/2003		A los usuarios "noveles" no se les presenta la cabecera con los filtros
	28/5/2003		Utilizamos una matriz para guardar los valores del cuadro de mando: permite un tratamiento mas
					comodo y estandarizado de los datos
	10/6/2003		Corregimos un error al presentar las graficas con  varias agrupaciones: utiliza el mayor total como maximo del eje
	30/6/2003		ActualizarIndicador2(p_IDIndicador,	p_Debug) permite guardar la consulta correspondiente al indicador
					en la tabla de logedu;
	25/8/2003		Al entrar con un usuario normal, seleccionar en el EIS pedidos por proveedor y pulsar sobre
					un proveedor, aparecen los pedidos de todos los centros
	14/10/2003		Actualizamos de forma progresiva el EIS para hacerlo mas ligero, ya que sino carga demasiado la maquina.
	29/10/2003		Resultados matriciales de pedidos por centro y proveedor, Debe permitir detectar desviaciones mas facilmente.
					(en paquete EIS_MATRIZ_PCK)
	1/12/2003		Corregido error que presenta el primer mes con los valores a 0 y el resto desplazados una columna
					hacia la derecha.
	8/1/2004		Error: en el mes de enero 2004 aparecen en el resumen cantidades mas elevadas de las correctas.
					(El listado funciona correctamente). El error venia de la actualizacion parcial que no borraba correctamente
					los datos antiguos.
	24/2/2004		Error en las lineas cuando pedidos y abonos se compensan y toda la linea esta a cero: no se presenta el total
	05/11/2004		Ponemos color rojo si el valor esta un 20% por debajo de la media, verde si esta un 20% por encima.
	10oct05			Se produce un error con la consulta de Busquedas de ConcursosSanitarios. Añadimos codigo de depuracion.
	11jul06			Incluimos un numero correlativo en la lista de resultados para facilitar el conteo
	2nov06			Localizado error en la consulta de pedidos en modo ratio por numero de pedidos
	20nov06			Permitimos filtrar por numero de docuemnto (pedido, incidencia)
	4abr07			Corregido error en los graficos causado por el "nuevo" parametro de numero de documento. El problema estaba en un fichero XSQL pero aprovecho para añadir mas info en las "exception"
	25feb08			Problemas en las consultas "por producto" cuando se ha modificado la unidad básica
	15set08			Problemas en las consultas "por referencia" cuando se ha modificado la unidad básica -> pasamos script (EIS.sql) para quitar la unidad basica de la descripcion
					Quitamos las consultas "por producto"
	12feb09	ET		Mayor protección ante errores en una alarma
	28abr09	ET		Activamos OracleText para las busquedas por palabras
	7jul09	ET		Tras quitar el filtro "por producto", que ralentiza mucho, volvemos a activarlo para usuarios con derechos especificos
	20jul09	ET		No se aplica la restricción si el filtro y la agregacion coinciden y se pulsa sobre el total.
	23feb10	ET		El grafico del EIS falla por Cocoon, utilizamos los graficos de Google
	24ago10	ET		Para la nueva versión del EIS, permitimos seleccion de grupos al llamar a "Lista de resultados"


	(*) Da errores! Hay que sustituirlo y cambiar su funcionamiento

	Temas en desarrollo:
	- Tablas de datos
	- Listas de registros
		. No se presenta bien la lista de registros cuando el EIS esta agrupado por familia de productos
	- Guardar solo las consultas base y no todos los indicadores para reducir el tiempo de refresco: requiere
	guardar todos los campos que se utilizaran como restriccion en los indicadores---> Solo reducira un 20%
	el tiempo, pasando de 25 indic. a 20 consultas base. Tambien se podrian automatizar los indicadores simetricos
	(compras vs ventas) reduciendo a casi la mitad la carga.

	Temas Pendientes
	- Guardar consultas predefinidas personalizadas
	- Permitir condiciones Y,O,NO en las consultas del EIS
	- 2 niveles de agregación
	- Comparar un indicador respecto al año anterior
	- Indicadores manuales
	- Ratios
		. Plazo medio de entrega
		. Pedidos/incidencias por numero de camas
		. Pedidos/incidencias por facturacion objetivo
		. Incidencias/Pedidos (volumen o numero)
		. Pedido medio (Volumen pedidos/numero pedidos)
		. Rotacion de stocks
		. Stock medio
	- Alarmas
	- Informes personalizados

	28abr09	ET		Activamos OracleText para las busquedas por palabras
		exec  ctx_ddl.create_preference('eis_va_text_search', 'multi_column_datastore');
		CUIDADO!!!! Ya no trabajamos con estos campos sino con EIS_VA_TEXTONORM... exec ctx_ddl.set_attribute('eis_va_text_search', 'columns', 'eis_va_familia, eis_va_refproducto, eis_va_producto');
  
  
	create index eis_va_tidx on EIS_VALORES(eis_va_refproducto)  indextype is ctxsys.context  parameters('datastore eis_va_text_search sync (on commit)'); 

	6may09	ET		OracleText da problemas con los acentos. Habrá que tener una columna normalizada.
	
		ALTER TABLE EIS_VALORES ADD EIS_VA_TEXTONORM VARCHAR2(250);
		
		UPDATE EIS_VALORES 
			SET EIS_VA_TEXTONORM = normalizar_pck.NormalizarString(eis_va_familia||' '||eis_va_refproducto||' '||eis_va_producto);


		DROP index eis_va_tidx;
		
		exec  ctx_ddl.create_preference('eis_va_text_search', 'multi_column_datastore');
		exec ctx_ddl.set_attribute('eis_va_text_search', 'columns', 'EIS_VA_TEXTONORM');
  
		create index eis_va_tidx on EIS_VALORES(eis_va_refproducto)  indextype is ctxsys.context  parameters('datastore eis_va_text_search sync (on commit)'); 
		
	
select SUBSTR(eis_va_refproducto||' '||eis_va_producto,1,70) Producto from EIS_VALORES
where c o n t a i n s(eis_va_refproducto,'SONDA'||'%',1)>0
AND UPPER(eis_va_refproducto||' '||eis_va_producto) NOT LIKE ('%SONDA%')
AND ROWNUM<20
;	
	
	
	18nov09	ET	Aparecen entradas en la tabla de ERRORES: value too large for column "MEDICALVM"."EIS_VALORESTEMPORAL"."EIS_VT_IDGRUPO"
		ALTER TABLE EIS_VALORESTEMPORAL MODIFY EIS_VT_IDGRUPO VARCHAR2(200);
	
	09dic09	ET	value too large for column "MEDICALVM"."EIS_VALORES"."EIS_VA_CODIGO" (actual: 53, maximum: 50
		ALTER TABLE EIS_VALORES  MODIFY EIS_VA_CODIGO VARCHAR2(100);
		
	
	--	8mar10	ET	Eliminamos la familia del campo normalizado para que no aparezca en las busquedas por texto
	UPDATE EIS_VALORES 
		SET EIS_VA_TEXTONORM = normalizar_pck.NormalizarString(eis_va_refproducto||' '||eis_va_producto);
	
		DROP index eis_va_tidx;	
		exec ctx_ddl.set_attribute('eis_va_text_search', 'columns', 'EIS_VA_TEXTONORM');
		create index eis_va_tidx on EIS_VALORES(eis_va_refproducto)  indextype is ctxsys.context  parameters('datastore eis_va_text_search sync (on commit)'); 



	--	27nov12	Cambiamos la normalización en la tabla de EIS_VALORES para permitir referencias con punto
	UPDATE EIS_VALORES SET 
		EIS_VA_TEXTONORM=normalizar_pck.NormalizarID(eis_va_refproducto)||' '||normalizar_pck.NormalizarString(eis_va_producto);

	ALTER INDEX eis_va_tidx REBUILD;
	
	--	21dic12	Creamos un resumen de centros para optimizar las consultas
	CREATE TABLE EIS_CENTROS
	(
		EIS_CEN_ID 						NUMBER(6), 
		EIS_CEN_IDINDICADOR	 			VARCHAR2(30), 
    	CONSTRAINT EIS_CEN_ID_PK PRIMARY KEY (EIS_CEN_ID, EIS_CEN_IDINDICADOR),
   		CONSTRAINT EIS_CEN_ID FOREIGN KEY (EIS_CEN_ID) REFERENCES CENTROS(CEN_ID),
    		CONSTRAINT EIS_CEN_IDINDICADOR FOREIGN KEY (EIS_CEN_IDINDICADOR) REFERENCES EIS_INDICADORES(EIS_IN_ID)
	);
	
	CREATE INDEX EIS_CEN_IDINDICADOR_IDX ON EIS_CENTROS(EIS_CEN_IDINDICADOR);


	ALTER TABLE EIS_CENTROS	ADD EIS_CEN_IDEMPRESA NUMBER(5);
  	ALTER TABLE EIS_CENTROS	ADD CONSTRAINT EIS_CEN_IDEMPRESA FOREIGN KEY (EIS_CEN_IDEMPRESA) REFERENCES EMPRESAS(EMP_ID);

	--	18ene13	Indice de fecha para que sea más rápido el filtrado
	--	borro la columna de prueba creada por David: ALTER TABLE EIS_VALORES DROP COLUMN EIS_VA_FECHA;
	ALTER TABLE EIS_VALORES ADD EIS_VA_INDICEFECHA DATE;
	CREATE INDEX MEDICALVM.EIS_VA_INDICEFECHA_IDX ON MEDICALVM.EIS_VALORES (EIS_VA_INDICEFECHA);
	--	18ene13	Indice de año (antes el índice era combinado año/mes)
	CREATE INDEX EIS_VA_ANNO_IDX ON EIS_VALORES (EIS_VA_ANNO);

	
	--	18ene13	Limpiamos 3 registros sin fecha informada
	SELECT EIS_VA_IDINDICADOR, EIS_VA_IDEMPRESA FROM  EIS_VALORES WHERE EIS_VA_MES IS NULL OR EIS_VA_ANNO IS NULL;
	DELETE EIS_VALORES  WHERE EIS_VA_MES IS NULL OR EIS_VA_ANNO IS NULL;

	--	18ene13	Inicializamos el índice
	UPDATE EIS_VALORES SET EIS_VA_INDICEFECHA=TO_DATE('1'||'/'||EIS_VA_MES||'/'||EIS_VA_ANNO,'dd/mm/yyyy');

	--	30abr13	Nueva tabla para listados en el excel
	DROP TABLE EIS_LISTADOS;
	CREATE TABLE EIS_LISTADOS
	(
		EIS_LS_ID				NUMBER(10),
		EIS_LS_IDLINEA			NUMBER(12),
		EIS_LS_COL01			VARCHAR2(100),
		EIS_LS_COL02			VARCHAR2(100),
		EIS_LS_COL03			VARCHAR2(100),
		EIS_LS_COL04			VARCHAR2(100),
		EIS_LS_COL05			VARCHAR2(100),
		EIS_LS_COL06			VARCHAR2(100),
		EIS_LS_COL07			VARCHAR2(100),
		EIS_LS_COL08			VARCHAR2(100),
		EIS_LS_COL09			VARCHAR2(100),
		EIS_LS_COL10			VARCHAR2(100),
		EIS_LS_COL11			VARCHAR2(100),
		EIS_LS_COL12			VARCHAR2(100),
		EIS_LS_COL13			VARCHAR2(100),
		EIS_LS_COL14			VARCHAR2(100),
		CONSTRAINT EIS_LS_ID PRIMARY KEY (EIS_LS_ID, EIS_LS_IDLINEA)
	);
	
	CREATE SEQUENCE EIS_LS_ID_SEQ START WITH 1 INCREMENT BY 1 MINVALUE 1;
	CREATE SEQUENCE EIS_LS_IDLINEA_SEQ START WITH 1 INCREMENT BY 1 MINVALUE 1;
	
	--	IMPORTANTE: EIS_VA_TIDX_SET devinido en NuevosCamposEIS.sql
	DROP INDEX EIS_VA_TIDX_SET; --> CUIDADO!!! 11ago17, el nombre pasa a ser EIS_VA_TIDX

	UPDATE 		EIS_VALORES 
		SET 	EIS_VA_TEXTONORM = normalizar_pck.NormalizarID(EIS_VA_REFPRODUCTO)||' '||normalizar_pck.NormalizarID(EIS_VA_REFPROVEEDOR)||' '||normalizar_pck.NormalizarString(EIS_VA_PRODUCTO)
		WHERE	EIS_VA_TEXTONORM<>normalizar_pck.NormalizarID(EIS_VA_REFPRODUCTO)||' '||normalizar_pck.NormalizarID(EIS_VA_REFPROVEEDOR)||' '||normalizar_pck.NormalizarString(EIS_VA_PRODUCTO)

	CREATE INDEX EIS_VA_TIDX_SET ON EIS_VALORES(EIS_VA_TEXTONORM) INDEXTYPE IS CTXSYS.CTXCAT
		PARAMETERS ('index set EIS_VA_TIDX_SET');

	--	18nov13 para pruebas de ratios
	ALTER TABLE EIS_VALORESTEMPORAL ADD EIS_VT_VALORORIGINAL    NUMBER(14,4);


	--	19may14	Tabla para acelerar el funcionamiento de los desplegables dinámicos
	CREATE TABLE EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO	VARCHAR2(10),
		EIS_DD_IDPADRE	VARCHAR2(10),
		EIS_DD_ID		VARCHAR2(100),
		EIS_DD_NOMBRE	VARCHAR2(200)
	);
	
	CREATE INDEX EIS_DD_IDTIPO_IDX ON EIS_DESPLEGABLESDINAMICOS(EIS_DD_IDTIPO);
	CREATE INDEX EIS_DD_IDPADRE_IDX ON EIS_DESPLEGABLESDINAMICOS(EIS_DD_IDPADRE);
	CREATE INDEX EIS_DD_ID_IDX ON EIS_DESPLEGABLESDINAMICOS(EIS_DD_ID);

	--	26ago14	Tabla para tareas pendientes de mantenimiento del EIS
	DROP TABLE EIS_TAREASPENDIENTES;
	CREATE TABLE EIS_TAREASPENDIENTES
	(
		EIS_TP_ID			NUMBER(12),
		EIS_TP_FECHA		DATE,
		EIS_TP_IDTIPO		VARCHAR2(100),
		EIS_TP_IDREGISTRO	NUMBER(12),
		EIS_TP_IDREGISTRO2	NUMBER(12)
	);
	CREATE SEQUENCE EIS_TP_ID_SEQ START WITH 1 INCREMENT BY 1 MINVALUE 1;

	DROP TABLE EIS_TAREASREALIZADAS;
	CREATE TABLE EIS_TAREASREALIZADAS
	(
		EIS_TR_ID			NUMBER(12),
		EIS_TR_FECHA		DATE,
		EIS_TR_FECHAINICIO	DATE,
		EIS_TR_FECHAFINAL	DATE,
		EIS_TR_IDTIPO		VARCHAR2(100),
		EIS_TR_IDREGISTRO	NUMBER(12),
		EIS_TR_IDREGISTRO2	NUMBER(12),
		EIS_TR_RESULTADO	VARCHAR2(1000)
	);
	
	CREATE INDEX EIS_TR_ID_IDX ON EIS_TAREASREALIZADAS(EIS_TR_ID);
	CREATE INDEX EIS_TR_FECHA_IDX ON EIS_TAREASREALIZADAS(EIS_TR_FECHA);
	CREATE INDEX EIS_TR_FECHAINICIO_IDX ON EIS_TAREASREALIZADAS(EIS_TR_FECHAINICIO);
*/

	TYPE ref_cursor is REF CURSOR; -- RETURN EMPRESAS%rowtype;

	TYPE TElement IS RECORD (
  	   Code NUMBER, -- Indicador
	   Filtro NUMBER,  -- ????
	   Agrupacion NUMBER,   -- Código del filtro a aplicar EIS_FILTROS
	   FiltroMan VARCHAR2(500) -- Filtro manual, separado por comillas simples
	);

	TYPE TElementTab IS TABLE OF TElement INDEX BY BINARY_INTEGER;

	TYPE TCuadroMando IS RECORD
	(
  	   ID NUMBER, 			-- ID
	   Nombre VARCHAR2(200) -- Nombre
	);

	--	Devuelve el cuadro principal del EIS en XML
	PROCEDURE	CuadroPrincipalEIS_XML
	(
		p_IDUSUARIO			VARCHAR2
	);

	--	Devuelve el estado de las alarmas en XML
	PROCEDURE	PresentaAlarmas_XML
	(
		p_IDUSUARIO			VARCHAR2,
		p_IDIdioma			NUMBER,
		p_IncluirCabecera	VARCHAR2 DEFAULT null
	);

	--	Devuelve los datos correspondientes a un cuadro de mando en formato XML
	PROCEDURE CuadroDeMando
	(
		p_IDUSUARIO				VARCHAR2,
		p_IDCUADROMANDO 		VARCHAR2,
		p_ANNO 					VARCHAR2,
		p_IDEmpresa				VARCHAR2,
		p_IDCENTRO 				VARCHAR2,
		p_IDUSUARIOSEL			VARCHAR2,
		p_IDEmpresa2			VARCHAR2,
		p_IDCENTRO2				VARCHAR2,	--16abr13
		p_IDPRODESTANDAR		VARCHAR2,
		p_IDGRUPO				VARCHAR2,	--16abr13
		p_IDSUBFAMILIA			VARCHAR2,	--16abr13
		p_IDFAMILIA				VARCHAR2,	--16abr13
		p_IDCATEGORIA			VARCHAR2,	--16abr13
		--16abr13	p_IDNOMENCLATOR			VARCHAR2,
		--16abr13	p_URGENCIA				VARCHAR2,
		p_IDESTADO				VARCHAR2,
		--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
		--16abr13	p_IDGRAVEDAD			VARCHAR2,
		p_REFERENCIA			VARCHAR2,
		p_CODIGO				VARCHAR2,
		p_AgruparPor			VARCHAR2,
		p_IDResultados			VARCHAR2,
		p_RestriccionAdicional	VARCHAR2 	DEFAULT	null,
		p_FormatoResultados		VARCHAR2	DEFAULT 'TABLADATOS',		--TABLADATOS o GRAFICO
		p_RatioSobre			VARCHAR2 	DEFAULT	null,
		p_PosicionRelativa 		VARCHAR2 	DEFAULT	null
	);
	
	--	19abr12	En lugar de hacer una consulta por desplegable, lo hacemos de una única vez, para comprobar el rendimiento
	PROCEDURE PrepararVectores
	(
		p_IDIndicador			IN VARCHAR2,
		p_IDEmpresa				IN VARCHAR2,
		p_FiltroSQL				IN VARCHAR2,
		p_VectorEmpresas		OUT vector_pck.TVector,
		p_VectorEmpresas2		OUT vector_pck.TVector,
		p_VectorEstados			OUT vector_pck.TVector,
		p_VectorCategorias		OUT vector_pck.TVector,
		p_VectorFamilias		OUT vector_pck.TVector
	);

	--	24abr13	Datos basicos de una empresa en XML
	--			En principio se utiliza para EMP_CATPRIV_CATEGORIAS, EMP_CATPRIV_GRUPOS pero aprovecho para añadir otros campos interesantes
	PROCEDURE DatosBasicosEmpresa_XML
	(
		p_IDEmpresa				NUMBER
	);

	--	12dic13 Necesitamos el ID de Indicador de un cuadro de mando
	PROCEDURE DatosCuadroMando_XML
	(
		p_IDCuadroMando			VARCHAR2
	);

	--	15abr13	Desplegable XML correspondiente a la familia 'FAM', subfamilia 'SF', grupo 'GRU' o producto estándar 'PRO'
	PROCEDURE DesplegableDinamico_XML
	(
		p_IDEmpresa				VARCHAR2,
		p_IDIndicador			VARCHAR2,
		p_FiltroSQL				VARCHAR2,
		p_IDPadre				NUMBER,
		p_Tipo					VARCHAR2,
		p_IDIdioma				NUMBER,
		p_IDUSUARIO				NUMBER DEFAULT NULL
	);

	--	Envia los desplegables necesarios para el EIS avanzado
	PROCEDURE EnviaDesplegablesCabecera_XML
	(
		p_IDUSUARIO				VARCHAR2,
		p_IDCUADROMANDO 		VARCHAR2,
		p_ANNO 					VARCHAR2,
		p_IDEmpresa				VARCHAR2,
		p_IDCENTRO 				VARCHAR2,
		p_IDUSUARIOSEL			VARCHAR2,
		p_IDEmpresa2			VARCHAR2,
		p_IDCENTRO2				VARCHAR2,	--16abr13
		p_IDPRODESTANDAR		VARCHAR2,
		p_IDGRUPO				VARCHAR2,	--16abr13
		p_IDSUBFAMILIA			VARCHAR2,	--16abr13
		p_IDFAMILIA				VARCHAR2,	--16abr13
		p_IDCATEGORIA			VARCHAR2,	--16abr13
		--16abr13	p_IDNOMENCLATOR			VARCHAR2,
		--16abr13	p_URGENCIA				VARCHAR2,
		p_IDESTADO				VARCHAR2,
		--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
		--16abr13	p_IDGRAVEDAD			VARCHAR2,
		p_REFERENCIA			VARCHAR2,
		p_CODIGO				VARCHAR2,
		p_AgruparPor			VARCHAR2,
		p_IDResultados			VARCHAR2,
		p_DerechosUsuario		VARCHAR2,
		p_FiltroSQL				VARCHAR2,
		p_RatioSobre			VARCHAR2
	);

	--	Monta la restriccion para una consulta en funcion de los filtros y agrupaciones utilizados
	FUNCTION RestriccionConsulta
	(
		p_IDUSUARIO				VARCHAR2,
		p_IDCUADROMANDO 		VARCHAR2,
		p_ANNO 					VARCHAR2,
		p_IDPAIS				VARCHAR2,		--	21nov11	Nueva restriccion por país
		p_IDEmpresa				VARCHAR2,
		p_IDCENTRO 				VARCHAR2,
		p_IDUSUARIOSEL			VARCHAR2,
		p_IDEmpresa2			VARCHAR2,
		p_IDCENTRO2				VARCHAR2,	--16abr13
		p_IDPRODESTANDAR		VARCHAR2,
		p_IDGRUPO				VARCHAR2,	--16abr13
		p_IDSUBFAMILIA			VARCHAR2,	--16abr13
		p_IDFAMILIA				VARCHAR2,	--16abr13
		p_IDCATEGORIA			VARCHAR2,	--16abr13
		--16abr13	p_IDNOMENCLATOR			VARCHAR2,
		--16abr13	p_URGENCIA				VARCHAR2,
		p_IDESTADO				VARCHAR2,
		--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
		--16abr13	p_IDGRAVEDAD			VARCHAR2,
		p_REFERENCIA			VARCHAR2,
		p_CODIGO				VARCHAR2,
		p_AgruparPor			VARCHAR2,
		p_DerechosUsuario		VARCHAR2,
		p_RestriccionAdicional	VARCHAR2	DEFAULT NULL
	) RETURN VARCHAR2;

	/*
		Realiza la consulta sobre un indicador EIS.
		Devuelve los datos en formato XML y/o en formato grafico SVG
	*/
	FUNCTION PreparaConsultaEnTablaTemporal
	(
		p_IDUSUARIO			VARCHAR2,
		p_IDCUADROMANDO		VARCHAR2,
		p_Anno				VARCHAR2,
		vFiltroSQL			VARCHAR2,
		p_AgruparPor		VARCHAR2,
		p_IDResultados		VARCHAR2,
		p_RatioSobre		VARCHAR2 	DEFAULT	null,
		p_PosicionRelativa 	VARCHAR2 	DEFAULT	null,
		p_IDEmpresa			VARCHAR2 	DEFAULT	null		--	19abr13
	) RETURN VARCHAR2;

	--	Prepara un indicador volcando los datos correspondientes en la tabla temporal
	FUNCTION IndicadorATablaTemporal
	(
		p_IDUSUARIO			VARCHAR2,
		p_IDIndicador		VARCHAR2,
		p_NombreIndicador	VARCHAR2,
		p_Anno				VARCHAR2,
		p_Agregar			VARCHAR2,
		p_FiltroSQL			VARCHAR2,
		p_AgruparPor		VARCHAR2,
		p_IDResultados		VARCHAR2,
		p_IDEmpresa			VARCHAR2
	)	RETURN NUMBER;

	--	Calcula un ratio entre dos indicadores
	PROCEDURE RatioEnTablaTemporal
	(
		p_IDOperacionM		INTEGER,
		p_IDOperacionD		INTEGER
	);

	--	Prepara un indicador en la tabla temporal informando de su posicion relativa respecto al resto de indicadores
	PROCEDURE CalculaPosicionRelativa
	(
		p_IDOperacionM		INTEGER,
		p_PosicionRelativa	VARCHAR2
	);

	--	Prepara la matriz que se utilizara para devolver los resultados en XML
	TYPE TVectorCadenas		IS TABLE OF VARCHAR2(300) INDEX BY BINARY_INTEGER;
	TYPE TVectorNumerico	IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

	PROCEDURE PrepararMatriz
	(
		p_IDUsuario			NUMBER,			--	8abr14 Para depuración
		v_SQL				VARCHAR2,
		p_Anno				VARCHAR2,
		p_AgruparPor		VARCHAR2,
		p_IDResultados		VARCHAR2,
		p_MarcarRojo		VARCHAR2,
		p_NumeroFilas		OUT INTEGER,
		p_VectorNombres		OUT TVectorCadenas,
		p_VectorValores		OUT TVectorNumerico
	);
/*
	--	Llamada desde PreparaConsultaEnTablaTemporal para devolver XML
	PROCEDURE EnviarCuadroDeMando_XML
	(
		v_SQL				VARCHAR2,
		p_Anno				VARCHAR2,
		p_AgruparPor		VARCHAR2,
		p_IDResultados		VARCHAR2,
		p_MarcarRojo		VARCHAR2
	);
*/
	--	Similar al anterior, pero trabajando con una matriz de datos en lugar de una consulta SQL
	PROCEDURE EnviarCuadroDeMando_v2_XML
	(
		p_Anno				VARCHAR2,
		p_NumeroFilas		INTEGER,
		p_VectorNombres		TVectorCadenas,
		p_VectorValores		IN OUT TVectorNumerico,
		p_MarcarRojo		VARCHAR2,
		p_IDResultados		VARCHAR2
	);

	--	30abr13	Inserta una línea en la tabla de listados
	PROCEDURE LineaAListado
	(
		p_IDListado				NUMBER,
		p_EIS_LS_COL01			VARCHAR2,
		p_EIS_LS_COL02			VARCHAR2,
		p_EIS_LS_COL03			VARCHAR2,
		p_EIS_LS_COL04			VARCHAR2,
		p_EIS_LS_COL05			VARCHAR2,
		p_EIS_LS_COL06			VARCHAR2,
		p_EIS_LS_COL07			VARCHAR2,
		p_EIS_LS_COL08			VARCHAR2,
		p_EIS_LS_COL09			VARCHAR2,
		p_EIS_LS_COL10			VARCHAR2,
		p_EIS_LS_COL11			VARCHAR2,
		p_EIS_LS_COL12			VARCHAR2,
		p_EIS_LS_COL13			VARCHAR2,
		p_EIS_LS_COL14			VARCHAR2
	);
	
	--	30abr13	Inserta una línea con una cadena de texto en la tabla de listados
	PROCEDURE LineaTextoAListado
	(
		p_IDListado				NUMBER,
		p_Texto					VARCHAR2
	);
	
	--	30abr13	Inserta una línea vacía en la tabla de listados
	PROCEDURE LineaTituloAListado
	(
		p_IDListado				NUMBER,
		p_Titulo				VARCHAR2,
		p_Anno					INTEGER,
		p_Mes					INTEGER	
	);
	
	--	30abr13 Guarda en la tabla temporal el resultado de la consulta
	PROCEDURE PrepararListado_Excel
	(
		p_IDUsuario			NUMBER,
		p_Anno				VARCHAR2,
		p_NumeroFilas		INTEGER,
		p_VectorNombres		TVectorCadenas,
		p_VectorValores		IN OUT TVectorNumerico,			--	Para poder modificar el vector (ratio de dias laborables) debe ser de entrada/salida
		p_IDResultados		VARCHAR2
	);


	--	Devuelve el XML correspondiente a las posiciones relativas de los conceptos
	PROCEDURE EnviarCuadro_Posiciones_XML
	(
		v_SQL				VARCHAR2,
		p_Anno				VARCHAR2,
		p_AgruparPor		VARCHAR2,
		p_IDResultados		VARCHAR2,
		p_MarcarRojo		VARCHAR2
	);

	/*²4feb11	Sustituidos graficos SVG por graficos Google
	--	Llamada desde PreparaConsultaEnTablaTemporal para devolver SVG
	PROCEDURE EnviarCuadroDeMando_SVG
	(
		p_IDUSUARIO			VARCHAR2,
		p_SQL				VARCHAR2,
		p_Anno				VARCHAR2,
		p_AgruparPor		VARCHAR2,
		p_IDResultados		VARCHAR2,
		p_TipoGrafico 		VARCHAR2	DEFAULT 'BARRAS2D'
	);*/

	--
	--  Registro de resultado de la consulta del EIS
	--

	TYPE TRegEIS IS RECORD
	(
		Indicador			VARCHAR2(100),
		IDIndicador			VARCHAR2(100),
		Grupo				VARCHAR2(100),	-- Necesario para el resultado de las consultas con agrupacion
		IDGrupo 			VARCHAR2(200),	--	25feb08	ET concatenamos ID + Nombre para crear IDGRUPO
		Anno 				NUMBER,
		Mes 				NUMBER,
		Total 				VARCHAR2(100),	-- 30/10/2002 ET: Pasamos el resultado formateado, antes: NUMBER
		TotalNumero			NUMBER
	);


	--	Lista XML de resultados de una consulta
	PROCEDURE ListaResultados
	(
		p_IDUSUARIO				VARCHAR2,
		p_IDIndicador			VARCHAR2,
		p_ANNO 					VARCHAR2,
		p_MES 					VARCHAR2,
		p_IDEmpresa				VARCHAR2,
		p_IDCENTRO 				VARCHAR2,
		p_IDUSUARIOSEL			VARCHAR2,
		p_IDEmpresa2			VARCHAR2,
		p_IDCENTRO2				VARCHAR2,	--16abr13
		p_IDPRODUCTOESTANDAR	VARCHAR2,
		p_IDGRUPOCAT			VARCHAR2,	--16abr13
		p_IDSUBFAMILIA			VARCHAR2,	--16abr13
		p_IDFAMILIA				VARCHAR2,	--16abr13
		p_IDCATEGORIA			VARCHAR2,	--16abr13
		--16abr13	p_IDNOMENCLATOR			VARCHAR2,
		--16abr13	p_URGENCIA				asisaVARCHAR2,
		p_IDESTADO				VARCHAR2,
		--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
		--16abr13	p_IDGRAVEDAD			VARCHAR2,
		p_REFERENCIA			VARCHAR2,
		p_CODIGO				VARCHAR2,
		p_AgruparPor			VARCHAR2,
		p_IDSeleccionActual		VARCHAR2
	);


	--	Llamada a una Consulta predefinida
	PROCEDURE	ConsultaPredefinida
	(
		p_IDUSUARIO			VARCHAR2,
		p_IDCONSULTA		VARCHAR2,
		p_IDEmpresa			VARCHAR2 DEFAULT NULL,
		p_REFERENCIA		VARCHAR2 DEFAULT NULL
	);

	--
	--  Registro de resultado de la consulta de filtros
	--
	TYPE TRegFiltro IS RECORD
	(
		ID 			VARCHAR2(100),
		Nombre 		VARCHAR2(1000)
	);

	--	Actualiza todos los indicadores del EIS
	PROCEDURE	ActualizarResumenEIS
	(
		p_Periodo	INTEGER DEFAULT NULL
	);


	--	Actualiza un indicador del EIS
	PROCEDURE	ActualizarIndicador
	(
		p_IDIndicador	VARCHAR2,
		p_Periodo		INTEGER DEFAULT NULL,
		p_Limpiar		VARCHAR2 DEFAULT 'S'
	);
/*
	--	Version revisada de la funcion anterior
	PROCEDURE	ActualizarIndicador2
	(
		p_IDIndicador	VARCHAR2,
		p_Debug			VARCHAR2	DEFAULT 'N'
	);*/

	--	12abr13	Nuevos niveles del cat.priv., ID y Nombre
	--	19abr13	Referencias correspondientes al cat.priv.
	PROCEDURE	InsertarValor
	(
		--	Indicador
		p_IDINDICADOR			VARCHAR2,
		p_IDDocumento			VARCHAR2,		--	6may13
		--	Mes y año
		p_MES					VARCHAR2,
		p_ANNO					VARCHAR2,
		p_CODIGO				VARCHAR2,
		p_IDPAIS				VARCHAR2,		--	21nov11
		p_IDEmpresa				VARCHAR2,
		p_EMPRESA				VARCHAR2,
		p_IDCENTRO				VARCHAR2,
		p_CENTRO				VARCHAR2,
		p_IDUSUARIO				VARCHAR2,
		p_USUARIO				VARCHAR2,
		p_IDEmpresa2			VARCHAR2,	--Proveeedor en Compras, Cliente en Ventas
		p_EMPRESA2				VARCHAR2,
		p_IDCentro2				VARCHAR2,  						--10abr13
		p_Centro2				VARCHAR2,  			--10abr13
		p_IDProductoEstandar	VARCHAR2, 				--10abr13
		--19abr13	p_REFPRODUCTO			VARCHAR2,
		p_IDPRODUCTO			VARCHAR2,
		p_PRODUCTO				VARCHAR2,
		p_RefProveedor			VARCHAR2, 			--10abr13
		--19abr13	p_IDFAMILIA			VARCHAR2,
		--19abr13	p_FAMILIA			VARCHAR2,
		--19abr13	p_IDNOMENCLATOR		VARCHAR2,
		--19abr13	p_CCNOMENCLATOR		VARCHAR2,
		--19abr13	p_IDURGENCIAS		VARCHAR2,
		--19abr13	p_URGENCIAS			VARCHAR2,
		p_IDESTADO				VARCHAR2,
		p_ESTADO				VARCHAR2,
		--10abr13	p_IDTipoIncidencia		VARCHAR2,
		--10abr13	p_TipoIncidencia		VARCHAR2,
		--10abr13	p_IDGravedadIncidencia	VARCHAR2,
		--10abr13	p_GravedadIncidencia	VARCHAR2,
		--	Valor de la celda
		p_VALOR					VARCHAR2,
		p_IDDIVISA				VARCHAR2	-- -1 si no es un importe monetario
	);

	FUNCTION	FechaActualizacionEIS	RETURN VARCHAR2;

	--	Devuelve el nombre de un cuadro de mando
	FUNCTION	NombreCuadroMando
	(
		p_IDCuadro 				VARCHAR2,
		p_IDIdioma 				VARCHAR2
	)	RETURN VARCHAR2;

	--	Retraso en dias de un pedido
	FUNCTION	RetrasoPedido
	(
		p_FECHAENTREGA		DATE,
		p_FECHAENTREGAREAL	DATE
	)	RETURN NUMBER;

	--	6feb12	Corrige las descripciones de productos en el EIS que pudieran dar lugar a errores
	--	19ago15	PROCEDURE	CorregirDatosEIS;

	--	3may12	Corrige las familias de productos en el EIS que pudieran dar lugar a errores
	--	19ago15	PROCEDURE CorregirFamiliasEIS;

	--	21dic12	Creamos una tabla de resumen de los centros informados por indicador ya que en los informes de rendimiento esta consulta penaliza mucho
	PROCEDURE ResumenCentros
	(
		p_IDIndicador		VARCHAR2
	);

	--	21dic12	Creamos una tabla de resumen de los centros informados para todos los indicadores
	PROCEDURE ResumenCentros;


	--	25abr13 Devuelve un desplegable bloqueado, para simplificar la construccion de la cabecera del EIS
	PROCEDURE DesplegableBloqueado_XML
	(
		p_Control		VARCHAR2,
		p_Etiqueta		VARCHAR2
	);

	--	16ene14 Guarda la selección de un usuario
	PROCEDURE GuardarSeleccion_XML
	(
		p_IDUsuario			VARCHAR2,
		p_IDEmpresa			VARCHAR2,			--	Solo cuando la seleccion sea pública para todos los usuarios de la empresa
		p_Nombre			VARCHAR2,			--	Nombre de la selección
		p_Tipo				VARCHAR2,
		p_Seleccion			VARCHAR2,			--	IDs separados por '|'
		p_Excluir			VARCHAR2 DEFAULT NULL
	);

	--	16ene14 Borra la selección de un usuario
	PROCEDURE BorrarSeleccion_XML
	(
		p_IDUsuario			NUMBER,
		p_IDSeleccion		NUMBER
	);

	--	12feb14	Controla errores en las linasisaeas de pedido a nivel de la catalogación
	PROCEDURE RevisarLineasPedidos
	(
		p_Dias		INTEGER
	);

	--	20may14	prepara la tabla para acelerar los desplegables dinámicos
	PROCEDURE PrepararDesplegablesDinamicos;

	--	26ago14	Tareas para procesar durante el proceso batch, antes del cálculo de los indicadores
	PROCEDURE PrepararTarea
	(
		p_IDTipo			VARCHAR2,
		p_IDRegistro		NUMBER,
		p_IDRegistro2		NUMBER	 DEFAULT NULL
	);

	--	26ago14	Eejcutar tareas (durante el proceso batch, antes del cálculo de los indicadores)
	PROCEDURE EjecutarTareas;

	--	26ago14	Eejcutar tareas (durante el proceso batch, antes del cálculo de los indicadores)
	FUNCTION EjecutarTarea
	(
		p_IDTipo			VARCHAR2,
		p_IDRegistro		NUMBER,
		p_IDRegistro2		NUMBER	 DEFAULT NULL
	) RETURN VARCHAR2;

	--	16feb15 Comprueba si el año actual está en la tabla de anyos, si no lo inserta
	PROCEDURE ControlCambioAnyo;
	
	--	16abr13	Año a partir del cual activamos las funciones avanzadas
	c_AnnoFuncionesAvanzadas		NUMBER(4):=2012;
END;
/
SHOW ERRORS;































































































































































































CREATE OR REPLACE PACKAGE BODY EIS_PCK AS

/*
	PROCEDURE	CuadroPrincipalEIS_XML

	Devuelve en XML la lista de consultas predefinidas

	13jul09	Añadimos la consulta de ahorro por cambios de precios SOLO PARA MVM
	06jun11	Consultas precalculadas de la matriz del EIS (solo usuarios MVM)
	15mar13	Añadimos la matriz para Brasil
	18feb14	Añadimos la tabla por años para MVM y empresas con más de 2 años de históricos
	2ene15	Añadimos los graficos de seguimiento del mes y del año
	15feb17 Usuarios MULTICENTRO

*/
PROCEDURE	CuadroPrincipalEIS_XML
(
	p_IDUSUARIO			VARCHAR2
)
IS
	CURSOR cGruposConsultas(p_ROL VARCHAR2, IDIdioma NUMBER) IS
		SELECT 		EIS_GCP_ID, DECODE(IDIdioma,0,EIS_GCP_NOMBRE,2,EIS_GCP_NOMBRE_BR,EIS_GCP_NOMBRE) NOMBRE
			FROM 	EIS_GRUPOSCONSULTAS
			WHERE	((EIS_GCP_ROL=P_ROL) OR (P_ROL='MVM') OR (P_ROL='MVMB'))
			ORDER BY	EIS_GCP_ORDEN;

	CURSOR cListaConsultas(IDGrupo VARCHAR2, ConIVA VARCHAR2, p_Derechos VARCHAR2, IDIdioma NUMBER) IS
		SELECT 		EIS_CP_ID, DECODE(IDIdioma,0,EIS_CP_NOMBRE,2,EIS_CP_NOMBRE_BR,EIS_CP_NOMBRE) NOMBRE
			FROM 	EIS_CONSULTASPREDEFINIDAS
			WHERE	EIS_CP_IDGRUPO=IDGrupo
			AND		((EIS_CP_TIPO<>'MVM') OR (p_Derechos='MVM') OR (p_Derechos='MVMB'))
			AND		((EIS_CP_SOLOCONIVA IS NULL) OR (EIS_CP_SOLOCONIVA=ConIVA))
			AND		((EIS_CP_SOLOSINIVA IS NULL) OR (EIS_CP_SOLOSINIVA<>ConIVA))
			ORDER BY	EIS_CP_ORDEN;

	CURSOR cConsultasMatriz(IDPais NUMBER) IS
		SELECT 		EIS_MP_ID, EIS_MP_NOMBRE,EIS_MP_TOTAL_ACTUAL,EIS_MP_TOTAL_HIST, EIS_MP_TOTAL_ASISA, EIS_MP_CASILLASUTILIZADAS
			FROM 	EIS_MAT_PREDEFINIDAS
			WHERE	EIS_MP_IDPAIS=IDPais	--	18mar13
			ORDER BY	EIS_MP_ORDEN;


	v_Anno				VARCHAR2(4);
	v_Texto				VARCHAR2(3000);
	vFiltroSQL			VARCHAR2(3000);
	v_DerechosUsuario	VARCHAR2(100);
	v_Rol		VARCHAR2(100);
	v_IDCONSULTA		EIS_CONSULTASPREDEFINIDAS.EIS_CP_ID%TYPE;
	v_SQL				VARCHAR2(3000);
	v_Variacion			NUMBER(14,4);
	v_Penetracion		NUMBER(14,4);
	TYPE TRegResultado IS RECORD
	(
		Total 			NUMBER
	);
	v_cur 				REF_CURSOR;
	v_reg 				TRegResultado;
	v_IDIdioma			USUARIOS.US_IDIDIOMA%TYPE;				--	4nov11
	v_IDEmpresa			EMPRESAS.EMP_ID%TYPE;					--	18feb14
	v_IDPais			EMPRESAS.EMP_IDPAIS%TYPE;				--	18mar13
	v_PreciosConIva		EMPRESAS.EMP_PRECIOSCONIVA%TYPE;		--	9oct13

	v_IDMVM				EMPRESAS.EMP_ID%TYPE:=utilidades_pck.Parametro('ID_MVM');
	v_IDMVMB			EMPRESAS.EMP_ID%TYPE:=utilidades_pck.Parametro('ID_MVMB');
	
	v_CdC				USUARIOS.US_CENTRALCOMPRAS%TYPE;		--	24feb14
	v_Admin				VARCHAR2(1);							--	14ene15
	v_EISEmpresa		VARCHAR2(1);							--	15ene15

	v_PreciosHistPorCentro		VARCHAR2(1);					--	25may15
BEGIN

	--
	--	Falta comprobar los derechos del usuario
	--
	v_Anno:=to_char(SYSDATE,'yyyy');
	v_DerechosUsuario	:=USUARIOS_PCK.DerechosUsuarioEIS(p_IDUSUARIO);

	--	18mar13	Cargamos todos los datos en una única petición
	--v_Rol			:=Utilidades_PCK.RolEmpresaDelUsuario(p_IDUSUARIO);
	--v_IDIdioma			:=USUARIOS_PCK.IDIdioma(p_IDUSUARIO);
	SELECT		EMP_ID, EMP_IDPAIS, TE_ROL, US_IDIDIOMA, NVL(EMP_PRECIOSCONIVA,'N'),NVL(US_CENTRALCOMPRAS,'N'), DECODE(US_USUARIOGERENTE,1,'S','N'), NVL(US_EIS_ACCESOGERENTE,'N'),
				NVL(EMP_PRECIOSHISTPORCENTRO,'N')
		INTO	v_IDEmpresa, v_IDPais, v_Rol, v_IDIdioma, v_PreciosConIva,v_CdC, v_Admin, v_EISEmpresa,
				v_PreciosHistPorCentro
		FROM	USUARIOS, CENTROS, EMPRESAS, TIPOSEMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		EMP_IDTIPO=TE_ID
		AND		US_ID=p_IDUSUARIO;
	

	HTP.P(	Utilidades_PCK.CabeceraXML
		||	'<CUADROPRINCIPALEIS>'
		||	'<ROL>'			||	v_Rol		||	'</ROL>'
		||	'<IDEMPRESA>'	||	v_IDEmpresa	||	'</IDEMPRESA>'		--	26mar15
		||	'<IDPAIS>'		||	v_IDPais	||	'</IDPAIS>'			--	13mar15
		||	'<IDIDIOMA>'	||	v_IDIdioma	||	'</IDIDIOMA>'		--	13mar15
		);
		
	IF v_CdC='S' THEN
		HTP.P('<CDC/>');
	END IF;
		
	IF v_Admin='S' THEN
		HTP.P('<ADMIN/>');
	END IF;

	--	15ene15
	IF v_EISEmpresa='S' THEN
		HTP.P('<EIS_EMPRESA/>');
	END IF;

	--	25may15
	IF v_PreciosHistPorCentro='S' THEN
		HTP.P('<TIENE_HISTORICOS_POR_CENTRO/>');
	END IF;

	--	28feb12	Para los usuarios MVM mostramos el icono que permite abrir el EIS en pestaña, útil para TV en sala de reuniones
	--16jul14	IF (v_DerechosUsuario='MVM') OR (v_DerechosUsuario='MVMB') THEN
	--15feb17	IF v_IDEmpresa IN (v_IDMVM, v_IDMVMB) THEN
	IF (v_DerechosUsuario='MVM') THEN
		HTP.P('<PRESENTARENLACEALTERNATIVO/>');

		--	22ago14	Como estas consultas son lentas las abriremos con ajax
		--	22ago14	EISSeguimiento_PCK.InfoDia_XML(p_IDUSUARIO);
		--	22ago14	EISSeguimiento_PCK.ClientesSeleccionados_XML(p_IDUSUARIO);
	END IF;
	
	PresentaAlarmas_XML(p_IDUSUARIO, v_IDIdioma);


	HTP.P('<LISTACONSULTAS>');
	FOR Grupo IN cGruposConsultas(v_Rol,v_IDIdioma) LOOP
		--	Devuelve el XML de cada grupo
		HTP.P(			'<GRUPO>'
					||	'<ID>'				||	Grupo.EIS_GCP_ID			||'</ID>'
					||	'<NOMBRE>'			||	MVM.ScapeHTMLString(Grupo.NOMBRE)		||'</NOMBRE>');
		FOR Consulta IN cListaConsultas(Grupo.EIS_GCP_ID, v_PreciosConIva, v_DerechosUsuario, v_IDIdioma) LOOP

			--	Devuelve el XML de cada consulta
			HTP.P(			'<CONSULTA>'
						||	'<ID>'				||	Consulta.EIS_CP_ID			||'</ID>'
						||	'<NOMBRE>'			||	MVM.ScapeHTMLString(Consulta.NOMBRE)		||'</NOMBRE>'
						||	'</CONSULTA>');

		END LOOP;
		HTP.P('</GRUPO>');
	END LOOP;
	HTP.P('</LISTACONSULTAS>');

	--	6jun11 	Para MVM, consultas precalculadas en la matriz del EIS
	--	26ene12	Para MVMB por ahora no mostramos la matriz, hasta que la tengamos montada
	--IF (v_DerechosUsuario='MVM') OR (v_DerechosUsuario='MVMB') THEN
	IF (v_DerechosUsuario='MVM') /*OR (v_DerechosUsuario='MVMB')*/ THEN
		HTP.P('<MVM/>'
			||'<CUADRO_AVANZADO/>');

		-- 2ene15 Actualizamos  los datos del día en curso
		EISResumenConsumo_PCK.ActualizarResumenDiario(0,1);

		-- 2ene15 Resumen de actividad de los últimos 30 días
		HTP.P('<RESUMENES_DIARIOS>');
		EISSeguimiento_PCK.IndicadoresResumen_XML(v_IDPais,0,'DIARIO',v_IDIdioma);
		--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,0,'COMPRAS');
		--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,0,'NUMPEDIDOS');
		--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,0,'CONTROLPEDIDOS');
		--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,0,'CATALOGOS');
		HTP.P('</RESUMENES_DIARIOS>');
		-- 2ene15 Resumen de actividad de los últimos 12 meses
		HTP.P('<RESUMENES_MENSUALES>');
		EISSeguimiento_PCK.IndicadoresResumen_XML(v_IDPais,0,'MENSUAL',v_IDIdioma);
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'COMPRAS');
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'AHORRO');
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'NUMPEDIDOS');
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'CONTROLPEDIDOS');
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'PED_RETRASADOS');
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'PED_URGENTES');
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'INC_FUERAPLAZO');
		--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,0,'CATALOGOS');
		HTP.P('</RESUMENES_MENSUALES>');

		HTP.P(	'<'||v_DerechosUsuario||'/>');
		/*
		HTP.P( '<LISTACONSULTASMATRIZ>');
		FOR Consulta IN cConsultasMatriz(v_IDPais) LOOP
		
			--	Devuelve el XML de cada consulta
			HTP.P(		'<CONSULTA>'
						||	'<ID>'					||	Consulta.EIS_MP_ID								||'</ID>'
						||	'<NOMBRE>'				||	MVM.ScapeHTMLString(Consulta.EIS_MP_NOMBRE)		||'</NOMBRE>'
						||	'<CASILLASUTILIZADAS>'	||	Consulta.EIS_MP_CASILLASUTILIZADAS				||'</CASILLASUTILIZADAS>'
						||	'<TOTAL_ACTUAL>'		||	Consulta.EIS_MP_TOTAL_ACTUAL					||'</TOTAL_ACTUAL>'
						||	'<TOTAL_HIST>'			||	Consulta.EIS_MP_TOTAL_HIST						||'</TOTAL_HIST>');
			
			IF Consulta.EIS_MP_TOTAL_HIST>0 THEN
				v_Variacion:=100*(Consulta.EIS_MP_TOTAL_ACTUAL-Consulta.EIS_MP_TOTAL_HIST)/Consulta.EIS_MP_TOTAL_HIST;
				HTP.P('<VARIACION>'|| FLOOR(v_Variacion)||'</VARIACION>');	
			ELSE
				HTP.P('<VARIACION>?</VARIACION>');	
			END IF;			

			IF Consulta.EIS_MP_TOTAL_ASISA>0 THEN
				v_Penetracion:=100*Consulta.EIS_MP_TOTAL_ACTUAL/Consulta.EIS_MP_TOTAL_ASISA;
				HTP.P('<PENETRACION>'|| FLOOR(v_Penetracion)||'</PENETRACION>');	
			ELSE
				HTP.P('<PENETRACION>?</PENETRACION>');	
			END IF;			
						
			HTP.P('</CONSULTA>');		

		END LOOP;
		HTP.P('</LISTACONSULTASMATRIZ>');
		*/
	ELSE

		--	Para usuarios admin empresa o CDC de COMPRADORES mostramos también estadísticas de actividad
		IF (v_DerechosUsuario='EMPRESA' OR v_CdC='S' OR (v_DerechosUsuario='MULTICENTROS')) AND (v_Rol='COMPRADOR') THEN

			HTP.P('<CUADRO_AVANZADO/>');

			-- 2ene15 Actualizamos  los datos del día en curso
			EISResumenConsumo_PCK.ActualizarResumenDiario(v_IDEmpresa,1);

			-- 2ene15 Resumen de actividad de los últimos 30 días
			HTP.P('<RESUMENES_DIARIOS>');
			EISSeguimiento_PCK.IndicadoresResumen_XML(v_IDPais,v_IDEmpresa,'DIARIO',v_IDIdioma);
			--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,v_IDEmpresa,'COMPRAS');
			--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,v_IDEmpresa,'NUMPEDIDOS');
			--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,v_IDEmpresa,'CONTROLPEDIDOS');
			--27feb15	EISSeguimiento_PCK.ResumenDiario_XML(v_IDPais,v_IDEmpresa,'CATALOGOS');
			HTP.P('</RESUMENES_DIARIOS>');
			-- 2ene15 Resumen de actividad de los últimos 12 meses
			HTP.P('<RESUMENES_MENSUALES>');
			EISSeguimiento_PCK.IndicadoresResumen_XML(v_IDPais,v_IDEmpresa,'MENSUAL',v_IDIdioma);
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'COMPRAS');
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'AHORRO');
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'NUMPEDIDOS');
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'CONTROLPEDIDOS');
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'PED_RETRASADOS');
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'PED_URGENTES');
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'INC_FUERAPLAZO');
			--27feb15	EISSeguimiento_PCK.ResumenMensual_XML(v_IDPais,v_IDEmpresa,'CATALOGOS');
			HTP.P('</RESUMENES_MENSUALES>');

		END IF;
	
	END IF;	
	
	IF (v_DerechosUsuario='MVM' /*OR v_DerechosUsuario='MVMB'*/ OR v_DerechosUsuario='EMPRESA' OR (v_DerechosUsuario='MULTICENTROS'))  THEN
		HTP.P(	'<ADMINISTRADOR Tipo="'||v_DerechosUsuario ||'"/>');

		IF (v_Rol='COMPRADOR') THEN
			HTP.P('<PRESENTARMATRIZ/>');
		END IF;
	END IF;
	
	--	30mar15 Devolvemos el desplegable con informes autorizados para usuarios MVM, ADMIN, CDC o con derechos sobre la EMPRESA
	IF (v_Rol='COMPRADOR') AND (v_DerechosUsuario='MVM' /*OR v_DerechosUsuario='MVMB'*/ OR v_DerechosUsuario='EMPRESA' OR v_Admin='S' OR v_CdC='S' OR (v_DerechosUsuario='MULTICENTROS')) THEN
		EISSeguimiento_PCK.DesplegableInformes_XML(v_IDPais,v_IDEmpresa,NULL);
	END IF;
	

	--	24feb14	Cuadro de análisis por años: usuarios MVM, admin de empresa y cdc de proveedores y clientes
	IF v_DerechosUsuario='MVM' /* OR v_DerechosUsuario='MVMB' */
		OR ((v_DerechosUsuario='EMPRESA' OR v_CdC='S'  OR (v_DerechosUsuario='MULTICENTROS')) AND (v_Rol='COMPRADOR') AND (EIS_ANUAL_PCK.TieneResumenAnual(v_IDEmpresa)='S'))
		OR ((v_DerechosUsuario='EMPRESA') AND (v_Rol='VENDEDOR'))  THEN
		HTP.P('<PRESENTARINFORMEANUAL/>');
	END IF;
	--pruebas!	IF p_IDUSUARIO IN (1,17008,10466,15886 ) THEN
	--pruebas!		HTP.P('<PRESENTARINFORMEANUAL/>');
	--pruebas!	END IF;
	
	HTP.P('</CUADROPRINCIPALEIS>');

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.CuadroPrincipalEIS_XML','IDUSUARIO:'||p_IDUSUARIO||' SQLERRM:'||sqlerrm);
END;


/*
	PROCEDURE	PresentaAlarmas_XML

	Devuelve en XML la lista de alarmas activas
	
	12feb09	ET	Mayor protección ante errores en una alarma
				Utilizamos Bind Variables para mejor rendimiento
	2mar10	ET	Permitimos alarmas solo para MVM
				Evitamos que en MVM las alarmas se muestren por duplicado
	3mar10	ET	Carla necesita las alarmas por duplicado, las volvemos a incluir
	4nov11	ET	Alarmas en portugués para usuarios de Brasil
	26ene12	ET	Filtranos por PAIS
	12dic14	ET	Modificamos las alarmas para utilizar vistas, creamos campo para saber donde está IDPAIS, creamos campo para indicar "alarmas positivas"
	24dic14	ET	Nuevas alarmas de licitaciones, evaluaciones, incidencias en productos y solicitudes de catalogación
*/
PROCEDURE	PresentaAlarmas_XML
(
	p_IDUSUARIO			VARCHAR2,
	p_IDIdioma			NUMBER,
	p_IncluirCabecera	VARCHAR2 DEFAULT null
)
IS

	CURSOR cAlarmas(IDIdioma NUMBER) IS
		SELECT 		EIS_ALARMAS.*, DECODE(IDIdioma,0, EIS_AL_MENSAJE,2,NVL(EIS_AL_MENSAJE_BR,EIS_AL_MENSAJE),EIS_AL_MENSAJE) MENSAJE
			FROM 	EIS_ALARMAS
			WHERE 	EIS_AL_STATUS IS NULL	--para pruebas con una alarma dada		AND EIS_AL_ID='VEN_PEDIDOSNOCOBRADOS';
			ORDER BY EIS_AL_ID;

	/*
	
	ALTER TABLE ALARMAS ADD EIS_AL_ROL	VARCHAR2(10);
	
	SELECT	EIS_AL_ID||':'||SUBSTR(EIS_AL_MENSAJE,1,60)
		FROM 	EIS_ALARMAS
		WHERE	EIS_AL_MENSAJE_BR IS NULL
		ORDER BY EIS_AL_ID;
		
	UPDATE EIS_ALARMAS SET EIS_AL_ROL='COMPRADOR'
		WHERE	EIS_AL_ID LIKE 'COM%';
			
		
		*/
	v_Texto				VARCHAR2(3000);
	v_DerechosUsuario	VARCHAR2(100);
	v_SQL				VARCHAR2(3000);
	TYPE TRegResultado IS RECORD
	(
		Total 			NUMBER
	);
	v_cur 				REF_CURSOR;
	v_reg 				TRegResultado;

	v_ID				NUMBER(10);
	v_Debug				VARCHAR2(3000);
	v_SaltarAlarma		VARCHAR2(1);					--2mar10
	
	v_AlarmasActivas	INTEGER:=0;						--23dic14	Mostramos contador de alarmas activas	
BEGIN

	v_DerechosUsuario:=USUARIOS_PCK.DerechosUsuarioEIS(p_IDUSUARIO);

	IF p_IncluirCabecera='S' THEN
		HTP.P(Utilidades_PCK.CabeceraXML);
	END IF;

	HTP.P('<ALARMAS>');

	FOR Alarma IN cAlarmas(p_IDIdioma) LOOP
		v_SaltarAlarma	:='N';
		v_SQL			:= Alarma.EIS_AL_CONSULTA;

		v_Debug:='Alarma:'||Alarma.EIS_AL_ID||' IDUsuario='||p_IDUSUARIO||' derechos:'||v_DerechosUsuario||'.';

		--	Aplica un filtro segun los derechos del usuario
		
		IF Alarma.EIS_AL_RESTRICCION_ADMIN='SOLO_MVM' THEN
			v_Debug:=v_Debug||'SQL para SOLO_MVM.';
			IF v_DerechosUsuario='MVM' OR v_DerechosUsuario='MVMB' THEN
				--	Admin MVM, no hay restricciones: controla todos los pedidos pendientes de recibir
				null;
			ELSE
				v_SaltarAlarma:='S';
			END IF;
		ELSE
			IF v_DerechosUsuario='MVM' THEN
				v_Debug:=v_Debug||'SQL para MVM.';
				--	4abr14	El siguiente código estaba comentado, pero lo reactivamos para quitar las alarmas de ventas para usuarios MVM
				IF SUBSTR(Alarma.EIS_AL_ID,1,4)='VEN_' THEN	--	quitamos alarmas de ventas
					v_SaltarAlarma:='S';
				END IF;
				--	Admin MVM, no hay restricciones: controla todos los pedidos pendientes de recibir
				--	12dic14	v_SQL:=v_SQL||' AND MO_IDCLIENTE IN (SELECT EMP_ID FROM EMPRESAS WHERE EMP_IDPAIS=34)';
				v_SQL:=v_SQL||' AND IDPAIS=34';

			/*ELSIF v_DerechosUsuario='MVMB' THEN
				v_Debug:=v_Debug||'SQL para MVMB.';
				IF SUBSTR(Alarma.EIS_AL_ID,1,4)='VEN_' THEN	--	quitamos alarmas de ventas
					v_SaltarAlarma:='S';
				END IF;

				--	12dic14	v_SQL:=v_SQL||' AND MO_IDCLIENTE IN (SELECT EMP_ID FROM EMPRESAS WHERE EMP_IDPAIS=55)';
				v_SQL:=v_SQL||' AND IDPAIS=55';*/

			ELSIF v_DerechosUsuario='EMPRESA' THEN
				--	Admin de empresa
				v_Debug:=v_Debug||'SQL para EMPRESA.';
				v_SQL:=	v_SQL || REPLACE(Alarma.EIS_AL_RESTRICCION_ADMIN,'#IDEMPRESA#',':ID');	--UTILIDADES_PCK.EmpresaDelUsuario(p_IDUSUARIO));
				v_ID:=UTILIDADES_PCK.EmpresaDelUsuario(p_IDUSUARIO);
			--	PENDIENTE	ELSIF v_DerechosUsuario='MULTICENTROS' THEN
			--
			--
			--
			ELSIF v_DerechosUsuario='CENTRO' OR v_DerechosUsuario='MULTICENTROS' THEN
				--	Admin de centro
				v_Debug:=v_Debug||'SQL para CENTRO.';
				v_SQL:=	v_SQL || REPLACE(Alarma.EIS_AL_RESTRICCION_ADMINCEN,'#IDCENTRO#',':ID');	--UTILIDADES_PCK.CentroDelUsuario(p_IDUSUARIO));
				v_ID:=UTILIDADES_PCK.CentroDelUsuario(p_IDUSUARIO);
			ELSE
				--	'NORMAL'
				v_Debug:=v_Debug||'SQL para NORMAL.';
				v_SQL:=	v_SQL || REPLACE(Alarma.EIS_AL_RESTRICCION_NORMAL,'#IDUSUARIO#',':ID');	--p_IDUSUARIO);
				v_ID:=p_IDUSUARIO;
			END IF;
		END IF;

		IF v_SaltarAlarma='N' THEN		--	2mar10 evitamos entrar en consultas innecesarias
			BEGIN	--	12feb09	ET	Protegemos el bloque, insertamos error sin problemas de XML
				v_Debug:=v_Debug||' SQL:'||v_SQL;
				IF v_ID IS NULL THEN
					--	Sin Bind Variables si hay restricciones
					OPEN v_cur FOR v_SQL;
				ELSE
					--	Bind Variables si hay restricciones
					OPEN v_cur FOR v_SQL USING v_ID;
				END IF;

				FETCH v_cur INTO v_reg;
				IF v_cur%found THEN

					IF v_reg.Total>0 THEN
					
						v_AlarmasActivas:=v_AlarmasActivas+1;
					
						v_Texto	:=		'<ALARMA>'
									||	'<ENLACE>'	|| Alarma.EIS_AL_LISTADO			||'</ENLACE>'
									||	'<POSITIVO>'|| Alarma.EIS_AL_POSITIVO			||'</POSITIVO>'		--	22dic14
									||	'<NOMBRE>'	|| v_reg.Total||' '||Alarma.MENSAJE	||'</NOMBRE>'
									||	'</ALARMA>';
						HTP.P(v_Texto);

						--utilidades_pck.debug(Alarma.MENSAJE||':: Total:'||v_reg.Total||':::'||v_SQL);

					END IF;

				END IF;
				CLOSE v_cur;

			EXCEPTION
				WHEN OTHERS THEN
					MVM.InsertDBError ('EIS_PCK.PresentaAlarmas.', v_Debug|| ' SQLERRM:'||sqlerrm);
			END;
		END IF;


	END LOOP;

	HTP.P(	'<TOTAL>'||v_AlarmasActivas||'</TOTAL>'
		||	'</ALARMAS>');

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.PresentaAlarmas.', v_Debug|| ' SQLERRM:'||sqlerrm);
END;




/*
	PROCEDURE EnviaValoresFiltro

	Funcion privada
	Envia via HTP.P el contenido de un filtro
	
	13feb09	ET	Utilizamos BIND VARIABLES para mejorar rendimiento
*/
/*	18ene13	Ya no debe utilizarse esta petición, se montan todos los desplegables de una única vez
PROCEDURE EnviaValoresFiltro
(
	p_IDIndicador	VARCHAR2,
	p_Control		VARCHAR2,
	p_ID			VARCHAR2,
	p_Nombre		VARCHAR2,
	p_Label			VARCHAR2,
	p_Current		VARCHAR2,
	p_FiltroSQL		VARCHAR2
)
IS
	v_SQL			VARCHAR2(3000);
  	v_cur 			REF_CURSOR;
 	v_reg 			TRegFiltro;
	v_Status		VARCHAR2(300);

	v_Count			NUMBER;
	--ERROR EXCEPTION;

	--	3abr12	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion	VARCHAR2(100);
BEGIN

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'EnviaValoresFiltro:'||p_Control,'','EIS Cons');


	v_SQL:=		' SELECT 	DISTINCT '||p_ID||' AS ID, SUBSTR('||p_Nombre||',1,100) AS NOMBRE'
			||	' FROM	EIS_VALORES'
			||	' WHERE 1=1'
			||	p_FiltroSQL;
			
	--	13feb09	BIND VARIABLES
	IF p_IDIndicador IS NOT NULL THEN
		v_SQL:=	v_SQL||' AND EIS_VA_IDINDICADOR= :ID';
	END IF;

			
	--	Ordenación
	v_SQL:=	v_SQL||	' ORDER BY Normalizar_pck.NormalizarString(NOMBRE)';


	--Utilidades_PCK.Debug('EIS_PCK.EnviaValoresFiltro: '||v_SQL||' IDIndicador:'||p_IDIndicador);	--solodebug!!!!!!

	IF p_IDIndicador IS NOT NULL THEN
		OPEN v_cur FOR v_SQL USING p_IDIndicador;
	ELSE
		OPEN v_cur FOR v_SQL;
	END IF;
	
	FETCH v_cur INTO v_reg;
	IF v_cur%found THEN
		HTP.P('<field label="'||p_Label||'" name="'||p_Control||'" current="'|| p_Current ||'">');
		HTP.P('<dropDownList>');
		HTP.P('<listElem>');
		HTP.P('<listItem>Todos</listItem>');
		HTP.P('<ID>-1</ID>');
		HTP.P('</listElem>');
		WHILE v_cur%found LOOP
			HTP.P('<listElem>');
			HTP.P('<listItem>'|| MVM.ScapeHTMLString(v_reg.Nombre) ||'</listItem>');
			HTP.P('<ID>'|| v_reg.ID ||'</ID>');
			HTP.P('</listElem>');
	 		FETCH v_cur INTO v_reg;
   		END LOOP;
		HTP.P('</dropDownList>');
		HTP.P('</field>');
	END IF;

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.EnviaValoresFiltro','SQL:'||v_SQL||' SQLERRM:'||sqlerrm);
END;

*/
--	19abr12	En lugar de hacer una consulta por desplegable, lo hacemos de una única vez, para comprobar el rendimiento
PROCEDURE PrepararVectores
(
	p_IDIndicador			IN VARCHAR2,
	p_IDEmpresa				IN VARCHAR2,
	p_FiltroSQL				IN VARCHAR2,
	p_VectorEmpresas		OUT vector_pck.TVector,
	p_VectorEmpresas2		OUT vector_pck.TVector,
	p_VectorEstados			OUT vector_pck.TVector,
	p_VectorCategorias		OUT vector_pck.TVector,		--	25abr13
	p_VectorFamilias		OUT vector_pck.TVector
)
IS
	--
	--  Registro de resultado de la consulta de filtros
	--
	TYPE TRegDespegables IS RECORD
	(
		IDEmpresa		VARCHAR2(100),
		Empresa 		VARCHAR2(1000),
		IDEmpresa2		VARCHAR2(100),
		Empresa2		VARCHAR2(1000),
		IDEstado		VARCHAR2(100),
		Estado			VARCHAR2(1000),
		IDCategoria		VARCHAR2(100),
		Categoria		VARCHAR2(1000),
		IDFamilia		VARCHAR2(100),
		Familia			VARCHAR2(1000)
	);


	v_SQL			VARCHAR2(3000);
  	v_cur 			REF_CURSOR;
 	v_reg 			TRegDespegables;
	v_Status		VARCHAR2(300);
	v_FiltroSQL		VARCHAR2(3000);					--	1oct13	Adaptaremos el filtro SQL a restriciones que empiecen con WHERE o AND

	v_Count			NUMBER;
	--ERROR EXCEPTION;

	v_IDPais		EMPRESAS.EMP_IDPAIS%TYPE;		--	8feb17

	--	3abr12	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion		VARCHAR2(100);
BEGIN

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'PrepararVectores','','EIS Cons');
	
	v_IDPais:=empresas_pck.IDPaisDeEmpresa(p_IDEmpresa);

	vector_pck.vecInicializar(p_VectorEmpresas,'Empresas');
	vector_pck.vecInicializar(p_VectorEmpresas2,'Empresas2');
	vector_pck.vecInicializar(p_VectorEstados,'Estados');
	vector_pck.vecInicializar(p_VectorCategorias,'Categorias');
	vector_pck.vecInicializar(p_VectorFamilias,'Familias');

	vector_pck.vecNuevoElemento(p_VectorEmpresas, '-1', 'Todas', null);
	vector_pck.vecNuevoElemento(p_VectorEmpresas2, '-1', 'Todas', null);
	vector_pck.vecNuevoElemento(p_VectorEstados, '-1', 'Todos', null);
	vector_pck.vecNuevoElemento(p_VectorCategorias, '-1', 'Todas',null);
	vector_pck.vecNuevoElemento(p_VectorFamilias, '-1', 'Todas',null);
	
	IF p_IDEmpresa='1640' THEN
		vector_pck.vecNuevoElemento(p_VectorFamilias, '-2', 'Material sanitario',null);	--	3may12	familia teórica, todo menos farmacia
	END IF;
	
	IF p_IDEmpresa='7996' THEN
		vector_pck.vecNuevoElemento(p_VectorCategorias, '-2', 'Material licitado',null);	--	3may12	categoría teórica, todo menos "no licitado"
	END IF;

	v_FiltroSQL:=TRIM(p_FiltroSQL);
	--solodebug	Utilidades_PCK.Debug('EIS_PCK.PrepararVectores: IDIndicador:'||p_IDIndicador||' IDEmpresa:'||p_IDEmpresa||' FiltroSQL:'||p_FiltroSQL||': Claúsula: ['||UPPER(SUBSTR(v_FiltroSQL,1,5))||']');	--solodebug!!!!!!
	
	--	1oct13	Adaptamos el filtro SQL a restriciones que empiecen con WHERE o AND
	IF UPPER(SUBSTR(v_FiltroSQL,1,5))='WHERE' THEN
		--solodebug	Utilidades_PCK.Debug('EIS_PCK.PrepararVectores: IDIndicador:'||p_IDIndicador||' IDEmpresa:'||p_IDEmpresa||' FiltroSQL:'||p_FiltroSQL||': Claúsula WHERE');	--solodebug!!!!!!
		v_FiltroSQL:=v_FiltroSQL;
	ELSIF UPPER(SUBSTR(v_FiltroSQL,1,3))='AND' THEN
		--solodebug	Utilidades_PCK.Debug('EIS_PCK.PrepararVectores: IDIndicador:'||p_IDIndicador||' IDEmpresa:'||p_IDEmpresa||' FiltroSQL:'||p_FiltroSQL||': Claúsula AND');	--solodebug!!!!!!
		v_FiltroSQL:='WHERE '||SUBSTR(v_FiltroSQL,4,LENGTH(v_FiltroSQL)-3);
	ELSIF v_FiltroSQL IS NULL THEN
		--solodebug	Utilidades_PCK.Debug('EIS_PCK.PrepararVectores: IDIndicador:'||p_IDIndicador||' IDEmpresa:'||p_IDEmpresa||' FiltroSQL:'||p_FiltroSQL||': Claúsula VACIA');	--solodebug!!!!!!
		v_FiltroSQL:='WHERE 1=1';
	ELSE
		--solodebug	Utilidades_PCK.Debug('EIS_PCK.PrepararVectores: IDIndicador:'||p_IDIndicador||' IDEmpresa:'||p_IDEmpresa||' FiltroSQL:'||p_FiltroSQL||': Claúsula DESCONOCIDA');	--solodebug!!!!!!
		v_FiltroSQL:='WHERE '||v_FiltroSQL;
	END IF;
	
	--8feb17	IF p_IDEmpresa IS NULL OR p_IDEmpresa=Mvm.BuscarParametro(0) OR p_IDEmpresa=Mvm.BuscarParametro(200) THEN
	IF p_IDEmpresa IS NULL OR p_IDEmpresa=TO_NUMBER(utilidades_pck.Parametro('IDMVM_'||v_IDPais)) THEN
		v_SQL:=		' SELECT DISTINCT'
				||	' 	EIS_VA_IDEMPRESA, EIS_VA_EMPRESA, EIS_VA_IDEMPRESA2, EIS_VA_EMPRESA2, EIS_VA_IDESTADO, EIS_VA_ESTADO,'
				--	30abr13	||  ' 	EIS_VA_REFCATEGORIA, EIS_VA_REFCATEGORIA||'':''||lower(EIS_VA_CATEGORIA),'
				--	30abr13	||  ' 	EIS_VA_REFFAMILIA, EIS_VA_REFFAMILIA||'':''||lower(EIS_VA_FAMILIA)'
				||	'	NULL, NULL, NULL, NULL'
				||	' FROM	EIS_VALORES'
				||	' '||v_FiltroSQL;
				--1oct13||	' WHERE 1=1'||	p_FiltroSQL;
	ELSE
		v_SQL:=		' SELECT DISTINCT'
				||	' 	EIS_VA_IDEMPRESA, EIS_VA_EMPRESA, EIS_VA_IDEMPRESA2, EIS_VA_EMPRESA2, EIS_VA_IDESTADO, EIS_VA_ESTADO,'
				||  ' 	EIS_VA_IDCATEGORIA, EIS_VA_REFCATEGORIA||'':''||lower(EIS_VA_CATEGORIA),'
				||  ' 	EIS_VA_IDFAMILIA, EIS_VA_REFFAMILIA||'':''||lower(EIS_VA_FAMILIA)'
				||	' FROM	EIS_VALORES'
				||	' '||v_FiltroSQL;
				--1oct13||	' WHERE 1=1'||	p_FiltroSQL;
	END IF;
			
	--	13feb09	BIND VARIABLES
	IF p_IDIndicador IS NOT NULL THEN
		v_SQL:=	v_SQL||' AND EIS_VA_IDINDICADOR= :ID';
	END IF;

	--solodebug	
	--Utilidades_PCK.Debug('EIS_PCK.PrepararVectores: IDIndicador:'||p_IDIndicador||' IDEmpresa:'||p_IDEmpresa||' SQL:'||v_SQL);	--solodebug!!!!!!

	IF p_IDIndicador IS NOT NULL THEN
		OPEN v_cur FOR v_SQL USING p_IDIndicador;
	ELSE
		OPEN v_cur FOR v_SQL;
	END IF;
	
	FETCH v_cur INTO v_reg;
	IF v_cur%found THEN
		
		--Utilidades_PCK.Debug('EIS_PCK.PrepararVectores:'||v_reg.Empresa||','||v_reg.IDEmpresa2||','||v_reg.IDCategoria);

		WHILE v_cur%found LOOP
		
			--	Actualizamos Empresas
			--v_Status:=v_Status||'. Empresas.';
			IF vector_pck.vecBuscarElemento(p_VectorEmpresas, v_reg.IDEmpresa) IS NULL THEN
				vector_pck.vecNuevoElemento(p_VectorEmpresas, v_reg.IDEmpresa, v_reg.Empresa, null);
			END IF;
			--	Actualizamos Empresas2
			--v_Status:=v_Status||'. Empresas2.';
			IF vector_pck.vecBuscarElemento(p_VectorEmpresas2, v_reg.IDEmpresa2) IS NULL THEN
				vector_pck.vecNuevoElemento(p_VectorEmpresas2, v_reg.IDEmpresa2, v_reg.Empresa2, null);
			END IF;
			--	Actualizamos Estados
			--v_Status:=v_Status||'. Estados.';
			IF vector_pck.vecBuscarElemento(p_VectorEstados, v_reg.IDEstado) IS NULL THEN
				vector_pck.vecNuevoElemento(p_VectorEstados, v_reg.IDEstado, v_reg.Estado, null);
			END IF;
			--	Actualizamos Categorias
			--v_Status:=v_Status||'. Categorias.';
			IF vector_pck.vecBuscarElemento(p_VectorCategorias, v_reg.IDCategoria) IS NULL THEN
				vector_pck.vecNuevoElemento(p_VectorCategorias, v_reg.IDCategoria, v_reg.Categoria, null);
			END IF;
			--	Actualizamos Familias
			--v_Status:=v_Status||'. Familias.';
			IF vector_pck.vecBuscarElemento(p_VectorFamilias, v_reg.IDFamilia) IS NULL THEN
				vector_pck.vecNuevoElemento(p_VectorFamilias, v_reg.IDFamilia, v_reg.Familia, null);
			END IF;

	 		FETCH v_cur INTO v_reg;
   		END LOOP;

	END IF;
	
	--vector_pck.vecDebug(p_VectorEmpresas2);	--	solodebug
	
	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.PrepararVectores','SQL:'||v_SQL||' SQLERRM:'||sqlerrm);
END;


--	24abr13	Datos basicos de una empresa en XML
--			En principio se utiliza para EMP_CATPRIV_CATEGORIAS, EMP_CATPRIV_GRUPOS pero aprovecho para añadir otros campos interesantes
PROCEDURE DatosBasicosEmpresa_XML
(
	p_IDEmpresa				NUMBER
)
IS
	v_IDPais			PAISES.PA_ID%TYPE;
	
	v_IDEmpresa			EMPRESAS.EMP_ID%TYPE; 
	v_CP_Categorias		EMPRESAS.EMP_CATPRIV_CATEGORIAS%TYPE;
	v_CP_Grupos			EMPRESAS.EMP_CATPRIV_GRUPOS%TYPE;
	v_Rol				TIPOSEMPRESAS.TE_ROL%TYPE;
BEGIN

	--	16mar12	Indicadores según rol
	SELECT 		TE_ROL, EMP_IDPAIS, NVL(EMP_CATPRIV_CATEGORIAS,'N'), NVL(EMP_CATPRIV_GRUPOS,'N')
		INTO	v_Rol, v_IDPais, v_CP_Categorias, v_CP_Grupos
		FROM	EMPRESAS, TIPOSEMPRESAS
		WHERE 	EMP_IDTIPO=TE_ID
		AND		EMP_ID=p_IDEmpresa;

	HTP.P(Utilidades_PCK.CabeceraXML
		||	'<EMPRESA>'
		||	'<IDEMPRESA>'			||p_IDEmpresa		||'</IDEMPRESA>'
		||	'<ROL>'					||v_Rol				||'</ROL>'
		||	'<IDPAIS>'				||v_IDPais			||'</IDPAIS>'
		||	'<MOSTRARCATEGORIAS>'	||v_CP_Categorias	||'</MOSTRARCATEGORIAS>'
		||	'<MOSTRARGRUPOS>'		||v_CP_Grupos		||'</MOSTRARGRUPOS>'
		||	'</EMPRESA>');
	
		
EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.DatosBasicosEmpresa_XML','IDEmpresa:'||p_IDEmpresa||' SQLERRM:'||sqlerrm);
END;


--	12dic13 Necesitamos el ID de Indicador de un cuadro de mando
PROCEDURE DatosCuadroMando_XML
(
	p_IDCuadroMando			VARCHAR2
)
IS
	CURSOR cCuadroMando(IDCuadro VARCHAR2) IS
		SELECT	EIS_IN_ID, EIS_IN_NOMBRE
		FROM	EIS_INDICADORESPORCUADRO, EIS_INDICADORES
		WHERE	EIS_CI_IDINDICADOR	=EIS_IN_ID
			AND	EIS_CI_IDCUADRO		=IDCuadro;
BEGIN

	HTP.P(Utilidades_PCK.CabeceraXML
		||'<INDICADORES IDCuadro="'||p_IDCuadroMando||'">');

	FOR i IN cCuadroMando(p_IDCuadroMando) LOOP
		HTP.P('<INDICADOR>'
			||'<EIS_IN_ID>'		||i.EIS_IN_ID		||'</EIS_IN_ID>'
			||'<EIS_IN_NOMBRE>'	||i.EIS_IN_NOMBRE	||'</EIS_IN_NOMBRE>'
			||'</INDICADOR>');
	END LOOP;
	HTP.P('</INDICADORES>');
END;




--	15abr13	Desplegable XML correspondiente a la familia 'FAM', subfamilia 'SF', grupo 'GRU' o producto estándar 'PRO'
--			También sirve para los centros cliente 'CEN' si quién consulta es un proveedor
--	20may14 Todas las consultas a través de EIS_DESPLEGABLESDINAMICOS
PROCEDURE DesplegableDinamico_XML
(
	p_IDEmpresa				VARCHAR2,
	p_IDIndicador			VARCHAR2,
	p_FiltroSQL				VARCHAR2,
	p_IDPadre				NUMBER,
	p_Tipo					VARCHAR2,
	p_IDIdioma				NUMBER,
	p_IDUSUARIO				NUMBER DEFAULT NULL
)
IS
	--
	--  Registro de resultado de la consulta de filtros
	--
	TYPE TRegDespegables IS RECORD
	(
		ID			NUMBER(12),
		NOMBRE 		VARCHAR2(1000)
	);

	v_SQL			VARCHAR2(3000);
  	v_cur 			REF_CURSOR;
 	v_reg 			TRegDespegables;
	v_Status		VARCHAR2(300);

	v_Control		VARCHAR2(100);
	v_CampoID		VARCHAR2(100);
	v_Campo			VARCHAR2(100);
	v_SQLPadre		VARCHAR2(1000);
	v_Titulo		VARCHAR2(100);
	
	v_Count			NUMBER:=0;
	--ERROR EXCEPTION;
	v_Tipo			VARCHAR2(100);


	--	3abr12	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion		VARCHAR2(100);

	v_Debug			VARCHAR2(1000);
	SIN_PARAMETRO 	EXCEPTION;
BEGIN

	v_Debug:='p_IDEmpresa:'||p_IDEmpresa||' IDIndicador:'||p_IDIndicador||' Tipo:'||p_Tipo||' IDIdioma:'||p_IDIdioma||' IDUSUARIO:'||p_IDUSUARIO||' Padre:'||p_IDPadre||' FiltroSQL:'||p_FiltroSQL;
	
	--utilidades_pck.debug('DesplegableDinamico_XML:'||v_Debug);

	--	15may14 Si no está informado p_IDPadre directamente generamos un aviso de error
	IF p_IDPadre IS NULL THEN
		RAISE SIN_PARAMETRO;
	END IF;
	
	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'DesplegableDinamico_XML:'||p_Tipo||' Ind:'||p_IDIndicador||' Padre:'||p_IDPadre||' FiltroSQL:'||SUBSTR(p_FiltroSQL,1,10),'','EIS Cons');

	--	Preparamos los campos para la consulta SQL
	/*
	IF p_Tipo='CAT' THEN

		v_Control	:='IDCATEGORIA';
		v_CampoID	:='EIS_VA_IDCATEGORIA';
		v_Campo		:='EIS_VA_CATEGORIA';
		v_SQLPadre	:=' AND EIS_VA_IDEMPRESA='||p_IDPadre;
		v_Titulo	:='EIS_CATEGORIA';

	ELSIF p_Tipo='FAM' THEN

		v_Control	:='IDFAMILIA';
		v_CampoID	:='EIS_VA_IDFAMILIA';
		v_Campo		:='EIS_VA_FAMILIA';
		IF p_IDPadre='-2' THEN
			v_SQLPadre	:=' AND EIS_VA_IDCATEGORIA<>1341';	--	3dic13	Especial para Viamed			
		ELSE
			v_SQLPadre	:=' AND EIS_VA_IDCATEGORIA='||p_IDPadre;
		END IF;
		v_Titulo	:='EIS_FAMILIA';


	ELSIF p_Tipo='FAMEMP' THEN

		v_Control	:='IDFAMILIA';
		v_CampoID	:='EIS_VA_IDFAMILIA';
		v_Campo		:='EIS_VA_FAMILIA';
		v_SQLPadre	:=' AND EIS_VA_IDEMPRESA='||p_IDPadre;
		v_Titulo	:='EIS_FAMILIA';

	ELSIF p_Tipo='SF' THEN

		v_Control	:='IDSUBFAMILIA';
		v_CampoID	:='EIS_VA_IDSUBFAMILIA';
		v_Campo		:='EIS_VA_SUBFAMILIA';
		v_SQLPadre	:=' AND EIS_VA_IDFAMILIA='||p_IDPadre;
		v_Titulo	:='EIS_SUBFAMILIA';

	ELSIF p_Tipo='GRU' THEN

		v_Control	:='IDGRUPO';
		v_CampoID	:='EIS_VA_IDGRUPO';
		v_Campo		:='EIS_VA_GRUPO';
		v_SQLPadre	:=' AND EIS_VA_IDSUBFAMILIA='||p_IDPadre;
		v_Titulo	:='EIS_GRUPO';

	ELSIF p_Tipo='PRO' THEN

		v_Control	:='IDPRODUCTOESTANDAR';
		v_CampoID	:='EIS_VA_IDPRODESTANDAR';
		v_Campo		:='EIS_VA_PRODESTANDAR';
		v_SQLPadre	:=' AND EIS_VA_IDGRUPO='||p_IDPadre;
		v_Titulo	:='EIS_PRODUCTOESTANDAR';


	ELSIF p_Tipo='PROSF' THEN

		v_Control	:='IDPRODUCTOESTANDAR';
		v_CampoID	:='EIS_VA_IDPRODESTANDAR';
		v_Campo		:='EIS_VA_PRODESTANDAR';
		v_SQLPadre	:=' AND EIS_VA_IDSUBFAMILIA='||p_IDPadre;
		v_Titulo	:='EIS_PRODUCTOESTANDAR';

	ELSIF p_Tipo='CEN' THEN

		v_Control	:='IDCENTRO';
		v_CampoID	:='EIS_VA_IDCENTRO';
		v_Campo		:='EIS_VA_CENTRO';
		v_SQLPadre	:=' AND EIS_VA_IDEMPRESA='||p_IDPadre;
		v_Titulo	:='EIS_CENTRO';

	ELSIF p_Tipo='CEN2' THEN

		v_Control	:='IDCENTRO2';
		v_CampoID	:='EIS_VA_IDCENTRO2';
		v_Campo		:='EIS_VA_CENTRO2';
		v_SQLPadre	:=' AND EIS_VA_IDEMPRESA2='||p_IDPadre;
		v_Titulo	:='EIS_CENTRO';

	END IF;
	
	v_SQL:=		' SELECT DISTINCT '||v_CampoID||','||v_Campo
			||	' FROM	EIS_VALORES'
			||	' WHERE EIS_VA_IDINDICADOR= :ID'
			||	p_FiltroSQL
			||	v_SQLPadre
			||	' ORDER BY '||v_Campo;
	*/
	v_SQLPadre	:=' AND EIS_DD_IDPADRE='||p_IDPadre;
	v_Tipo:=p_Tipo;
	IF p_Tipo='CAT' THEN

		v_Control	:='IDCATEGORIA';
		v_Titulo	:='EIS_CATEGORIA';

	ELSIF p_Tipo='FAM' THEN

		v_Control	:='IDFAMILIA';
		IF p_IDPadre='-2' THEN
			v_SQLPadre	:=' AND EIS_DD_IDPADRE<>1341';	--	3dic13	Especial para Viamed			
		END IF;
		v_Titulo	:='EIS_FAMILIA';

	ELSIF p_Tipo='FAMEMP' THEN

		v_Control	:='IDFAMILIA';
		v_Titulo	:='EIS_FAMILIA';

	ELSIF p_Tipo='SF' THEN

		v_Control	:='IDSUBFAMILIA';
		v_Titulo	:='EIS_SUBFAMILIA';

	ELSIF p_Tipo='GRU' THEN

		v_Control	:='IDGRUPO';
		v_Titulo	:='EIS_GRUPO';

	ELSIF p_Tipo='PRO' THEN

		v_Control	:='IDPRODUCTOESTANDAR';
		v_Titulo	:='EIS_PRODUCTOESTANDAR';


	ELSIF p_Tipo='PROSF' THEN

		v_Control	:='IDPRODUCTOESTANDAR';
		v_Titulo	:='EIS_PRODUCTOESTANDAR';

	ELSIF p_Tipo='CEN' THEN

		v_Control	:='IDCENTRO';
		v_Titulo	:='EIS_CENTRO';

	ELSIF p_Tipo='CEN2' THEN

		IF SUBSTR(p_IDIndicador,1,3)='VE_' THEN
			v_Tipo:='CEN';	--	Para un usuario proveedor cambiamos para ver los centros clientes
		END IF;
		v_Control	:='IDCENTRO2';
		v_Titulo	:='EIS_CENTRO';

	END IF;
	
	v_SQL:=		' SELECT DISTINCT EIS_DD_ID,EIS_DD_NOMBRE'
			||	' FROM	EIS_DESPLEGABLESDINAMICOS'
			||	' WHERE EIS_DD_IDTIPO= :ID'
			||	v_SQLPadre
			||	' ORDER BY EIS_DD_NOMBRE';
			
	--Utilidades_PCK.Debug('EIS_PCK.DesplegableDinamico_XML: '||v_SQL||' Tipo:'||v_Tipo);	--solodebug!!!!!!

	--	Cabecera del desplegable
	HTP.P(utilidades_pck.CabeceraXML
		||'<field label="'|| Utilidades_pck.TextoMensaje(p_IDIdioma, v_Titulo)||'" name="'||v_Control||'" current="-1">'
		||'<dropDownList>'
		||'<listElem>'
		||'<ID>-1</ID>'
		||'<listItem>Todos</listItem>'
		||'</listElem>');


	IF p_Tipo='FAM' AND p_IDEmpresa=1640 THEN
		HTP.P('<listElem>'
			||'<ID>-2</ID>'
			||'<listItem>Material sanitario</listItem>'
			||'</listElem>');
	END IF;
	
	IF p_Tipo='CAT' AND p_IDEmpresa=7996 THEN
		HTP.P('<listElem>'
			||'<ID>-2</ID>'
			||'<listItem>Material licitado</listItem>'
			||'</listElem>');
	END IF;

	IF p_Tipo='CEN' AND p_IDUSUARIO IS NOT NULL THEN
		EISSelecciones_PCK.Selecciones_XML(p_IDUSUARIO, 'CEN', 'listElem', 'ID', 'listItem', 25);
	END IF;

	IF p_Tipo='CAT' AND p_IDUSUARIO IS NOT NULL THEN
		EISSelecciones_PCK.Selecciones_XML(p_IDUSUARIO, 'CAT', 'listElem', 'ID', 'listItem', 25);
	END IF;

	IF (p_Tipo='FAM' OR p_Tipo='FAMEMP') AND p_IDUSUARIO IS NOT NULL THEN
		EISSelecciones_PCK.Selecciones_XML(p_IDUSUARIO, 'FAM', 'listElem', 'ID', 'listItem', 25);
	END IF;

	--20may14	OPEN v_cur FOR v_SQL USING p_IDIndicador;
	OPEN v_cur FOR v_SQL USING v_Tipo;
	FETCH v_cur INTO v_reg;
	IF v_cur%found THEN

		WHILE v_cur%found LOOP

			--Utilidades_PCK.Debug('EIS_PCK.DesplegableDinamico_XML: '||v_Count||' ID:'||v_reg.ID ||' Nombre:'||v_reg.Nombre);	--solodebug!!!!!!

			v_Count:=v_Count+1;
			HTP.P('<listElem>'
				||'<ID>'		|| v_reg.ID 						||'</ID>'
				||'<listItem>'	|| mvm.ScapeHTMLString(v_reg.Nombre)||'</listItem>'
				||'</listElem>');

	 		FETCH v_cur INTO v_reg;
   		END LOOP;

	END IF;
	HTP.P('</dropDownList>');
	HTP.P('</field>');


	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

EXCEPTION
	WHEN SIN_PARAMETRO THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.DesplegableDinamico_XML',v_Debug||' ERROR: falta parámetro IDPadre');
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.DesplegableDinamico_XML',v_Debug||' SQL:'||v_SQL||' SQLERRM:'||sqlerrm);
END;




/*
 * Devolvemos la estructura de los cuadros de mando del
 * usuario seleccionado
 *
 *   EISAnalisis
 *   \
 *	 \Cuadros de mando
 *		\Indicadores
 *			\Combos
 *				\Filtros
 *				\AgruparPor
 *	 \Annos
 *
 *
 *	Cuidado! Da un ERROR si no está informado el usuario!
 */

PROCEDURE CuadroDeMando
(
	p_IDUSUARIO				VARCHAR2,
	p_IDCUADROMANDO 		VARCHAR2,
	p_ANNO 					VARCHAR2,
	p_IDEmpresa				VARCHAR2,
	p_IDCENTRO 				VARCHAR2,
	p_IDUSUARIOSEL			VARCHAR2,
	p_IDEmpresa2			VARCHAR2,
	p_IDCENTRO2				VARCHAR2,	--16abr13
	p_IDPRODESTANDAR		VARCHAR2,
	p_IDGRUPO				VARCHAR2,	--16abr13
	p_IDSUBFAMILIA			VARCHAR2,	--16abr13
	p_IDFAMILIA				VARCHAR2,	--16abr13
	p_IDCATEGORIA			VARCHAR2,	--16abr13
	--16abr13	p_IDNOMENCLATOR			VARCHAR2,
	--16abr13	p_URGENCIA				VARCHAR2,
	p_IDESTADO				VARCHAR2,
	--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
	--16abr13	p_IDGRAVEDAD			VARCHAR2,
	p_REFERENCIA			VARCHAR2,
	p_CODIGO				VARCHAR2,
	p_AgruparPor			VARCHAR2,
	p_IDResultados			VARCHAR2,
	p_RestriccionAdicional	VARCHAR2 	DEFAULT	null,
	p_FormatoResultados		VARCHAR2	DEFAULT 'TABLADATOS',		--TABLADATOS o GRAFICO o XML o EXCEL
	p_RatioSobre			VARCHAR2 	DEFAULT	null,
	p_PosicionRelativa 		VARCHAR2 	DEFAULT	null
)
IS
	--	Devuelve la empresa del usuario y si este es gerente
	CURSOR	cDerechos(p_USUARIO NUMBER) IS
		SELECT	CEN_IDEMPRESA		Empresa,
				US_USUARIOGERENTE	Gerente
		FROM	CENTROS, USUARIOS
		WHERE	CEN_ID=US_IDCENTRO
			AND	US_ID=p_IDUSUARIO;



	vCount					INTEGER;
	vFiltroSQL				VARCHAR2(3000);
	v_STATUS 				VARCHAR2(3000); 	--	Solo para depuracion!
	v_DerechosUsuario		VARCHAR2(100);		--	Derechos del usuario
	v_IDCuadromando			EIS_CUADROSDEMANDO.EIS_CM_ID%TYPE;
	v_Anno					INTEGER;
	v_Mes					INTEGER;
	v_Sql					VARCHAR2(3000);
	v_MarcarRojo			VARCHAR2(1);


	--	Pruebas matriz de datos
	v_NumeroFilas			INTEGER;
	v_VectorNombres			TVectorCadenas;
	v_VectorValores			TVectorNumerico;

	v_IDEmpresaDelUsuario	EMPRESAS.EMP_ID%TYPE;
	v_IDPAIS				PAISES.PA_ID%TYPE;				--	21nov11	ET Diferenciamos por país
	v_Rol					TIPOSEMPRESAS.TE_ROL%TYPE;		--	23abr13	ET y por rol
	
	v_CentroDelUsuario		CENTROS.CEN_NOMBRE%TYPE;		--	24oct13 Nombre de la empresa del usuario para el título de la ventana
	v_Usuario				USUARIOS.US_USUARIO%TYPE;		--	24oct13 Usuario para el título de la ventana
	v_IDIDioma				USUARIOS.US_IDIDIOMA%TYPE;		--	10mar15	Idioma para los textos 
	
	--	20nov13	Indicamos si hay que convertir a %
	v_Porcentaje			EIS_CUADROSDEMANDO.EIS_CM_PORCENTAJE%TYPE;
	v_FilaTotalesXML		EIS_CUADROSDEMANDO.EIS_CM_TOTALESXML%TYPE;

	--	17dic13	Pasamos codificación ZZ
	v_Referencia			VARCHAR2(1000);
	v_Codigo				VARCHAR2(1000);
BEGIN

/*	Utilidades_pck.debug('EIS_PCK.CuadroDeMando.'
		||' p_IDUSUARIO:'||p_IDUSUARIO
		||' p_IDCUADROMANDO:'||p_IDCUADROMANDO
		||' p_REFERENCIA:'||p_REFERENCIA
		||' p_ANNO :'|| p_ANNO
		||' p_IDEmpresa:'||p_IDEmpresa
		||' p_IDCENTRO :'|| p_IDCENTRO 
		||' p_IDUSUARIOSEL:'|| p_IDUSUARIOSEL
		||' p_IDEmpresa2:'|| p_IDEmpresa2
		||' p_IDCENTRO2:'|| p_IDCENTRO2
		||' p_IDPRODESTANDAR:'|| p_IDPRODESTANDAR
		||' p_IDGRUPO:'|| p_IDGRUPO
		||' p_IDSUBFAMILIA:'|| p_IDSUBFAMILIA
		||' p_IDFAMILIA:'||p_IDFAMILIA
		||' p_IDCATEGORIA:'|| p_IDCATEGORIA
		||' p_IDESTADO:'|| p_IDESTADO
		||' p_REFERENCIA:'|| p_REFERENCIA
		||' p_CODIGO:'||p_CODIGO
		||' p_AgruparPor:'|| p_AgruparPor
		||' p_IDResultados:'|| p_IDResultados
		||' p_RestriccionAdicional:'|| p_RestriccionAdicional
		||' p_FormatoResultados:'|| p_FormatoResultados
		||' p_RatioSobre:'|| p_RatioSobre
		||' p_PosicionRelativa:'|| p_PosicionRelativa
			);*/
	
	-- Cargamos la tabla con los indicadores seleccionados
	v_STATUS:=SYSDATE ||' Entrando';


	--
	--	Inicializacion de parametros
	--
	v_Referencia:=Normalizar_pck.QuitarCodificacionZZ(p_REFERENCIA);
	v_Codigo:=Normalizar_pck.QuitarCodificacionZZ(p_CODIGO);

	--	Comprobammos que esten informados los parametros basicos o les damos un valor por defecto
	IF p_ANNO IS NULL THEN
		v_Anno:=to_char(SYSDATE,'yyyy');
	ELSE
		v_Anno:=p_ANNO;
	END IF;


	--
	--	CUIDADO!!!	Si hemos cambiado el cuadro de mando no deberemos tener en cuenta los filtros!!!
	--
	IF p_IDCUADROMANDO IS NULL THEN
		--SELECT 	MIN(EIS_CM_ID)
		--INTO	v_IDCuadromando
		--FROM	EIS_CUADROSDEMANDO;
		v_IDCuadromando:=null;--'CO_Pedidos_Eur';
	ELSE
		v_IDCuadromando:=p_IDCUADROMANDO;
	END IF;

	--	20nov13	Indicamos si hay que convertir a %
	IF v_IDCuadromando IS NOT NULL THEN
		SELECT		EIS_CM_PORCENTAJE, EIS_CM_TOTALESXML
			INTO	v_Porcentaje, v_FilaTotalesXML
			FROM	EIS_CUADROSDEMANDO
			WHERE	EIS_CM_ID=v_IDCuadromando;
	END IF;

	
	--	Consulta los derechos del usuario
	v_DerechosUsuario:=USUARIOS_PCK.DerechosUsuarioEIS(p_IDUSUARIO);
	
	--	21nov11	Seleccionamos el país correspondiente a la empresa del usuario para aplicarlo como un criterio más de filtrado
	SELECT		EMP_ID, CEN_NOMBRE, EMP_IDPAIS, TE_ROL, US_USUARIO, US_IDIDIOMA
		INTO	v_IDEmpresaDelUsuario, v_CentroDelUsuario, v_IDPAIS, v_Rol, v_Usuario, v_IDIDioma
		FROM	USUARIOS, CENTROS, EMPRESAS, TIPOSEMPRESAS
		WHERE	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		EMP_IDTIPO=TE_ID
		AND		US_ID=p_IDUSUARIO;

	v_STATUS:='Preparando filtro';

	--
	--	Prepara el filtro SQL del cuadro de mando
	--
	vFiltroSQL:=RestriccionConsulta
	(
		p_IDUSUARIO,
		v_IDCUADROMANDO,
		v_ANNO,
		v_IDPAIS,				--	21nov11	Restricción por país
		p_IDEmpresa,
		p_IDCENTRO,
		p_IDUSUARIOSEL,
		p_IDEmpresa2,
		p_IDCENTRO2,					--16abr13
		p_IDPRODESTANDAR,
		p_IDGRUPO,						--16abr13
		p_IDSUBFAMILIA,					--16abr13
		p_IDFAMILIA,					--16abr13
		p_IDCATEGORIA,					--16abr13
		--16abr13	p_IDNOMENCLATOR			VARCHAR2,
		--16abr13	p_URGENCIA				VARCHAR2,
		p_IDESTADO,
		--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
		--16abr13	p_IDGRAVEDAD			VARCHAR2,
		v_Referencia,
		v_Codigo,
		p_AgruparPor,
		v_DerechosUsuario,
		p_RestriccionAdicional
	);


	--	Filtro	utilidades_pck.debug('AgruparPor:'||p_AgruparPor||' Filtro SQL:'||vFiltroSQL);



	v_STATUS:='Preparando consulta en tabla temporal';

	v_SQL:=PreparaConsultaEnTablaTemporal( p_IDUSUARIO, v_IDCuadromando, p_ANNO, vFiltroSQL, p_AgruparPor, p_IDResultados, p_RatioSobre, p_PosicionRelativa, p_IDEmpresa);

	IF p_FormatoResultados = 'TABLADATOS' 
		OR p_FormatoResultados = 'XML' 
		OR p_FormatoResultados = 'EXCEL' 
		OR p_FormatoResultados IS NULL THEN

		v_STATUS:='Enviando cabecera del Cuadro:'||v_IDCuadromando;

		--
		--	Envia la cabecera
		--

		--utilidades_pck.debug('Cuadro de mando='||v_IDCuadromando);
		IF p_FormatoResultados <> 'EXCEL' THEN
			HTP.P(
					Utilidades_PCK.CabeceraXML
				||	'<EISANALISIS>'
				||	'<ACTUALIZACION>'	||FechaActualizacionEIS						||'</ACTUALIZACION>'
				||	'<CENTRO>'			||mvm.ScapeHTMLString(v_CentroDelUsuario)	||'</CENTRO>'
				||	'<USUARIO>'			||mvm.ScapeHTMLString(v_Usuario)			||'</USUARIO>'
				||	'<ROL>'				||v_Rol										||'</ROL>'
				||	'<IDIDIOMA>'		||v_IDIDioma								||'</IDIDIOMA>'
				||	'<DERECHOS>'		||v_DerechosUsuario							||'</DERECHOS>'
				);

			IF Usuarios_PCK.EISSimplificado(p_IDUSUARIO)=TRUE THEN
				HTP.P('<EISSIMPLIFICADO/>');
			ELSE
				--	16abr13	Nuevos desplegables
				IF p_ANNO>=c_AnnoFuncionesAvanzadas THEN
					HTP.P('<ACTIVAR_FUNCIONES_AVANZADAS/>');
				END IF;
			END IF;

			HTP.P('<VALORES>'
				||	'<US_ID>'				||	p_IDUSUARIO 			||'</US_ID>'
				||	'<IDCUADRO>'			||	v_IDCuadromando 		||'</IDCUADRO>');
			IF v_IDCuadromando IS NOT NULL THEN
				HTP.P('<CUADRO>'			||	NombreCuadroMando(v_IDCuadromando, v_IDIDioma) 	||'</CUADRO>');
			END IF;
			HTP.P(	'<ANNO>'				||	p_ANNO 					||'</ANNO>'
				||	'<IDEMPRESA>'			||	p_IDEmpresa				||'</IDEMPRESA>'
				||	'<IDEMPRESADELUSUARIO>'	||	v_IDEmpresaDelUsuario	||'</IDEMPRESADELUSUARIO>'
				||	'<IDCENTRO>'			||	p_IDCENTRO 				||'</IDCENTRO>'
				||	'<IDUSUARIOSEL>'		||	p_IDUSUARIOSEL			||'</IDUSUARIOSEL>'
				||	'<IDEMPRESA2>'			||	p_IDEmpresa2			||'</IDEMPRESA2>'
				||	'<IDCENTRO2>'			||	p_IDCentro2				||'</IDCENTRO2>'
				||	'<IDPRODESTANDAR>'		||	p_IDPRODESTANDAR		||'</IDPRODESTANDAR>'
				--||	'<IDNOMENCLATOR>'		||	p_IDNOMENCLATOR		||'</IDNOMENCLATOR>'
				--||	'<URGENCIA>'			||	p_URGENCIA			||'</URGENCIA>'
				||	'<AGRUPARPOR>'			||	p_AgruparPor			||'</AGRUPARPOR>'
				||	'<IDESTADO>'			||	p_IDESTADO				||'</IDESTADO>'
				||	'<IDCATEGORIA>'			||	p_IDCATEGORIA			||'</IDCATEGORIA>'					--	8may12
				||	'<IDFAMILIA>'			||	p_IDFAMILIA				||'</IDFAMILIA>'					--	8may12
				||	'<IDSUBFAMILIA>'		||	p_IDSUBFAMILIA			||'</IDSUBFAMILIA>'					--	8may12
				||	'<IDGRUPO>'				||	p_IDGRUPO				||'</IDGRUPO>'					--	8may12
				--||	'<IDTIPOINCIDENCIA>'	||	p_IDTIPOINCIDENCIA	||'</IDTIPOINCIDENCIA>'
				--||	'<IDGRAVEDAD>'			||	p_IDGRAVEDAD		||'</IDGRAVEDAD>'
				||	'<REFERENCIA>'			||	v_Referencia			||'</REFERENCIA>'
				||	'<CODIGO>'				||	v_Codigo				||'</CODIGO>'
				||	'<IDRESULTADOS>'		||	p_IDResultados			||'</IDRESULTADOS>'
				||	'<IDRATIO>'				||	p_RatioSobre			||'</IDRATIO>'
				||	'<SQL>'					||	mvm.ScapeHTMLString(NORMALIZAR_PCK.ParaJavascript(vFiltroSQL))	||'</SQL>'
				||	'</VALORES>');
			
			IF NVL(v_Porcentaje,'N')='S' THEN
				HTP.P('<CONVERTIR_PORCENTAJE/>');
			END IF;
			
			IF NVL(v_FilaTotalesXML,'N')='S' THEN
				HTP.P('<UTILIZAR_FILA_TOTALES_XML/>');
			END IF;
		END IF;
		
		--
		--	Envia los desplegables
		--
		v_STATUS:='Enviando desplegables';

		--	26abr13	Si queremos XML no hace falta la cabecera
		IF p_FormatoResultados='TABLADATOS' THEN

			EnviaDesplegablesCabecera_XML
			(
				p_IDUSUARIO,
				v_IDCUADROMANDO,
				v_ANNO,
				p_IDEmpresa,
				p_IDCENTRO,
				p_IDUSUARIOSEL,
				p_IDEmpresa2,
				p_IDCENTRO2,		--16abr13
				p_IDPRODESTANDAR,
				p_IDGRUPO,			--16abr13
				p_IDSUBFAMILIA,		--16abr13
				p_IDFAMILIA,		--16abr13
				p_IDCATEGORIA,		--16abr13
				--16abr13	p_IDNOMENCLATOR			VARCHAR2,
				--16abr13	p_URGENCIA				VARCHAR2,
				p_IDESTADO,
				--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
				--16abr13	p_IDGRAVEDAD			VARCHAR2,
				v_Referencia,
				v_Codigo,
				p_AgruparPor,
				p_IDResultados,
				v_DerechosUsuario,
				vFiltroSQL,
				p_RatioSobre
			);

		END IF;


		--utilidades_pck.debug('CuadroDeMando: FiltroSQL='||vFiltroSQL);	--solodebug

		v_STATUS:='Enviando meses.1.';

		IF p_FormatoResultados <> 'EXCEL' THEN
			HTP.P('<DATOSEIS>'
				||'<LISTAMESES>');
		END IF;
		
		--	Construye la lista de meses
		IF p_Anno=9999 THEN
			v_Anno:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;
			v_Mes:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'))+1;
			IF v_Mes=13 THEN
				v_Anno:=v_Anno+1;
				v_Mes:=1;
			END IF;
		ELSE
			v_Mes:=1;
		END IF;

		v_STATUS:='Enviando meses.2.';

		IF p_FormatoResultados <> 'EXCEL' THEN

			--	Envia los doce meses
			FOR I IN 1..12 LOOP

				HTP.P('<MES><POS>'||I||'</POS><MES>'||v_Mes||'/'||v_Anno||'</MES><NOMBRE>'||SUBSTR(Utilidades_PCK.NombreMes(v_Mes),1,3)||' '||SUBSTR(v_Anno,3,2)||'</NOMBRE></MES>');

				--	Siguiente mes
				IF I<12 THEN
				v_Mes:=v_Mes+1;

					--	Si hemos superado el año incrementamos este
					IF v_Mes=13 THEN
						v_Anno:=v_Anno+1;
						v_Mes:=1;
					END IF;

				END IF;

			END LOOP;
			--	Columna para el total
			HTP.P('<MES><POS>13</POS><NOMBRE>Total</NOMBRE></MES>');
			HTP.P('</LISTAMESES>');
		
		END IF;
		
		--	Comprueba que marcas hay que utilizar para detectar incidencias en funcion del primer indicador del cuadro
		--	(solo para administradores)
		v_STATUS:='Comprobando Marca Roja';
		IF v_IDCUADROMANDO IS NOT NULL AND (v_DerechosUsuario='EMPRESA' OR v_DerechosUsuario='MVM' OR v_DerechosUsuario='MVMB') THEN
				SELECT		EIS_CB_MARCAROJA
					INTO	v_MarcarRojo
					FROM	EIS_CONSULTABASE, EIS_INDICADORES
					WHERE	EIS_IN_IDCONSULTABASE=EIS_CB_ID
					AND		EIS_IN_ID=
							(
								SELECT	MIN(EIS_CI_IDINDICADOR)
								FROM	EIS_INDICADORESPORCUADRO
								WHERE	EIS_CI_IDCUADRO=v_IDCUADROMANDO
							);
		ELSE
			v_MarcarRojo:=null;
		END IF;

		--	Envia los datos en formato XML
		v_STATUS:='Enviando datos XML';

		IF p_PosicionRelativa='C' OR  p_PosicionRelativa='D' THEN
			--	Invertimos la marca: si el indicador es positivo interesa que este en la posicion mas baja posible
			IF v_MarcarRojo='D' THEN
				v_MarcarRojo:='A';
			ELSE
				v_MarcarRojo:='D';
			END IF;

			--utilidades_pck.debug('CuadroDeMando: EnviarCuadro_Posiciones_XML='||v_IDCUADROMANDO);	--solodebug

			EnviarCuadro_Posiciones_XML(v_SQL, p_Anno, p_AgruparPor, p_IDResultados, v_MarcarRojo);
		ELSE

			--	Sustituimos la antigua llamada para devolver los datos en XML a partir de la consulta
			--	SQL por una nueva version que permite crear previamente una matriz y facilita el trabajo
			--	de mantenimiento.
			--
			--EnviarCuadroDeMando_XML(v_SQL, p_Anno, p_AgruparPor, p_IDResultados, v_MarcarRojo);
			--
			--utilidades_pck.debug('CuadroDeMando: PrepararMatriz='||v_IDCUADROMANDO);	--solodebug

			--HTP.P('<SQL>'|| v_SQL ||'</SQL>');--Solodebug!!!!

			PrepararMatriz
			(
				p_IDUSUARIO,
				v_SQL,
				p_Anno,
				p_AgruparPor,
				p_IDResultados,
				v_MarcarRojo,
				v_NumeroFilas,
				v_VectorNombres,
				v_VectorValores
			);	
			
			IF p_FormatoResultados = 'TABLADATOS' OR p_FormatoResultados = 'XML' THEN

				--	Devolvemos XML
				EnviarCuadroDeMando_v2_XML(p_Anno, v_NumeroFilas, v_VectorNombres, v_VectorValores, v_MarcarRojo, p_IDResultados);

			ELSIF p_FormatoResultados = 'EXCEL' THEN

				--	Generamos un fichero Excel
				PrepararListado_Excel(p_IDUsuario, p_Anno, v_NumeroFilas, v_VectorNombres, v_VectorValores, p_IDResultados);
				
			END IF;
		END IF;
		--HTP.P('<vFiltroSQL>'|| mvm.scapehtmlstring(vFiltroSQL) ||'</vFiltroSQL>');--Solodebug!!!!
		IF p_FormatoResultados <> 'EXCEL' THEN
			HTP.P('</DATOSEIS>'
				||'</EISANALISIS>');
		END IF;
	/*	24feb11	Ya no utilizamos graficos SVG
	ELSIF p_FormatoResultados = 'GRAFICOBARRAS' THEN
		--	Envia los datos en formato Grafico de Barras SVG
		v_STATUS:='Enviando Grafico de Barras';
		EnviarCuadroDeMando_SVG(p_IDUSUARIO, v_SQL, v_ANNO, p_AgruparPor, p_IDResultados, 'BARRAS2D');
	ELSIF p_FormatoResultados = 'GRAFICOLINEAS' THEN
		--	Envia los datos en formato Grafico de Lineas SVG
		v_STATUS:='Enviando Grafico de Lineas';
		EnviarCuadroDeMando_SVG(p_IDUSUARIO, v_SQL, v_ANNO, p_AgruparPor, p_IDResultados, 'LINEAS2D');
	*/
	END IF;

	--utilidades_pck.debug('EIS_PCK.CuadroDeMando formato:'||p_FormatoResultados);

	--	Quitamos provisionalmente para debug et 18ene06, volvemos a ponerlo 19ene06 porque se producen muchos errores en el EIS
	--DELETE EIS_VALORESTEMPORAL WHERE EIS_VT_USUARIO=p_IDUSUARIO;

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.CuadroDeMando ID='||v_IDCUADROMANDO ||' Estado:'||v_Status,'',sqlcode,sqlerrm,null);
END;

/*
	PROCEDURE EnviaDesplegablesCabecera_XML

	Envia los desplegables necesarios para el EIS avanzado
	28abr09	ET	Quitamos el desplegable de productos (miles de productos, ralentiza mucho!)
				El desplegable de proveedores lo creamos en base a las restricciones de la consulta
*/
--	16mar12	ET	A los usuarios de centros, solo indicadores de compras. A los usuarios de proveedores, solo indicadores de ventas
--	3may12	ET	Familia teórica "Material sanitario" (todo menos farmacia)
PROCEDURE EnviaDesplegablesCabecera_XML
(
	p_IDUSUARIO				VARCHAR2,
	p_IDCUADROMANDO 		VARCHAR2,
	p_ANNO 					VARCHAR2,
	p_IDEmpresa				VARCHAR2,
	p_IDCENTRO 				VARCHAR2,
	p_IDUSUARIOSEL			VARCHAR2,
	p_IDEmpresa2			VARCHAR2,
	p_IDCENTRO2				VARCHAR2,	--16abr13
	p_IDPRODESTANDAR		VARCHAR2,
	p_IDGRUPO				VARCHAR2,	--16abr13
	p_IDSUBFAMILIA			VARCHAR2,	--16abr13
	p_IDFAMILIA				VARCHAR2,	--16abr13
	p_IDCATEGORIA			VARCHAR2,	--16abr13
	--16abr13	p_IDNOMENCLATOR			VARCHAR2,
	--16abr13	p_URGENCIA				VARCHAR2,
	p_IDESTADO				VARCHAR2,
	--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
	--16abr13	p_IDGRAVEDAD			VARCHAR2,
	p_REFERENCIA			VARCHAR2,
	p_CODIGO				VARCHAR2,
	p_AgruparPor			VARCHAR2,
	p_IDResultados			VARCHAR2,
	p_DerechosUsuario		VARCHAR2,
	p_FiltroSQL				VARCHAR2,
	p_RatioSobre			VARCHAR2
)
IS
	--	Indicadores del cuadro de mando
	CURSOR	cIndicadores(IDCuadro IN VARCHAR2) IS
		SELECT		EIS_IN_ID, EIS_IN_NOMBRE, EIS_IN_NOMBRECORTO, EIS_IN_MANUAL,
					EIS_IN_RESTRICCIONES, EIS_IN_ACTUALIZACION, EIS_IN_F_EMPRESA, EIS_IN_F_CENTRO,
					EIS_IN_F_USUARIO, EIS_IN_F_EMPRESA2, EIS_IN_F_PRODUCTO,
					EIS_IN_F_NOMENCLATOR, EIS_IN_F_URGENCIAS, EIS_IN_F_ESTADO, EIS_IN_NOMBREEMPRESA2,
					EIS_IN_NOMBREEMPRESA2_BR,		--	8jun12	Nombre de la contraparte en portugués
					EIS_IN_F_GRAVEDAD,EIS_IN_F_TIPOINCIDENCIAS
			FROM	EIS_INDICADORESPORCUADRO, EIS_INDICADORES
			WHERE	EIS_CI_IDINDICADOR	=EIS_IN_ID
			AND		EIS_CI_IDCUADRO		=IDCuadro;

	CURSOR	cCuadrosDeMando (p_USUARIO NUMBER, ConIVA VARCHAR2, DerechosUsuario VARCHAR2, Rol VARCHAR2) IS
		SELECT		EIS_CM_ID
					--25mar17	EIS_CM_Nombre,
					--25mar17	EIS_CM_NOMBRE_BR	--	5jun12
			FROM 	EIS_CUADROSDEMANDO
			WHERE	((EIS_CM_SoloMVM='N') OR (DerechosUsuario='MVM') OR (DerechosUsuario='MVMB'))
			AND		((SUBSTR(EIS_CM_ID,1,2)='CO' AND Rol='COMPRADOR')
			OR		(SUBSTR(EIS_CM_ID,1,2)='VE' AND Rol='VENDEDOR')
			OR 		 (DerechosUsuario='MVM') OR (DerechosUsuario='MVMB'))
			AND		((EIS_CM_SOLOCONIVA IS NULL) OR (EIS_CM_SOLOCONIVA=ConIVA))
			AND		((EIS_CM_SOLOSINIVA IS NULL) OR (EIS_CM_SOLOSINIVA<>ConIVA))
			ORDER BY	EIS_CM_ORDEN;
		-- Falta comprobar la identidad del usuario
		-- WHERE EIS_CM_IDUSUARIO={p_USUARIO}

	CURSOR	cCuadrosDeMandoMVM IS
		SELECT		EIS_CM_ID,
					EIS_CM_Nombre
			FROM 	EIS_CUADROSDEMANDO;
	-- Falta comprobar la identidad del usuario
	-- WHERE EIS_CM_IDUSUARIO={p_USUARIO}

	--	Cursor con los años válidos para el EIS
	CURSOR	cAnnos  IS
		SELECT		EIS_AN_ID
			FROM	EIS_ANYOS
			ORDER BY EIS_AN_ID DESC;

	--	Cursor con los centros autorizados para el usuario gerente
	CURSOR	cCentrosUsuarioGerente(IDCuadro IN VARCHAR2, IDEmpresa NUMBER)  IS
		SELECT		CEN_ID, SUBSTR(CEN_NOMBRE,1,25) CEN_NOMBRE
			FROM	CENTROS, EIS_CENTROS
			WHERE	EIS_CEN_ID=CEN_ID
			AND		EIS_CEN_IDINDICADOR IN
					(
						SELECT 	EIS_CI_IDINDICADOR
						FROM 	EIS_INDICADORESPORCUADRO
						WHERE	EIS_CI_IDCUADRO		=IDCuadro
					)
			AND		CEN_IDEMPRESA=IDEmpresa
			ORDER BY UPPER(CEN_NOMBRE);


	--	16feb17	Cursor con los centros autorizados para un usuario multicentros
	CURSOR	cCentrosUsuarioMultiCentro(IDUsuario NUMBER)  IS
		SELECT		CEN_ID, SUBSTR(CEN_NOMBRE,1,25) CEN_NOMBRE
			FROM	CENTROS, USUARIOS_CENTROSAUTORIZADOS
			WHERE	UCA_IDCENTRO=CEN_ID
			AND		CEN_STATUS IS NULL
			AND		UCA_AUTORIZADO='S'
			AND		UCA_IDUSUARIO=IDUsuario
			ORDER BY CEN_NOMBRE_NORM;
			

	--	16/12/03	Sustituimos por un cursor con las empresas informadas en el EIS
	--	29oct07		Si filtramos por empresa solo mostramos los centros de esta empresa
	CURSOR	cCentrosTodos(IDCuadro IN VARCHAR2, IDEmpresa NUMBER)  IS
	/*	21dic12		SELECT		DISTINCT EIS_VA_IDCENTRO CEN_ID, SUBSTR(EIS_VA_CENTRO,1,25) CEN_NOMBRE, EIS_VA_CENTRO
			FROM	EIS_VALORES
			WHERE	EIS_VA_IDINDICADOR IN
				(
					SELECT 	EIS_CI_IDINDICADOR
					FROM 	EIS_INDICADORESPORCUADRO
					WHERE	EIS_CI_IDCUADRO		=IDCuadro
				)
			AND		((EIS_VA_IDEMPRESA=IDEMPRESA)OR(IDEMPRESA=-1))
			ORDER BY UPPER(EIS_VA_CENTRO);*/
		SELECT		CEN_ID, SUBSTR(CEN_NOMBRE,1,25) CEN_NOMBRE
			FROM	CENTROS, EIS_CENTROS
			WHERE	EIS_CEN_ID=CEN_ID
			AND		EIS_CEN_IDINDICADOR IN
					(
						SELECT 	EIS_CI_IDINDICADOR
						FROM 	EIS_INDICADORESPORCUADRO
						WHERE	EIS_CI_IDCUADRO		=IDCuadro
					)
			AND		((CEN_IDEMPRESA=IDEmpresa)OR(IDEmpresa=-1))
			ORDER BY UPPER(CEN_NOMBRE);

	CURSOR cCentroUsuario(IDUsuario NUMBER) IS
		SELECT		CEN_ID, SUBSTR(CEN_NOMBRE,1,25) CEN_NOMBRE
			FROM	CENTROS, USUARIOS
			WHERE	US_IDCENTRO=CEN_ID
			AND		US_ID=IDUsuario;
		


	--	Cursor con todas las empresas
	--	16/12/03	Sustituimos por un cursor con las empresas informadas en el EIS
	CURSOR	cEmpresasMVM(IDCuadro IN VARCHAR2)   IS
	/*	21dic12		SELECT	DISTINCT EIS_VA_IDEMPRESA EMP_ID, SUBSTR(EIS_VA_EMPRESA,1,25) EMP_NOMBRE, EIS_VA_EMPRESA
			FROM	EIS_VALORES
			WHERE	EIS_VA_IDINDICADOR IN
				(
					SELECT 	EIS_CI_IDINDICADOR
					FROM 	EIS_INDICADORESPORCUADRO
					WHERE	EIS_CI_IDCUADRO		=IDCuadro
				)
			ORDER BY UPPER(EIS_VA_EMPRESA);*/
		SELECT		EMP_ID, SUBSTR(EMP_NOMBRE,1,25) EMP_NOMBRE
			FROM	EIS_CENTROS, CENTROS, EMPRESAS
			WHERE	EIS_CEN_ID=CEN_ID
			AND		CEN_IDEMPRESA=EMP_ID
			AND		EIS_CEN_IDINDICADOR IN
					(
						SELECT 	EIS_CI_IDINDICADOR
						FROM 	EIS_INDICADORESPORCUADRO
						WHERE	EIS_CI_IDCUADRO		=IDCuadro
					)
			ORDER BY UPPER(EMP_NOMBRE);

	FEmpresa			VARCHAR2(1);
	FCentro				VARCHAR2(1);
	FUsuario			VARCHAR2(1);
	FEmpresa2			VARCHAR2(1);
	FProducto			VARCHAR2(1);
	FNomenclator		VARCHAR2(1);
	FUrgencias			VARCHAR2(1);
	FEstado				VARCHAR2(1);
	FGravedad			VARCHAR2(1);
	FTipoIncidencias	VARCHAR2(1);
	vNombreEmpresa2		VARCHAR2(100);
	vFiltroSQL			VARCHAR2(3000);
	vCount				INTEGER;
	--	13feb09	ET	Usaremos BIND VARIABLES para crear los filtros

	v_IDIndicador		EIS_INDICADORES.EIS_IN_ID%TYPE;
	vFiltroIndicadorSQL	VARCHAR2(1000);
	
	--	16mar12	Indicadores según rol
	v_Rol				TIPOSEMPRESAS.TE_ROL%TYPE;

	--	19abr12	Buscamos mejorar el rendimiento con vectores
	v_VectorEmpresas		vector_pck.TVector;
	v_VectorEmpresas2		vector_pck.TVector;
	v_VectorEstados			vector_pck.TVector;
	v_VectorCategorias		vector_pck.TVector;
	v_VectorFamilias		vector_pck.TVector;

	--	3abr12	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion	VARCHAR2(100);
	
	--	5jun12	Multipaís
	v_IDPais			PAISES.PA_ID%TYPE;
	v_IDIdioma			USUARIOS.US_IDIDIOMA%TYPE;
	
	v_IDEmpresa			EMPRESAS.EMP_ID%TYPE; 					--	21nov12
	v_IDCentro			CENTROS.CEN_ID%TYPE; 					--	21nov12
	v_CP_Categorias		EMPRESAS.EMP_CATPRIV_CATEGORIAS%TYPE;	--	16abr13
	v_CP_Grupos			EMPRESAS.EMP_CATPRIV_GRUPOS%TYPE;		--	16abr13
	
	v_PreciosConIva		EMPRESAS.EMP_PRECIOSCONIVA%TYPE;		--	9oct13

	v_IDMVM				EMPRESAS.EMP_ID%TYPE:=utilidades_pck.Parametro('ID_MVM');			--	19mar15
	v_IDMVMB			EMPRESAS.EMP_ID%TYPE:=utilidades_pck.Parametro('ID_MVMB');			--	19mar15

	v_Debug				VARCHAR2(1000);
BEGIN

	/*utilidades_pck.debug('EIS_PCK.EnviaDesplegablesCabecera_XML.'
			||' IDUSUARIO:'		||p_IDUSUARIO
			||' IDCUADROMANDO:'	||p_IDCUADROMANDO
			||' ANNO:'			||p_ANNO
			||' IDEmpresa:'		||p_IDEmpresa	
			||' IDCENTRO:'		||p_IDCENTRO 
			||' IDUSUARIOSEL:'	||p_IDUSUARIOSEL	
			||' IDEmpresa2:'	||p_IDEmpresa2
			||' IDCENTRO2:'		||p_IDCENTRO2
			||' IDPRODESTANDAR:'||p_IDPRODESTANDAR
			||' IDGRUPO:'		||p_IDGRUPO
			||' IDSUBFAMILIA:'	||p_IDSUBFAMILIA	
			||' IDFAMILIA:'		||p_IDFAMILIA
			||' IDCATEGORIA:'	||p_IDCATEGORIA
			||' IDESTADO:'		||p_IDESTADO	
			||' REFERENCIA:'	||p_REFERENCIA
			||' CODIGO:'		||p_CODIGO
			||' AgruparPor:'	||p_AgruparPor	
			||' IDResultados:'	||p_IDResultados	
			||' DerechosUsuario:'||p_DerechosUsuario
			||' FiltroSQL:'		||p_FiltroSQL
			||' RatioSobre:'	||p_RatioSobre);*/


	v_Debug:='Inicio.';

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'EnviaDesplegablesCabecera_XML','','EIS Cons');

	v_Debug:='Datos usuario.';

	--	16mar12	Indicadores según rol
	SELECT 		EMP_ID, CEN_ID, TE_ROL, EMP_IDPAIS, US_IDIDIOMA, NVL(EMP_CATPRIV_CATEGORIAS,'N'), NVL(EMP_CATPRIV_GRUPOS,'N'), NVL(EMP_PRECIOSCONIVA,'N')
		INTO	v_IDEmpresa, v_IDCentro, v_Rol, v_IDPais, v_IDIdioma, v_CP_Categorias, v_CP_Grupos, v_PreciosConIva
		FROM	USUARIOS, CENTROS, EMPRESAS, TIPOSEMPRESAS
		WHERE 	US_IDCENTRO=CEN_ID
		AND		CEN_IDEMPRESA=EMP_ID
		AND		EMP_IDTIPO=TE_ID
		AND		US_ID=p_IDUSUARIO;
		
	v_Debug:='Datos empresa.';
	
	--	23abr13 Si el parámetro empresa no coincide con la empresa del usuario utilizamos este parámetro para saber si tiene categorias y grupos
	IF p_IDEmpresa IS NOT NULL AND p_IDEmpresa<>'-1' AND v_IDEmpresa<>p_IDEmpresa THEN
		SELECT 		NVL(EMP_CATPRIV_CATEGORIAS,'N'), NVL(EMP_CATPRIV_GRUPOS,'N')
			INTO	v_CP_Categorias, v_CP_Grupos
			FROM	EMPRESAS
			WHERE 	EMP_ID=p_IDEmpresa;
	END IF;


	--	21nov12	En algunos casos no está informado el ID de empresa
	IF p_IDEmpresa='-1' THEN						--	20ago14	Al llamar directamente a EISDATOS.xsql (por cambiar año, por ejemplo) se pasa -1
		--	19mar15 Solo para usuarios de MVM, ponemos a NULL
		IF v_IDEmpresa IN (v_IDMVM, v_IDMVMB) THEN
			v_IDEmpresa:=NULL;
		END IF;
	ELSIF p_IDEmpresa IS NOT NULL THEN
		v_IDEmpresa:=p_IDEmpresa;
	END IF;


	vCount:=0;
	FOR Indicador IN cIndicadores(p_IDCuadromando) LOOP
		IF vCount>0 THEN
			vFiltroIndicadorSQL:=vFiltroIndicadorSQL|| ' OR ';
			v_IDIndicador:=NULL;
		END IF;
		vFiltroIndicadorSQL:=vFiltroIndicadorSQL|| 'EIS_VA_IDINDICADOR='''||Indicador.EIS_IN_ID||'''';
		vCount:=vCount+1;
		v_IDIndicador:=Indicador.EIS_IN_ID;
	END LOOP;


	--	únicamente si el indicador es múltiple añadimos la restricción al SQl, sino utilizaremos BIND VARIABLES
	IF v_IDIndicador IS NULL THEN
		vFiltroSQL:=vFiltroSQL||vFiltroIndicadorSQL;
	END IF;

	IF vFiltroSQL IS NOT NULL THEN
		vFiltroSQL:=' AND ('||vFiltroSQL||') '||p_FiltroSQL;
	ELSE
		vFiltroSQL:=p_FiltroSQL;	--	28abr09	ET	Faltaba esta linea, no se creaba correctamente el filtro para llamar a los desplegables
	END IF;

	v_Debug:='Vectores.';
	
	--	19abr12	Utilizamos los vectores para hacer la consulta una única vez
	PrepararVectores
	(
		v_IDIndicador,
		v_IDEmpresa,
		vFiltroSQL,
		v_VectorEmpresas,
		v_VectorEmpresas2,
		v_VectorEstados,
		v_VectorCategorias,
		v_VectorFamilias
	);
	
	--	20ene14	Completamos los vectores con las selecciones personalizadas
	EISSelecciones_PCK.SeleccionesAVector(p_IDUSUARIO, 'EMP', v_VectorEmpresas, 25);
	EISSelecciones_PCK.SeleccionesAVector(p_IDUSUARIO, 'EMP2', v_VectorEmpresas2, 25);
	EISSelecciones_PCK.SeleccionesAVector(p_IDUSUARIO, 'EST', v_VectorEstados, 25);
	EISSelecciones_PCK.SeleccionesAVector(p_IDUSUARIO, 'CAT', v_VectorCategorias, 25);
	EISSelecciones_PCK.SeleccionesAVector(p_IDUSUARIO, 'FAM', v_VectorFamilias, 25);
	
	v_Debug:='Datos indicador.';
		
	FOR Indicador IN cIndicadores(p_IDCuadromando) LOOP
		--	Filtros activados que permitiran agrupar
		FEmpresa:=Indicador.EIS_IN_F_EMPRESA;
		FCentro:=Indicador.EIS_IN_F_CENTRO;
		FUsuario:=Indicador.EIS_IN_F_USUARIO;
		FEmpresa2:=Indicador.EIS_IN_F_EMPRESA2;
		FProducto:=Indicador.EIS_IN_F_PRODUCTO;
		FNomenclator:=Indicador.EIS_IN_F_NOMENCLATOR;
		FUrgencias:=Indicador.EIS_IN_F_URGENCIAS;
		FEstado:=Indicador.EIS_IN_F_ESTADO;
		FGravedad:=Indicador.EIS_IN_F_GRAVEDAD;
		FTipoIncidencias:=Indicador.EIS_IN_F_TIPOINCIDENCIAS;
		--	Nombre de la empresa 2
		IF v_IDIdioma=0 THEN
			vNombreEmpresa2:=Indicador.EIS_IN_NOMBREEMPRESA2;	--Contraparte: Cliente, proveedor, reclamante, reclamado, etc.
		ELSE
			vNombreEmpresa2:=Indicador.EIS_IN_NOMBREEMPRESA2_BR;	--	8jun12	Contraparte en portugués.
		END IF;
	END LOOP;

	v_Debug:='XML.';
	
	HTP.P('<FILTROS>'
		||	'<MOSTRARCATEGORIAS>'	||v_CP_Categorias	||	'</MOSTRARCATEGORIAS>'
		||	'<MOSTRARGRUPOS>'		||v_CP_Grupos		||	'</MOSTRARGRUPOS>'
	);

	Empresas_Pck.NombresNiveles_XML(v_IDEmpresa, v_IDPais);
	
	-- 	Recorremos todos los cuadros de mando
	HTP.P('<field label="'|| Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_CUADRODEMANDO')||'" name="IDCUADROMANDO" current="'|| p_IDCuadromando ||'">'
		||'<dropDownList>');
	FOR Cuadro IN cCuadrosDeMando(p_IDUSUARIO, v_PreciosConIva, p_DerechosUsuario, v_Rol) LOOP
		HTP.P('<listElem>'
			||'<ID>'		|| Cuadro.EIS_CM_ID 										||'</ID>'
			||'<listItem>'	|| Utilidades_pck.TextoMensaje(v_IDIdioma,'EIS_CM_'||Cuadro.EIS_CM_ID) ||'</listItem>');
		/*
		IF v_IDIdioma=0 THEN
			HTP.P('<listItem>'|| Cuadro.EIS_CM_Nombre ||'</listItem>');
		ELSIF v_IDIdioma=2 THEN
			HTP.P('<listItem>'|| Cuadro.EIS_CM_Nombre_BR ||'</listItem>');
		END IF;	*/
		HTP.P('</listElem>');
	END LOOP; -- Bucle para todos los indicadores
	HTP.P('</dropDownList>');
	HTP.P('</field>');

	--	Años activos en el sistema
	HTP.P('<field label="'|| Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_ANNO')||'" name="ANNO" current="'|| p_ANNO ||'">'
		||'<dropDownList>'
		||'<listElem>'
		||'<ID>9999</ID>'
		||'<listItem>Ultimos 12 meses</listItem>'
		||'</listElem>');
	FOR Anno IN cAnnos  LOOP
		HTP.P('<listElem>'
			||'<ID>'|| Anno.EIS_AN_ID ||'</ID>'
			||'<listItem>'|| Anno.EIS_AN_ID ||'</listItem>'
			||'</listElem>');
	END LOOP; -- Bucle para el indicador (Solo 1 registro )
	HTP.P('</dropDownList>');
	HTP.P('</field>');



	--	En funcion del perfil del usuario:
	--	Normal: NO presentamos filtro
	--	Gerente: Presentamos filtro de usuarios y de centros
	--	Administrador MVM: Presentamos filtro de empresas
	--	24abr13 Administrador MVM: No presentamos filtro de centros
	IF p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB'	THEN
	/*
		HTP.P('<field label="Empresa" name="IDEMPRESA" current="'|| p_IDEmpresa ||'">');
		HTP.P('<dropDownList>');
		HTP.P('<listElem>');
		HTP.P('<ID>-1</ID>');
		HTP.P('<listItem>Todas las Empresas</listItem>');
		HTP.P('</listElem>');
		FOR Empresa IN cEmpresasMVM(p_IDCuadromando)  LOOP -- Bucle para el indicador (Solo 1 registro )
			HTP.P('<listElem>');
			HTP.P('<ID>'|| Empresa.EMP_ID ||'</ID>');
			HTP.P('<listItem>'|| MVM.ScapeHTMLString(Empresa.EMP_Nombre) ||'</listItem>');
			HTP.P('</listElem>');
		END LOOP;
		HTP.P('</dropDownList>');
		HTP.P('</field>');
	*/
		--	Filtramos según la consulta
		--EnviaValoresFiltro(v_IDIndicador, 'IDEMPRESA', 'EIS_VA_IDEMPRESA','EIS_VA_EMPRESA', 'Empresa', p_IDEmpresa, vFiltroSQL );
		--	19abr12	Utilizamos vectores
		vector_pck.vecBuscarElemento(v_VectorEmpresas, p_IDEmpresa);
		vector_pck.vecLista_XML(v_VectorEmpresas, 'IDEMPRESA', 'Empresa','N','N');
	ELSIF  p_DerechosUsuario='EMPRESA'  OR p_DerechosUsuario='MULTICENTROS' THEN	--	16feb17 MULTICENTROS
		HTP.P('<field label="'|| Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_CENTRO')||'" name="IDCENTRO" current="'|| p_IDCENTRO ||'">'
			||'<dropDownList>'
			||'<listElem>'
			||'<ID>-1</ID>'
			||'<listItem>Todos los Centros</listItem>'
			||'</listElem>');

			--	16feb17 Para usuarios de EMPRESA, todos los centros
			IF p_DerechosUsuario='EMPRESA' THEN
				FOR Centro IN cCentrosUsuarioGerente(p_IDCuadromando, v_IDEmpresa)  LOOP -- Bucle para el indicador (Solo 1 registro )
					HTP.P('<listElem>'
						||'<ID>'		|| Centro.CEN_ID 							||'</ID>'
						||'<listItem>'	|| MVM.ScapeHTMLString(Centro.CEN_Nombre)	||'</listItem>'
						||'</listElem>');
				END LOOP;
			ELSE
				FOR Centro IN cCentrosUsuarioMultiCentro(p_IDUsuario)  LOOP 
					HTP.P('<listElem>'
						||'<ID>'		|| Centro.CEN_ID 							||'</ID>'
						||'<listItem>'	|| MVM.ScapeHTMLString(Centro.CEN_Nombre)	||'</listItem>'
						||'</listElem>');
				END LOOP;
			END IF;

			EISSelecciones_PCK.Selecciones_XML(p_IDUSUARIO, 'CEN', 'listElem', 'ID', 'listItem', 25);

		HTP.P('</dropDownList>'
			||'</field>');
	ELSE
		--	10may13	Para usuarios normales mostramos el desplegable de centros desactivado
		HTP.P('<field label="'|| Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_CENTRO')||'" name="IDCENTRO" current="'|| v_IDCentro ||'" disabled="disabled">'
			||'<dropDownList>');
			FOR Centro IN cCentroUsuario(p_IDUsuario)  LOOP -- Bucle para el indicador (Solo 1 registro )
				HTP.P('<listElem>'
					||'<ID>'		|| Centro.CEN_ID 							||'</ID>'
					||'<listItem>'	|| MVM.ScapeHTMLString(Centro.CEN_Nombre) 	||'</listItem>'
					||'</listElem>');
			END LOOP;
		HTP.P('</dropDownList>'
			||'</field>');

	END IF;



	--	Los siguientes filtros los crea cargando los datos existentes en la tabla de resumen
	--	Si esta disponible, presenta el filtro de "Empresa2"
	IF FEmpresa2='S' THEN
		--EnviaValoresFiltro(v_IDIndicador, 'IDEMPRESA2', 'EIS_VA_IDEMPRESA2','EIS_VA_EMPRESA2', vNombreEmpresa2, p_IDEmpresa2, vFiltroSQL );
		--	19abr12	Utilizamos vectores
		vector_pck.vecBuscarElemento(v_VectorEmpresas2, p_IDEmpresa2);
		vector_pck.vecLista_XML(v_VectorEmpresas2, 'IDEMPRESA2', vNombreEmpresa2,'N','N');
	END IF;

	--	20nov13 Siempre necesitamos el filtro. Antes: si esta disponible, presenta el filtro de Estado
	--	20nov13IF FEstado='S' THEN
		--EnviaValoresFiltro(v_IDIndicador, 'IDESTADO', 'EIS_VA_IDESTADO','EIS_VA_ESTADO', 'Estado', p_IDESTADO, vFiltroSQL );
		--	19abr12	Utilizamos vectores
		vector_pck.vecBuscarElemento(v_VectorEstados, p_IDESTADO);
		vector_pck.vecLista_XML(v_VectorEstados, 'IDESTADO', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_ESTADO'),'N','N');
	--	20nov13END IF;

	--	30abr13 El catalogo privado solo lo mostramos para clientes
	IF v_Rol='COMPRADOR' THEN
		--	25abr13	Si estamos en una empresa de 5 niveles, mostramos las categorías
		IF v_CP_Categorias='S' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB' THEN

			--30abr13	vector_pck.vecBuscarElemento(v_VectorCategorias, p_IDCATEGORIA);
			--30abr13	vector_pck.vecLista_XML(v_VectorCategorias, 'IDCATEGORIA', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_CATEGORIA'),'N','N');

			DesplegableBloqueado_XML('IDCATEGORIA', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_CATEGORIA'));
			DesplegableBloqueado_XML('IDFAMILIA', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_FAMILIA'));
		ELSE
			--	18may11	Enviamos siempre el filtro por familias (antes solo cuando se enviaba el filtro por productos)
			--			Pero ahora se filtra solo por la referencia de la familia
			--EnviaValoresFiltro(v_IDIndicador, 'IDFAMILIA', 'SUBSTR(EIS_VA_REFPRODUCTO,1,2)','SUBSTR(EIS_VA_REFPRODUCTO,1,2)||'':''||lower(EIS_VA_FAMILIA)', 'Familia', p_IDFAMILIA, vFiltroSQL );
			--catalogoprivado_pck.NombreFamilia(catalogoprivado_pck.IdentificadorFamilia(EIS_VA_IDEMPRESA, SUBSTR(EIS_VA_REFPRODUCTO,1,2))))
			--	19abr12	Utilizamos vectores
			vector_pck.vecBuscarElemento(v_VectorFamilias, p_IDFAMILIA);
			vector_pck.vecLista_XML(v_VectorFamilias, 'IDFAMILIA', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_FAMILIA'),'N','N');
		END IF;	

		DesplegableBloqueado_XML('IDSUBFAMILIA', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_SUBFAMILIA'));
		IF v_CP_Grupos='S' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB' THEN
			DesplegableBloqueado_XML('IDGRUPO', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_GRUPO'));
		END IF;
		DesplegableBloqueado_XML('IDPRODUCTOESTANDAR', Utilidades_pck.TextoMensaje(v_IDIdioma, 'EIS_PRODUCTOESTANDAR'));
	END IF;
		

	--	Si esta disponible, presenta el filtro de Producto (y/o Nomenclator) y el de familia
	--	28abr09	ET	Este filtro incluye demasiados datos, lo quitamos
	--	3nov11	ET	Quitamos 
	--IF FProducto='S' AND USUARIOS_PCK.EISFiltroProductos(p_IDUSUARIO)='S' THEN
	--	EnviaValoresFiltro(v_IDIndicador, 'IDPRODUCTO', 'EIS_VA_IDPRODUCTO','EIS_VA_PRODUCTO', 'Producto', p_IDPRODUCTO, vFiltroSQL );
	--END IF;

	--	Si esta disponible, presenta el filtro de tipo de incidencia
	--3abr12	IF 	FTipoIncidencias='S' THEN
	--3abr12		EnviaValoresFiltro(v_IDIndicador, 'IDTIPOINCIDENCIA', 'EIS_VA_IDTIPOINCIDENCIA','EIS_VA_TIPOINCIDENCIA', 'Tipo', p_IDTIPOINCIDENCIA, vFiltroSQL );
	--3abr12	END IF;

	--	Si esta disponible, presenta el filtro de gravedad de la incidencia
	--3abr12	IF 	FGravedad='S' THEN
	--3abr12		EnviaValoresFiltro(v_IDIndicador, 'IDGRAVEDAD', 'EIS_VA_IDGRAVEDAD','EIS_VA_GRAVEDAD', 'Gravedad', p_IDGRAVEDAD, vFiltroSQL );
	--3abr12	END IF;

	--	Pendiente
	--	Si esta disponible, presenta el filtro de Nomenclator
	--	Si esta disponible, presenta el filtro de Urgencias


	HTP.P('</FILTROS>');


	IF v_IDIdioma=0 THEN
		HTP.P('<AGRUPARPOR>'
			||'<field label="Agrupar por" name="AGRUPARPOR" current="'|| p_AgruparPor ||'">'
			||'<dropDownList>'
				||'<listElem>'
				||'<ID>-1</ID>'
				||'<listItem>No Agrupar</listItem>'
				||'</listElem>');
			IF FEmpresa='S' AND (p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
				HTP.P('<listElem>'
					||'<ID>EMP</ID>'
					||'<listItem>Por Empresa</listItem>'
					||'</listElem>');
			END IF;
			IF FCentro='S'  AND (p_DerechosUsuario='EMPRESA' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
				HTP.P('<listElem>'
					||'<ID>CEN</ID>'
					||'<listItem>Por Centro</listItem>'
					||'</listElem>');
			END IF;
			IF FUsuario='S' THEN
				HTP.P('<listElem>'
					||'<ID>USU</ID>'
					||'<listItem>Por Usuario</listItem>'
					||'</listElem>');
			END IF;
			IF FEstado='S' THEN
				HTP.P('<listElem>'
					||'<ID>EST</ID>'
					||'<listItem>Por Estado</listItem>'
					||'</listElem>');
			END IF;
			IF FEmpresa2='S' THEN
				HTP.P('<listElem>'
					||'<ID>EMP2</ID>'
					||'<listItem>Por '|| vNombreEmpresa2 ||'</listItem>'
					||'</listElem>');
			END IF;
			IF FEmpresa2='S' THEN
				HTP.P('<listElem>'
					||'<ID>CEN2</ID>'
					||'<listItem>Por centro '|| vNombreEmpresa2 ||'</listItem>'
					||'</listElem>');
			END IF;
			IF FProducto='S' THEN
				IF  p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB'	THEN
					HTP.P(
						--19mar15		'<listElem>'
						--19mar15	||	'<ID>PRO</ID>'
						--19mar15	||	'<listItem>Por Producto</listItem>'
						--19mar15	||	'</listElem>'
							'<listElem>'
						||'<ID>REF</ID>'
						||'<listItem>Por ref. cliente</listItem>'
						||'</listElem>'
                		||'<listElem>'
                		||'<ID>REFPROV</ID>'
                		||'<listItem>Por ref. proveedor</listItem>'
                		||'</listElem>');
				ELSE	--	15set08	ET	Para los usuarios normales ocultamos la consulta por producto, ya que da ambiguedades y la hacemos por referencia
					HTP.P('<listElem>'
						||'<ID>REF</ID>'
						||'<listItem>Por ref. cliente</listItem>'			--	19mar15	Por Producto
						||'</listElem>'
                		||'<listElem>'
                		||'<ID>REFPROV</ID>'
                		||'<listItem>Por ref. proveedor</listItem>'
                		||'</listElem>');
				END IF;
				HTP.P('<listElem>'
					||'<ID>DES</ID>'
					||'<listItem>Por Descripción</listItem>'	--	19set08	ET	agrupamos por descripción estándar
					||'</listElem>');
				IF p_ANNO>=c_AnnoFuncionesAvanzadas AND (v_CP_Categorias='S' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
					HTP.P('<listElem>'
						||'<ID>CAT</ID>'
						||'<listItem>Por Categoría</listItem>'
						||'</listElem>');
				END IF;
				HTP.P('<listElem>'
					||'<ID>FAM</ID>'
					||'<listItem>Por Familia</listItem>'
					||'</listElem>');
				IF p_ANNO>=c_AnnoFuncionesAvanzadas THEN
					HTP.P('<listElem>'
						||'<ID>SF</ID>'
						||'<listItem>Por Subfamilia</listItem>'
						||'</listElem>');
				END IF;
				IF p_ANNO>=c_AnnoFuncionesAvanzadas AND (v_CP_Grupos='S' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
					HTP.P('<listElem>'
						||'<ID>GRU</ID>'
						||'<listItem>Por Grupo</listItem>'
						||'</listElem>');
				END IF;
			END IF;
        	/*	16abr13
			IF FNomenclator='S' THEN
				HTP.P('<listElem>');
				HTP.P('<ID>NOM</ID>');
				HTP.P('<listItem>Por Nomenclator</listItem>');
				HTP.P('</listElem>');
			END IF;
			IF 	FTipoIncidencias='S' THEN
				HTP.P('<listElem>');
				HTP.P('<ID>TIP</ID>');
				HTP.P('<listItem>Tipo de Incidencia</listItem>');
				HTP.P('</listElem>');
			END IF;
			IF 	FGravedad='S' THEN
				HTP.P('<listElem>');
				HTP.P('<ID>GRA</ID>');
				HTP.P('<listItem>Gravedad de Incidencia</listItem>');
				HTP.P('</listElem>');
			END IF;
			IF FUrgencias='S' THEN
				HTP.P('<listElem>');
				HTP.P('<ID>URG</ID>');
				HTP.P('<listItem>Por Urgencias</listItem>');
				HTP.P('</listElem>');
			END IF;*/
		HTP.P('</dropDownList>'
			||'</field>'
			||'</AGRUPARPOR>'

		-- 	Tipos de resultados: Acumulado, porcentaje (mensual u horizontal) o ratio
			||'<IDRESULTADOS>'
			||'<field label="Resultados" name="IDRESULTADOS" current="'||p_IDResultados||'">'
			||'<dropDownList>'
				||'<listElem>'
				||'<ID>ACUM</ID>'
				||'<listItem>Acumulado Mensual</listItem>'
				||'</listElem>');
			IF  p_DerechosUsuario='EMPRESA'	OR p_DerechosUsuario='MVM'	OR p_DerechosUsuario='MVMB' THEN
				HTP.P('<listElem>'
					||'<ID>LABOR</ID>'
					||'<listItem>Acumulado Mensual/días laborables</listItem>'
					||'</listElem>');
			END IF;
			HTP.P('<listElem>'
				||'<ID>PORCV</ID>'
				||'<listItem>Porcentaje Mensual</listItem>'
				||'</listElem>'
		   		||'<listElem>'
				||'<ID>PORCH</ID>'
				||'<listItem>Porcentaje Horizontal</listItem>'
				||'</listElem>'
				||'<listElem>'
				||'<ID>RATIO</ID>'
				||'<listItem>Ratio</listItem>'
				||'</listElem>'
			||'</dropDownList>'
			||'</field>'
			||'</IDRESULTADOS>'

		-- 	Tipos de resultados: Acumulado, porcentaje (mensual u horizontal) o ratio
			||'<IDRATIO>'
			||'<field label="Tipo de ratio" name="IDRATIO" current="'||p_RatioSobre||'">'
			||'<dropDownList>'
			--	Ratios solo para la direccion de la empresa
			--IF  p_DerechosUsuario='EMPRESA'	OR p_DerechosUsuario='MVM' THEN
			--	HTP.P('<listElem>');
			--	HTP.P('<ID>CAMAS</ID>');
			--	HTP.P('<listItem>Sobre el número de camas</listItem>');
			--	HTP.P('</listElem>');
			--	HTP.P('<listElem>');
			--	HTP.P('<ID>OBJETIVOPEDIDOS</ID>');
			--	HTP.P('<listItem>Sobre el objetivo de pedidos mensual</listItem>');
			--	HTP.P('</listElem>');
			--END IF;
				||'<listElem>'
				||'<ID>CO_PED_EUR</ID>'
				||'<listItem>Sobre el volumen de pedidos en euros</listItem>'
				||'</listElem>'
				||'<listElem>'
				||'<ID>CO_PED_NUM</ID>'
				||'<listItem>Sobre el número de pedidos</listItem>'
				||'</listElem>'
				||'<listElem>'
				||'<ID>CO_PED_CANT</ID>'
				||'<listItem>Sobre el num. unidades minimas</listItem>'
				||'</listElem>'
			||'</dropDownList>'
			||'</field>'
			||'</IDRATIO>');
	ELSIF v_IDIdioma=2 THEN
		--	5jun12	Portugués
		HTP.P('<AGRUPARPOR>'
    		||'<field label="Agrupar por" name="AGRUPARPOR" current="'|| p_AgruparPor ||'">'
    		||'<dropDownList>'
        		||'<listElem>'
        		||'<ID>-1</ID>'
        		||'<listItem>Não Agrupar</listItem>'
        		||'</listElem>');
        	IF FEmpresa='S' AND (p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
            	HTP.P('<listElem>'
            		||'<ID>EMP</ID>'
            		||'<listItem>Por Empresa</listItem>'
            		||'</listElem>');
        	END IF;
        	IF FCentro='S'  AND (p_DerechosUsuario='EMPRESA' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
            	HTP.P('<listElem>'
            		||'<ID>CEN</ID>'
            		||'<listItem>Por Centro</listItem>'
            		||'</listElem>');
        	END IF;
        	IF FUsuario='S' THEN
            	HTP.P('<listElem>'
            		||'<ID>USU</ID>'
            		||'<listItem>Por Usuário</listItem>'
            		||'</listElem>');
        	END IF;
        	IF FEstado='S' THEN
            	HTP.P('<listElem>'
            		||'<ID>EST</ID>'
            		||'<listItem>Por Estado</listItem>'
            		||'</listElem>');
        	END IF;
        	IF FEmpresa2='S' THEN
            	HTP.P('<listElem>'
            		||'<ID>EMP2</ID>'
                	||'<listItem>Por '|| vNombreEmpresa2 ||'</listItem>'
            		||'</listElem>');
        	END IF;
			IF FEmpresa2='S' THEN
				HTP.P('<listElem>'
					||'<ID>CEN2</ID>'
					||'<listItem>Por centro '|| vNombreEmpresa2 ||'</listItem>'
					||'</listElem>');
			END IF;
        	IF FProducto='S' THEN
            	IF  p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB'    THEN
                	HTP.P(
						--19mar15	'<listElem>'
                		--19mar15	||'<ID>PRO</ID>'
                		--19mar15	||'<listItem>Por Produto</listItem>'
                		--19mar15	||'</listElem>'
                			'<listElem>'
                		||'<ID>REF</ID>'
                		||'<listItem>Por ref. cliente</listItem>'
                		||'</listElem>'
                		||'<listElem>'
                		||'<ID>REFPROV</ID>'
                		||'<listItem>Por ref. forneçedor</listItem>'
                		||'</listElem>');
            	ELSE    --    15set08    ET    Para los usuarios normales ocultamos la consulta por producto, ya que da ambiguedades y la hacemos por referencia
                	HTP.P('<listElem>'
                		||'<ID>REF</ID>'
                		||'<listItem>Por ref. cliente</listItem>'			--	19mar15	Por Produto
                		||'</listElem>'
                		||'<listElem>'
                		||'<ID>REFPROV</ID>'
                		||'<listItem>Por ref. forneçedor</listItem>'
                		||'</listElem>');
            	END IF;
            	HTP.P('<listElem>'
            		||'<ID>DES</ID>'
            		||'<listItem>Por Descrição</listItem>'    --    19set08    ET    Ordenamos por descripción estándar
                	||'</listElem>');
				IF p_ANNO>=c_AnnoFuncionesAvanzadas AND (v_CP_Categorias='S' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
					HTP.P('<listElem>'
						||'<ID>CAT</ID>'
						||'<listItem>Por Categoría</listItem>'
						||'</listElem>');
				END IF;
            	HTP.P('<listElem>'
            		||'<ID>FAM</ID>'
            		||'<listItem>Por Familia</listItem>'
            		||'</listElem>');
				IF p_ANNO>=c_AnnoFuncionesAvanzadas THEN
					HTP.P('<listElem>'
						||'<ID>SF</ID>'
						||'<listItem>Por Subfamilia</listItem>'
						||'</listElem>');
				END IF;
				IF p_ANNO>=c_AnnoFuncionesAvanzadas AND (v_CP_Grupos='S' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB') THEN
					HTP.P('<listElem>'
						||'<ID>GRU</ID>'
						||'<listItem>Por Grupo</listItem>'
						||'</listElem>');
				END IF;
        	END IF;
        	/*	16abr13
			IF FNomenclator='S' THEN
            	HTP.P('<listElem>');
            	HTP.P('<ID>NOM</ID>');
            	HTP.P('<listItem>Por Nomenclatura</listItem>');
            	HTP.P('</listElem>');
        	END IF;
        	IF     FTipoIncidencias='S' THEN
            	HTP.P('<listElem>');
            	HTP.P('<ID>TIP</ID>');
            	HTP.P('<listItem>Tipo de Incidencia</listItem>');
            	HTP.P('</listElem>');
        	END IF;
        	IF     FGravedad='S' THEN
            	HTP.P('<listElem>');
            	HTP.P('<ID>GRA</ID>');
            	HTP.P('<listItem>Gravedade da Incidencia</listItem>');
            	HTP.P('</listElem>');
        	END IF;
        	IF FUrgencias='S' THEN
            	HTP.P('<listElem>');
            	HTP.P('<ID>URG</ID>');
            	HTP.P('<listItem>Por Urgências</listItem>');
            	HTP.P('</listElem>');
        	END IF;*/
    	HTP.P('</dropDownList>'
    		||'</field>'
    		||'</AGRUPARPOR>');

    	--     Tipos de resultados: Acumulado, porcentaje (mensual u horizontal) o ratio
    	HTP.P('<IDRESULTADOS>'
    		||'<field label="Resultados" name="IDRESULTADOS" current="'||p_IDResultados||'">'
    		||'<dropDownList>'
        		||'<listElem>'
            	||'<ID>ACUM</ID>'
        		||'<listItem>Acumulado Mensal</listItem>'
        		||'</listElem>');
        	IF  p_DerechosUsuario='EMPRESA' OR p_DerechosUsuario='MVM' OR p_DerechosUsuario='MVMB' THEN
            	HTP.P('<listElem>'
            		||'<ID>LABOR</ID>'
            		||'<listItem>Acumulado Mensal/dias úteis</listItem>'
            		||'</listElem>');
        	END IF;
        	HTP.P('<listElem>'
        		||'<ID>PORCV</ID>'
        		||'<listItem>Porcentagem Mensal</listItem>'
        		||'</listElem>'
        		||'<listElem>'
        		||'<ID>PORCH</ID>'
        		||'<listItem>Porcentagem Horizontal</listItem>'
        		||'</listElem>'
        		||'<listElem>'
        		||'<ID>RATIO</ID>'
        		||'<listItem>Ratio</listItem>'
        		||'</listElem>'
    		||'</dropDownList>'
    		||'</field>'
    		||'</IDRESULTADOS>'

    	--     Tipos de resultados: Acumulado, porcentaje (mensual u horizontal) o ratio
    		||'<IDRATIO>'
    		||'<field label="Tipo de ratio" name="IDRATIO" current="'||p_RatioSobre||'">'
    		||'<dropDownList>'
        	--    Ratios solo para la direccion de la empresa
        	--IF  p_DerechosUsuario='EMPRESA'    OR p_DerechosUsuario='MVM' THEN
        	--    HTP.P('<listElem>');
        	--    HTP.P('<ID>LEITOS</ID>');
        	--    HTP.P('<listItem>Sobre o número de leitos</listItem>');
        	--    HTP.P('</listElem>');
        	--    HTP.P('<listElem>');
        	--    HTP.P('<ID>OBJETIVOPEDIDOS</ID>');
        	--    HTP.P('<listItem>Sobre o objetivo de pedidos mensal</listItem>');
        	--    HTP.P('</listElem>');
        	--END IF;
        		||'<listElem>'
        		||'<ID>CO_PED_EUR</ID>'
        		||'<listItem>Sobre o volume de pedidos em reais</listItem>'
        		||'</listElem>'
        		||'<listElem>'
        		||'<ID>CO_PED_NUM</ID>'
        		||'<listItem>Sobre o número de pedidos</listItem>'
        		||'</listElem>'
				||'<listElem>'
				||'<ID>CO_PED_CANT</ID>'
				||'<listItem>Sobre o num. unidades minimas</listItem>'
				||'</listElem>'
    		||'</dropDownList>'
    		||'</field>'
    		||'</IDRATIO>');

	END IF;	

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.EnviaDesplegablesCabecera_XML',v_Debug||' SQLERRM:'||SQLERRM);
END;


/*
	FUNCTION PreparaFiltroCuadroDeMando

	Crea el filtro SQL en base a las condiciones de la seleccion del usuario
	
	--	18may11	La restriccion "por familia" la hacemos por la ref.estandar en lugar del ID de familia
	--	3may12	Familia "Material sanitario" (todo menos farmacia)
	--	7dic12	Volvemos a utilizar el ID de familia
	--	5set13	Índice CATSEARCH en lugar de CONTEXT
*/
FUNCTION RestriccionConsulta
(
	p_IDUSUARIO				VARCHAR2,
	p_IDCUADROMANDO 		VARCHAR2,
	p_ANNO 					VARCHAR2,
	p_IDPAIS				VARCHAR2,
	p_IDEmpresa				VARCHAR2,
	p_IDCENTRO 				VARCHAR2,
	p_IDUSUARIOSEL			VARCHAR2,
	p_IDEmpresa2			VARCHAR2,
	p_IDCENTRO2				VARCHAR2,	--16abr13
	p_IDPRODESTANDAR		VARCHAR2,
	p_IDGRUPO				VARCHAR2,	--16abr13
	p_IDSUBFAMILIA			VARCHAR2,	--16abr13
	p_IDFAMILIA				VARCHAR2,	--16abr13
	p_IDCATEGORIA			VARCHAR2,	--16abr13
	--16abr13	p_IDNOMENCLATOR			VARCHAR2,
	--16abr13	p_URGENCIA				VARCHAR2,
	p_IDESTADO				VARCHAR2,
	--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
	--16abr13	p_IDGRAVEDAD			VARCHAR2,
	p_REFERENCIA			VARCHAR2,
	p_CODIGO				VARCHAR2,
	p_AgruparPor			VARCHAR2,
	p_DerechosUsuario		VARCHAR2,
	p_RestriccionAdicional	VARCHAR2	DEFAULT NULL
) RETURN VARCHAR2
IS
	--	Indicadores del cuadro de mando
	CURSOR	cIndicadores(IDCuadro IN VARCHAR2) IS
		SELECT	EIS_IN_ID, EIS_IN_NOMBRE, EIS_IN_NOMBRECORTO, EIS_IN_MANUAL,
				EIS_IN_RESTRICCIONES, EIS_IN_ACTUALIZACION, EIS_IN_F_EMPRESA, EIS_IN_F_CENTRO,
				EIS_IN_F_USUARIO, EIS_IN_F_EMPRESA2, EIS_IN_F_PRODUCTO,
				EIS_IN_F_NOMENCLATOR, EIS_IN_F_URGENCIAS, EIS_IN_F_ESTADO, EIS_IN_NOMBREEMPRESA2,
				EIS_IN_F_GRAVEDAD,EIS_IN_F_TIPOINCIDENCIAS
		FROM	EIS_INDICADORESPORCUADRO, EIS_INDICADORES
		WHERE	EIS_CI_IDINDICADOR	=EIS_IN_ID
			AND	EIS_CI_IDCUADRO		=IDCuadro;

	--	Cursor con los centros autorizados para el usuario
	CURSOR	cCentroYEmpresa(p_USUARIO NUMBER)  IS
		SELECT		CEN_ID, CEN_IDEMPRESA
			FROM	CENTROS, USUARIOS
			WHERE	CEN_ID=US_IDCENTRO
			AND		US_ID=p_IDUSUARIO
			AND		CEN_STATUS IS NULL;

	vFiltroSQL			VARCHAR2(3000);
	v_REFERENCIA		VARCHAR2(1000);
	v_CODIGO			VARCHAR2(1000);
	vCount				INTEGER;

	v_Status			VARCHAR2(3000);

	v_AnnoActual		INTEGER;
	v_MesActual			INTEGER;
	
	v_FiltroCatsearch	VARCHAR2(1000);		--	2set13	Filtro interno para mejor rendimiento del CATSEARCH
	
	v_Seleccion			VARCHAR2(1000);		--	20ene14	Para montar las selecciones de los usuarios
	--	18ene13	Utilizamos un índice de fecha
	--v_FechaActual		DATE;
	--v_FechaInicial		DATE;
BEGIN
	/*Utilidades_pck.debug('EIS_PCK.RestriccionConsulta.'
		||' p_IDUSUARIO:'||p_IDUSUARIO
		||' p_IDCUADROMANDO:'||p_IDCUADROMANDO
		||' p_REFERENCIA:'||p_REFERENCIA
		||' p_ANNO :'|| p_ANNO
		||' p_IDEmpresa:'||p_IDEmpresa
		||' p_IDCENTRO :'|| p_IDCENTRO 
		||' p_IDUSUARIOSEL:'|| p_IDUSUARIOSEL
		||' p_IDEmpresa2:'|| p_IDEmpresa2
		||' p_IDCENTRO2:'|| p_IDCENTRO2
		||' p_IDPRODESTANDAR:'|| p_IDPRODESTANDAR
		||' p_IDGRUPO:'|| p_IDGRUPO
		||' p_IDSUBFAMILIA:'|| p_IDSUBFAMILIA
		||' p_IDFAMILIA:'||p_IDFAMILIA
		||' p_IDCATEGORIA:'|| p_IDCATEGORIA
		||' p_IDESTADO:'|| p_IDESTADO
		||' p_CODIGO:'||p_CODIGO
		||' p_AgruparPor:'|| p_AgruparPor
		||' p_RestriccionAdicional:'|| p_RestriccionAdicional
			);*/

	--	Tambien utiliza la lista de indicadores para saber que indicadores del resumen consultar

	vFiltroSQL:=null;

	v_Status:='Fecha';
	IF p_Anno=9999 THEN
		v_AnnoActual:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'));
		v_MesActual:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'));
		
		--18ene13	vFiltroSQL:=vFiltroSQL	||' AND ((EIS_VA_ANNO='||to_char(v_AnnoActual-1)||' AND EIS_VA_MES>'||v_MesActual||')'
		--18ene13						||' OR (EIS_VA_ANNO='||v_AnnoActual||' AND EIS_VA_MES<='||v_MesActual||'))';
		
		--18ene13 Restamos 360 días para situarnos en el mes siguiente del año anterior, será siempre superior al 1/mm/yyyy
		--1mar13	Problemas el día 1 de marzo! vFiltroSQL:=vFiltroSQL	||' AND EIS_VA_INDICEFECHA>SYSDATE-365';
		vFiltroSQL:=vFiltroSQL	||' AND EIS_VA_INDICEFECHA>TO_DATE(''1/'||v_MesActual||'/'||TO_CHAR(v_AnnoActual-1)||''',''dd/mm/yyyy'')';
		
		v_FiltroCatsearch:=' EIS_VA_INDICEFECHA>TO_DATE(''''1/'||v_MesActual||'/'||TO_CHAR(v_AnnoActual-1)||''''',''''dd/mm/yyyy'''')';--	5set13
		
	ELSE
		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_ANNO='||p_Anno;

		v_FiltroCatsearch:=' EIS_VA_INDICEFECHA>=TO_DATE(''''1/1/'||TO_CHAR(p_Anno)||''''',''''dd/mm/yyyy'''')';		--	5set13
	END IF;

	--	Restriccion en funcion del tipo de usuario
	v_Status:='Derechos Usuario';
	FOR CentroYEmpresa IN cCentroYEmpresa(p_IDUSUARIO) LOOP	--Solo una vez
		IF p_DerechosUsuario='MVM'	THEN		--	16feb17
			NULL;
		ELSIF p_DerechosUsuario='EMPRESA'	THEN
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDEMPRESA='||CentroYEmpresa.CEN_IDEMPRESA;
		ELSIF  p_DerechosUsuario='MULTICENTROS'	THEN
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCENTRO IN (SELECT UCA_IDCENTRO FROM USUARIOS_CENTROSAUTORIZADOS WHERE UCA_IDUSUARIO='||p_IDUSUARIO||' AND UCA_AUTORIZADO=''S'')';
		ELSIF  p_DerechosUsuario='CENTRO'	THEN
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCENTRO='||CentroYEmpresa.CEN_ID;
		ELSIF  p_DerechosUsuario='NORMAL'	THEN
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDUSUARIO='||p_IDUSUARIO;
		ELSE 		--	14feb17 Si hay algn problema con los derechos, mejor recortar a que vean demasiado
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDUSUARIO='||p_IDUSUARIO;
		END IF;
	END LOOP;

	v_Status:='Pais';
	IF	p_IDPAIS IS NOT NULL AND p_IDPAIS<>'-1' THEN
		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDPAIS='||p_IDPAIS;
	END IF;

	v_Status:='Empresa';
	IF p_IDEmpresa IS NOT NULL AND p_IDEmpresa<>'-1' THEN
		IF SUBSTR(p_IDEmpresa,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDEmpresa,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDEMPRESA'||v_Seleccion;
			v_FiltroCatsearch:=v_FiltroCatsearch||' AND EIS_VA_IDEMPRESA'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDEMPRESA='||p_IDEmpresa;
			v_FiltroCatsearch:=v_FiltroCatsearch||' AND EIS_VA_IDEMPRESA='||p_IDEmpresa;		--	5set13
		END IF;
	END IF;

	v_Status:='Centro';
	IF	p_IDCENTRO IS NOT NULL AND	p_IDCENTRO<>'-1' THEN
		IF SUBSTR(p_IDCENTRO,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDCENTRO,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCENTRO'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCENTRO='||p_IDCENTRO;
		END IF;
	END IF;

	v_Status:='Centro';
	IF	p_IDUSUARIOSEL IS NOT NULL AND p_IDUSUARIOSEL<>'-1' THEN
		IF SUBSTR(p_IDUSUARIOSEL,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDUSUARIOSEL,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDUSUARIO'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDUSUARIO='||p_IDUSUARIOSEL;
		END IF;
	END IF;

	v_Status:='Empresa2';
	IF	p_IDEmpresa2 IS NOT NULL AND p_IDEmpresa2<>'-1' THEN
		IF SUBSTR(p_IDEmpresa2,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDEmpresa2,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDEMPRESA2'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDEMPRESA2='||p_IDEmpresa2;
		END IF;
	END IF;

	v_Status:='Centro2';
	IF	p_IDCENTRO2 IS NOT NULL AND	p_IDCENTRO2<>'-1' THEN
		IF SUBSTR(p_IDCENTRO2,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDCENTRO2,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCENTRO2'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCENTRO2='||p_IDCENTRO2;
		END IF;
	END IF;

	v_Status:='Familia';
	IF	p_IDFAMILIA IS NOT NULL AND p_IDFAMILIA<>'-1' THEN
	/*2may13
		IF	(p_IDEmpresa IS NOT NULL AND p_IDEmpresa<>'-1') AND (p_DerechosUsuario<>'MVM') AND (p_DerechosUsuario<>'MVMB') THEN
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDFAMILIA='||p_IDFAMILIA;	--	3may12
		ELSE
			IF p_IDFAMILIA=-2 THEN
				vFiltroSQL:=vFiltroSQL||' AND EIS_VA_REFFAMILIA<>''30''';	--	3may12
			ELSE
				--	Hay que trabajar con la ref. producto ya que el ID de familia cambia por empresa
				vFiltroSQL:=vFiltroSQL||' AND EIS_VA_REFFAMILIA='''||p_IDFAMILIA||'''';--	3may12
			END IF;
		END IF;*/
		--	Recuperamos el "no farmacia" para ASISA
		IF SUBSTR(p_IDFAMILIA,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDFAMILIA,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDFAMILIA'||v_Seleccion;
		ELSIF p_IDFAMILIA=-2 THEN
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_REFFAMILIA<>''30''';	--	3may12
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDFAMILIA='||p_IDFAMILIA;	--	3may12
		END IF;
	END IF;

	v_Status:='Categoria';
	--	16abr13	Nuevos niveles catálogo privado: Categoría
	IF	p_IDCATEGORIA IS NOT NULL AND p_IDCATEGORIA<>'-1' THEN
	/*2may13
		IF	(p_IDEmpresa IS NOT NULL AND p_IDEmpresa<>'-1') AND (p_DerechosUsuario<>'MVM') AND (p_DerechosUsuario<>'MVMB') THEN
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCATEGORIA='||p_IDCATEGORIA;	--	3may12
		ELSE
			--	Hay que trabajar con la ref. producto ya que el ID de familia cambia por empresa
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_REFCATEGORIA='''||p_IDCATEGORIA||'''';--	3may12
		END IF;*/
		--3dic13	vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCATEGORIA='||p_IDCATEGORIA;	--	3may12

		IF SUBSTR(p_IDCATEGORIA,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDCATEGORIA,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCATEGORIA'||v_Seleccion;
		ELSIF p_IDCATEGORIA='-2' THEN
			IF SUBSTR(p_IDCUADROMANDO,1,10)='CO_Pedidos' THEN
				--	Si estamos en un cuadro de pedidos filtramos por EIS_VA_IDCATEGORIA
				vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCATEGORIA<>1341';	--	No debe ser "Material no licitado" (Solo Viamed)
			ELSE
				--	Si no, filtramos por la lista de proveedores que nos pasó Alfonso
				vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDEMPRESA2 IN (5576,2065,7517,9076,2412,2373,4696,1719,8636,7956,3096, 1904,7736,6196,1901,1420,5516)';	
			END IF;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDCATEGORIA='||p_IDCATEGORIA;
		END IF;
	END IF;

	--30abr13	v_Status:='Producto';
	--30abr13	IF	p_IDPRODUCTO IS NOT NULL AND p_IDPRODUCTO<>-1 THEN
	--30abr13		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDPRODUCTO='||p_IDPRODUCTO;
	--30abr13	END IF;

	v_Status:='Producto estándar';
	IF	p_IDPRODESTANDAR IS NOT NULL AND p_IDPRODESTANDAR<>'-1' THEN
		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDPRODESTANDAR='||p_IDPRODESTANDAR;
	END IF;

	--	16abr13	Nuevos niveles catálogo privado
	v_Status:='Grupo';
	IF	p_IDGRUPO IS NOT NULL AND p_IDGRUPO<>'-1' THEN
		IF SUBSTR(p_IDGRUPO,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDGRUPO,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDGRUPO'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDGRUPO='||p_IDGRUPO;
		END IF;
	END IF;

	--	16abr13	Nuevos niveles catálogo privado
	v_Status:='Subfamilia';
	IF	p_IDSUBFAMILIA IS NOT NULL AND p_IDSUBFAMILIA<>'-1' THEN
		IF SUBSTR(p_IDSUBFAMILIA,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDSUBFAMILIA,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDSUBFAMILIA'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDSUBFAMILIA='||p_IDSUBFAMILIA;
		END IF;
	END IF;


	--16abr13	v_Status:='Nomenclator';
	--16abr13	IF	p_IDNOMENCLATOR IS NOT NULL AND p_IDNOMENCLATOR<>-1 THEN
	--16abr13		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDNOMENCLATOR='||p_IDNOMENCLATOR;
	--16abr13	END IF;

	--16abr13	v_Status:='Urgencia';
	--16abr13	IF	p_URGENCIA IS NOT NULL AND p_URGENCIA<>-1 THEN
	--16abr13		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_URGENCIA='||p_URGENCIA;
	--16abr13	END IF;

	v_Status:='IDEstado';
	IF	p_IDESTADO IS NOT NULL AND p_IDESTADO<>'-1' THEN
		IF SUBSTR(p_IDESTADO,1,4)='SEL_' THEN	--	20ene14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(p_IDESTADO,5,20));
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDESTADO'||v_Seleccion;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDESTADO='''||p_IDESTADO||'''';
		END IF;
	END IF;

	--16abr13	v_Status:='TipoIncidencia';
	--16abr13	IF	p_IDTIPOINCIDENCIA IS NOT NULL AND p_IDTIPOINCIDENCIA<>-1 THEN
	--16abr13		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDTIPOINCIDENCIA='||p_IDTIPOINCIDENCIA;
	--16abr13	END IF;

	--16abr13	v_Status:='Gravedad';
	--16abr13	IF	p_IDGRAVEDAD IS NOT NULL AND p_IDGRAVEDAD<>-1 THEN
	--16abr13		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_IDGRAVEDAD='||p_IDGRAVEDAD;
	--16abr13	END IF;

	v_Status:='Referencia';
	IF	p_REFERENCIA IS NOT NULL THEN
	
		--UTILIDADES_PCK.debug('Paso 1: p_REFERENCIA:['||p_REFERENCIA||'] v_REFERENCIA:['||v_REFERENCIA||']');
	
		/*v_REFERENCIA:=REPLACE(p_REFERENCIA,'*',' ');

		--UTILIDADES_PCK.debug('Paso 2: p_REFERENCIA:['||p_REFERENCIA||'] v_REFERENCIA:['||v_REFERENCIA||']');


		-- la funcion de normalizacion estandar no nos sirve porque elimina los comodines
		SELECT translate(TRIM(UPPER(v_REFERENCIA)),'ÀÁÂÄÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜ*?''",:;+_()[]\^`Ç','AAAAEEEEIIIIOOOOUUUU%_                  ')
		INTO v_REFERENCIA
		FROM dual;

		--UTILIDADES_PCK.debug('Paso 3: p_REFERENCIA:['||p_REFERENCIA||'] v_REFERENCIA:['||v_REFERENCIA||']');


		--	27nov12	El punto lo reemplazamos por '[46]' --> 29nov12 'ZZ46ZZ'
		v_REFERENCIA:=REPLACE(v_REFERENCIA,'/','ZZ47ZZ');
		v_REFERENCIA:=REPLACE(v_REFERENCIA,'-','ZZ45ZZ');		--	22abr13
		v_REFERENCIA:=REPLACE(v_REFERENCIA,'.','ZZ46ZZ');

		--UTILIDADES_PCK.debug('Paso 4: p_REFERENCIA:['||p_REFERENCIA||'] v_REFERENCIA:['||v_REFERENCIA||']');
	
		v_REFERENCIA:=REPLACE( normalizar_pck.LimpiarEspacios(v_REFERENCIA),' ','% and ');

		--UTILIDADES_PCK.debug('Paso 5: p_REFERENCIA:['||p_REFERENCIA||'] v_REFERENCIA:['||v_REFERENCIA||']');*/
		
		-- 28abr09 ET	Oracle Text vFiltroSQL:=vFiltroSQL||' AND Normalizar_pck.NormalizarString(EIS_VA_REFPRODUCTO||'' ''||EIS_VA_PRODUCTO) LIKE ''%'||v_REFERENCIA||'%''';

		--2set13	índice de tipo CATSEARCH en lugar de CONTEXT	vFiltroSQL:=vFiltroSQL||' AND c o n t a i n s(eis_va_refproducto,'''||v_REFERENCIA||'''||''%'',1)>0';
		v_REFERENCIA:=REPLACE(p_REFERENCIA,'/','ZZ47ZZ');
		v_REFERENCIA:=REPLACE(v_REFERENCIA,'.','ZZ46ZZ');

		vFiltroSQL:=vFiltroSQL||' AND CATSEARCH(EIS_VA_TEXTONORM,'''||Normalizar_Pck.CadenaCatsearch(v_REFERENCIA)||'*'','''||v_FiltroCatsearch||''')>0';
	END IF;

	v_Status:='Codigo';
	IF	p_CODIGO IS NOT NULL THEN
		-- la funcion de normalizacion estandar no nos sirve porque elimina los comodines
		/*	16nov06	para acelerar, utilizamos "=" en lugar de "like"
  	   SELECT UPPER(translate(p_CODIGO,'ÀÁÂÄÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜ*?''",.:;+_()[]/\^`Ç','AAAAEEEEIIIIOOOOUUUU%_                    '))
	   INTO v_CODIGO
	   FROM dual;

		vFiltroSQL:=vFiltroSQL||' AND Normalizar_pck.NormalizarString(EIS_VA_CODIGO) LIKE ''%'||v_CODIGO||'%''';
		*/
		vFiltroSQL:=vFiltroSQL||' AND EIS_VA_CODIGO='''||p_CODIGO||'''';		--p_Codigo en lugar de v_codigo otra vez!

	END IF;

	v_Status:='Restriccion adicional';
	IF p_RestriccionAdicional IS NOT NULL AND p_RestriccionAdicional<>'' THEN
		vFiltroSQL:=vFiltroSQL||' AND '||p_RestriccionAdicional;
	END IF;

	--solodebug!!!	utilidades_pck.debug('EIS_PCK.RestriccionConsulta. FiltroSQL:'||vFiltroSQL);

	RETURN vFiltroSQL;

EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.RestriccionConsulta:'||v_Status||' ['||vFiltroSQL||']','',sqlcode,sqlerrm,null);
		RETURN NULL;
END;




/*
	FUNCTION PreparaConsultaEnTablaTemporal

	Actualizaciones
	30/10/2002	Sustituimos el sistema de calculo basado en una unica consulta por una
				tabla intermedia que permite realizar los calculos de porcentajes (y
				mas adelante, ratios)


*/
FUNCTION PreparaConsultaEnTablaTemporal
(
	p_IDUSUARIO				VARCHAR2,
	p_IDCUADROMANDO			VARCHAR2,
	p_Anno					VARCHAR2,
	vFiltroSQL				VARCHAR2,
	p_AgruparPor			VARCHAR2,
	p_IDResultados			VARCHAR2,
	p_RatioSobre			VARCHAR2 	DEFAULT	null,
	p_PosicionRelativa 		VARCHAR2 	DEFAULT	null,
	p_IDEmpresa				VARCHAR2 	DEFAULT	null		--	19abr13
)	RETURN VARCHAR2
IS
	--	Indicadores del cuadro de mando
	CURSOR	cIndicadores(IDCuadro IN VARCHAR2) IS
		SELECT	EIS_IN_ID, EIS_IN_NOMBRE, EIS_IN_NOMBRECORTO, EIS_IN_MANUAL, EIS_IN_ACUMULACION,
				EIS_IN_RESTRICCIONES, EIS_IN_ACTUALIZACION, EIS_IN_F_EMPRESA, EIS_IN_F_CENTRO,
				EIS_IN_F_USUARIO, EIS_IN_F_EMPRESA2, EIS_IN_F_PRODUCTO,
				EIS_IN_F_NOMENCLATOR, EIS_IN_F_URGENCIAS, EIS_IN_NOMBREEMPRESA2
		FROM	EIS_INDICADORESPORCUADRO, EIS_INDICADORES
		WHERE	EIS_CI_IDINDICADOR	=EIS_IN_ID
			AND	EIS_CI_IDCUADRO		=IDCuadro;

	v_SQL					VARCHAR2(3000);
	v_IDOperacionP			INTEGER;
	v_IDOperacionI			INTEGER;
	v_IDOperacionD			INTEGER;
	v_IndicadorPeso			VARCHAR2(100);
	v_NombrePeso			VARCHAR2(100);
	v_AcumulacionPeso		VARCHAR2(100);
	v_TextoRatio			VARCHAR2(100);
	v_Nombre				VARCHAR2(1000);
	v_Status				VARCHAR2(3000);
BEGIN

	--utilidades_pck.debug('PreparaConsultaEnTablaTemporal TipoResultados:'||p_IDResultados||' Ratio:'||p_RatioSobre);

	--	Limpia las consultas previas de este usuario
		--	Quitamos provisionalmente para debug et 18ene06, volvemos a pknerlo 19ene06 porque se producen muchos errores en el EIS
	v_Status:=	'LimpiandoTablaTemporal';
	DELETE EIS_VALORESTEMPORAL WHERE EIS_VT_USUARIO=p_IDUSUARIO;

	--	"Peso" para el ratio
	v_Status:=	'Peso';
	IF p_IDResultados='RATIO' THEN
		IF	p_RatioSobre='CAMAS' THEN
			v_IndicadorPeso :='CAMAS';
			v_NombrePeso := 'Peso: Camas (Número)';
			v_AcumulacionPeso := 'SUM(TotalLinea)';
			v_TextoRatio:='Camas (Número)';
		ELSIF	p_RatioSobre='OBJETIVOPEDIDOS' THEN
			v_IndicadorPeso :='CONSUMO_OBJETIVO';
			v_NombrePeso := 'Peso: Objetivo Consumo (Euros)';
			v_AcumulacionPeso := 'SUM(TotalLinea)';
			v_TextoRatio:='Objetivo Consumo (Euros)';
		ELSIF	p_RatioSobre='CO_PED_EUR' THEN
			v_IndicadorPeso :='CO_PED_EUR';
			v_NombrePeso := 'Peso: Pedidos (Euros)';
			v_AcumulacionPeso := 'SUM(TotalLinea)';
			v_TextoRatio:='Pedidos (Euros)';
		ELSIF	p_RatioSobre='CO_PED_CANT' THEN			--22mar17
			v_IndicadorPeso :='CO_PED_CANT';
			v_NombrePeso := 'Peso: Pedidos (Euros)';
			v_AcumulacionPeso := 'SUM(TotalLinea)';
			v_TextoRatio:='Pedidos (Euros)';
		ELSIF	p_RatioSobre='CO_PED_NUM' THEN
			v_IndicadorPeso:='CO_PED_NUM';
			v_NombrePeso := 'Peso: Pedidos (Numero)';
			v_AcumulacionPeso := 'ID';
			v_TextoRatio:='Pedidos (Numero)';
		END IF;

		v_Status:=	'Peso: IndicadorATablaTemporal';
		v_IDOperacionP:=IndicadorATablaTemporal
		(
			p_IDUSUARIO,
			v_IndicadorPeso,
			v_NombrePeso,
			p_Anno,
			v_AcumulacionPeso,
			vFiltroSQL,
			p_AgruparPor,
			p_IDResultados,
			p_IDEmpresa
		);
	END IF;

	--utilidades_pck.debug('PreparaConsultaEnTablaTemporal: Fuera del bucle:'||p_IDCUADROMANDO);	--solodebug


	v_Status:=	'EntrandoBucleIndicadores';
	FOR r IN cIndicadores ( p_IDCUADROMANDO ) LOOP
		v_Status:=	'DentroBucleIndicadores';


		--utilidades_pck.debug('PreparaConsultaEnTablaTemporal: Dentro del bucle:'||p_IDCUADROMANDO);	--solodebug


		--	Calculo del indicador (duplicado para pruebas!)
		/*v_IDOperacionD:=IndicadorATablaTemporal
		(
			p_IDUSUARIO,
			r.EIS_IN_ID,
			r.EIS_IN_NOMBRE,
			r.EIS_IN_ACUMULACION,
			vFiltroSQL,
			p_AgruparPor,
			p_IDResultados
		);*/

		IF p_IDResultados='RATIO' THEN
			v_Nombre:='Ratio: '||r.EIS_IN_NOMBRE||' sobre '||v_TextoRatio;
		ELSE
			v_Nombre:=r.EIS_IN_NOMBRE;
		END IF;

		--	Calculo del indicador
		v_Status:=	'IndicadorATablaTemporal:'||r.EIS_IN_ID;
		v_IDOperacionI:=IndicadorATablaTemporal
		(
			p_IDUSUARIO,
			r.EIS_IN_ID,
			v_Nombre,
			p_Anno,
			r.EIS_IN_ACUMULACION,
			vFiltroSQL,
			p_AgruparPor,
			p_IDResultados,
			p_IDEmpresa
		);

		--	Si el resultado debe ofrecerse como ratio, realiza el calculo
		IF p_IDResultados='RATIO' THEN
			v_Status:=	'RatioEnTablaTemporal:v_IDOperacionI:'||v_IDOperacionI||' v_IDOperacionP:'||v_IDOperacionP;
			RatioEnTablaTemporal(v_IDOperacionI,v_IDOperacionP);
		END IF;

		--	Si el resultado debe ofrecerse como posicion relativa, realiza el calculo
		IF  p_PosicionRelativa='C' OR p_PosicionRelativa='D' THEN
			CalculaPosicionRelativa(v_IDOperacionI, p_PosicionRelativa);
		END IF;

	END LOOP; -- Bucle para todos los indicadores


	--	Eliminar peso

	--	Quitamos provisionalmente para debug et 18ene06, volvemos a pknerlo 19ene06 porque se producen muchos errores en el EIS
	IF p_IDResultados='RATIO' THEN
		v_Status:=	'LimpiandoTablaTemporal(Peso)';
		DELETE EIS_VALORESTEMPORAL WHERE EIS_VT_IDOPERACION=v_IDOperacionP;
	END IF;




	--	Prepara la consulta SQL que devolvera los valores, ordenados por INDICADOR, GRUPO, MES
	--	Concatenamos EIS_VT_IDOPERACION||''|''||EIS_VT_IDINDICADOR ya que el mismo indicador puede aparecer varias veces en la consulta
	--	Tambien en la ordenacion, EIS_VT_GRUPO||EIS_VT_IDGRUPO, por si se repite el nombre del grupo (habitual en nucleo)
	--	Forzamos ademas que el total sea el ultimo de los grupos

	--	Resultado en Posicion relativa
	v_Status:=	'Generando consulta';
	IF p_PosicionRelativa='C' OR p_PosicionRelativa='D'  THEN
		v_SQL:=' SELECT '	||	'	EIS_VT_INDICADOR 	AS INDICADOR,'
							||	'	EIS_VT_IDOPERACION||''|''||EIS_VT_IDINDICADOR 	AS IDINDICADOR,'
							||	'	EIS_VT_GRUPO 		AS GRUPO,'
							||	'	EIS_VT_IDOPERACION||''|''||EIS_VT_IDGRUPO		AS IDGRUPO,'	--	Para el grafico, son grupos diferentes aunque tengan mismo ID
							||	' 	EIS_VT_ANNO 		AS ANNO,'
							||	' 	EIS_VT_MES 			AS MES,'
							||	' 	EIS_VT_POSICION		AS TOTAL,'
							||	' 	EIS_VT_POSICION		AS TOTALNUMERO'
							||	'	FROM 		EIS_VALORESTEMPORAL'
							||	'	WHERE		EIS_VT_USUARIO='||p_IDUSUARIO
							||	'	AND			EIS_VT_IDGRUPO NOT LIKE ''%99999Total'''		--	El total no tiene sentido
							--ET	13/1/03||	'	ORDER BY 	EIS_VT_IDOPERACION||EIS_VT_IDINDICADOR, DECODE(EIS_VT_IDGRUPO,''99999Total'',''99999Total'',EIS_VT_GRUPO), EIS_VT_ANNO, EIS_VT_MES';
							--ET	2dic09	Pasamos a zzzzzTotal para forzar que quede el ultimo, 
							--ET	25jul11 UPPER en el nombre para evitar problemas mayusuclas-minusuclas en la ordenacion
							||	'	ORDER BY 	EIS_VT_IDOPERACION||EIS_VT_IDINDICADOR, DECODE(EIS_VT_IDGRUPO,''99999Total'',''zzzzzTotal'',UPPER(EIS_VT_GRUPO)||EIS_VT_IDGRUPO), EIS_VT_ANNO, EIS_VT_MES';

	--	Resultado en Porcentaje
	ELSIF p_IDResultados='PORCV' OR p_IDResultados='PORCH'  THEN
		v_SQL:=' SELECT '	||	'	EIS_VT_INDICADOR 	AS INDICADOR,'
							||	'	EIS_VT_IDOPERACION||''|''||EIS_VT_IDINDICADOR 	AS IDINDICADOR,'
							||	'	EIS_VT_GRUPO 		AS GRUPO,'
							||	'	EIS_VT_IDOPERACION||''|''||EIS_VT_IDGRUPO		AS IDGRUPO,'	--	Para el grafico, son grupos diferentes aunque tengan mismo ID
							||	' 	EIS_VT_ANNO 		AS ANNO,'
							||	' 	EIS_VT_MES 			AS MES,'
							||	' 	Formato.Formato(EIS_VT_PORCENTAJE,1)||''%''	AS TOTAL,'
							||	' 	EIS_VT_PORCENTAJE	AS TOTALNUMERO'
							||	'	FROM 		EIS_VALORESTEMPORAL'
							||	'	WHERE		EIS_VT_USUARIO='||p_IDUSUARIO
							--ET 13/1/03||	'	ORDER BY 	EIS_VT_IDOPERACION||EIS_VT_IDINDICADOR, DECODE(EIS_VT_IDGRUPO,''99999Total'',''99999Total'',EIS_VT_GRUPO), EIS_VT_ANNO, EIS_VT_MES';
							||	'	ORDER BY 	EIS_VT_IDOPERACION||EIS_VT_IDINDICADOR, DECODE(EIS_VT_IDGRUPO,''99999Total'',''zzzzzTotal'',UPPER(EIS_VT_GRUPO)||EIS_VT_IDGRUPO), EIS_VT_ANNO, EIS_VT_MES';

	--	Otros resultados
	ELSE
		v_SQL:=' SELECT '	||	'	EIS_VT_INDICADOR 	AS INDICADOR,'
							||	'	EIS_VT_IDOPERACION||''|''||EIS_VT_IDINDICADOR 	AS IDINDICADOR,'
							||	'	EIS_VT_GRUPO		AS GRUPO,'
							||	'	EIS_VT_IDOPERACION||''|''||EIS_VT_IDGRUPO		AS IDGRUPO,'
							||	' 	EIS_VT_ANNO 		AS ANNO,'
							||	' 	EIS_VT_MES 			AS MES,'
							||	' 	DECODE(EIS_VT_ERROR,''S'',''Div.0'',Formato.Formato(EIS_VT_VALOR,1)) AS TOTAL,'
							||	' 	EIS_VT_VALOR		AS TOTALNUMERO'
							||	'	FROM 		EIS_VALORESTEMPORAL'
							||	'	WHERE		EIS_VT_USUARIO='||p_IDUSUARIO
							--ET 13/1/03||	'	ORDER BY 	EIS_VT_IDOPERACION||EIS_VT_IDINDICADOR, DECODE(EIS_VT_IDGRUPO,''99999Total'',''99999Total'',EIS_VT_GRUPO), EIS_VT_ANNO, EIS_VT_MES';
							||	'	ORDER BY 	EIS_VT_IDOPERACION||EIS_VT_IDINDICADOR, DECODE(EIS_VT_IDGRUPO,''99999Total'',''zzzzzTotal'',UPPER(EIS_VT_GRUPO)||EIS_VT_IDGRUPO), EIS_VT_ANNO, EIS_VT_MES';
	END IF;

	RETURN v_SQL;

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.PreparaConsultaEnTablaTemporal','Cuadro de Mando:'||p_IDCUADROMANDO||' PosicionRelativa:'||p_PosicionRelativa||' Resultados:'||p_IDResultados||' Situacion:'||v_Status,sqlcode,sqlerrm,null);
		RETURN NULL;
END;

/*
	FUNCTION IndicadorATablaTemporal

	Prepara un indicador en la tabla temporal
	13feb09	ET	Usamos BIND VARIABLES
	15nov12	ET	Utilizamos NormalizarID en lugar de NormalizarString para los IDs
	19abr12	ET	Si hay una restricción sobre empresa, agrupamos las familias por ID
*/
FUNCTION IndicadorATablaTemporal
(
	p_IDUSUARIO			VARCHAR2,
	p_IDIndicador		VARCHAR2,
	p_NombreIndicador	VARCHAR2,
	p_Anno				VARCHAR2,
	p_Agregar			VARCHAR2,
	p_FiltroSQL			VARCHAR2,
	p_AgruparPor		VARCHAR2,
	p_IDResultados		VARCHAR2,
	p_IDEmpresa			VARCHAR2
)	RETURN NUMBER
IS
	--	Indicadores del cuadro de mando
	CURSOR	cIndicador(IDIndicador IN VARCHAR2) IS
		SELECT	EIS_IN_RESTRICCIONES
		FROM	EIS_INDICADORES
		WHERE	EIS_IN_ID=IDIndicador;


	v_NombreAgrupacion	VARCHAR2(200);
	v_IDAgrupacion		VARCHAR2(200);
	v_SQL 				VARCHAR2(3000);
	v_Agregar			VARCHAR2(100);		-- ET 22/5/2002 para agregar correctamente los contadores
	v_TipoAgregar		VARCHAR2(100);		-- ET 30/10/2002 para agregar correctamente en porcentaje
	v_MesActual			INTEGER;
	v_Texto				VARCHAR2(3000);		-- ET 30/10/2002 enviamos los resultados con '%' cuando convenga
	v_SQLTemporal		VARCHAR2(3000);		-- ET 30/10/2002 consulta necesaria para calcular el total en %
	v_IDOperacion		INTEGER;
	vFiltroSQL			VARCHAR2(3000);		--	ET 28/7/2003: antes se pasaba como parametro, pero ahora añadimos la restriccion

	v_Restriccion		VARCHAR2(1000);		--	ET 28/7/2003 Restriccion propia del indicador

	--	Para calculo de rendimiento
	v_IDRendimiento 	NUMBER;
	v_Operacion			VARCHAR2(100);

	v_Status			VARCHAR2(3000);--debug
	RES					INTEGER;	--debug
BEGIN

	/*utilidades_pck.debug('EIS_PCK.IndicadorATablaTemporal'
		||' IDUSUARIO:'||p_IDUSUARIO
		||' IDIndicador:'||p_IDIndicador
		||' NombreIndicador:'||p_NombreIndicador
		||' Anno:'||p_Anno
		||' Agregar:'||p_Agregar
		||' FiltroSQL:'||p_FiltroSQL
		||' AgruparPor:'||p_AgruparPor
		||' IDResultados:'||p_IDResultados
		||' IDEmpresa:'||p_IDEmpresa);*/


	v_Status:='Entrando';
	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Temporal: Preparar','','EIS Cons');
	v_MesActual:=to_number(to_char(SYSDATE,'mm'));

	v_Status:='BuscandoIDOperacion';
	BEGIN
		SELECT 	MAX(EIS_VT_IDOPERACION+1)
		INTO	v_IDOperacion
		FROM	EIS_VALORESTEMPORAL;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			v_IDOperacion:=0;
	END;

	IF v_IDOperacion IS NULL THEN
		v_IDOperacion:=0;
	END IF;

	--	Aplica tambien la restriccion propia del indicador
	v_Status:='BuscandoRestricciones';
		SELECT	EIS_IN_RESTRICCIONES
		INTO	v_Restriccion
		FROM	EIS_INDICADORES
		WHERE	EIS_IN_ID=p_IDIndicador;

		--	Concatenamos la restriccion del indicador a la recibida del usuario
			vFiltroSQL:=p_FiltroSQL;
		/*

		Estas lineas de codigo no estan funcionando porque el campo restriccion debe ser uno de la tabla EIS_VALORES
		y no de la consulta basica


		IF NVL(v_Restriccion,'NULO')<>'NULO' THEN
			vFiltroSQL:=p_FiltroSQL|| ' AND ' || v_Restriccion;

			Utilidades_PCK.debug('EIS_PCK.IndicadorATablaTemporal: -1- Indicador:'||p_IDIndicador||' Restriccion ampliada:'||vFiltroSQL);

		ELSE
			vFiltroSQL:=p_FiltroSQL;

			Utilidades_PCK.debug('EIS_PCK.IndicadorATablaTemporal: -2- Indicador:'||p_IDIndicador||' Restriccion basica: ['||v_Restriccion||']');

		END IF;
*/

		v_Status:='ConstruyendoConsulta';
		IF p_Agregar LIKE '%ID%' THEN
			--18nov13	v_Agregar:='COUNT (DISTINCT EIS_VA_VALOR)';	Cuidado, no cuenta como pedidos diferentes si coincide el valor
			v_Agregar:='COUNT (DISTINCT EIS_VA_IDEMPRESA||EIS_VA_IDEMPRESA2||EIS_VA_CODIGO)';
			v_TipoAgregar:='COUNT';
		ELSE
			v_Agregar:='SUM (EIS_VA_VALOR)';
			v_TipoAgregar:='SUM';
		END IF;

		IF (p_AgruparPor = '-1') THEN
			v_SQL:=' SELECT ''Total'' AS GRUPO, ''Total'' AS IDGRUPO, EIS_VA_ANNO ANNO, EIS_VA_MES MES, '|| v_Agregar||' AS TOTAL '
							||	' FROM EIS_VALORES'
							--||	' WHERE EIS_VA_IDINDICADOR='''||	p_IDIndicador || '''' 
							||	' WHERE EIS_VA_IDINDICADOR=:ID' 				--13feb09	ET	Usamos BIND VARIABLES
							||	vFiltroSQL
							||	' GROUP BY EIS_VA_ANNO, EIS_VA_MES';
		ELSE -- Con agrupacion

			IF p_AgruparPor='EMP' THEN
				v_NombreAgrupacion:='EIS_VA_EMPRESA';
				v_IDAgrupacion:='EIS_VA_IDEMPRESA';
			ELSIF p_AgruparPor='CEN' THEN
				v_NombreAgrupacion:='EIS_VA_CENTRO';
				v_IDAgrupacion:='EIS_VA_IDCENTRO';
			ELSIF p_AgruparPor='CEN2' THEN
				v_NombreAgrupacion:='EIS_VA_CENTRO2';
				v_IDAgrupacion:='EIS_VA_IDCENTRO2';
			ELSIF p_AgruparPor='USU' THEN
				v_NombreAgrupacion:='EIS_VA_USUARIO';
				v_IDAgrupacion:='EIS_VA_IDUSUARIO';
			ELSIF p_AgruparPor='EMP2' THEN
				v_NombreAgrupacion:='EIS_VA_EMPRESA2';
				v_IDAgrupacion:='EIS_VA_IDEMPRESA2';
			ELSIF p_AgruparPor='PRO' THEN
				v_NombreAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||lower(SUBSTR(EIS_VA_PRODUCTO,1,80))';
				v_IDAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_PRODUCTO),1,80)';	--'EIS_VA_REFPRODUCTO';
			ELSIF p_AgruparPor='REFPROV' THEN
				v_NombreAgrupacion:='SUBSTR(EIS_VA_REFPROVEEDOR,1,20)||'':''||lower(SUBSTR(EIS_VA_PRODUCTO,1,80))';
				--15may13	v_IDAgrupacion:='EIS_VA_IDPRODUCTO';	--'EIS_VA_REFPRODUCTO';
				v_IDAgrupacion:='SUBSTR(EIS_VA_REFPROVEEDOR,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_PRODUCTO),1,80)';	--'EIS_VA_REFPRODUCTO';
			ELSIF p_AgruparPor='REF' THEN
				v_NombreAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||lower(SUBSTR(EIS_VA_PRODUCTO,1,80))';
				--v_NombreAgrupacion:='EIS_VA_REFPRODUCTO';
				v_IDAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_PRODUCTO),1,80)';	--'EIS_VA_REFPRODUCTO';
			ELSIF p_AgruparPor='DES' THEN
				v_NombreAgrupacion:='lower(SUBSTR(EIS_VA_PRODUCTO,1,78))||'' (''||SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'')''';
				--v_NombreAgrupacion:='EIS_VA_REFPRODUCTO';
				v_IDAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_PRODUCTO),1,80)';	--'EIS_VA_REFPRODUCTO';
			ELSIF p_AgruparPor='FAM' THEN
				--	30oct12	No mostramos los números de la familia ya que hay ambiguedades en el caso de ASISA
				--	19nov12	Los recuperamos, cambiamos al ID familia como identificador
				--v_NombreAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,2)||'':''||lower(TRIM(EIS_VA_FAMILIA))';
				v_NombreAgrupacion:='EIS_VA_REFFAMILIA||'':''||lower(TRIM(EIS_VA_FAMILIA))';
				--	Si está filtrasdo por empresa, utilizamos los IDs de familia
				IF p_IDEmpresa IS NOT NULL THEN
					v_IDAgrupacion:='EIS_VA_IDFAMILIA';	--	19nov12	
				ELSE
					v_IDAgrupacion:='EIS_VA_REFFAMILIA||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_FAMILIA),1,80)';
				END IF;	
			ELSIF p_AgruparPor='GRU' THEN
				v_NombreAgrupacion:='EIS_VA_REFGRUPO||'':''||lower(TRIM(EIS_VA_GRUPO))';
				v_IDAgrupacion:='EIS_VA_IDGRUPO';	
			ELSIF p_AgruparPor='SF' THEN
				v_NombreAgrupacion:='EIS_VA_REFSUBFAMILIA||'':''||lower(TRIM(EIS_VA_SUBFAMILIA))';
				v_IDAgrupacion:='EIS_VA_IDSUBFAMILIA';	
			ELSIF p_AgruparPor='CAT' THEN
				v_NombreAgrupacion:='EIS_VA_REFCATEGORIA||'':''||lower(TRIM(EIS_VA_CATEGORIA))';
				v_IDAgrupacion:='EIS_VA_IDCATEGORIA';	
			--22abr13	ELSIF p_AgruparPor='URG' THEN
			--22abr13		v_NombreAgrupacion:='EIS_VA_URGENCIAS';
			--22abr13		v_IDAgrupacion:='EIS_VA_URGENCIAS';
			ELSIF p_AgruparPor='EST' THEN
				v_NombreAgrupacion:='EIS_VA_ESTADO';
				v_IDAgrupacion:='EIS_VA_IDESTADO';
			--22abr13	ELSIF p_AgruparPor='TIP' THEN
			--22abr13		v_NombreAgrupacion:='EIS_VA_TIPOINCIDENCIA';
			--22abr13		v_IDAgrupacion:='EIS_VA_IDTIPOINCIDENCIA';
			--22abr13	ELSIF p_AgruparPor='GRA' THEN
			--22abr13		v_NombreAgrupacion:='EIS_VA_GRAVEDAD';
			--22abr13		v_IDAgrupacion:='EIS_VA_IDGRAVEDAD';
			END IF;
			--	Los resultados tienen que devolverse en %
			v_SQL:=' SELECT '	||	v_NombreAgrupacion	||' AS GRUPO,'
								||	v_IDAgrupacion ||'||''|''||'||	v_NombreAgrupacion	||' AS IDGRUPO,'			--25feb08	ET	Para cuidar los cambios de nombres
								||	' 	EIS_VA_ANNO ANNO,	EIS_VA_MES MES, '|| v_Agregar||' AS TOTAL'
								||	' FROM EIS_VALORES'
								--||	' WHERE EIS_VA_IDINDICADOR='''||	p_IDIndicador || '''' 
								||	' WHERE EIS_VA_IDINDICADOR=:ID' 				--13feb09	ET	Usamos BIND VARIABLES
								||	vFiltroSQL
								||	' GROUP BY '|| v_NombreAgrupacion || ', ' ||v_IDAgrupacion ||'||''|''||'||	v_NombreAgrupacion|| ', EIS_VA_ANNO, EIS_VA_MES';
								--||	' ORDER BY '|| v_NombreAgrupacion;	--	2dic09	ET	Faltaba ordenar
   		END IF;

		--utilidades_pck.debug('IndicadorATablaTemporal SQL='||v_SQL||' IDIndicador:'||p_IDIndicador);	--	solodebug

		--
		--	Crea la tabla temporal
		--
		v_Status:='CreandoDatosTemporales';
		v_SQLTemporal:=		'INSERT INTO EIS_VALORESTEMPORAL'
					||	' (EIS_VT_IDOPERACION, EIS_VT_USUARIO, EIS_VT_IDINDICADOR, EIS_VT_INDICADOR, EIS_VT_ANNO, EIS_VT_MES, EIS_VT_GRUPO, EIS_VT_IDGRUPO, EIS_VT_VALOR, EIS_VT_PORCENTAJE)'
					||	' SELECT '||v_IDOperacion||', '||p_IDUSUARIO ||', '''||p_IDIndicador||''', '''||p_NombreIndicador||''', ANNO, MES, GRUPO, IDGRUPO, TOTAL, 0'
					||	' FROM ('	|| v_SQL ||')';

		--solodebugutilidades_pck.Debug('EIS_PCK.IndicadorATablaTemporal. SQL='||v_SQLTemporal);	


		--	13feb09	ET	Usamos BIND VARIABLES
		EXECUTE IMMEDIATE v_SQLTemporal USING p_IDIndicador;

		--14oct08	ET	Este calculo de totales apenas consume, no realizamos la inserción de control de rendimiento
		--RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
		--v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Temporal: Total fila','','EIS Cons');




		--	Calcula el total por filas
		v_Status:='CalculaTotalPorFila';
		v_SQLTemporal:=		'INSERT INTO EIS_VALORESTEMPORAL'
					||	' (EIS_VT_IDOPERACION, EIS_VT_USUARIO, EIS_VT_IDINDICADOR, EIS_VT_INDICADOR, EIS_VT_ANNO, EIS_VT_MES, EIS_VT_GRUPO, EIS_VT_IDGRUPO, EIS_VT_VALOR, EIS_VT_PORCENTAJE)'
					||	' SELECT '||v_IDOperacion||','|| p_IDUSUARIO ||', '''||p_IDIndicador||''', '''||p_NombreIndicador||''','||p_Anno||', 13, EIS_VT_GRUPO, EIS_VT_IDGRUPO, SUM(EIS_VT_VALOR),0'
					||	' FROM EIS_VALORESTEMPORAL'
					||	'	WHERE EIS_VT_IDOPERACION=:ID'			--13feb09	ET	Usamos BIND VARIABLES	||v_IDOperacion
					||	'	AND EIS_VT_MES<=12'
					||	' GROUP BY EIS_VT_GRUPO, EIS_VT_IDGRUPO';

		EXECUTE IMMEDIATE v_SQLTemporal USING v_IDOperacion;

		--14oct08	ET	Este calculo de totales apenas consume, no realizamos la inserción de control de rendimiento
		--RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
		--v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Temporal: Total columna','','EIS Cons');

		--	Calcula el total por columnas
		v_Status:='CalculaTotalPorColumna';
		v_SQLTemporal:=		'INSERT INTO EIS_VALORESTEMPORAL'
					||	' (EIS_VT_IDOPERACION, EIS_VT_USUARIO, EIS_VT_IDINDICADOR, EIS_VT_INDICADOR, EIS_VT_ANNO, EIS_VT_MES, EIS_VT_GRUPO, EIS_VT_IDGRUPO, EIS_VT_VALOR, EIS_VT_PORCENTAJE)'
					||	' SELECT '||v_IDOperacion||','|| p_IDUSUARIO ||', '''||p_IDIndicador||''', '''||p_NombreIndicador||''',	EIS_VT_ANNO, EIS_VT_MES, ''Total'', ''99999Total'', SUM(EIS_VT_VALOR),0'
					||	' FROM EIS_VALORESTEMPORAL'
					||	'	WHERE EIS_VT_IDOPERACION=:ID'			--13feb09	ET	Usamos BIND VARIABLES	||v_IDOperacion
					||	' GROUP BY EIS_VT_ANNO, EIS_VT_MES';

		EXECUTE IMMEDIATE v_SQLTemporal USING v_IDOperacion;


		--	Calcula los porcentajes o ratios correspondientes a los valores solicitados
		IF p_IDResultados='PORCV' THEN		--	Porcentaje mensual

			RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
			v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Temporal: Porcentaje vert.','','EIS Cons');

			--	Porcentaje mensual
			v_Status:='CalculaPorcentajeMensual';
			v_SQLTemporal:=		'UPDATE EIS_VALORESTEMPORAL B'
						||	' SET B.EIS_VT_PORCENTAJE=100*B.EIS_VT_VALOR/'
						||	' 		(SELECT		A.EIS_VT_VALOR FROM EIS_VALORESTEMPORAL A'
						||	'			WHERE	A.EIS_VT_IDOPERACION='||v_IDOperacion
						||	' 			AND		A.EIS_VT_ANNO=B.EIS_VT_ANNO'
						||	' 			AND		A.EIS_VT_MES=B.EIS_VT_MES'
						||	' 			AND		A.EIS_VT_IDGRUPO=''99999Total'')'
						||	' WHERE B.EIS_VT_VALOR<>0'
						||	'	AND B.EIS_VT_IDOPERACION=:ID';			--13feb09	ET	Usamos BIND VARIABLES	

			EXECUTE IMMEDIATE v_SQLTemporal USING v_IDOperacion;

		ELSIF p_IDResultados='PORCH' THEN		--	Porcentaje horizontal

			RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
			v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Temporal: Porcentaje horz.','','EIS Cons');

			--	Porcentaje horizontal
			v_Status:='CalculaPorcentajeHor';
			v_SQLTemporal:=		'UPDATE EIS_VALORESTEMPORAL B'
						||	' SET B.EIS_VT_PORCENTAJE=100*B.EIS_VT_VALOR/'
						||	' 		(SELECT		A.EIS_VT_VALOR FROM EIS_VALORESTEMPORAL A'
						||	'			WHERE	A.EIS_VT_IDOPERACION='||v_IDOperacion
						||	' 			AND		A.EIS_VT_MES=13'
						||	' 			AND		A.EIS_VT_IDGRUPO=B.EIS_VT_IDGRUPO)'
						||	' WHERE B.EIS_VT_VALOR<>0'
						||	'	AND B.EIS_VT_IDOPERACION=:ID';			--13feb09	ET	Usamos BIND VARIABLES	

			EXECUTE IMMEDIATE v_SQLTemporal USING v_IDOperacion;

		END IF;


		RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
		v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Resultados','','EIS Cons');

		--	Si los resultados no estan agrupados eliminamos la linea de total
		IF (p_AgruparPor = '-1') THEN
			v_Status:='BorrandoLineaTotal';
			v_SQLTemporal:=		'DELETE EIS_VALORESTEMPORAL'
						||		'	WHERE EIS_VT_IDOPERACION=:ID'			--13feb09	ET	Usamos BIND VARIABLES	||v_IDOperacion
						||		'	AND		EIS_VT_IDGRUPO LIKE ''%99999Total''';

			EXECUTE IMMEDIATE v_SQLTemporal USING v_IDOperacion;
		END IF;


	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

	RETURN	v_IDOperacion;
EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.IndicadorATablaTemporal',v_Status||' AgruparPor:'||p_AgruparPor||' SQLTemporal:'||v_SQLTemporal,sqlcode,sqlerrm,null);
END;

/*
	FUNCTION RatioEnTablaTemporal

	Prepara un indicador en la tabla temporal
*/
PROCEDURE RatioEnTablaTemporal
(
	p_IDOperacionM		INTEGER,
	p_IDOperacionD		INTEGER
)
IS
	v_SQLTemporal		VARCHAR2(3000);

	--	solo para depuracion
	CURSOR cDepuracion1(IDOperacionM INTEGER) IS
			SELECT 		EIS_VT_MES Mes, EIS_VT_IDGRUPO IDGrupo,EIS_VT_VALORORIGINAL,EIS_VT_VALOR,EIS_VT_PESO,EIS_VT_PORCENTAJE
				FROM	EIS_VALORESTEMPORAL
				WHERE 	EIS_VT_VALOR<>0
				AND		EIS_VT_IDOPERACION=IDOperacionM
				ORDER BY	EIS_VT_IDGRUPO, EIS_VT_MES;

	--	solo para depuracion
	CURSOR cDepuracion2(IDOperacionD INTEGER, Mes INTEGER, IDGrupo VARCHAR2) IS
			SELECT	count(*) Total
				FROM
				(
					SELECT 	EIS_VT_VALOR Peso
					FROM 	EIS_VALORESTEMPORAL B
					WHERE	B.EIS_VT_IDOPERACION=IDOperacionD
					AND		B.EIS_VT_MES	=Mes
					AND		B.EIS_VT_IDGRUPO=IDGrupo
				);


	--	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion		VARCHAR2(100);
	v_Status		VARCHAR2(1000);
BEGIN

	--DELETE LOGEDU WHERE FECHA>SYSDATE-2;	--solo para depuracion, limpiamos antes de insertar de nuevo!

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Temporal: Calculo Ratio','','EIS Cons');

	--	busca el "peso"
	v_Status:='Peso';
	v_SQLTemporal:=		'UPDATE EIS_VALORESTEMPORAL A'
					||	' SET A.EIS_VT_PESO='
					||	'	('
					||	' 		SELECT		B.EIS_VT_VALOR '		--para forzar que funcione bien, poner MAX(B.EIS_VT_VALOR) el problema es que se oculta el problema de fondo
					||	' 		FROM EIS_VALORESTEMPORAL B'
					||	'		WHERE		B.EIS_VT_IDOPERACION='||p_IDOperacionD
					||	' 			AND		B.EIS_VT_MES	=A.EIS_VT_MES'
					||	' 			AND		B.EIS_VT_IDGRUPO=A.EIS_VT_IDGRUPO'
					||	'	)'
					||	' WHERE A.EIS_VT_VALOR<>0'
					||	'	AND	A.EIS_VT_IDOPERACION=:ID';			--13feb09	ET	Usamos BIND VARIABLES	||p_IDOperacionM;

	--	06nov06 ET	Para pruebas lo hacemos con un doble cursor en lugar del IMMEDIATE
	EXECUTE IMMEDIATE v_SQLTemporal USING p_IDOperacionM;

	/*	desactivamos el codigo de depuracion hasta poder trabajar de nuevo con el

	En el EIS se pueden producir errores en el caso de que un centro/empresa/producto cambie de nombre porque no se actualizan los historicos
	El error se produce por duplicidad en el momento de buscar los pesos para calcular ratios

	Este script permite detectar estos casos.*/

	FOR rA IN cDepuracion1(p_IDOperacionM) LOOP
		FOR rB IN cDepuracion2(p_IDOperacionD, rA.Mes, rA.IDGrupo) LOOP
			IF rb.Total>1 THEN
				Utilidades_PCK.debug('EIS_PCK.RatioEnTablaTemporal:ERR_DUP: Mes:'|| rA.Mes||' IDGrupo:'|| rA.IDGrupo|| ' TotalDatos:'|| rB.Total);
			END IF;
		END LOOP;
	END LOOP;
	


	--	Calcula el ratio
	v_Status:='CalculaRatio';
	v_SQLTemporal:=		'UPDATE EIS_VALORESTEMPORAL A'
					||	' SET 	'
					||	'	A.EIS_VT_VALORORIGINAL=A.EIS_VT_VALOR,'
					||	'	A.EIS_VT_PORCENTAJE=DECODE(A.EIS_VT_PESO,0,0,A.EIS_VT_VALOR/A.EIS_VT_PESO),'
					||	' 	A.EIS_VT_VALOR=DECODE(A.EIS_VT_PESO,0,0,A.EIS_VT_VALOR/A.EIS_VT_PESO),'
					||	' 	A.EIS_VT_ERROR=DECODE(A.EIS_VT_PESO,0,''S'', ''N'')'
					||	' WHERE A.EIS_VT_VALOR<>0'
					||	' 	AND A.EIS_VT_PORCENTAJE IS NOT NULL'
					||	'	AND A.EIS_VT_VALOR IS NOT NULL'
					||	'	AND	A.EIS_VT_IDOPERACION=:ID';			--13feb09	ET	Usamos BIND VARIABLES	||p_IDOperacionM;

	EXECUTE IMMEDIATE v_SQLTemporal USING p_IDOperacionM;

	--	Marca las divisiones por cero
	v_Status:='MarcaErrores';
	v_SQLTemporal:=		'UPDATE EIS_VALORESTEMPORAL A'
					||	' SET 	A.EIS_VT_ERROR=''S'', A.EIS_VT_VALOR=0, A.EIS_VT_PORCENTAJE=0' --Presentara el grafico aunque el ratio sea ind/0
					||	' WHERE ((A.EIS_VT_VALOR is null) AND (A.EIS_VT_PORCENTAJE is null))'
					||	'	AND	A.EIS_VT_IDOPERACION=:ID';			--13feb09	ET	Usamos BIND VARIABLES	||p_IDOperacionM;

	EXECUTE IMMEDIATE v_SQLTemporal USING p_IDOperacionM;

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

	/*
		Inserta en la tabla de LOGEDU todas las entradas de la matriz
	*/
	--	Solo depuración
	--FOR rA IN cDepuracion1(p_IDOperacionM) LOOP
	--	Utilidades_PCK.debug('EIS_PCK.RatioEnTablaTemporal: IDGrupo:'|| rA.IDGrupo||' Mes:'|| rA.Mes||' Total:'|| rA.EIS_VT_VALORORIGINAL|| ' Peso:'||rA.EIS_VT_PESO|| ' Porcentaje:'||rA.EIS_VT_PORCENTAJE);
	--END LOOP;


EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.RatioEnTablaTemporal', v_Status||' SQL:'||v_SQLTemporal);
END;


/*
	FUNCTION CalculaPosicionRelativa

	Prepara un indicador en la tabla temporal informando de su posicion relativa respecto al resto de indicadores
*/
PROCEDURE CalculaPosicionRelativa
(
	p_IDOperacionM		INTEGER,
	p_PosicionRelativa	VARCHAR2
)
IS
	v_SQLTemporal		VARCHAR2(3000);
	vComparacion		VARCHAR2(10);

	--	Para calculo de rendimiento
	v_IDRendimiento 	NUMBER;
	v_Operacion			VARCHAR2(100);
BEGIN

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Temporal: Calculo Pos.Rel.','','EIS Cons');

	IF p_PosicionRelativa='C' THEN
		--	Ordenacion creciente
		vComparacion:='>';
	ELSIF p_PosicionRelativa='D' THEN
		--	Ordenacion decreciente
		vComparacion:='<';
	ELSE	--	Por aqui no debe pasar, solo depuracion
		vComparacion:='=';
	END IF;

	--	busca el "peso"
	v_SQLTemporal:=		'UPDATE EIS_VALORESTEMPORAL A'
					||	' SET A.EIS_VT_POSICION=1+'
					||	'	('
					||	' 		SELECT		COUNT(*) '
					||	'		FROM EIS_VALORESTEMPORAL B'
					||	'		WHERE		B.EIS_VT_IDOPERACION=A.EIS_VT_IDOPERACION'			--13feb09	ET	Usamos BIND VARIABLES	'||p_IDOperacionM
					||	' 			AND		B.EIS_VT_MES	=A.EIS_VT_MES'
					||	' 			AND		B.EIS_VT_VALOR'||vComparacion||'A.EIS_VT_VALOR'
					||	' 			AND		B.EIS_VT_IDGRUPO NOT LIKE ''%99999Total'''
					||	'	)'
					||	' WHERE A.EIS_VT_IDOPERACION=:ID'--||p_IDOperacionM
					||	' AND	A.EIS_VT_IDGRUPO NOT LIKE ''%99999Total''';

	EXECUTE IMMEDIATE v_SQLTemporal USING p_IDOperacionM;

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.CalculaPosicionRelativa', ' SQL:'||v_SQLTemporal);
END;

/*
	PROCEDURE PrepararMatriz

	Envia los valores de un cuadro de mando en formato XML a partir de una consulta SQL
	contra la tabla temporal de valores
*/
PROCEDURE PrepararMatriz
(
	p_IDUsuario			NUMBER,			--	8abr14 Para depuración
	v_SQL				VARCHAR2,
	p_Anno				VARCHAR2,
	p_AgruparPor		VARCHAR2,
	p_IDResultados		VARCHAR2,
	p_MarcarRojo		VARCHAR2,
	p_NumeroFilas		OUT INTEGER,
	p_VectorNombres		OUT TVectorCadenas,
	p_VectorValores		OUT TVectorNumerico
)
IS
	v_cur 				REF_CURSOR;
	v_reg 				TRegEIS;
	v_GrupoActual 		VARCHAR2(200);	--	ET 16set08	100
	v_IndicadorActual	VARCHAR2(200);	--	ET 16set08	100
	v_Grupos 			NUMBER;
	i 					NUMBER;
	v_Total 			NUMBER;
	UltimoMesInformado 	INTEGER;
	UltimoValor		 	NUMBER;
	ColumnaActual	 	INTEGER;
	--ColumnaAnterior	 	INTEGER;
	v_Anno				INTEGER;
	v_AnnoInicial		INTEGER;
	v_AnnoActual		INTEGER;
	v_Mes				INTEGER;
	v_MesInicial		INTEGER;
	v_MesActual			INTEGER;
	v_Status			VARCHAR2(3000);		-- para depuracion
	v_HayDatos			BOOLEAN;

	v_Count				INTEGER;


	--	Para calculo de rendimiento
	v_IDRendimiento 	NUMBER;
	v_Operacion			VARCHAR2(100);


BEGIN


	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Preparando Matriz','','EIS Cons');

	--	Mes a partir del cual los totales 0 se presentaran como null en lugar de 0
	v_MesActual:=to_number(to_char(SYSDATE,'mm'));
	v_AnnoActual:=to_number(to_char(SYSDATE,'yyyy'));
	--IF p_Anno<to_char(SYSDATE,'yyyy') THEN
	--	v_MesActual:=99;
	--END IF;


	--	Mes y año correspondientes a la primera columna del grafico
	IF p_Anno=9999 THEN
		v_MesInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'))+1;	--	el mes siguiente al actual, pero del año anterior
		v_AnnoInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;
	ELSE
		v_MesInicial:=1;
		v_AnnoInicial:=p_Anno;
	END IF;

	IF v_MesInicial>12 THEN
		v_AnnoInicial:=v_AnnoInicial+1;
		v_MesInicial:=v_MesInicial-12;
	END IF;

	/*utilidades_pck.debug('EIS_PCK.PrepararMatriz - Parametro:'||p_Anno
							||' Sistema:'||to_char(SYSDATE,'yyyy')
							||' Mes actual:'||v_MesActual||'/'||v_AnnoActual
							||' Mes inicial:'||v_MesInicial||'/'||v_AnnoInicial
							||' SQL:'||v_SQL);*/

	v_HayDatos:=FALSE;
	OPEN v_cur FOR v_SQL;

	   FETCH v_cur INTO v_reg;

	   IF v_cur%found THEN
		v_HayDatos:=TRUE;

		--	Indicador:	Contiene nombre|ID
		p_VectorNombres(0):='I'||'|'||SUBSTR(v_reg.Indicador,1,100)||'|'||Utilidades_PCK.Piece(v_reg.IDIndicador,'|',1);

		--	Grupo:		Contiene nombre|ID
		p_VectorNombres(1):='G'||'|'||SUBSTR(v_reg.Grupo,1,100)||'|'||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1);

		p_NumeroFilas:=1;

		--	25feb08 ET
		v_IndicadorActual	:=v_reg.IDIndicador;	--	Actualiza el indicador
		v_GrupoActual		:=v_reg.IDGrupo;		--	Actualiza el grupo	--	ET	25feb08	Concatenamos ID+Nombre
		UltimoMesInformado	:=0;					--	Para que no inserte una linea vacia con CEROS
		ColumnaActual		:=1;					--	Idem

		v_Grupos:=0;			-- Empieza con el primer grupo

		--	Inicializamos el y año de inicio del cuadro de mando
		v_Mes:=v_MesInicial;
		v_Anno:=v_AnnoInicial;

		UltimoValor:=0;

		WHILE v_cur%found LOOP

			--
			--	Cambio de indicador
			--
			IF ((v_IndicadorActual != v_reg.IDIndicador) OR (v_IndicadorActual IS NULL)) THEN
				--	Comprobamos si hay que cerrar el indicador anterior
				IF v_IndicadorActual IS NOT NULL THEN
					--	Insertamos ceros
	   				--	ET 13/1/2003 FOR I IN UltimoMesInformado+1..12 LOOP
	   				FOR I IN ColumnaActual+1..12 LOOP

						p_VectorValores(p_NumeroFilas*13+ColumnaActual):=0;

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;

					END LOOP;
				END IF;
				--	Abrimos el nuevo indicador
				--	Indicador:	Contiene nombre|ID
				p_NumeroFilas:=p_NumeroFilas+1;
				p_VectorNombres(p_NumeroFilas):='I'||'|'||SUBSTR(v_reg.Indicador,1,100)||'|'||Utilidades_PCK.Piece(v_reg.IDIndicador,'|',1);

				--	Grupo:		Contiene nombre|ID
				p_NumeroFilas:=p_NumeroFilas+1;
				p_VectorNombres(p_NumeroFilas):='G'||'|'||SUBSTR(v_reg.Grupo,1,100)||'|'||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1);

				v_IndicadorActual:=v_reg.IDIndicador;	--	Actualiza el indicador
				v_GrupoActual:=v_reg.IDGrupo;			--	Actualiza el grupo: Ya no entrara en el cambio de grupo
				UltimoMesInformado:=0;					--	Evita que se rellene con ceros otra vez
				v_Grupos:=v_Grupos+1;

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;
				UltimoValor:=0;

			END IF;

			--
			--	Cambio de grupo
			--

			IF ((v_GrupoActual != v_reg.IDGrupo)
				OR((v_reg.IDGrupo IS NULL)AND(v_GrupoActual IS NOT NULL))) THEN

				--	Si ya ha empezado algún grupo, rellena con CEROS la fila anterior
				--	cierra el grupo y pone la cabecera del nuevo grupo
				--IF v_Grupos>0 THEN
	   				--	ET 13/1/2003 FOR I IN UltimoMesInformado+1..12 LOOP
	   				FOR I IN ColumnaActual+1..12 LOOP

						p_VectorValores(p_NumeroFilas*13+ColumnaActual):=0;

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;

					END LOOP;

				--	Grupo:		Contiene nombre|ID
				p_NumeroFilas:=p_NumeroFilas+1;
				p_VectorNombres(p_NumeroFilas):='G'||'|'||SUBSTR(v_reg.Grupo,1,100)||'|'||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1);

				--END IF;
				v_GrupoActual := v_reg.IDGrupo;
				v_Grupos:=v_Grupos+1;
				UltimoMesInformado:=0;

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;
				UltimoValor:=0;
			END IF;


			--
			-- Presenta los resultados segun la estructura (Mes, Total)
			--

			v_Count:=0;	--Fuerza salida del bucle si el algoritmo esta mal

			-- Rellena con el valor 0 los meses no informados desde el ultimo informado hasta el actual
			IF ((v_Anno<v_reg.Anno) OR (UltimoMesInformado+1<v_reg.Mes)) 	--	Mismo año
				OR ((v_Anno<v_reg.Anno) AND ((v_reg.Mes>1) OR (v_Mes<12)))  --	Año diferente
				OR ((v_reg.Anno=9999) AND (ColumnaActual<13))				--	Pendiente llegar al total de la fila
					THEN


				--	Si no estamos en el primer mes, empezamos a rellenar en el siguiente
				IF ColumnaActual>1 THEN
					v_Mes:=v_Mes+1;
					IF v_Mes>12 THEN
						v_Mes:=v_Mes-12;
						v_Anno:=v_Anno+1;
					END IF;
				END IF;


					--
					v_Status:=p_VectorNombres(p_NumeroFilas);
					--

				--	Repite el bucle hasta llegar al mes anterior al del registro
				WHILE ((v_Mes<=v_reg.Mes-1) OR (v_Anno<v_reg.Anno) OR (v_reg.Anno=9999))
						AND (ColumnaActual<13)
						AND v_Count<12 LOOP

					--
					v_Status:='Entra';
					--

					p_VectorValores(p_NumeroFilas*13+ColumnaActual):=0;

					--	Incrementa la columna
					ColumnaActual:=ColumnaActual+1;
					v_Mes:=v_Mes+1;

					IF v_Mes>12 THEN
						v_Mes:=v_Mes-12;
						v_Anno:=v_Anno+1;
					END IF;

					v_Count:=v_Count+1; 		--Cuenta el numero de pasos por el bucle, nunca mayor a 12

				END LOOP;

			END IF;


			v_Mes:=v_reg.Mes;

			-- ET10/6/2003IF v_Anno<v_reg.Anno THEN
			-- ET10/6/2003	v_Mes:=v_Mes+12;
			-- ET10/6/2003END IF;

			v_Anno:=v_reg.Anno;
			--ColumnaActual:=ColumnaAnterior;

			--
			--	Envia el registro actual
			--

			p_VectorValores(p_NumeroFilas*13+ColumnaActual):=TO_NUMBER(v_reg.TotalNumero);
			UltimoValor:=TO_NUMBER(v_reg.TotalNumero);

			UltimoMesInformado:=v_reg.Mes;
			ColumnaActual:=ColumnaActual+1;

	     	FETCH v_cur INTO v_reg;

	   	END LOOP;
	ELSE
		utilidades_pck.Debug('EIS_PCK.PrepararMatriz. Sin resultados: IDUsuario:'||p_IDUsuario||' SQL='||v_sql);
	END IF;
	CLOSE v_cur;

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );


	--FOR I IN 0..p_NumeroFilas LOOP			--solodebug
	--	utilidades_pck.debug('EIS_PCK.PrepararMatriz: Fila:'||I||' Contenido:'||p_VectorNombres(I)||p_VectorValores(I*13+1));--solodebug
	--END LOOP;								--solodebug


EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.PrepararMatriz','IDUsuario:'||p_IDUsuario||' SQL='||v_sql||' SQLERRM:'||sqlerrm);
END;



/*
	PROCEDURE EnviarCuadroDeMando_XML

	Envia los valores de un cuadro de mando en formato XML a partir de una consulta SQL
	contra la tabla temporal de valores
*/
/*
PROCEDURE EnviarCuadroDeMando_XML
(
	v_SQL				VARCHAR2,
	p_Anno				VARCHAR2,
	p_AgruparPor		VARCHAR2,
	p_IDResultados		VARCHAR2,
	p_MarcarRojo		VARCHAR2
)
IS
	v_cur 				REF_CURSOR;
	v_reg 				TRegEIS;
	v_GrupoActual 		VARCHAR2(100);
	v_IndicadorActual	VARCHAR2(100);
	v_Grupos 			NUMBER;
	i 					NUMBER;
	v_Total 			NUMBER;
	UltimoMesInformado 	INTEGER;
	UltimoValor		 	NUMBER;
	ColumnaActual	 	INTEGER;
	--ColumnaAnterior	 	INTEGER;
	v_Anno				INTEGER;
	v_AnnoInicial		INTEGER;
	v_AnnoActual		INTEGER;
	v_Mes				INTEGER;
	v_MesInicial		INTEGER;
	v_MesActual			INTEGER;
	v_Texto				VARCHAR2(3000);		-- ET 30/10/2002 enviamos los resultados con '%' cuando convenga
	v_HayDatos			BOOLEAN;

	v_Count				INTEGER;

	--	Para calculo de rendimiento
	v_IDRendimiento 	NUMBER;
	v_Operacion			VARCHAR2(100);
BEGIN

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'EnviaCuadrodeMando_XML','','EIS Cons');

	--	Mes a partir del cual los totales 0 se presentaran como null en lugar de 0
	v_MesActual:=to_number(to_char(SYSDATE,'mm'));
	v_AnnoActual:=to_number(to_char(SYSDATE,'yyyy'));
	--IF p_Anno<to_char(SYSDATE,'yyyy') THEN
	--	v_MesActual:=99;
	--END IF;


	--	Mes y año correspondientes a la primera columna del grafico
	IF p_Anno=9999 THEN
		v_MesInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'))+1;	--	el mes siguiente al actual, pero del año anterior
		v_AnnoInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;
	ELSE
		v_MesInicial:=1;
		v_AnnoInicial:=p_Anno;
	END IF;


--	utilidades_pck.debug('EIS_PCK.EnviarCuadroDeMando_XML - Parametro:'||p_Anno
--							||' Sistema:'||to_char(SYSDATE,'yyyy')
--							||' Mes actual:'||v_MesActual||'/'||v_AnnoActual
--							||' Mes inicial:'||v_MesInicial||'/'||v_AnnoInicial
--							||' SQL:'||v_SQL);
--


	v_HayDatos:=FALSE;
	HTP.P('<CUADRODEMANDO>');
	OPEN v_cur FOR v_SQL;

	   FETCH v_cur INTO v_reg;

	   IF v_cur%found THEN
		v_HayDatos:=TRUE;

		HTP.P('<INDICADOR>');
			HTP.P('<NOMBREINDICADOR>'	||v_reg.Indicador	||		'</NOMBREINDICADOR>');
			HTP.P('<IDINDICADOR>'		||Utilidades_PCK.Piece(v_reg.IDIndicador,'|',1)	||		'</IDINDICADOR>');

   		HTP.P('<GRUPO>');
		IF (p_AgruparPor = '-1') THEN
			HTP.P('<NOMBREGRUPO>Total</NOMBREGRUPO>');
			HTP.P('<IDGRUPO>-1</IDGRUPO>');
		ELSE
			HTP.P('<NOMBREGRUPO>'	||SUBSTR(v_reg.Grupo,1,100)	||'</NOMBREGRUPO>');
			HTP.P('<IDGRUPO>'		||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1)	||'</IDGRUPO>');
		END IF;

		v_IndicadorActual	:=v_reg.IDIndicador;	--	Actualiza el indicador
		v_GrupoActual		:=v_reg.IDGrupo;		--	Actualiza el grupo
		UltimoMesInformado	:=0;					--	Para que no inserte una linea vacia con CEROS
		ColumnaActual		:=1;					--	Idem

		v_Grupos:=0;			-- Empieza con el primer grupo

		--	Inicializamos el y año de inicio del cuadro de mando
		v_Mes:=v_MesInicial;
		v_Anno:=v_AnnoInicial;

		UltimoValor:=0;

		WHILE v_cur%found LOOP

			--
			--	Cambio de indicador
			--
			IF ((v_IndicadorActual != v_reg.IDIndicador) OR (v_IndicadorActual IS NULL)) THEN
				--	Comprobamos si hay que cerrar el indicador anterior
				IF v_IndicadorActual IS NOT NULL THEN
					--	Insertamos ceros
	   				--	ET 13/1/2003 FOR I IN UltimoMesInformado+1..12 LOOP
	   				FOR I IN ColumnaActual+1..12 LOOP

						--	Envia el registro
	    				HTP.P('<ROW>');
							HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
							HTP.P('<ANNO>'||v_Anno||'</ANNO>');
							HTP.P('<MES>'||v_Mes||'</MES>');	--I
							IF ((p_MarcarRojo='D') AND (UltimoValor>0)) OR ((p_MarcarRojo='A') AND (UltimoValor<0)) THEN
	    	 					HTP.P('<ROJO/>');
							END IF;
							IF (v_Mes>v_MesActual) AND (v_Anno>=v_AnnoActual) THEN
	    	 					HTP.P('<TOTAL></TOTAL>');
							ELSE
	    	 					v_Texto:='<TOTAL>'||0;
	    	 					v_Texto:=v_Texto||'</TOTAL>';
	    	 					HTP.P(v_Texto);
							END IF;
							UltimoValor:=0;
	    	 			HTP.P('</ROW>');

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;


					END LOOP;
					--	Cerramos el grupo
					HTP.P('</GRUPO>');
					--	Cerramos el indicador
					HTP.P('</INDICADOR>');
				END IF;
				--	Abrimos el nuevo indicador
				HTP.P('<INDICADOR>');
					HTP.P('<NOMBREINDICADOR>'	||v_reg.Indicador	||		'</NOMBREINDICADOR>');
					HTP.P('<IDINDICADOR>'		||Utilidades_PCK.Piece(v_reg.IDIndicador,'|',1)	||		'</IDINDICADOR>');
					HTP.P('<GRUPO>');
					HTP.P('<NOMBREGRUPO>'		||SUBSTR(v_reg.Grupo,1,100)	||'</NOMBREGRUPO>');
					HTP.P('<IDGRUPO>'			||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1)		||'</IDGRUPO>');

				v_IndicadorActual:=v_reg.IDIndicador;	--	Actualiza el indicador
				v_GrupoActual:=v_reg.IDGrupo;			--	Actualiza el grupo: Ya no entrara en el cambio de grupo
				UltimoMesInformado:=0;					--	Evita que se rellene con ceros otra vez
				v_Grupos:=v_Grupos+1;

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;
				UltimoValor:=0;

			END IF;

			--
			--	Cambio de grupo
			--

			IF ((v_GrupoActual != v_reg.IDGrupo)
				OR((v_reg.IDGrupo IS NULL)AND(v_GrupoActual IS NOT NULL))) THEN

				--	Si ya ha empezado algún grupo, rellena con CEROS la fila anterior
				--	cierra el grupo y pone la cabecera del nuevo grupo
				--IF v_Grupos>0 THEN
	   				--	ET 13/1/2003 FOR I IN UltimoMesInformado+1..12 LOOP
	   				FOR I IN ColumnaActual+1..12 LOOP

						--	Envia el registro
	    				HTP.P('<ROW>');
							HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
							HTP.P('<ANNO>'||v_Anno||'</ANNO>');
							HTP.P('<MES>'||v_Mes||'</MES>');--I
							IF ((p_MarcarRojo='D') AND (UltimoValor>0)) THEN
	    	 					HTP.P('<ROJO/>');
							END IF;
							IF (v_Mes>v_MesActual) AND (v_Anno>=v_AnnoActual) THEN
	    	 					HTP.P('<TOTAL></TOTAL>');
							ELSE
	    	 					v_Texto:='<TOTAL>'||0;
	    	 					v_Texto:=v_Texto||'</TOTAL>';
	    	 					HTP.P(v_Texto);
							END IF;
							UltimoValor:=0;
	    	 			HTP.P('</ROW>');

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;

					END LOOP;
					HTP.P('</GRUPO>');
					HTP.P('<GRUPO>');
					HTP.P('<NOMBREGRUPO>'	||SUBSTR(v_reg.Grupo,1,100)	||'</NOMBREGRUPO>');
					HTP.P('<IDGRUPO>'		||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1)	||'</IDGRUPO>');
				--END IF;
				v_GrupoActual := v_reg.IDGrupo;
				v_Grupos:=v_Grupos+1;
				UltimoMesInformado:=0;

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;
				UltimoValor:=0;
			END IF;


			--
			-- Presenta los resultados segun la estructura (Mes, Total)
			--

			v_Count:=0;	--Fuerza salida del bucle si el algoritmo esta mal

			-- Rellena con el valor 0 los meses no informados desde el ultimo informado hasta el actual
			IF (UltimoMesInformado+1<v_reg.Mes) 	--	Mismo año
				OR ((v_Anno<v_reg.Anno) AND ((v_reg.Mes>1) OR (v_Mes<12)))  --	Año diferente
				OR ((v_reg.Anno=9999) AND (ColumnaActual<13))				--	Pendiente llegar al total de la fila
					THEN


				--	Si no estamos en el primer mes, empezamos a rellenar en el siguiente
				IF ColumnaActual>1 THEN
					v_Mes:=v_Mes+1;
				END IF;

				--	Repite el bucle hasta llegar al mes anterior al del registro
				WHILE ((v_Mes<=v_reg.Mes-1) OR (v_Anno<v_reg.Anno) OR (v_reg.Anno=9999))
						AND (ColumnaActual<13)
						AND v_Count<12 LOOP


					--	Solo depuracion
					--IF (v_reg.Anno IS NULL) THEN
					--	IF ((v_reg.Anno IS NULL) AND (ColumnaActual<13)) THEN
					--		utilidades_pck.debug('Año: '||v_reg.Anno||' Columna:'||ColumnaActual
					--			||' Resultado: TRUE');
					--	ElSE
					--		utilidades_pck.debug('Año: '||v_reg.Anno||' Columna:'||ColumnaActual
					--			||' Resultado: FALSE');
					--	END IF;
					--END IF;


			--	FOR I IN UltimoMesInformado+1..v_reg.Mes-1 LOOP

			--IF UltimoMesInformado+1<v_reg.Mes THEN
	   			--FOR I IN ColumnaAnterior+1..ColumnaActual-1 LOOP


					--	Envia el registro
	    			HTP.P('<ROW>');

						HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
						HTP.P('<ANNO>'||v_Anno||'</ANNO>');
						HTP.P('<MES>'||v_Mes||'</MES>');--I
						IF ((p_MarcarRojo='D') AND (UltimoValor>0)) OR ((p_MarcarRojo='A') AND (UltimoValor<0)) THEN
	    	 				HTP.P('<ROJO/>');
						END IF;
						IF (v_Mes>v_MesActual) AND (v_Anno>=v_AnnoActual) THEN
	    					HTP.P('<TOTAL></TOTAL>');
						ELSE
	    					v_Texto:='<TOTAL>0';
							IF p_IDResultados	='on' THEN
	    						v_Texto:=v_Texto||'%';
							END IF;
	    					v_Texto:=v_Texto||'</TOTAL>';
	    					HTP.P(v_Texto);
						END IF;
						UltimoValor:=0;
	    			HTP.P('</ROW>');

					--	Incrementa la columna
					ColumnaActual:=ColumnaActual+1;
					v_Mes:=v_Mes+1;

					IF v_Mes>12 THEN
						v_Mes:=v_Mes-12;
						v_Anno:=v_Anno+1;
					END IF;

					v_Count:=v_Count+1; 		--Cuenta el numero de pasos por el bucle, nunca mayor a 12

				END LOOP;
			END IF;


			v_Mes:=v_reg.Mes;

			-- ET10/6/2003IF v_Anno<v_reg.Anno THEN
			-- ET10/6/2003	v_Mes:=v_Mes+12;
			-- ET10/6/2003END IF;

			v_Anno:=v_reg.Anno;
			--ColumnaActual:=ColumnaAnterior;

			--	Envia el registro actual
	    	HTP.P('<ROW>');

				--	utilidades_pck.debug('EIS_PCK.EnviarCuadroDeMando_XML.Anno:'||v_reg.Anno ||' Mes:'||v_Mes ||' Valor:'||v_reg.Total);--solodebug

				HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
				HTP.P('<ANNO>'||v_reg.Anno||'</ANNO>');
				HTP.P('<MES>'||v_reg.Mes||'</MES>');
				IF ((p_MarcarRojo='D') AND (UltimoValor>TO_NUMBER(v_reg.TotalNumero)))
							OR ((p_MarcarRojo='A') AND (UltimoValor<TO_NUMBER(v_reg.TotalNumero))) THEN
	    	 		HTP.P('<ROJO/>');
				END IF;
				IF (v_reg.Mes>v_MesActual AND v_reg.Mes<13) AND (v_Anno>=v_AnnoActual) AND (v_reg.Total='0,00' OR v_reg.Total='0' OR v_reg.Total='0,00%') THEN
	    			HTP.P('<TOTAL></TOTAL>');
					UltimoValor:=0;
				ELSE
					--	El formato se introduce en la propia select
	    			HTP.P('<TOTAL>'||v_reg.Total||'</TOTAL>');
					UltimoValor:=TO_NUMBER(v_reg.TotalNumero);
				END IF;
	    	HTP.P('</ROW>');

			UltimoMesInformado:=v_reg.Mes;
			ColumnaActual:=ColumnaActual+1;

	     	FETCH v_cur INTO v_reg;

	   	END LOOP;

	END IF;
	CLOSE v_cur;
	IF v_HayDatos=TRUE THEN
		HTP.P('</GRUPO>');
		HTP.P('</INDICADOR>');
	END IF;
	HTP.P('</CUADRODEMANDO>');

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.EnviarCuadroDeMando_XML:'||UltimoValor||'>'||v_reg.Total,'',sqlcode,sqlerrm,null);
END;
*/
/*
	PROCEDURE EnviarCuadroDeMando_v2_XML

	Envia los valores de un cuadro de mando en formato XML a partir de una consulta SQL
	contra la tabla temporal de valores

	05 nov 04	ET	Incluimos el color verde cuando estamos por encima de la media
					Tenemos en cuenta un margen (por defecto, 20%: deberia poderse cambiar desde la web)
	29abr09		ET	Había un gazapo, no se pone limite superior si el mes seleccionado era el TOTAL, porque el año que se pasa es el siguiente
	19jun09		ET	Otro gazapo, cuando se selecciona el total hay que poner 9999
	23feb10		ET	Añadimos el numeo de linea y el total de lineas por indicador

*/
PROCEDURE EnviarCuadroDeMando_v2_XML
(
	p_Anno				VARCHAR2,
	p_NumeroFilas		INTEGER,
	p_VectorNombres		TVectorCadenas,
	p_VectorValores		IN OUT TVectorNumerico,			--	Para poder modificar el vector (ratio de dias laborables) debe ser de entrada/salida
	p_MarcarRojo		VARCHAR2,
	p_IDResultados		VARCHAR2
)
IS
	
	CURSOR cDiasLaborables(v_MesInicial INTEGER, v_AnnoInicial INTEGER) IS
		SELECT 		EIS_DL_DIASLABORABLES Total
			FROM	EIS_DIASLABORABLESPORMES
			WHERE	((EIS_DL_ANNO=v_AnnoInicial AND EIS_DL_MES>=v_MesInicial)
				OR		(EIS_DL_ANNO=v_AnnoInicial+1 AND EIS_DL_MES<v_MesInicial))
			ORDER BY EIS_DL_ANNO, EIS_DL_MES;
			
	v_cur 				REF_CURSOR;
	v_reg 				TRegEIS;
	v_GrupoActual 		VARCHAR2(100);
	v_IndicadorActual	VARCHAR2(100);
	v_Grupos 			NUMBER;
	i 					NUMBER;
	v_Total 			NUMBER;
	UltimoMesInformado 	INTEGER;
	UltimoValor		 	NUMBER;
	MediaFila		 	NUMBER;
	ColumnaActual	 	INTEGER;
	--ColumnaAnterior	 	INTEGER;
	v_Anno				INTEGER;
	v_AnnoInicial		INTEGER;
	v_AnnoActual		INTEGER;
	v_Mes				INTEGER;
	v_MesInicial		INTEGER;
	v_MesActual			INTEGER;
	v_DiaActual			INTEGER;
	v_Texto				VARCHAR2(3000);		-- ET 30/10/2002 enviamos los resultados con '%' cuando convenga
	v_HayDatos			BOOLEAN;

	v_Count				INTEGER;
	v_Linea				INTEGER;

	vCadena				VARCHAR2(3000);		-- ET 28/5/2003 enviamos los resultados por filas
	Inicio				BOOLEAN;

	--	Para calculo de rendimiento
	v_IDRendimiento 	NUMBER;
	v_Operacion			VARCHAR2(100);

	v_Margen			INTEGER:=20;
	v_Corrector			NUMBER(15,10);
	
	--	Para el ratio por días laborables
	TYPE TDiasLaborables	IS TABLE OF INTEGER INDEX BY BINARY_INTEGER;
	v_DiasLaborables	TDiasLaborables;

	vStatus					VARCHAR2(3000);		--	solodebug
BEGIN

	vStatus:='Inicio';

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'EnviaCuadrodeMando_v2_XML','','EIS Cons');

	--	Mes a partir del cual los totales 0 se presentaran como null en lugar de 0
	v_DiaActual:=to_number(to_char(SYSDATE,'dd'));		--	7mar12	Factor corrector en el mes actual
	v_MesActual:=to_number(to_char(SYSDATE,'mm'));
	v_AnnoActual:=to_number(to_char(SYSDATE,'yyyy'));
	--IF p_Anno<to_char(SYSDATE,'yyyy') THEN
	--	v_MesActual:=99;
	--END IF;


	--	Mes y año correspondientes a la primera columna del grafico
	IF p_Anno=9999 THEN
		v_MesInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'))+1;	--	el mes siguiente al actual, pero del año anterior
		v_AnnoInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;
	ELSE
		v_MesInicial:=1;
		v_AnnoInicial:=p_Anno;
	END IF;


--	utilidades_pck.debug('EIS_PCK.EnviarCuadroDeMando_XML - Parametro:'||p_Anno
--							||' Sistema:'||to_char(SYSDATE,'yyyy')
--							||' Mes actual:'||v_MesActual||'/'||v_AnnoActual
--							||' Mes inicial:'||v_MesInicial||'/'||v_AnnoInicial
--							||' SQL:'||v_SQL);
--


	v_HayDatos:=FALSE;
	HTP.P('<CUADRODEMANDO>');
	vCadena:='';

	vStatus:='<CUADRODEMANDO>';

	Inicio:=TRUE;

	--	Nos aseguramos de que hayan datos
	IF p_NumeroFilas IS NOT NULL THEN
	
		--	Si serán necesarios los días laborables los cargamos antes de entrar en el bucle
		IF p_IDResultados='LABOR' THEN
			v_Total:=0;
			v_Count:=0;
			FOR rDiasLaborables IN cDiasLaborables(v_MesInicial, v_AnnoInicial) LOOP
				v_Count						:=v_Count+1;
				v_Total						:=v_Total+rDiasLaborables.Total;
				v_DiasLaborables(v_Count)	:=rDiasLaborables.Total;
			END LOOP;
			v_DiasLaborables(13):=v_Total;

			--	Normalizamos también el vector de valores, una vez normalizado su uso es como para el indicador de ACUMULADO 

			--	Bucle sobre todas las filas
			FOR I IN 0..p_NumeroFilas LOOP
				--	Recorre todas las columnas
				FOR J IN 1..13 LOOP
					BEGIN
						IF SUBSTR(p_VectorNombres(I),1,1)<>'I' THEN
							p_VectorValores(I*13+J):=p_VectorValores(I*13+J)/v_DiasLaborables(J);
						END IF;
					EXCEPTION
						WHEN OTHERS THEN
							utilidades_pck.debug('I:'||I||' J:'||J||' SQLERRM:'||SQLERRM);
					END;
				END LOOP;
			END LOOP;
		END IF;
		

		--	Bucle sobre todas las filas
		FOR I IN 0..p_NumeroFilas LOOP


			--	Si esta fila corresponde a un nuevo indicador devuelve el XML correspondiente
			IF SUBSTR(p_VectorNombres(I),1,1)='I' THEN

				-- Cierra y envia la cadena anterior
				IF Inicio=FALSE THEN
					HTP.P(	'<MAXLINEAS>'|| v_Linea ||'</MAXLINEAS>'
							||	vCadena||'</INDICADOR>');
					vStatus:=vStatus||'</INDICADOR>';
				END IF;

				Inicio:=FALSE;

				vCadena:=		'<INDICADOR>'
							||	'<NOMBREINDICADOR>'	||mvm.ScapeHTMLString(Utilidades_PCK.Piece(p_VectorNombres(I),'|',1))	||	'</NOMBREINDICADOR>'	--	14jul15	 Añado mvm.ScapeHTMLString
							||	'<IDINDICADOR>'		||Utilidades_PCK.Piece(p_VectorNombres(I),'|',2)						||	'</IDINDICADOR>';

				vStatus:=vStatus||'<INDICADOR>';
				v_Linea:=0;

			--	Si se trata de un grupo
			ELSE

				v_HayDatos:=TRUE;

				--	Inicializamos el y año de inicio del cuadro de mando
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;

				--	Y el ultimo valor para marcar tendencias --> Utilizamos la media en lugar del ultimo valor
				--UltimoValor:=0;
				IF p_IDResultados='ACUM' OR p_IDResultados IS NULL THEN
					MediaFila:=p_VectorValores(I*13+13)/12;		--Acumulados: media = total/12
				ELSIF p_IDResultados='PORCH' THEN
					MediaFila:=100/12;						--Porc.Horiz.: media = 100%/12
				ELSE
					MediaFila:=p_VectorValores(I*13+13);	--Ratio: media = total
				END IF;

				v_Linea:=v_Linea+1;
				--	Prepara la cabecera del grupo
				vCadena:=vCadena	||	'<GRUPO>'
									||	'<NOMBREGRUPO>'	||mvm.ScapeHTMLString(Utilidades_PCK.Piece(p_VectorNombres(I),'|',1))	||'</NOMBREGRUPO>'	--	14jul15	 Añado mvm.ScapeHTMLString
									||	'<IDGRUPO>'		||Utilidades_PCK.Piece(p_VectorNombres(I),'|',2)						||'</IDGRUPO>'
									||	'<LINEA>'		||v_Linea																||'</LINEA>';

				--utilidades_pck.debug('Nueva linea '||v_Linea||' Grupo|IDGRupo:'||p_VectorNombres(I));--solodebug
				
				--vStatus:=vStatus||'<GRUPO>';

				--	Recorre todos los valores del grupo para montar el XML correspondiente
				FOR J IN 1..13 LOOP

					vCadena:=vCadena	||'<ROW>'
										||'<COLUMNA>'	||J				||'</COLUMNA>'
										||'<ANNO>'		||v_Anno		||'</ANNO>'
										||'<MES>'		||v_Mes			||'</MES>';

					IF v_Mes=v_MesActual AND v_Anno=v_AnnoActual AND v_DiaActual>1 THEN
						v_Corrector:=utilidades_pck.NumeroDiasMes(v_Mes, v_Anno)/(v_DiaActual-1);
					ELSE
						v_Corrector:=1;
					END IF;
					
					IF MediaFila<>0 THEN

						--utilidades_pck.debug('Media:'||MediaFila||' Valor:'||p_VectorValores(I*13+J)
						--					||' Margen:'||v_Margen||' Coeficiente:'||to_char((MediaFila-p_VectorValores(I*13+J))*100/MediaFila));

						IF ((p_MarcarRojo='D') AND ( (MediaFila-p_VectorValores(I*13+J)*v_Corrector)*100/MediaFila) >v_Margen)
									OR ((p_MarcarRojo='A') AND (((p_VectorValores(I*13+J)*v_Corrector-MediaFila)*100/MediaFila)>v_Margen)) THEN
	    	 				vCadena:=vCadena||'<ROJO/>';
						END IF;
						IF ((p_MarcarRojo='D') AND (((p_VectorValores(I*13+J)*v_Corrector-MediaFila)*100/MediaFila)>v_Margen))--(MediaFila<p_VectorValores(I*13+J)))
									OR ((p_MarcarRojo='A') AND ((MediaFila-p_VectorValores(I*13+J)*v_Corrector)*100/MediaFila)>v_Margen) THEN
	    	 				vCadena:=vCadena||'<VERDE/>';
						END IF;
					END IF;

					IF  (p_VectorValores(I*13+J)=0) THEN
						--	Si el total de la columna es 0
						IF (v_Mes>v_MesActual AND J<13) AND (v_Anno>=v_AnnoActual) THEN
							--	Si es mayor al mes actual, devolvemos espacio
	    					vCadena:=vCadena||'<TOTAL></TOTAL>';
						ELSE
							--	Si es menor, devolvemos 0, sin decimales
	    					vCadena:=vCadena||'<TOTAL>0</TOTAL>';
						END IF;
						--UltimoValor:=0;
					ELSE
						--	El formato se introduce en la propia select
	    				--	ET 25/11/03	utilizamos la nueva funcion de Autoformato que presenta decimales en funcion
						--				del tamaño del valor
						
						--solodebug	utilidades_pck.debug('Fila:'||I||' Columna:'||J||' Valor:'||p_VectorValores(I*13+J));
						
						vCadena:=vCadena||'<TOTAL>'||Formato.formato(p_VectorValores(I*13+J),0,'L')||'</TOTAL>';	--solodebug

    					--solodebug	vCadena:=vCadena||'<TOTAL>'||Formato.AutoFormato(p_VectorValores(I*13+J),'S')||'</TOTAL>';

						--UltimoValor:=p_VectorValores(I*13+J);
					END IF;
	    	 		vCadena:=vCadena||'</ROW>';

					IF J<12 THEN	--	29abr09	ET	se incrementaba el año al llegar al total, por lo que en la lista de resultados se mostraba el año siguiente al pulsar sobre la columna de total
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;
						
						--utilidades_pck.debug('I:'||I||' J:'||J||' v_Mes:'||v_Mes||' v_Anno:'||v_Anno);--solodebug
						
					END IF;

				END LOOP;
				vCadena:=vCadena	||	'</GRUPO>';
				--vStatus:=vStatus||'</GRUPO>';
				END IF;

			HTP.P(vCadena);
			
			--solodebug	utilidades_pck.debug(vCadena);

			vCadena:='';

		END LOOP;

	END IF;

	--	Cerramos el indicador que puede haber quedado abierto
	IF v_HayDatos=TRUE THEN
		HTP.P(		'<MAXLINEAS>'|| v_Linea ||'</MAXLINEAS>'
				||	'</INDICADOR>');
		vStatus:=vStatus||'</INDICADOR>';
	END IF;
	HTP.P('</CUADRODEMANDO>');
	vStatus:=vStatus||'</CUADRODEMANDO>';

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

	--utilidades_pck.debug('EnviarCuadroDeMando_v2_XML:'||vStatus);		--solodebug

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.EnviarCuadroDeMando_v2_XML', SUBSTR(vStatus,1,2500)||' Numero filas:'||p_NumeroFilas||' SQLERRM:'||sqlerrm);
END;


--	30abr13	Inserta una línea en la tabla de listados
PROCEDURE LineaAListado
(
	p_IDListado				NUMBER,
	p_EIS_LS_COL01			VARCHAR2,
	p_EIS_LS_COL02			VARCHAR2,
	p_EIS_LS_COL03			VARCHAR2,
	p_EIS_LS_COL04			VARCHAR2,
	p_EIS_LS_COL05			VARCHAR2,
	p_EIS_LS_COL06			VARCHAR2,
	p_EIS_LS_COL07			VARCHAR2,
	p_EIS_LS_COL08			VARCHAR2,
	p_EIS_LS_COL09			VARCHAR2,
	p_EIS_LS_COL10			VARCHAR2,
	p_EIS_LS_COL11			VARCHAR2,
	p_EIS_LS_COL12			VARCHAR2,
	p_EIS_LS_COL13			VARCHAR2,
	p_EIS_LS_COL14			VARCHAR2
)
IS
BEGIN

	INSERT INTO	EIS_LISTADOS
	(
		EIS_LS_ID,
		EIS_LS_IDLINEA,
		EIS_LS_COL01,
		EIS_LS_COL02,
		EIS_LS_COL03,
		EIS_LS_COL04,
		EIS_LS_COL05,
		EIS_LS_COL06,
		EIS_LS_COL07,
		EIS_LS_COL08,
		EIS_LS_COL09,
		EIS_LS_COL10,
		EIS_LS_COL11,
		EIS_LS_COL12,
		EIS_LS_COL13,
		EIS_LS_COL14
	)
	VALUES
	(
		p_IDListado,
		EIS_LS_IDLINEA_SEQ.Nextval,
		p_EIS_LS_COL01,
		p_EIS_LS_COL02,
		p_EIS_LS_COL03,
		p_EIS_LS_COL04,
		p_EIS_LS_COL05,
		p_EIS_LS_COL06,
		p_EIS_LS_COL07,
		p_EIS_LS_COL08,
		p_EIS_LS_COL09,
		p_EIS_LS_COL10,
		p_EIS_LS_COL11,
		p_EIS_LS_COL12,
		p_EIS_LS_COL13,
		p_EIS_LS_COL14
	);

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.InsertaLineaEnListado', 'IDListado:'||p_IDListado||' EIS_LS_COL01:'||p_EIS_LS_COL01||' EIS_LS_COL02:'||p_EIS_LS_COL02||' SQLERRM:'||sqlerrm);
END;

--	30abr13	Inserta una línea vacía en la tabla de listados
PROCEDURE LineaTextoAListado
(
	p_IDListado				NUMBER,
	p_Texto					VARCHAR2
)
IS
BEGIN
	LineaAListado
	(
		p_IDListado,
		p_Texto,				--	1
		NULL,					--	2
		NULL,					--	3
		NULL,					--	4
		NULL,					--	5
		NULL,					--	6
		NULL,					--	7
		NULL,					--	8
		NULL,					--	9
		NULL,					--	10
		NULL,					--	11
		NULL,					--	12
		NULL,					--	13
		NULL					--	14
	);
END;

--	30abr13	Inserta una línea vacía en la tabla de listados
PROCEDURE LineaTituloAListado
(
	p_IDListado				NUMBER,
	p_Titulo				VARCHAR2,
	p_Anno					INTEGER,
	p_Mes					INTEGER	
)
IS
	v_Mes			NUMBER(2);
	v_Anno			NUMBER(4);
	
	TYPE TVectorMeses 	IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
	v_NombreMes		TVectorMeses;
	
BEGIN
	v_Mes:=p_Mes;
	v_Anno:=p_Anno;
	
	--	Envia los doce meses
	FOR I IN 1..12 LOOP
	
		v_NombreMes(I):=SUBSTR(Utilidades_PCK.NombreMes(v_Mes),1,3)||' '||SUBSTR(v_Anno,3,2);

		--	Siguiente mes
		v_Mes:=v_Mes+1;

		--	Si hemos superado el año incrementamos este
		IF v_Mes=13 THEN
			v_Anno:=v_Anno+1;
			v_Mes:=1;
		END IF;

	END LOOP;


	LineaAListado
	(
		p_IDListado,
		p_Titulo,				--	1
		v_NombreMes(1),			--	2
		v_NombreMes(2),			--	3
		v_NombreMes(3),			--	4
		v_NombreMes(4),			--	5
		v_NombreMes(5),			--	6
		v_NombreMes(6),			--	7
		v_NombreMes(7),			--	8
		v_NombreMes(8),			--	9
		v_NombreMes(9),			--	10
		v_NombreMes(10),		--	11
		v_NombreMes(11),		--	12
		v_NombreMes(12),		--	13
		'TOTAL'					--	14
	);
END;


--	30abr13 Guarda en la tabla temporal el resultado de la consulta
PROCEDURE PrepararListado_Excel
(
	p_IDUsuario			NUMBER,
	p_Anno				VARCHAR2,
	p_NumeroFilas		INTEGER,
	p_VectorNombres		TVectorCadenas,
	p_VectorValores		IN OUT TVectorNumerico,			--	Para poder modificar el vector (ratio de dias laborables) debe ser de entrada/salida
	p_IDResultados		VARCHAR2
)
IS
	
	CURSOR cDiasLaborables(v_MesInicial INTEGER, v_AnnoInicial INTEGER) IS
		SELECT 		EIS_DL_DIASLABORABLES Total
			FROM	EIS_DIASLABORABLESPORMES
			WHERE	((EIS_DL_ANNO=v_AnnoInicial AND EIS_DL_MES>=v_MesInicial)
				OR		(EIS_DL_ANNO=v_AnnoInicial+1 AND EIS_DL_MES<v_MesInicial))
			ORDER BY EIS_DL_ANNO, EIS_DL_MES;
			
	v_cur 				REF_CURSOR;
	v_reg 				TRegEIS;
	v_GrupoActual 		VARCHAR2(100);
	v_IndicadorActual	VARCHAR2(100);
	v_Grupos 			NUMBER;
	i 					NUMBER;
	v_Total 			NUMBER;
	UltimoMesInformado 	INTEGER;
	UltimoValor		 	NUMBER;
	MediaFila		 	NUMBER;
	ColumnaActual	 	INTEGER;
	--ColumnaAnterior	 	INTEGER;
	v_Anno				INTEGER;
	v_AnnoInicial		INTEGER;
	v_AnnoActual		INTEGER;
	v_Mes				INTEGER;
	v_MesInicial		INTEGER;
	v_MesActual			INTEGER;
	v_DiaActual			INTEGER;
	v_Texto				VARCHAR2(3000);		-- ET 30/10/2002 enviamos los resultados con '%' cuando convenga
	v_HayDatos			BOOLEAN;

	v_Count				INTEGER;
	v_Linea				INTEGER;

	vCadena				VARCHAR2(3000);		-- ET 28/5/2003 enviamos los resultados por filas
	Inicio				BOOLEAN;

	--	Para calculo de rendimiento
	v_IDRendimiento 	NUMBER;
	v_Operacion			VARCHAR2(100);

	v_Margen			INTEGER:=20;
	v_Corrector			NUMBER(15,10);
	
	--	Para el ratio por días laborables
	TYPE TDiasLaborables	IS TABLE OF INTEGER INDEX BY BINARY_INTEGER;
	v_DiasLaborables		TDiasLaborables;

	v_IDListado				NUMBER(10);
	v_SQL					VARCHAR2(3000);

	vStatus					VARCHAR2(3000);		--	solodebug
BEGIN

	vStatus:='Inicio';

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'PrepararListado_Excel','','EIS Cons');

	--	Mes a partir del cual los totales 0 se presentaran como null en lugar de 0
	v_DiaActual:=to_number(to_char(SYSDATE,'dd'));		--	7mar12	Factor corrector en el mes actual
	v_MesActual:=to_number(to_char(SYSDATE,'mm'));
	v_AnnoActual:=to_number(to_char(SYSDATE,'yyyy'));
	--IF p_Anno<to_char(SYSDATE,'yyyy') THEN
	--	v_MesActual:=99;
	--END IF;


	--	Mes y año correspondientes a la primera columna del grafico
	IF p_Anno=9999 THEN
		v_MesInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'))+1;	--	el mes siguiente al actual, pero del año anterior
		v_AnnoInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;
	ELSE
		v_MesInicial:=1;
		v_AnnoInicial:=p_Anno;
	END IF;

	--	Si serán necesarios los días laborables los cargamos antes de entrar en el bucle
	IF p_IDResultados='LABOR' THEN
		v_Total:=0;
		v_Count:=0;
		FOR rDiasLaborables IN cDiasLaborables(v_MesInicial, v_AnnoInicial) LOOP
			v_Count						:=v_Count+1;
			v_Total						:=v_Total+rDiasLaborables.Total;
			v_DiasLaborables(v_Count)	:=rDiasLaborables.Total;
		END LOOP;
		v_DiasLaborables(13):=v_Total;

		--	Normalizamos también el vector de valores, una vez normalizado su uso es como para el indicador de ACUMULADO 

		--	Bucle sobre todas las filas
		FOR I IN 0..p_NumeroFilas LOOP
			--	Recorre todas las columnas
			FOR J IN 1..13 LOOP
				BEGIN
					IF SUBSTR(p_VectorNombres(I),1,1)<>'I' THEN
						p_VectorValores(I*13+J):=p_VectorValores(I*13+J)/v_DiasLaborables(J);
					END IF;
				EXCEPTION
					WHEN OTHERS THEN
						utilidades_pck.debug('I:'||I||' J:'||J||' SQLERRM:'||SQLERRM);
				END;
			END LOOP;
		END LOOP;
	END IF;



	SELECT EIS_LS_ID_SEQ.NEXTVAL INTO v_IDListado FROM DUAL;


--	utilidades_pck.debug('EIS_PCK.PrepararListado_Excel - Parametro:'||p_Anno
--							||' Sistema:'||to_char(SYSDATE,'yyyy')
--							||' Mes actual:'||v_MesActual||'/'||v_AnnoActual
--							||' Mes inicial:'||v_MesInicial||'/'||v_AnnoInicial
--							||' SQL:'||v_SQL);
--

	--	Nos aseguramos de que hayan datos
	IF p_NumeroFilas IS NOT NULL THEN
	
		--	Bucle sobre todas las filas
		FOR I IN 0..p_NumeroFilas LOOP

			--	Si esta fila corresponde a un nuevo indicador devuelve el XML correspondiente
			IF SUBSTR(p_VectorNombres(I),1,1)='I' THEN
				
				-- Inserta línea vacía
				LineaTextoAListado(v_IDListado,'');
				-- Inserta línea con el nombre del indicador y los meses
				LineaTituloAListado(v_IDListado,Utilidades_PCK.Piece(p_VectorNombres(I),'|',1), v_AnnoInicial, v_MesInicial);
				v_Linea:=0;

			--	Si se trata de un grupo
			ELSE
				--	Recorre todos los valores del grupo para montar el XML correspondiente
				LineaAListado
				(
					v_IDListado,
					Utilidades_PCK.Piece(p_VectorNombres(I),'|',1),
					formato.FormatoSinPunto(p_VectorValores(I*13+1),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+2),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+3),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+4),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+5),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+6),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+7),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+8),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+9),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+10),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+11),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+12),4),
					formato.FormatoSinPunto(p_VectorValores(I*13+13),4)
				);
				
			END IF;
		END LOOP;
	ELSE
		--	No hay resultados, insertamos aviso
		LineaTextoAListado(v_IDListado,'No se han encontrado resultados');
	
	END IF;
	
/*	
		--	Si serán necesarios los días laborables los cargamos antes de entrar en el bucle
		IF p_IDResultados='LABOR' THEN
			v_Total:=0;
			v_Count:=0;
			FOR rDiasLaborables IN cDiasLaborables(v_MesInicial, v_AnnoInicial) LOOP
				v_Count						:=v_Count+1;
				v_Total						:=v_Total+rDiasLaborables.Total;
				v_DiasLaborables(v_Count)	:=rDiasLaborables.Total;
			END LOOP;
			v_DiasLaborables(13):=v_Total;

			--	Normalizamos también el vector de valores, una vez normalizado su uso es como para el indicador de ACUMULADO 

			--	Bucle sobre todas las filas
			FOR I IN 0..p_NumeroFilas LOOP
				--	Recorre todas las columnas
				FOR J IN 1..13 LOOP
					BEGIN
						IF SUBSTR(p_VectorNombres(I),1,1)<>'I' THEN
							p_VectorValores(I*13+J):=p_VectorValores(I*13+J)/v_DiasLaborables(J);
						END IF;
					EXCEPTION
						WHEN OTHERS THEN
							utilidades_pck.debug('I:'||I||' J:'||J||' SQLERRM:'||SQLERRM);
					END;
				END LOOP;
			END LOOP;
		END IF;
		

		--	Bucle sobre todas las filas
		FOR I IN 0..p_NumeroFilas LOOP


			--	Si esta fila corresponde a un nuevo indicador devuelve el XML correspondiente
			IF SUBSTR(p_VectorNombres(I),1,1)='I' THEN

				-- Cierra y envia la cadena anterior
				IF Inicio=FALSE THEN
					HTP.P(	'<MAXLINEAS>'|| v_Linea ||'</MAXLINEAS>'
							||	vCadena||'</INDICADOR>');
					vStatus:=vStatus||'</INDICADOR>';
				END IF;

				Inicio:=FALSE;

				vCadena:=		'<INDICADOR>'
							||	'<NOMBREINDICADOR>'	||Utilidades_PCK.Piece(p_VectorNombres(I),'|',1)	||	'</NOMBREINDICADOR>'
							||	'<IDINDICADOR>'		||Utilidades_PCK.Piece(p_VectorNombres(I),'|',2)	||	'</IDINDICADOR>';

				vStatus:=vStatus||'<INDICADOR>';
				v_Linea:=0;

			--	Si se trata de un grupo
			ELSE

				v_HayDatos:=TRUE;

				--	Inicializamos el y año de inicio del cuadro de mando
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;

				--	Y el ultimo valor para marcar tendencias --> Utilizamos la media en lugar del ultimo valor
				--UltimoValor:=0;
				IF p_IDResultados='ACUM' OR p_IDResultados IS NULL THEN
					MediaFila:=p_VectorValores(I*13+13)/12;		--Acumulados: media = total/12
				ELSIF p_IDResultados='PORCH' THEN
					MediaFila:=100/12;						--Porc.Horiz.: media = 100%/12
				ELSE
					MediaFila:=p_VectorValores(I*13+13);	--Ratio: media = total
				END IF;

				v_Linea:=v_Linea+1;
				--	Prepara la cabecera del grupo
				vCadena:=vCadena	||	'<GRUPO>'
									||	'<NOMBREGRUPO>'	||Utilidades_PCK.Piece(p_VectorNombres(I),'|',1)	||'</NOMBREGRUPO>'
									||	'<IDGRUPO>'		||Utilidades_PCK.Piece(p_VectorNombres(I),'|',2)	||'</IDGRUPO>'
									||	'<LINEA>'		||v_Linea											||'</LINEA>';

				--utilidades_pck.debug('Nueva linea '||v_Linea||' Grupo|IDGRupo:'||p_VectorNombres(I));--solodebug
				
				--vStatus:=vStatus||'<GRUPO>';

				--	Recorre todos los valores del grupo para montar el XML correspondiente
				FOR J IN 1..13 LOOP

					vCadena:=vCadena	||'<ROW>'
										||'<COLUMNA>'	||J				||'</COLUMNA>'
										||'<ANNO>'		||v_Anno		||'</ANNO>'
										||'<MES>'		||v_Mes			||'</MES>';

					IF v_Mes=v_MesActual AND v_Anno=v_AnnoActual AND v_DiaActual>1 THEN
						v_Corrector:=utilidades_pck.NumeroDiasMes(v_Mes, v_Anno)/(v_DiaActual-1);
					ELSE
						v_Corrector:=1;
					END IF;
					
					IF MediaFila<>0 THEN

						--utilidades_pck.debug('Media:'||MediaFila||' Valor:'||p_VectorValores(I*13+J)
						--					||' Margen:'||v_Margen||' Coeficiente:'||to_char((MediaFila-p_VectorValores(I*13+J))*100/MediaFila));

						IF ((p_MarcarRojo='D') AND ( (MediaFila-p_VectorValores(I*13+J)*v_Corrector)*100/MediaFila) >v_Margen)
									OR ((p_MarcarRojo='A') AND (((p_VectorValores(I*13+J)*v_Corrector-MediaFila)*100/MediaFila)>v_Margen)) THEN
	    	 				vCadena:=vCadena||'<ROJO/>';
						END IF;
						IF ((p_MarcarRojo='D') AND (((p_VectorValores(I*13+J)*v_Corrector-MediaFila)*100/MediaFila)>v_Margen))--(MediaFila<p_VectorValores(I*13+J)))
									OR ((p_MarcarRojo='A') AND ((MediaFila-p_VectorValores(I*13+J)*v_Corrector)*100/MediaFila)>v_Margen) THEN
	    	 				vCadena:=vCadena||'<VERDE/>';
						END IF;
					END IF;
v_SQL
					IF  (p_VectorValores(I*13+J)=0) THEN
						--	Si el total de la columna es 0
						IF (v_Mes>v_MesActual AND J<13) AND (v_Anno>=v_AnnoActual) THEN
							--	Si es mayor al mes actual, devolvemos espacio
	    					vCadena:=vCadena||'<TOTAL></TOTAL>';
						ELSE
							--	Si es menor, devolvemos 0, sin decimales
	    					vCadena:=vCadena||'<TOTAL>0</TOTAL>';
						END IF;
						--UltimoValor:=0;
					ELSE
						--	El formato se introduce en la propia select
	    				--	ET 25/11/03	utilizamos la nueva funcion de Autoformato que presenta decimales en funcion
						--				del tamaño del valor
						--vCadena:=vCadena||'<TOTAL>'||Formato.formato(p_VectorValores(I*13+J),0,'N')||'</TOTAL>';
    					vCadena:=vCadena||'<TOTAL>'||Formato.AutoFormato(p_VectorValores(I*13+J),'S')||'</TOTAL>';
						--UltimoValor:=p_VectorValores(I*13+J);
					END IF;
	    	 		vCadena:=vCadena||'</ROW>';

					IF J<12 THEN	--	29abr09	ET	se incrementaba el año al llegar al total, por lo que en la lista de resultados se mostraba el año siguiente al pulsar sobre la columna de total
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;
						
						--utilidades_pck.debug('I:'||I||' J:'||J||' v_Mes:'||v_Mes||' v_Anno:'||v_Anno);--solodebug
						
					END IF;

				END LOOP;
				vCadena:=vCadena	||	'</GRUPO>';
				--vStatus:=vStatus||'</GRUPO>';
				END IF;

			HTP.P(vCadena);

			vCadena:='';

		END LOOP;

	END IF;

	--	Cerramos el indicador que puede haber quedado abierto
	IF v_HayDatos=TRUE THEN
		HTP.P(		'<MAXLINEAS>'|| v_Linea ||'</MAXLINEAS>'
				||	'</INDICADOR>');
		vStatus:=vStatus||'</INDICADOR>';
	END IF;
	HTP.P('</CUADRODEMANDO>');
	vStatus:=vStatus||'</CUADRODEMANDO>';
*/


	v_SQL:=' SELECT EIS_LS_COL01,EIS_LS_COL02,EIS_LS_COL03,EIS_LS_COL04,EIS_LS_COL05,EIS_LS_COL06,'
		||		' 	EIS_LS_COL07,EIS_LS_COL08,EIS_LS_COL09,EIS_LS_COL10,EIS_LS_COL11,EIS_LS_COL12,EIS_LS_COL13,EIS_LS_COL14'
		||		' FROM EIS_LISTADOS WHERE EIS_LS_ID='||v_IDListado||' ORDER BY EIS_LS_IDLINEA';
	
	--utilidades_pck.debug('CATALOGOPRIVADO_SEG_PCK.FamiliasYProductos_Excel SQL:'||v_SQL);
	LISTADOSEXCEL_PCK.DescargaExcel
	(
    	p_IDUsuario,
    	'EIS',
    	v_SQL 
	);
	
	--	Limpiamos el listado de la tabla
	DELETE EIS_LISTADOS
		WHERE EIS_LS_ID=v_IDListado;



	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

	--utilidades_pck.debug('PrepararListado_Excel:'||vStatus);		--solodebug

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.PrepararListado_Excel', SUBSTR(vStatus,1,2500)||' Numero filas:'||p_NumeroFilas||' SQLERRM:'||sqlerrm);
END;

/*
	PROCEDURE EnviarCuadro_Posiciones_XML

	Envia los valores (posicion relativa del concepto) de un cuadro de mando en formato XML a partir de una consulta SQL
	contra la tabla temporal de valores
*/
PROCEDURE EnviarCuadro_Posiciones_XML
(
	v_SQL				VARCHAR2,
	p_Anno				VARCHAR2,
	p_AgruparPor		VARCHAR2,
	p_IDResultados		VARCHAR2,
	p_MarcarRojo		VARCHAR2
)
IS
	v_cur 				REF_CURSOR;
	v_reg 				TRegEIS;
	v_GrupoActual 		VARCHAR2(100);
	v_IndicadorActual	VARCHAR2(100);
	v_Grupos 			NUMBER;
	i 					NUMBER;
	v_Total 			NUMBER;
	UltimoMesInformado 	INTEGER;
	UltimoValor		 	NUMBER;
	ColumnaActual	 	INTEGER;
	--ColumnaAnterior	 	INTEGER;
	v_Anno				INTEGER;
	v_AnnoInicial		INTEGER;
	v_AnnoActual		INTEGER;
	v_Mes				INTEGER;
	v_MesInicial		INTEGER;
	v_MesActual			INTEGER;
	v_Texto				VARCHAR2(3000);		-- ET 30/10/2002 enviamos los resultados con '%' cuando convenga
	v_HayDatos			BOOLEAN;

	v_Count				INTEGER;

	ULTIMAPOSICION		INTEGER:=99999999;	--	Si no tiene posicion informada, sera el "muy muy muy ultimo" ;-)
BEGIN

	--	Mes a partir del cual los totales 0 se presentaran como null en lugar de 0
	v_MesActual:=to_number(to_char(SYSDATE,'mm'));
	v_AnnoActual:=to_number(to_char(SYSDATE,'yyyy'));
	--IF p_Anno<to_char(SYSDATE,'yyyy') THEN
	--	v_MesActual:=99;
	--END IF;


	--	Mes y año correspondientes a la primera columna del grafico
	IF p_Anno=9999 THEN
		v_MesInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'))+1;	--	el mes siguiente al actual, pero del año anterior
		v_AnnoInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;
	ELSE
		v_MesInicial:=1;
		v_AnnoInicial:=p_Anno;
	END IF;


--	utilidades_pck.debug('EIS_PCK.EnviarCuadroDeMando_XML - Parametro:'||p_Anno
--							||' Sistema:'||to_char(SYSDATE,'yyyy')
--							||' Mes actual:'||v_MesActual||'/'||v_AnnoActual
--							||' Mes inicial:'||v_MesInicial||'/'||v_AnnoInicial
--							||' SQL:'||v_SQL);
--


	v_HayDatos:=FALSE;
	HTP.P('<CUADRODEMANDO>');
	OPEN v_cur FOR v_SQL;

	   FETCH v_cur INTO v_reg;

	   IF v_cur%found THEN
		v_HayDatos:=TRUE;

		HTP.P('<INDICADOR>');
			HTP.P('<NOMBREINDICADOR>'	||v_reg.Indicador	||		'</NOMBREINDICADOR>');
			HTP.P('<IDINDICADOR>'		||Utilidades_PCK.Piece(v_reg.IDIndicador,'|',1)	||		'</IDINDICADOR>');

   		HTP.P('<GRUPO>');
		IF (p_AgruparPor = '-1') THEN
			HTP.P('<NOMBREGRUPO>Total</NOMBREGRUPO>');
			HTP.P('<IDGRUPO>-1</IDGRUPO>');
		ELSE
			HTP.P('<NOMBREGRUPO>'	||SUBSTR(v_reg.Grupo,1,100)	||'</NOMBREGRUPO>');
			HTP.P('<IDGRUPO>'		||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1)	||'</IDGRUPO>');
		END IF;

		v_IndicadorActual	:=v_reg.IDIndicador;	--	Actualiza el indicador
		v_GrupoActual		:=v_reg.IDGrupo;		--	Actualiza el grupo
		UltimoMesInformado	:=0;					--	Para que no inserte una linea vacia con CEROS
		ColumnaActual		:=1;					--	Idem

		v_Grupos:=0;			-- Empieza con el primer grupo

		--	Inicializamos el y año de inicio del cuadro de mando
		v_Mes:=v_MesInicial;
		v_Anno:=v_AnnoInicial;

		UltimoValor:=0;

		WHILE v_cur%found LOOP

			--
			--	Cambio de indicador
			--
			IF ((v_IndicadorActual != v_reg.IDIndicador) OR (v_IndicadorActual IS NULL)) THEN
				--	Comprobamos si hay que cerrar el indicador anterior
				IF v_IndicadorActual IS NOT NULL THEN
					--	Insertamos ceros
	   				--	ET 13/1/2003 FOR I IN UltimoMesInformado+1..12 LOOP
	   				FOR I IN ColumnaActual+1..12 LOOP

						--	Envia el registro
	    				HTP.P('<ROW>');
							HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
							HTP.P('<ANNO>'||v_Anno||'</ANNO>');
							HTP.P('<MES>'||v_Mes||'</MES>');	--I
							IF ((p_MarcarRojo='D') AND (UltimoValor>0)) OR ((p_MarcarRojo='A') AND (UltimoValor<0)) THEN
	    	 					HTP.P('<ROJO/>');
							END IF;
							IF (v_Mes>v_MesActual) AND (v_Anno>=v_AnnoActual) THEN
	    	 					HTP.P('<TOTAL></TOTAL>');
							ELSE
	    	 					v_Texto:='<TOTAL>-</TOTAL>';--'<TOTAL>'||0||'</TOTAL>';
	    	 					HTP.P(v_Texto);
							END IF;
							UltimoValor:=ULTIMAPOSICION;
	    	 			HTP.P('</ROW>');

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;


					END LOOP;
					--	Cerramos el grupo
					HTP.P('</GRUPO>');
					--	Cerramos el indicador
					HTP.P('</INDICADOR>');
				END IF;
				--	Abrimos el nuevo indicador
				HTP.P('<INDICADOR>');
					HTP.P('<NOMBREINDICADOR>'	||v_reg.Indicador	||		'</NOMBREINDICADOR>');
					HTP.P('<IDINDICADOR>'		||Utilidades_PCK.Piece(v_reg.IDIndicador,'|',1)	||		'</IDINDICADOR>');
					HTP.P('<GRUPO>');
					HTP.P('<NOMBREGRUPO>'		||SUBSTR(v_reg.Grupo,1,100)	||'</NOMBREGRUPO>');
					HTP.P('<IDGRUPO>'			||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1)		||'</IDGRUPO>');

				v_IndicadorActual:=v_reg.IDIndicador;	--	Actualiza el indicador
				v_GrupoActual:=v_reg.IDGrupo;			--	Actualiza el grupo: Ya no entrara en el cambio de grupo
				UltimoMesInformado:=0;					--	Evita que se rellene con ceros otra vez
				v_Grupos:=v_Grupos+1;

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;
				UltimoValor:=0;

			END IF;

			--
			--	Cambio de grupo
			--

			IF ((v_GrupoActual != v_reg.IDGrupo)
				OR((v_reg.IDGrupo IS NULL)AND(v_GrupoActual IS NOT NULL))) THEN

				--	Si ya ha empezado algún grupo, rellena con CEROS la fila anterior
				--	cierra el grupo y pone la cabecera del nuevo grupo
				--IF v_Grupos>0 THEN
	   				--	ET 13/1/2003 FOR I IN UltimoMesInformado+1..12 LOOP
	   				FOR I IN ColumnaActual+1..12 LOOP

						--	Envia el registro
	    				HTP.P('<ROW>');
							HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
							HTP.P('<ANNO>'||v_Anno||'</ANNO>');
							HTP.P('<MES>'||v_Mes||'</MES>');--I
							IF ((p_MarcarRojo='D') AND (UltimoValor>0)) THEN
	    	 					HTP.P('<ROJO/>');
							END IF;
							IF (v_Mes>v_MesActual) AND (v_Anno>=v_AnnoActual) THEN
	    	 					HTP.P('<TOTAL></TOTAL>');
							ELSE
	    	 					v_Texto:='<TOTAL>-</TOTAL>';--'<TOTAL>'||0||'</TOTAL>';
	    	 					HTP.P(v_Texto);
							END IF;
							UltimoValor:=ULTIMAPOSICION;
	    	 			HTP.P('</ROW>');

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;

					END LOOP;
					HTP.P('</GRUPO>');
					HTP.P('<GRUPO>');
					HTP.P('<NOMBREGRUPO>'	||SUBSTR(v_reg.Grupo,1,100)	||'</NOMBREGRUPO>');
					HTP.P('<IDGRUPO>'		||Utilidades_PCK.Piece(v_reg.IDGrupo,'|',1)	||'</IDGRUPO>');
				--END IF;
				v_GrupoActual := v_reg.IDGrupo;
				v_Grupos:=v_Grupos+1;
				UltimoMesInformado:=0;

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;
				UltimoValor:=0;
			END IF;


			--
			-- Presenta los resultados segun la estructura (Mes, Total)
			--

			v_Count:=0;	--Fuerza salida del bucle si el algoritmo esta mal

			-- Rellena con el valor 0 los meses no informados desde el ultimo informado hasta el actual
			IF (UltimoMesInformado+1<v_reg.Mes) 	--	Mismo año
				OR ((v_Anno<v_reg.Anno) AND ((v_reg.Mes>1) OR (v_Mes<12)))  --	Año diferente
				OR ((v_reg.Anno=9999) AND (ColumnaActual<13))				--	Pendiente llegar al total de la fila
					THEN


				--	Si no estamos en el primer mes, empezamos a rellenar en el siguiente
				IF ColumnaActual>1 THEN
					v_Mes:=v_Mes+1;
				END IF;

				--	Repite el bucle hasta llegar al mes anterior al del registro
				WHILE ((v_Mes<=v_reg.Mes-1) OR (v_Anno<v_reg.Anno) OR (v_reg.Anno=9999))
						AND (ColumnaActual<13)
						AND v_Count<12 LOOP


					--	Solo depuracion
					--IF (v_reg.Anno IS NULL) THEN
					--	IF ((v_reg.Anno IS NULL) AND (ColumnaActual<13)) THEN
					--		utilidades_pck.debug('Año: '||v_reg.Anno||' Columna:'||ColumnaActual
					--			||' Resultado: TRUE');
					--	ElSE
					--		utilidades_pck.debug('Año: '||v_reg.Anno||' Columna:'||ColumnaActual
					--			||' Resultado: FALSE');
					--	END IF;
					--END IF;


			--	FOR I IN UltimoMesInformado+1..v_reg.Mes-1 LOOP

			--IF UltimoMesInformado+1<v_reg.Mes THEN
	   			--FOR I IN ColumnaAnterior+1..ColumnaActual-1 LOOP


					--	Envia el registro
	    			HTP.P('<ROW>');

						HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
						HTP.P('<ANNO>'||v_Anno||'</ANNO>');
						HTP.P('<MES>'||v_Mes||'</MES>');--I
						IF ((p_MarcarRojo='D') AND (UltimoValor>0)) OR ((p_MarcarRojo='A') AND (UltimoValor<0)) THEN
	    	 				HTP.P('<ROJO/>');
						END IF;
						IF (v_Mes>v_MesActual) AND (v_Anno>=v_AnnoActual) THEN
	    					HTP.P('<TOTAL></TOTAL>');
						ELSE
	    	 				v_Texto:='<TOTAL>-</TOTAL>';--'<TOTAL>'||0||'</TOTAL>';
	    					HTP.P(v_Texto);
						END IF;
						UltimoValor:=ULTIMAPOSICION;
	    			HTP.P('</ROW>');

					--	Incrementa la columna
					ColumnaActual:=ColumnaActual+1;
					v_Mes:=v_Mes+1;

					IF v_Mes>12 THEN
						v_Mes:=v_Mes-12;
						v_Anno:=v_Anno+1;
					END IF;

					v_Count:=v_Count+1; 		--Cuenta el numero de pasos por el bucle, nunca mayor a 12

				END LOOP;
			END IF;


			v_Mes:=v_reg.Mes;

			IF v_Anno<v_reg.Anno THEN
				v_Mes:=v_Mes+12;
			END IF;

			v_Anno:=v_reg.Anno;
			--ColumnaActual:=ColumnaAnterior;

			--	Envia el registro actual
	    	HTP.P('<ROW>');

				--	utilidades_pck.debug('EIS_PCK.EnviarCuadroDeMando_XML.Anno:'||v_reg.Anno ||' Mes:'||v_Mes ||' Valor:'||v_reg.Total);--solodebug

				HTP.P('<COLUMNA>'||ColumnaActual||'</COLUMNA>');
				HTP.P('<ANNO>'||v_reg.Anno||'</ANNO>');
				HTP.P('<MES>'||v_reg.Mes||'</MES>');
				IF ((p_MarcarRojo='D') AND (UltimoValor>TO_NUMBER(v_reg.TotalNumero)))
							OR ((p_MarcarRojo='A') AND (UltimoValor<TO_NUMBER(v_reg.TotalNumero))) THEN
	    	 		HTP.P('<ROJO/>');
				END IF;
				IF (v_reg.Mes>v_MesActual AND v_reg.Mes<13) AND (v_Anno>=v_AnnoActual) AND (v_reg.Total='0,00' OR v_reg.Total='0' OR v_reg.Total='0,00%') THEN
	    			HTP.P('<TOTAL></TOTAL>');
					UltimoValor:=0;
				ELSE
					--	El formato se introduce en la propia select
	    			HTP.P('<TOTAL>'||v_reg.Total||'</TOTAL>');
					UltimoValor:=TO_NUMBER(v_reg.TotalNumero);
				END IF;
	    	HTP.P('</ROW>');

			UltimoMesInformado:=v_reg.Mes;
			ColumnaActual:=ColumnaActual+1;

	     	FETCH v_cur INTO v_reg;

	   	END LOOP;

	END IF;
	CLOSE v_cur;
	IF v_HayDatos=TRUE THEN
		HTP.P('</GRUPO>');
		HTP.P('</INDICADOR>');
	END IF;
	HTP.P('</CUADRODEMANDO>');
EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.EnviarCuadro_Posiciones_XML:'||UltimoValor||'>'||v_reg.Total,'',sqlcode,sqlerrm,null);
END;


/*
	PROCEDURE EnviarCuadroDeMando_SVG

	Envia el cuadro de mando en forma de grafico en formato SVG
	--24feb11	Ya no utilizamos gráficos SVG, sustituidos por APIs de Google
PROCEDURE EnviarCuadroDeMando_SVG
(
	p_IDUSUARIO			VARCHAR2,
	p_SQL				VARCHAR2,
	p_Anno				VARCHAR2,
	p_AgruparPor		VARCHAR2,
	p_IDResultados		VARCHAR2,
	p_TipoGrafico 		VARCHAR2	DEFAULT 'BARRAS2D'
)
IS
	v_SQLLimites		VARCHAR2(1000);	--	Consulta SQL para obtener el minimo y el maximo de los valores a presentar
	TYPE TColores 		IS TABLE OF VARCHAR2(100) INDEX BY BINARY_INTEGER;
	Colores				TColores;
--	TipoGrafico 		VARCHAR2(100)	:= 'BARRAS2D';--'LINEAS2D';
	TipoDatos 			VARCHAR2(100)	:= 'NORMAL';
	PresentarTotales 	VARCHAR2(1)		:= 'S';
	ColocarLeyenda 		VARCHAR2(100)	:= 'LEYENDA_INFERIOR';
	Ancho		 		NUMBER			:= 800;
	Alto		 		NUMBER			:= 600;
	v_Status			VARCHAR2(1000);
	v_Texto				VARCHAR2(3000);
	--	Coordenadas area de trabajo
	rx					INTEGER;
	ry					INTEGER;
	rh					INTEGER;
	rw					INTEGER;
	--	Coordenadas Grafico
	wx					INTEGER;
	wy					INTEGER;
	wh					INTEGER;
	ww					INTEGER;
	--	Coordenadas Leyenda
	lx					INTEGER;
	ly					INTEGER;
	--	Otras variables de control del aspecto
	NumTicsH			INTEGER;		--	Numero de puntos a dibujar en el eje horizontal
	NumTicsV			INTEGER;		--	Numero de puntos a dibujar en el eje vertical
	TicsSepH			INTEGER;			--	Separacion entre los puntos en el eje horizontal
	TicsSepV			INTEGER;			--	Separacion entre los puntos en el eje vertical
	DespLabelsH			INTEGER;
	dMinimo				NUMBER;			--	Valor minimo a representar en el grafico
	dMaximo				NUMBER;			--	Valor maximo a representar en el grafico
	EscalaH				NUMBER;			--	Escala horizontal
	EscalaV				NUMBER;			--	Escala vertical
	Precision			NUMBER;			--	"Salto" entre valores en el eje vertical
	TicSize				INTEGER;		--	Tamaño de las marcas de los puntos en los ejes
	NumChars			INTEGER;		--	Numero de caracteres de las etiquetas en los ejes
	Valor				VARCHAR2(100);	--	Valor numerico convertido en VARCHAR2
	NumSeries			INTEGER;		--	Numero de series en el grafico
	NumIndicadores		INTEGER;		--	Numero de indicadores en el grafico

	--	Para el cursor de resultados
	v_cur 				REF_CURSOR;
	v_reg 				TRegEIS;
	v_MesActual			INTEGER;
	v_MesInicial		INTEGER;
	v_AnnoInicial		INTEGER;
	v_Mes				INTEGER;
	v_Anno				INTEGER;
	v_AnnoActual		INTEGER;
	v_GrupoActual 		VARCHAR2(100);
	v_IndicadorActual	VARCHAR2(100);
	UltimoMesInformado	INTEGER;
	ColumnaActual		INTEGER;

	--	Para dibujar las lineas
	dValor				NUMBER;			--	Valor a presentar
	YValor				INTEGER;		--	Valor a presentar
	dAnterior			NUMBER;			--	Valor anterior. Necesario para el grafico de linea
	YAnterior			INTEGER;		--	Valor anterior. Necesario para el grafico de linea
	j					INTEGER;		--	Contador
	--AltRect				INTEGER;		--	Altura del rectangulo
	AnchoRectangulo		INTEGER;		--	Ancho del rectangulo para el grafico de barras 2D
	TotalGrupos			INTEGER;		--	Numero total de series a dibujar
	AnchoLeyenda		INTEGER;		--	Numero maximo de caracteres en el texto de la leyenda

	Cadena				VARCHAR2(100);
BEGIN
    v_Status:='Inicio Presentación Gráfico';

	v_MesActual:=to_number(to_char(SYSDATE,'mm'));
	v_AnnoActual:=to_number(to_char(SYSDATE,'yyyy'));

	--IF p_Anno<to_char(SYSDATE,'yyyy') THEN
	--	v_MesActual:=99;
	--END IF;

	--	Mes y año correspondientes a la primera columna del grafico
	IF p_Anno=9999 THEN
		v_MesInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'mm'))+1;	--	el mes siguiente al actual, pero del año anterior
		v_AnnoInicial:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;
	ELSE
		v_MesInicial:=1;
		v_AnnoInicial:=p_Anno;
	END IF;


	--	Definicion de colores
	Colores(1):='rgb(255,0,0)';
	Colores(2):='rgb(0,200,0)';			--	Verde, quedaba muy brillante
	Colores(3):='rgb(128,0,128)';			-- Inicialmente azul, pero como el azul intenso se utiliza en los titulos cambiamos... rgb(0,0,255)
	Colores(4):='rgb(0,0,0)';
	Colores(5):='rgb(200,200,0)';		--	Amarillo, quedaba muy brillante
	Colores(6):='rgb(255,0,255)';
	Colores(7):='rgb(0,255,255)';
	Colores(8):='rgb(255,128,0)';
	Colores(9):='rgb(0,128,255)';
	Colores(10):='rgb(100,100,100)';

	Colores(11):='rgb(128,0,255)';
	Colores(12):='rgb(128,0,0)';
	Colores(13):='rgb(0,128,0)';
	Colores(14):='rgb(0,0,128)';
	Colores(15):='rgb(128,128,0)';
	Colores(16):='rgb(0,128,128)';
	Colores(17):='rgb(50,50,128)';
	Colores(18):='rgb(50,128,0)';
	Colores(19):='rgb(128,50,0)';
	Colores(20):='rgb(0,128,50)';

	Colores(21):='rgb(128,50,255)';
	Colores(22):='rgb(50,128,255)';
	Colores(23):='rgb(50,255,128)';
	Colores(24):='rgb(128,255,50)';
	Colores(25):='rgb(255,50,128)';
	Colores(26):='rgb(255,50,50)';
	Colores(27):='rgb(50,255,50)';
	Colores(28):='rgb(255,128,255)';
	Colores(29):='rgb(128,255,255)';
	Colores(30):='rgb(255,255,128)';

	v_Status:='Calculando dimensiones';

	--	Prepara los espaciados y escalados para simplificar el dibujo
	--	r: Zona total de trabajo
	--	w: Zona de gráficos
	rx:=0;
	ry:=600;
	rw:=800;
	rh:=600;
	TicSize:=6;
	NumChars:=10;

	--	Montaje de la zona de trabajo en funcion de la ubicacion de la Leyenda
	--	Funcionan correctamente: LEYENDA_IZQUIERDA, LEYENDA_DERECHA
	--	En pruebas: LEYENDA_INFERIOR
	IF ColocarLeyenda='LEYENDA_DERECHA' THEN
		wx:=rx+60;	wy:=ry-50;	wh:=rh-100;	ww:= rw-300; DespLabelsH:=0; lx:=wx+ww+15; ly:=wy-wh+15; AnchoLeyenda:=50;
	ELSIF ColocarLeyenda='LEYENDA_IZQUIERDA' THEN
		wx:=rx+360;	wy:=ry-50;	wh:=rh-100;	ww:= rw-300; DespLabelsH:=0; lx:=15; ly:=wy-wh+15; AnchoLeyenda:=50;
	ELSIF ColocarLeyenda='LEYENDA_SUPERIOR' THEN
		wx:=rx+60;	wy:=ry-50;	wh:=rh-300;	ww:= rw-50; DespLabelsH:=10; lx:=100; ly:=15; AnchoLeyenda:=100;
	ELSIF ColocarLeyenda='LEYENDA_INFERIOR' THEN
		wx:=rx+60;	wy:=ry-250;	wh:=rh-300;	ww:= rw-50; DespLabelsH:=10; lx:=100; ly:=wy+20; AnchoLeyenda:=100;
	END IF;

	--	Separación de las marcas
	IF p_TipoGrafico='LINEAS2D' THEN
		NumTicsH := 12;
		DespLabelsH := -10;
	ELSIF p_TipoGrafico='BARRAS2D' THEN
		NumTicsH := 13;
		DespLabelsH := DespLabelsH;
	END IF;

	TicsSepH:=FLOOR(ww/NumTicsH);
	ww:=(NumTicsH-1)*TicsSepH;

	--	Una vez hechos los calculos de distancias, en realidad solo queremos 12 meses
	IF p_TipoGrafico='BARRAS2D' THEN
		NumTicsH := 12;
		DespLabelsH := DespLabelsH;
	END IF;

	NumTicsV:=10;

	v_Status:='Buscando en los datos minimos, maximos';

	v_SQLLimites:=		'SELECT 		MIN(TOTALNUMERO), MAX(TOTALNUMERO)'
					||	' FROM ('||p_SQL||')'
					||	' WHERE MES<13 AND	IDGRUPO NOT LIKE ''%99999Total''';		--	El total de la fila no lo presentamos en el grafico

	IF (p_AgruparPor<>'-1') THEN
		v_SQLLimites:=v_SQLLimites	||	' AND	IDGRUPO<>''99999Total''';		--	El total de la fila no lo presentamos en el grafico
	END IF;

	BEGIN
		EXECUTE IMMEDIATE v_SQLLimites	INTO	dMinimo, dMaximo;
	EXCEPTION
		WHEN OTHERS THEN
		utilidades_pck.debug('Casque horrible en limites!');
		dMinimo:=0;dMaximo:=1;
	END;

	v_Status:='Buscando en los datos numero de grupos';
--	IF p_TipoGrafico='BARRAS2D' THEN
		IF (p_AgruparPor='-1') THEN
			TotalGrupos:=1;
		ELSE
			v_SQLLimites:=		'SELECT 	COUNT(DISTINCT IDGRUPO)'	--	EL IDGrupo esta formado por operacion|IDGrupo en la Select
					||	' FROM ('||p_SQL||')'
					||	' WHERE	IDGRUPO NOT LIKE ''%99999Total''';		--	Calcular el numero de grupos

			BEGIN
				EXECUTE IMMEDIATE v_SQLLimites	INTO	TotalGrupos;
				--utilidades_pck.debug('Total grupos='||TotalGrupos||' SQL:'||v_SQLLimites);
			EXCEPTION
				WHEN OTHERS THEN
				utilidades_pck.debug('Casque horrible en grupos!');
				TotalGrupos:=1;
			END;
		END IF;
		IF TotalGrupos>13 THEN
			TotalGrupos:=13;
		END IF;
		IF TotalGrupos=1 THEN
			AnchoRectangulo:=TicsSepH-2;
		ELSE
			AnchoRectangulo:=FLOOR(TicsSepH/TotalGrupos);
		END IF;
		IF ColocarLeyenda='LEYENDA_SUPERIOR' THEN
			wh:=rh-130-15*TotalGrupos;	wy:=ry-50;
		ELSIF ColocarLeyenda='LEYENDA_INFERIOR' THEN
			wh:=rh-130-15*TotalGrupos;	wy:=ry-70-15*TotalGrupos; ly:=wy+25;
		END IF;
--	END IF;



	v_Status:='Calculando escalas';

	IF (dMinimo>=0) THEN
		dMinimo := 0;
	END IF;
	IF (dMinimo=dMaximo) THEN
		dMaximo:=dMinimo+1;
	END IF;
	dMaximo:=CEIL(dMaximo*1.1);
	EscalaV:=(dMaximo - dMinimo)/NumTicsV;

	IF (EscalaV>2) THEN
		Precision:=1;
	ELSIF (EscalaV>1) THEN
		Precision:=10;
	ELSIF (EscalaV>0.1) THEN
		Precision:=100;
    ELSIF (EscalaV>0.001) THEN
		Precision:=10000;
    ELSE
		Precision:=1000000;
        EscalaV := floor(EscalaV*Precision + 1)/Precision;
	END IF;
	dMaximo := EscalaV * NumTicsV;
	TicsSepV:=FLOOR((wh + 1)/(NumTicsV));


		--utilidades_pck.debug('Grafico EIS --- Minimo:'||dMinimo||' Maximo:'||dMaximo||' EscalaV:'||EscalaV);



	HTP.P('<g>');	--	Requerido por el XSQL para que el XML sea correcto

	--	Presenta el fondo, los ejes

	v_Texto:=	SVG_PCK.Rect(rx, ry-rh, rw-1, rh-1,'style="fill:rgb(248,248,248);stroke:rgb(100,100,100);stroke-width:1"')
			||	SVG_PCK.Rect(wx, wy-wh, ww-1, wh-1,'style="fill:rgb(255,255,255);stroke:none;stroke-width:0"')
			||	SVG_PCK.Line(wx, wy, wx+ww-1, wy-1,'style="fill:none;stroke:rgb(50,50,50);stroke-width:1"')
			||	SVG_PCK.Line(wx, wy, wx-1, wy-wh-1,'style="fill:none;stroke:rgb(50,50,50);stroke-width:1"')
			;
	HTP.P(v_Texto);

	--	Presenta puntos y etiquetas del eje horizontal
	HTP.P('<!--Presenta puntos y etiquetas del eje horizontal-->');
	v_Texto:='';
	v_Mes:=v_MesInicial;
	v_Anno:=v_AnnoInicial;
	FOR i IN 0..NumTicsH-1 LOOP
		--	Las marcas de puntos
		IF p_TipoGrafico='LINEAS2D' THEN
			v_Texto:=v_Texto||SVG_PCK.Line(wx+TicsSepH*i,wy,wx+TicsSepH*i,wy+TicSize,'style="fill:none;stroke:rgb(0,0,0);stroke-width:1"');
		ELSIF p_TipoGrafico='BARRAS2D' THEN
			v_Texto:=v_Texto||SVG_PCK.Line(wx+TicsSepH*(i+1),wy,wx+TicsSepH*(i+1),wy+TicSize,'style="fill:none;stroke:rgb(0,0,0);stroke-width:1"');
		END IF;
		--	Las etiquetas
		v_Texto:=v_Texto||SVG_PCK.Text(wx+TicsSepH*i+DespLabelsH, wy + 25, SUBSTR(Utilidades_PCK.NombreMes(v_Mes),1,3)||' '||SUBSTR(v_Anno,3,2),'style="font-size:10;font-family:Verdana;fill:blue"');
		v_Mes:=v_Mes+1;
		IF v_Mes=13 THEN
			v_Anno:=v_Anno+1;
			v_Mes:=1;
		END IF;
	END LOOP;
	HTP.P(v_Texto);

	--	Presenta puntos y etiquetas del eje vertical
	HTP.P('<!--Presenta puntos y etiquetas del eje vertical-->');
	v_Texto:='';
	FOR i IN 0..NumTicsV LOOP
		--	Las marcas de puntos
		IF (i<>0) THEN
			v_Texto:=v_Texto||SVG_PCK.Line(wx-TicSize,wy-TicsSepV*i, wx,wy-TicsSepV*i,'style="fill:none;stroke:rgb(0,0,0);stroke-width:1"');
		END IF;
		--	Las etiquetas
		Valor:=to_char(floor(Precision*(dMinimo+(EscalaV * i)))/Precision);
		NumChars:=length(Valor);
		v_Texto:=v_Texto||SVG_PCK.Text(wx-NumChars*9, wy - TicsSepV*i+5, Valor,'style="font-size:10;font-family:Verdana;fill:blue"');
	END LOOP;
	HTP.P(v_Texto);

	--	Presenta el titulo y la leyenda
	HTP.P('<!--Presenta el titulo y la leyenda-->');
	v_Texto:=SVG_PCK.Text(rh/2-75, 20, 'Medical Virtual Market. Sistema de Información para la Dirección (E.I.S.)',
											'style="font-size:10;font-family:Verdana;fill:blue"');
	HTP.P(v_Texto);

	--	Abrimos el cursor eliminando la fila y columna de totales

    v_Status:='Preparando el cursor';

	v_SQLLimites:=		'SELECT INDICADOR, IDINDICADOR, GRUPO, IDGRUPO, ANNO, MES, TOTAL, TOTALNUMERO'
					||	' FROM ('||p_SQL||')'
					||	' WHERE MES<13';		--	El total de la fila no lo presentamos en el grafico

	IF (p_AgruparPor<>'-1') THEN
		v_SQLLimites:=v_SQLLimites	||	' AND	IDGRUPO NOT LIKE ''%99999Total''';		--	El total de la fila no lo presentamos en el grafico
	END IF;


	--utilidades_pck.debug('Grafico SQL:'||v_SQLLimites);


	OPEN v_cur FOR v_SQLLimites;

	FETCH v_cur INTO v_reg;

	IF v_cur%found THEN

	    v_Status:='Dentro del cursor';

		--	Inicializa indicador
		v_IndicadorActual	:=v_reg.IDIndicador;	-- Actualiza el indicador
		v_GrupoActual		:=v_reg.IDGrupo;		-- Actualiza el grupo
		--v_Texto:=	SVG_PCK.Text(wx+ww+15, wy-wh+15, UPPER(SUBSTR(v_reg.Indicador,1,50)),'font-size="9" font-family="Verdana" fill="blue"')	--	Presenta leyenda
		--		||	SVG_PCK.Text(wx+ww+15, wy-wh+30, LOWER(SUBSTR(v_reg.Grupo,1,50)),'style="font-size:10;font-family:Verdana;fill:'||Colores(1)||'"');--	Presenta leyenda
		v_Texto:=	SVG_PCK.Text(lx, ly+15, UPPER(SUBSTR(v_reg.Indicador,1,AnchoLeyenda)),'font-size="9" font-family="Verdana" fill="blue"')	--	Presenta leyenda
				||	SVG_PCK.Text(lx, ly+30, LOWER(SUBSTR(v_reg.Grupo,1,AnchoLeyenda)),'style="font-size:10;font-family:Verdana;fill:'||Colores(1)||'"');--	Presenta leyenda
		HTP.P(v_Texto);

		NumSeries:=1;
		NumIndicadores:=1;

		UltimoMesInformado	:=0;					-- Para que no inserte una linea vacia con CEROS


		--	Inicializamos el y año de inicio del cuadro de mando
		v_Mes:=v_MesInicial;
		v_Anno:=v_AnnoInicial;
		ColumnaActual:=1;

		WHILE v_cur%found AND NumSeries<=TotalGrupos LOOP

		    v_Status:='Indicador='||v_IndicadorActual||' Grupo='||v_GrupoActual||' NumSeries='||NumSeries;

			--
			--	Cambio de indicador
			--
			IF ((v_IndicadorActual != v_reg.IDIndicador) OR (v_IndicadorActual IS NULL)) THEN
				--	Comprobamos si hay que cerrar el indicador anterior
				IF v_IndicadorActual IS NOT NULL THEN

					--	Insertamos ceros al final del grafico de lineas hasta llegar al mes actual o a la columna 12
					IF p_TipoGrafico='LINEAS2D' THEN
	   				--	ET 13/1/2003 FOR j IN UltimoMesInformado..v_MesActual-1 LOOP
	   				WHILE (ColumnaActual<=12) AND ((v_Mes<=v_MesActual) OR (v_Anno<v_AnnoActual)) LOOP
						-- Señala el punto
						YValor:=0;
						v_Texto:=SVG_PCK.Rect(wx + TicsSepH*(ColumnaActual-1) -2,  wy - YValor-2,
							5,5, 'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						--	Dibuja la linea si ya no estamos en el primer punto
						IF (ColumnaActual>1) THEN
							IF YAnterior IS NULL THEN
								YAnterior:=0;
							END IF;
							v_Texto:=v_Texto||SVG_PCK.Line((wx+TicsSepH*(ColumnaActual-2)),
										wy - YAnterior,
										wx + TicsSepH*(ColumnaActual-1),
										wy - YValor,
										'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						END IF;
						HTP.P(v_Texto);
						dAnterior := dValor;
						YAnterior := YValor;

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;

					END LOOP;
					dAnterior:=0;
					YAnterior:=0;
					END IF;
				END IF;
				--	Abrimos el nuevo indicador
				NumSeries:=NumSeries+1;
				NumIndicadores:=NumIndicadores+1;
				v_Texto:=	SVG_PCK.Text(lx, ly-15+(NumSeries+NumIndicadores)*15, UPPER(SUBSTR(v_reg.Indicador,1,AnchoLeyenda)),'font-size="9" font-family="Verdana" fill="blue"')	--	Presenta leyenda
						||	SVG_PCK.Text(lx, ly+(NumSeries+NumIndicadores)*15, LOWER(SUBSTR(v_reg.Grupo,1,AnchoLeyenda)),'style="font-size:10;font-family:Verdana;fill:'||Colores(NumSeries)||'"');--	Presenta leyenda
				HTP.P(v_Texto);

				v_IndicadorActual:=v_reg.IDIndicador;	--	Actualiza el indicador
				v_GrupoActual:=v_reg.IDGrupo;			--	Actualiza el grupo: Ya no entrara en el cambio de grupo
				UltimoMesInformado:=0;					--	Evita que se rellene con ceros otra vez

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;

			END IF;

			--
			--	Cambio de grupo
			--

			IF ((v_GrupoActual != v_reg.IDGrupo)
				OR((v_reg.IDGrupo IS NULL)AND(v_GrupoActual IS NOT NULL))) THEN

				--	Si ya ha empezado algún grupo, rellena con CEROS la fila anterior
				--	cierra el grupo y pone la cabecera del nuevo grupo
				IF p_TipoGrafico='LINEAS2D' THEN
	   				--	ET 13/1/2003 FOR j IN UltimoMesInformado+1..v_MesActual-1 LOOP
	   				WHILE (ColumnaActual<=12) AND ((v_Mes<=v_MesActual) OR (v_Anno<v_AnnoActual)) LOOP
						-- Señala el punto
						YValor:=0;
						v_Texto:=SVG_PCK.Rect(wx + TicsSepH*(ColumnaActual-1) -2,  wy - YValor-2,
							5,5, 'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						--	Dibuja la linea si ya no estamos en el primer punto
						IF (ColumnaActual>1) THEN
							IF YAnterior IS NULL THEN
								YAnterior:=0;
							END IF;
							v_Texto:=v_Texto||SVG_PCK.Line((wx+TicsSepH*(ColumnaActual-2)),
										wy - YAnterior,
										wx + TicsSepH*(ColumnaActual-1),
										wy - YValor,
										'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						END IF;
						HTP.P(v_Texto);
						dAnterior := dValor;
						YAnterior := YValor;

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;

					END LOOP;
					dAnterior:=0;
					YAnterior:=0;
				END IF;
				NumSeries:=NumSeries+1;
				v_Texto:=SVG_PCK.Text(lx, ly+(NumSeries+NumIndicadores)*15, LOWER(SUBSTR(v_reg.Grupo,1,AnchoLeyenda)),'style="font-size:10;font-family:Verdana;fill:'||Colores(NumSeries)||'"');--	Presenta leyenda
				HTP.P(v_Texto);
				v_GrupoActual := v_reg.IDGrupo;
				UltimoMesInformado:=0;

				--	Vuelve a la columna inicial
				ColumnaActual		:=1;
				v_Mes:=v_MesInicial;
				v_Anno:=v_AnnoInicial;

			END IF;

			--
			-- Presenta los resultados segun la estructura (Mes, Total)
			--

			-- Rellena con el valor 0 los meses no informados desde el ultimo informado hasta el actual
			IF UltimoMesInformado<v_reg.Mes+1 THEN

				--	ET 13/1/2003 FOR j IN UltimoMesInformado+1..v_reg.Mes-2 LOOP

				WHILE (ColumnaActual<12) AND ((v_Mes<v_reg.Mes) OR (v_Anno<v_reg.Anno)) LOOP

					--	En el caso de lineas, dibuja las lineas hasta el punto actual
					IF p_TipoGrafico='LINEAS2D' THEN

						-- Señala el punto
						YValor:=0;
						v_Texto:=SVG_PCK.Rect(wx + TicsSepH*(ColumnaActual-1) -2,  wy - YValor-2,
							5,5, 'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						--	Dibuja la linea si ya no estamos en el primer punto
						IF (ColumnaActual>1) THEN
							IF YAnterior IS NULL THEN
								YAnterior:=0;
							END IF;
							v_Texto:=v_Texto||SVG_PCK.Line((wx+TicsSepH*(ColumnaActual-2)),
									wy - YAnterior,
									wx + TicsSepH*(ColumnaActual-1),
									wy - YValor,
									'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						END IF;
						HTP.P(v_Texto);
						dAnterior := dValor;
						YAnterior := YValor;

					END IF;

					--	Incrementa la columna
					ColumnaActual:=ColumnaActual+1;
					v_Mes:=v_Mes+1;

					IF v_Mes>12 THEN
						v_Mes:=v_Mes-12;
						v_Anno:=v_Anno+1;
					END IF;

				END LOOP;
			END IF;
			--	Envia el registro actual (no se envia el total: columna 13)
			dValor:=v_reg.TotalNumero;
			j:=v_reg.Mes-1;

			--	Solo para depuracion: presentamos el valor junto al punto
			-- Depuración:
			--Cadena:=ColumnaActual||':'||v_reg.Mes||'/'||v_reg.Anno||'='||FLOOR(dValor);


			--	Si no hemos pasado el maximo de series presenta el punto
			IF NumSeries<=TotalGrupos THEN
				IF p_TipoGrafico='LINEAS2D' THEN
					-- Señala el punto
					YValor:=FLOOR(wh*((dValor - dMinimo)/(dMaximo - dMinimo)));
					v_Texto:=SVG_PCK.Rect(wx + TicsSepH*(ColumnaActual-1) -2,  wy - YValor-2,
						5,5, 'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');

					--	Depuracion - Presentamos el valor junto al punto
					--v_Texto:=v_Texto||SVG_PCK.Text(wx + TicsSepH*(ColumnaActual-1) -2 +10,  wy - YValor-2,
					--		Cadena,'style="font-size:10;font-family:Verdana;fill:'||Colores(NumSeries)||'"');


					--	Dibuja la linea si ya no estamos en el primer punto
					IF (ColumnaActual>1) THEN
						IF YAnterior IS NULL THEN
							YAnterior:=0;
						END IF;
						v_Texto:=v_Texto||SVG_PCK.Line((wx+TicsSepH*(ColumnaActual-2)),
										wy - YAnterior,
										wx + TicsSepH*(ColumnaActual-1),
										wy - YValor,
										'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
					END IF;
					HTP.P(v_Texto);
					dAnterior := dValor;
					YAnterior := YValor;
				ELSIF p_TipoGrafico='BARRAS2D' THEN

					YValor:=FLOOR(wh*((dValor - dMinimo)/(dMaximo - dMinimo)));
					v_Texto:=SVG_PCK.Rect(wx + TicsSepH*(ColumnaActual-1) +AnchoRectangulo*(NumSeries-1),  wy-YValor,
						AnchoRectangulo,YValor, 'style="fill:'||Colores(NumSeries)||';stroke:none"');

					--	Depuracion - Presentamos el valor junto al punto
					--v_Texto:=v_Texto||SVG_PCK.Text(wx + TicsSepH*(ColumnaActual-1)+AnchoRectangulo*(NumSeries-1)+10,  wy - YValor-10,
					--	Cadena,'style="font-size:10;font-family:Verdana;fill:'||Colores(NumSeries)||'"');

					HTP.P(v_Texto);

				END IF;

				--	Incrementa la columna
				ColumnaActual:=ColumnaActual+1;
				v_Mes:=v_Mes+1;

				IF v_Mes>12 THEN
					v_Mes:=v_Mes-12;
					v_Anno:=v_Anno+1;
				END IF;
			END IF;
			--utilidades_pck.debug('Grafico EIS --- Minimo:'||dMinimo||' Maximo:'||dMaximo||' EscalaV:'||EscalaV
			--	||' NumSeries:'||NumSeries||' Valor Actual:'||dValor||' Posicion:'
			--||to_char(wx + TicsSepH*(j-1) +AnchoRectangulo*NumSeries)||' Altura:'||YValor);



			UltimoMesInformado:=v_reg.Mes-1;

    		v_Status:='Preparando FETCH del cursor';
	     	FETCH v_cur INTO v_reg;

		END LOOP;

		--	Para el ultimo grupo tambien hay que acabar la linea
				IF p_TipoGrafico='LINEAS2D' THEN
					WHILE (ColumnaActual<12) AND ((v_Mes<v_reg.Mes) OR (v_Anno<v_reg.Anno)) LOOP
						-- Señala el punto
						YValor:=0;
						v_Texto:=SVG_PCK.Rect(wx + TicsSepH*j -2,  wy - YValor-2,
							5,5, 'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						--	Dibuja la linea si ya no estamos en el primer punto
						IF (j<>0) THEN
							IF YAnterior IS NULL THEN
								YAnterior:=0;
							END IF;
							v_Texto:=v_Texto||SVG_PCK.Line((wx+TicsSepH*(j-1)),
										wy - YAnterior,
										wx + TicsSepH*j,
										wy - YValor,
										'style="fill:none;stroke:'||Colores(NumSeries)||';stroke-width:1"');
						END IF;
						HTP.P(v_Texto);
						dAnterior := dValor;
						YAnterior := YValor;

						--	Incrementa la columna
						ColumnaActual:=ColumnaActual+1;
						v_Mes:=v_Mes+1;

						IF v_Mes>12 THEN
							v_Mes:=v_Mes-12;
							v_Anno:=v_Anno+1;
						END IF;
					END LOOP;
				END IF;

		--	Presenta un aviso si se han suprimido series
		IF NumSeries>TotalGrupos THEN
			v_Texto:=SVG_PCK.Text(	lx+300,
									ry-20,
									'* Únicamente se presentan las primeras '||to_char(TotalGrupos+1)||' series *',
									'style="font-size:10;font-family:Verdana;fill:red"');--	Presenta aviso
			HTP.P(v_Texto);
		END IF;


	END IF;

    v_Status:='Cerrando el cursor';

	CLOSE v_cur;

	HTP.P('</g>');	--	Requerido por el XSQL para que el XML sea correcto


EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.EnviarCuadroDeMando_SVG',v_Status||' SQL: SELECT INDICADOR, IDINDICADOR, GRUPO, IDGRUPO, MES, TOTAL, TOTALNUMERO FROM ('
											||p_SQL||	') WHERE IDGRUPO<>''99999Total'' AND MES<13. SQLERRM:'||sqlerrm);
END;
*/

/*
	PROCEDURE ListaResultados

	Devuelve la lista de resultados correspondientes a una consulta concreta del EIS

	p_ANNO: Año actual. 9999 para los ultimos 12 meses

	18/6/2003 ET	El listado no estaba funcionando correctamente al seleccionar el total horizontal cuando
					se estaban consultando los ultimos 12 meses. Corregimos pasando el '99':
					Problema: Tambien para el total del 2003 se presentaran los ultimos 12 meses en lugar de los
					meses transcurridos del año.
					
	20jul09	ET		Con el usuario admin, si se está filtrando por empresa pero se selecciona un total se pierde este filtrado.
					Se produce el mismo problema si el filtro y la agregacion coinciden y se pulsa sobre el total.

	24ago10	ET		Para la nueva versión del EIS, permitimos seleccion de grupos al llamar a "Lista de resultados"
	30ago10	ET		Enlace al dominio según donde haya hecho "login" el usuario
	29nov11	ET		Multipais
*/
PROCEDURE ListaResultados
(
	p_IDUSUARIO				VARCHAR2,
	p_IDIndicador			VARCHAR2,
	p_ANNO 					VARCHAR2,
	p_MES 					VARCHAR2,
	p_IDEmpresa				VARCHAR2,
	p_IDCENTRO 				VARCHAR2,
	p_IDUSUARIOSEL			VARCHAR2,
	p_IDEmpresa2			VARCHAR2,
	p_IDCENTRO2				VARCHAR2,	--16abr13
	p_IDPRODUCTOESTANDAR	VARCHAR2,
	p_IDGRUPOCAT			VARCHAR2,	--16abr13	-> Grupo catálogo, no confundir con grupo seleccionado
	p_IDSUBFAMILIA			VARCHAR2,	--16abr13
	p_IDFAMILIA				VARCHAR2,	--16abr13
	p_IDCATEGORIA			VARCHAR2,	--16abr13
	--16abr13	p_IDNOMENCLATOR			VARCHAR2,
	--16abr13	p_URGENCIA				VARCHAR2,
	p_IDESTADO				VARCHAR2,
	--16abr13	p_IDTIPOINCIDENCIA		VARCHAR2,
	--16abr13	p_IDGRAVEDAD			VARCHAR2,
	p_REFERENCIA			VARCHAR2,
	p_CODIGO				VARCHAR2,
	p_AgruparPor			VARCHAR2,
	p_IDSeleccionActual		VARCHAR2
)
IS
	--	Indicadores del cuadro de mando
	CURSOR	cIndicadores(IDIndicador IN VARCHAR2) IS
		SELECT	EIS_CB_CONSULTA, EIS_CB_ENLACE, EIS_CB_TIPO,
				EIS_IN_ID, EIS_IN_NOMBRE, EIS_IN_NOMBRECORTO, EIS_IN_MANUAL, EIS_IN_ACUMULACION,
				EIS_IN_RESTRICCIONES, EIS_IN_ACTUALIZACION, EIS_IN_F_EMPRESA, EIS_IN_F_CENTRO,
				EIS_IN_F_USUARIO, EIS_IN_F_EMPRESA2, EIS_IN_F_PRODUCTO,
				EIS_IN_F_NOMENCLATOR, EIS_IN_F_URGENCIAS, EIS_IN_NOMBREEMPRESA2	, 
				EIS_IN_NOMBREEMPRESA2_BR,		--	8jun12	Conntraparte en portugués
				EIS_IN_F_GRAVEDAD,EIS_IN_F_TIPOINCIDENCIAS
		FROM	EIS_INDICADORES, EIS_CONSULTABASE
		WHERE	EIS_IN_IDCONSULTABASE=EIS_CB_ID
		AND		EIS_IN_ID	=IDIndicador;


	TYPE TRegListado IS RECORD
	(
		ID	 			VARCHAR2(100),
		Fecha 			DATE,
		Total 			NUMBER,
		IDEmpresa		NUMBER,
		Empresa			VARCHAR2(300),
		IDCentro		NUMBER,
		Centro			VARCHAR2(300),
		IDEmpresa2		NUMBER,
		Empresa2		VARCHAR2(300),
		IDUsuario		NUMBER,
		Usuario			VARCHAR2(300),
		IDEstado		VARCHAR2(100),
		Estado			VARCHAR2(300),
--		Referencia		VARCHAR2(300),
		Codigo			VARCHAR2(100),
		MES				NUMBER,
		ANYO			NUMBER
	);


	--	Cursor con los centros autorizados para el usuario
	CURSOR	cCentroYEmpresa(p_USUARIO NUMBER)  IS
		SELECT		CEN_ID, CEN_IDEMPRESA, CEN_NOMBRE, EMP_IDPAIS IDPAIS, US_IDIDIOMA IDIDIOMA, US_USUARIO
			FROM	EMPRESAS, CENTROS, USUARIOS
			WHERE	CEN_ID=US_IDCENTRO
				AND	CEN_IDEMPRESA=EMP_ID
				AND	US_ID=p_IDUSUARIO
				AND	CEN_STATUS IS NULL;

	--vCount				INTEGER;
	vFiltroSQL			VARCHAR2(3000);
	vFiltroInternoSQL	VARCHAR2(3000);
	FEmpresa			VARCHAR2(1);
	FCentro				VARCHAR2(1);
	FUsuario			VARCHAR2(1);
	FEmpresa2			VARCHAR2(1);
	FProducto			VARCHAR2(1);
	FNomenclator		VARCHAR2(1);
	FUrgencias			VARCHAR2(1);
	vNombreEmpresa2		VARCHAR2(100);
	v_DerechosUsuario	VARCHAR2(100);		--	Derechos del usuario
	v_SQL 				VARCHAR2(3000);
	v_Texto				VARCHAR2(3000);
	v_IDAgrupacion		VARCHAR2(100);
	IDEMPRESA			VARCHAR2(100);
	IDCENTRO 			VARCHAR2(100);
	IDUSUARIOSEL		VARCHAR2(100);
	IDEMPRESA2			VARCHAR2(100);
	IDCENTRO2 			VARCHAR2(100);
	IDPRODUCTOESTANDAR	VARCHAR2(100);	--2may13
	--2may13	IDPRODUCTO			VARCHAR2(100);
	IDFAMILIA			VARCHAR2(100);
	IDCATEGORIA			VARCHAR2(100);	--	16abr13
	IDSUBFAMILIA		VARCHAR2(100);	--	16abr13
	IDGRUPO				VARCHAR2(100);	--	16abr13
	IDNOMENCLATOR		VARCHAR2(100);
	IDESTADO			VARCHAR2(100);
	IDTIPOINCIDENCIA	VARCHAR2(100);
	IDGRAVEDAD			VARCHAR2(100);
	REFERENCIA			VARCHAR2(100);
	v_REFERENCIA		VARCHAR2(100);
	URGENCIA			VARCHAR2(100);
	Total				NUMBER(14,4);
	Enlace				VARCHAR2(1000);
	DirEntorno			VARCHAR2(100);
	v_Agregar			VARCHAR2(100);

	v_Status			VARCHAR2(1000);
	vAnnoInicio			INTEGER;
	vMesInicio			INTEGER;
	v_Count				INTEGER	:=0;			--	Contador de registros devueltos

	v_IDSeleccionActual			VARCHAR2(1000);
	v_VariosGrupos		VARCHAR2(1):='N';		--	24ago10	Comprueba si se pasan varios ID de grupo separados por '|'
	--	Cursor y Registro con el resultado de la consulta
	v_cur 				REF_CURSOR;
	v_reg 				TRegListado;
	
	v_IDIDioma			USUARIOS.US_IDIDIOMA%TYPE;

	v_CentroDelUsuario		CENTROS.CEN_NOMBRE%TYPE;		--	24oct13 Nombre de la empresa del usuario para el título de la ventana
	v_Usuario				USUARIOS.US_USUARIO%TYPE;		--	24oct13 Usuario para el título de la ventana
	
	v_Seleccion			VARCHAR2(1000);			--	25jun14	Para poder trabajar con selecciones

	--	17ene13	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion	VARCHAR2(100);

BEGIN

	v_Status:='Entrando en Lista resultados para el indicador: '||p_IDIndicador||' del usuario:'||p_IDUSUARIO
			||' Agrupar por:'||p_AgruparPor||' IDGRUPO:'||p_IDSeleccionActual
			||' IDEmpresa:'||p_IDEmpresa
			||' IDCATEGORIA:'||p_IDCATEGORIA
			||' IDFAMILIA:'||p_IDFAMILIA
			||' IDSUBFAMILIA:'||p_IDSUBFAMILIA
			||' IDGRUPOCAT:'||p_IDGRUPOCAT
			||' IDPRODUCTOESTANDAR:'||p_IDPRODUCTOESTANDAR
			;
	
	--Utilidades_pck.debug(v_Status);--solodebug
	
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'ListaResultados','','EIS Cons');

	DirEntorno:=Seguridad_PCK.Dominio(p_IDUsuario);--30ago10
	--DirEntorno:=Utilidades_PCK.DireccionHost;

	--
	--	Crea el filtro SQL en base a las condiciones de la seleccion del usuario
	--
	v_DerechosUsuario:=USUARIOS_PCK.DerechosUsuarioEIS(p_IDUSUARIO);

	v_Status:='Creando filtro';

	vFiltroSQL:='';--' AND TO_CHAR(FECHA,''YYYY'')='||p_Anno;

	--	Restriccion en funcion del tipo de usuario
	FOR CentroYEmpresa IN cCentroYEmpresa(p_IDUSUARIO) LOOP	--Solo una vez
	
		IF v_DerechosUsuario='MVM' OR v_DerechosUsuario='MVMB'	THEN
			null;
		ELSIF v_DerechosUsuario='EMPRESA'	THEN
			vFiltroSQL:=vFiltroSQL||' AND IDEMPRESA='||CentroYEmpresa.CEN_IDEMPRESA;
		ELSIF  v_DerechosUsuario='MULTICENTROS'	THEN
			vFiltroSQL:=vFiltroSQL||' AND IDCENTRO IN (SELECT UCA_IDCENTRO FROM USUARIOS_CENTROSAUTORIZADOS WHERE UCA_IDUSUARIO='||p_IDUSUARIO||' AND UCA_AUTORIZADO=''S'')';
		ELSIF  v_DerechosUsuario='CENTRO'	THEN
			vFiltroSQL:=vFiltroSQL||' AND IDCENTRO='||CentroYEmpresa.CEN_ID;
		ELSE	--NORMAL
			vFiltroSQL:=vFiltroSQL||' AND IDUSUARIO='||p_IDUSUARIO;
		END IF;
		vFiltroSQL:=vFiltroSQL||' AND IDPAIS='||CentroYEmpresa.IDPAIS;
		
		v_CentroDelUsuario	:=CentroYEmpresa.CEN_NOMBRE;
		v_Usuario			:=CentroYEmpresa.US_USUARIO;
		v_IDIDioma			:=CentroYEmpresa.IDIDIOMA;
		
	END LOOP;

	v_Status:='Asignando parametros';

	--	Asignamos los parametros a variables para poder modificarlos
	IDEMPRESA		:=p_IDEmpresa;
	IDCENTRO 		:=p_IDCENTRO;
	IDUSUARIOSEL	:=p_IDUSUARIOSEL;
	IDEMPRESA2		:=p_IDEmpresa2;
	IDCENTRO2 		:=p_IDCENTRO2;
	IDPRODUCTOESTANDAR		:=p_IDPRODUCTOESTANDAR;
--	IDPRODUCTO		:=p_IDPRODUCTO;
	IDFAMILIA		:=p_IDFAMILIA;
	--16abr13	IDNOMENCLATOR	:=p_IDNOMENCLATOR;
	--16abr13	URGENCIA		:=p_URGENCIA;
	REFERENCIA		:=p_REFERENCIA;
	IDESTADO		:=p_IDESTADO;
	--16abr13	IDTIPOINCIDENCIA:=p_IDTIPOINCIDENCIA;
	--16abr13	IDGRAVEDAD		:=p_IDGRAVEDAD;
	IDCATEGORIA		:=p_IDCATEGORIA;
	IDSUBFAMILIA	:=p_IDSUBFAMILIA;
	IDGRUPO			:=p_IDGRUPOCAT;

	v_Status:='Creando filtro: Comprobando agrupacion';

	--	24ago10	Si hay varios grupos seleccionados, utiliza "IN ( , , , )" en lugar de " = "
	IF INSTR(p_IDSeleccionActual,'|')>0 THEN
		v_IDSeleccionActual:='('|| REPLACE(SUBSTR(p_IDSeleccionActual, 1, LENGTH(p_IDSeleccionActual)-1),'|',',')||')';
		v_VariosGrupos:='S';
	ELSE
		v_IDSeleccionActual:=p_IDSeleccionActual;
	END IF;

	--
	--	FILTRO basado en la agrupación
	--	
	IF p_AgruparPor='EMP' THEN
		v_IDAgrupacion:='IDEMPRESA';
		--	20jul09	ET	Si se filtra por empresa pero se selecciona el total, se pierde esta restricción
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDEMPRESA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='CEN' THEN
		v_IDAgrupacion:='IDCENTRO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDCENTRO:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='USU' THEN
		v_IDAgrupacion:='IDUSUARIO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDUSUARIOSEL:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='EMP2' THEN
		v_IDAgrupacion:='IDEMPRESA2';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDEMPRESA2:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='CEN2' THEN
		v_IDAgrupacion:='IDCENTRO2';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDCENTRO2:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='PRO' THEN
		v_IDAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_PRODUCTO),1,80)';	--'EIS_VA_REFPRODUCTO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			REFERENCIA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='REF' THEN
		--v_IDAgrupacion:='REFERENCIA';15abr11		
		v_IDAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_PRODUCTO),1,80)';	--'EIS_VA_REFPRODUCTO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			REFERENCIA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='DES' THEN		--ET	3oct08
		--v_IDAgrupacion:='REFERENCIA';15abr11		
		v_IDAgrupacion:='SUBSTR(EIS_VA_REFPRODUCTO,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(EIS_VA_PRODUCTO),1,80)';	--'EIS_VA_REFPRODUCTO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			REFERENCIA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='REFPROV' THEN		--ET	3oct08
		--v_IDAgrupacion:='REFERENCIA';15abr11		
		v_IDAgrupacion:='SUBSTR(lmo_refproveedor,1,20)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(NombreProducto),1,80)';	--'EIS_VA_REFPRODUCTO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			REFERENCIA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='FAM' THEN
		v_IDAgrupacion:='IDFAMILIA';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDFAMILIA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='EST' THEN
		v_IDAgrupacion:='IDESTADO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDESTADO:=v_IDSeleccionActual;
		END IF;
	/*	12abr13	ELSIF p_AgruparPor='TIP' THEN
		v_IDAgrupacion:='IDTIPOINCIDENCIA';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDTIPOINCIDENCIA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='GRA' THEN
		v_IDAgrupacion:='IDGRAVEDADINCIDENCIA';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDGRAVEDAD:=v_IDSeleccionActual;
		END IF;*/
	--	16abr13	Nuevos niveles cat.priv.
	ELSIF p_AgruparPor='GRU' THEN
		v_IDAgrupacion:='IDGRUPO';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDGRUPO:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='SF' THEN
		v_IDAgrupacion:='IDSUBFAMILIA';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDSUBFAMILIA:=v_IDSeleccionActual;
		END IF;
	ELSIF p_AgruparPor='CAT' THEN
		v_IDAgrupacion:='IDCATEGORIA';
		IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
			IDCATEGORIA:=v_IDSeleccionActual;
		END IF;
	END IF;

	--
	--	FILTROS	basados en las restricciones anteriores
	--	
	v_Status:='Creando filtro: Asignando condiciones->Centro['||IDEMPRESA||']';
	IF IDEMPRESA IS NOT NULL AND IDEMPRESA<>'-1' AND IDEMPRESA<>'99999Total' THEN

		IF SUBSTR(IDEMPRESA,1,4)='SEL_' THEN	--	25jun14 Selecciones personalizadas
			v_Seleccion:=EISSelecciones_PCK.RestriccionSeleccion(SUBSTR(IDEMPRESA,5,20));
			vFiltroSQL:=vFiltroSQL||' AND IDEMPRESA'||v_Seleccion;
		ELSE
			IF p_AgruparPor='EMP' AND v_VariosGrupos='S' THEN
				vFiltroSQL	:=vFiltroSQL||' AND IDEMPRESA IN '||IDEMPRESA;
			ELSE
				vFiltroSQL	:=vFiltroSQL||' AND IDEMPRESA='||IDEMPRESA;
			END IF;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Centro['||IDCENTRO||']';
	IF	IDCENTRO IS NOT NULL AND IDCENTRO<>'-1' AND IDCENTRO<>'99999Total' THEN
		IF p_AgruparPor='CEN' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDCENTRO IN '||IDCENTRO;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDCENTRO='||IDCENTRO;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Usuario Sel';
	IF	IDUSUARIOSEL IS NOT NULL AND IDUSUARIOSEL<>'-1' AND IDUSUARIOSEL<>'99999Total' THEN
		IF p_AgruparPor='USU' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDUSUARIO IN '||IDUSUARIOSEL;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDUSUARIO='||IDUSUARIOSEL;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Empresa';
	IF	IDEMPRESA2 IS NOT NULL AND IDEMPRESA2<>'-1' AND IDEMPRESA2<>'99999Total' THEN
		IF p_AgruparPor='EMP2' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDEMPRESA2 IN '||IDEMPRESA2;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDEMPRESA2='||IDEMPRESA2;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Centro['||IDCENTRO||']';
	IF	IDCENTRO2 IS NOT NULL AND IDCENTRO2<>'-1' AND IDCENTRO2<>'99999Total' THEN
		IF p_AgruparPor='CEN2' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDCENTRO2 IN '||IDCENTRO2;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDCENTRO2='||IDCENTRO2;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Familia';
	IF	IDFAMILIA IS NOT NULL AND IDFAMILIA<>'-1' AND IDFAMILIA<>'99999Total' THEN
		/*IF p_AgruparPor='FAM' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDFAMILIA IN '||IDFAMILIA;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDFAMILIA='||IDFAMILIA;
		END IF;
			4abr	Volvemos a trabajar con el IDFAMILIA
		IF p_AgruparPor='FAM' AND v_VariosGrupos='S' THEN
			vFiltroSQL:=vFiltroSQL||' AND SUBSTR(Referencia,1,2)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarString(FAMILIA),1,80) IN '||IDFAMILIA;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND SUBSTR(Referencia,1,2)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarString(FAMILIA),1,80)='''||IDFAMILIA||'''';
		END IF;*/
		--	8may12	Separamos los primeros digitos de la ref. estándar y el nombre normalizado
		IF IDFAMILIA IS NOT NULL AND IDFAMILIA<>'-1' THEN
			IF	(p_IDEmpresa IS NOT NULL OR p_IDEmpresa<>-1) OR ((v_DerechosUsuario<>'MVM') AND (v_DerechosUsuario<>'MVMB')) THEN
				IF IDFAMILIA='-2' THEN
					vFiltroSQL:=vFiltroSQL||' AND SUBSTR(Referencia,1,2)<>''30''';
				ELSE
					vFiltroSQL:=vFiltroSQL||' AND IDFAMILIA='||IDFAMILIA;	--	3may12
				END IF;
			ELSE

				vFiltroSQL:=vFiltroSQL	||' AND SUBSTR(Referencia,1,2)='''||utilidades_pck.Piece(IDFAMILIA,':',0)||'''';

				IF utilidades_pck.Piece(IDFAMILIA,':',1) IS NOT NULL THEN	--	en algunos casos no se guardan las 2 partes de la descripción de familia
					vFiltroSQL:=vFiltroSQL||' AND SUBSTR(NORMALIZAR_PCK.NormalizarID(FAMILIA),1,80)='''||TRIM(utilidades_pck.Piece(IDFAMILIA,':',1))||'''';
				END IF;
			END IF;
		END IF;
	END IF;

	/*	2may13
	v_Status:='Creando filtro: Asignando condiciones->Producto';
	IF	IDPRODUCTO IS NOT NULL AND IDPRODUCTO<>'-1' AND IDPRODUCTO<>'99999Total' THEN
		IF p_AgruparPor='PRO' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDPRODUCTO IN '||IDPRODUCTO;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDPRODUCTO='||IDPRODUCTO;
		END IF;
	END IF;	*/

	--	2may13	El filtro es a nivel de producto estándar
	v_Status:='Creando filtro: Asignando condiciones->Producto';
	IF	IDPRODUCTOESTANDAR IS NOT NULL AND IDPRODUCTOESTANDAR<>'-1' AND IDPRODUCTOESTANDAR<>'99999Total' THEN
		IF p_AgruparPor='PRO' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDPRODUCTOESTANDAR IN '||IDPRODUCTOESTANDAR;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDPRODUCTOESTANDAR='||IDPRODUCTOESTANDAR;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Grupo';
	IF	IDGRUPO IS NOT NULL AND IDGRUPO<>'-1' AND IDGRUPO<>'99999Total' THEN
		IF p_AgruparPor='PRO' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDGRUPO IN '||IDGRUPO;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDGRUPO='||IDGRUPO;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Subfamilia';
	IF	IDSUBFAMILIA IS NOT NULL AND IDSUBFAMILIA<>'-1' AND IDSUBFAMILIA<>'99999Total' THEN
		IF p_AgruparPor='PRO' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDSUBFAMILIA IN '||IDSUBFAMILIA;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDSUBFAMILIA='||IDSUBFAMILIA;
		END IF;
	END IF;

	v_Status:='Creando filtro: Asignando condiciones->Categoria';
	IF	IDCATEGORIA IS NOT NULL AND IDCATEGORIA<>'-1' AND IDCATEGORIA<>'99999Total'  THEN
		IF p_AgruparPor='EST' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDCATEGORIA IN '||IDCATEGORIA;
		ELSE
			IF IDCATEGORIA='-2' THEN
				vFiltroSQL:=vFiltroSQL||' AND IDCATEGORIA<>1341';	--	No debe ser "Material no licitado" (Solo Viamed)
			ELSE
				vFiltroSQL:=vFiltroSQL||' AND IDCATEGORIA='||IDCATEGORIA;
			END IF;
			--3dic13	vFiltroSQL:=vFiltroSQL||' AND IDCATEGORIA='||IDCATEGORIA;
		END IF;
	END IF;

	--	16may13 Faltaba el IDEstado!
	v_Status:='Creando filtro: Asignando condiciones->Estado';
	IF IDESTADO IS NOT NULL AND IDESTADO<>'-1' AND IDESTADO<>'99999Total'  THEN
		IF p_AgruparPor='EST' AND v_VariosGrupos='S' THEN
			vFiltroSQL	:=vFiltroSQL||' AND IDESTADO IN '||IDESTADO;
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND IDESTADO='||IDESTADO;
		END IF;
	END IF;


	v_Status:='Creando filtro: Asignando condiciones->Referencias';
	/*	15may07	ET	La select no se construia exactamente igual que en el caso de la tabla de datos
	IF	REFERENCIA IS NOT NULL AND REFERENCIA<>'-1' THEN --  AND REFERENCIA<>'99999Total'
		IF REFERENCIA<>'99999Total'  THEN
			vFiltroSQL:=vFiltroSQL||' AND UPPER(REFERENCIA||PRODUCTO) LIKE ''%'||REPLACE(REPLACE(UPPER(REFERENCIA),'*','%'),'?','_')||'%''';
		ELSE
			vFiltroSQL:=vFiltroSQL||' AND UPPER(REFERENCIA||PRODUCTO) LIKE ''%'||REPLACE(REPLACE(UPPER(p_REFERENCIA),'*','%'),'?','_')||'%''';
		END IF;
	END IF;
	*/
		
	--utilidades_pck.debug('Referencia:'||REFERENCIA||' p_Referencia:'||p_REFERENCIA);
	
	--	3jun09	ET
	--	En el caso de agregación por producto, hay que utilizar el parametro p_REFERENCIA para conocer el filtro por texto
	
	IF (p_AgruparPor='REF' OR p_AgruparPor='DES' OR p_AgruparPor='PRO') AND p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN
		--15abr11	vFiltroSQL:=vFiltroSQL||' AND REFERENCIA='''||REFERENCIA||'''';
		--21dic12	vFiltroSQL:=vFiltroSQL||' AND SUBSTR(Referencia,1,10)||'':''||SUBSTR(NORMALIZAR_PCK.NormalizarID(PRODUCTO),1,80)='''||REFERENCIA||'''';
		vFiltroInternoSQL:=vFiltroInternoSQL||' AND LMO_IDPRODUCTO_NORM='''||REFERENCIA||'''';
		
	ELSIF p_AgruparPor='REFPROV'  AND p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>'-1' AND p_IDSeleccionActual<>'99999Total' THEN

		vFiltroInternoSQL:=vFiltroInternoSQL||' AND '||v_IDAgrupacion||'='''||REFERENCIA||'''';

	ELSE
		IF	p_REFERENCIA IS NOT NULL AND p_REFERENCIA<>'-1'  AND p_REFERENCIA<>'99999Total' THEN

			/*	6set13
			v_REFERENCIA:=REPLACE(p_REFERENCIA,'*',' ');

			-- la funcion de normalizacion estandar no nos sirve porque elimina los comodines
			--	26nov12	Quito el punto, que daba errores con referencias estándar acabadas en "."
			SELECT UPPER(translate(TRIM(v_REFERENCIA),'ÀÁÂÄÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜ*?''",:;+_()[]/\^`Ç','AAAAEEEEIIIIOOOOUUUU%_                   '))
			INTO v_REFERENCIA
			FROM dual;

			--	27nov12	El punto lo reemplazamos por '[46]' --> 29nov12 'ZZ46ZZ'
			v_REFERENCIA:=REPLACE(p_REFERENCIA,'.','ZZ46ZZ');
			
			v_REFERENCIA:=REPLACE(v_REFERENCIA,' ','% and ');

			--25may09 vFiltroSQL:=vFiltroSQL||' AND Normalizar_pck.NormalizarString(REFERENCIA||'' ''||PRODUCTO) LIKE ''%'||REFERENCIA||'%''';
			--Tenemos que filtrar a nivel de consulta base para que exista el campo eis_va_refproducto
			--	6set13	vFiltroInternoSQL:=vFiltroInternoSQL||' AND c o n t a i n s(LPE_TEXTONORM,'''||v_REFERENCIA||'''||''%'',1)>0';*/

			v_REFERENCIA:=Normalizar_Pck.CadenaCatsearch(p_REFERENCIA);
			vFiltroInternoSQL:=vFiltroInternoSQL||' AND CATSEARCH(LPE_TEXTONORM,'''||v_REFERENCIA||'*'','''')>0';
			--utilidades_pck.debug('vFiltroInternoSQL:'||vFiltroInternoSQL);
		END IF;
	END IF;


/*
	--	2 casos: si es el total REFERENCIA='99999Total'
	IF REFERENCIA='99999Total' THEN
		IF	p_REFERENCIA IS NOT NULL AND p_REFERENCIA<>'-1'  AND p_REFERENCIA<>'99999Total' THEN

			v_REFERENCIA:=REPLACE(p_REFERENCIA,'*',' ');

			-- la funcion de normalizacion estandar no nos sirve porque elimina los comodines
			SELECT UPPER(translate(TRIM(v_REFERENCIA),'ÀÁÂÄÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜ*?''",.:;+_()[]/\^`Ç','AAAAEEEEIIIIOOOOUUUU%_                    '))
			INTO v_REFERENCIA
			FROM dual;

			v_REFERENCIA:=REPLACE(v_REFERENCIA,' ','% and ');

			--25may09 vFiltroSQL:=vFiltroSQL||' AND Normalizar_pck.NormalizarString(REFERENCIA||'' ''||PRODUCTO) LIKE ''%'||REFERENCIA||'%''';
			--Tenemos que filtrar a nivel de consulta base para que exista el campo eis_va_refproducto
			vFiltroInternoSQL:=' AND c o n t a i n s(LPE_TEXTONORM,'''||v_REFERENCIA||'''||''%'',1)>0';

			--utilidades_pck.debug('vFiltroInternoSQL:'||vFiltroInternoSQL);
		END IF;
	ELSE
		IF	p_REFERENCIA IS NOT NULL AND p_REFERENCIA<>'-1'  AND p_REFERENCIA<>'99999Total' THEN

			v_REFERENCIA:=REPLACE(p_REFERENCIA,'*',' ');

			-- la funcion de normalizacion estandar no nos sirve porque elimina los comodines
			SELECT UPPER(translate(TRIM(v_REFERENCIA),'ÀÁÂÄÈÉÊËÌÍÎÏÒÓÔÖÙÚÛÜ*?''",.:;+_()[]/\^`Ç','AAAAEEEEIIIIOOOOUUUU%_                    '))
			INTO v_REFERENCIA
			FROM dual;

			v_REFERENCIA:=REPLACE(v_REFERENCIA,' ','% and ');

			--25may09 vFiltroSQL:=vFiltroSQL||' AND Normalizar_pck.NormalizarString(REFERENCIA||'' ''||PRODUCTO) LIKE ''%'||REFERENCIA||'%''';
			--Tenemos que filtrar a nivel de consulta base para que exista el campo eis_va_refproducto
			vFiltroInternoSQL:=' AND c o n t a i n s(LPE_TEXTONORM,'''||v_REFERENCIA||'''||''%'',1)>0';
		ELSIF	REFERENCIA IS NOT NULL AND REFERENCIA<>'-1'  AND REFERENCIA<>'99999Total' THEN
			vFiltroSQL:=vFiltroSQL||' AND REFERENCIA='''||REFERENCIA||'''';
		END IF;
	END IF;
*/


	v_Status:='Creando filtro: Asignando condiciones->Codigo';
	IF	p_CODIGO IS NOT NULL AND p_CODIGO<>'-1' THEN
		--16nov06	Para acelerar la consulta hacemos busqueda mediante "=" en lugar de "like"
		--vFiltroSQL:=vFiltroSQL||' AND UPPER(CODIGO) LIKE ''%'||REPLACE(REPLACE(UPPER(p_CODIGO),'*','%'),'?','_')||'%''';
		vFiltroSQL:=vFiltroSQL||' AND CODIGO= '''||p_CODIGO||'''';
	END IF;

	/*12abr13
	IF	IDTIPOINCIDENCIA IS NOT NULL AND IDTIPOINCIDENCIA<>'-1' AND IDTIPOINCIDENCIA<>'99999Total'  THEN
		vFiltroSQL:=vFiltroSQL||' AND IDTIPOINCIDENCIA='||IDTIPOINCIDENCIA;
	END IF;

	IF	IDGRAVEDAD IS NOT NULL AND IDGRAVEDAD<>'-1' AND IDGRAVEDAD<>'99999Total'  THEN
		vFiltroSQL:=vFiltroSQL||' AND IDGRAVEDADINCIDENCIA='||IDGRAVEDAD;
	END IF;*/
	
	--IF	p_IDNOMENCLATOR IS NOT NULL AND p_IDNOMENCLATOR<>-1 THEN
	--	vFiltroSQL:=vFiltroSQL||' AND IDNOMENCLATOR='||p_IDNOMENCLATOR;
	--END IF;

	--IF	p_URGENCIA IS NOT NULL AND p_URGENCIA<>-1 THEN
	--	vFiltroSQL:=vFiltroSQL||' AND URGENCIA='||p_URGENCIA;
	--END IF;

	--Las siguientes lineas no son necesarias, ya que el filtro ya se ha aplicado en la asignacion anterior
	--IF p_IDSeleccionActual IS NOT NULL AND p_IDSeleccionActual<>-1 THEN
	--	vFiltroSQL:=vFiltroSQL||' AND '||v_IDAgrupacion||'='||p_IDSeleccionActual;
	--END IF;

	v_Status:='Entrando en el cursor de indicadores';

	HTP.P(Utilidades_PCK.CabeceraXML);

	FOR r IN cIndicadores ( p_IDIndicador ) LOOP --	Un solo registro

		v_Status:='Dentro del cursor de indicadores';

		v_Texto	:=		'<INDICADOR>'
					||	'<CENTRO>'			||mvm.ScapeHTMLString(v_CentroDelUsuario)	||'</CENTRO>'
					||	'<USUARIO>'			||mvm.ScapeHTMLString(v_Usuario)			||'</USUARIO>'
					||	'<ACTUALIZACION>'	|| to_char(SYSDATE,'dd/mm/yyyy hh:mm:ss')		||'</ACTUALIZACION>'
					||	'<NOMBREINDICADOR>'	|| r.EIS_IN_NOMBRE			||'</NOMBREINDICADOR>';
					
		IF v_IDIDioma=0 THEN
			v_Texto	:=	v_Texto	||	'<NOMBREEMPRESA2>'	|| r.EIS_IN_NOMBREEMPRESA2	||'</NOMBREEMPRESA2>';
		ELSE
			v_Texto	:=	v_Texto	||	'<NOMBREEMPRESA2>'	|| r.EIS_IN_NOMBREEMPRESA2_BR	||'</NOMBREEMPRESA2>';
		END IF;

		IF 	p_Anno=9999 THEN
			v_Texto	:=	v_Texto		||	'<ANNO>Últimos 12 meses</ANNO>';
		ELSE
			v_Texto	:=	v_Texto		||	'<ANNO>'			|| p_Anno					||'</ANNO>';
		END IF;

		v_Status:='Dentro del cursor de indicadores.2.';

		IF	p_Mes<=12 THEN
			v_Texto:=v_Texto||	'<NOMBREMES>'		|| Utilidades_PCK.NombreMes(p_Mes)	||'</NOMBREMES>';
		ELSE
			v_Texto:=v_Texto||	'<NOMBREMES>Todos</NOMBREMES>';
		END IF;

		v_Status:='Dentro del cursor de indicadores.3.';

		IF	IDEMPRESA IS NOT NULL AND IDEMPRESA<>'-1' AND IDEMPRESA<>'99999Total' THEN
			IF p_AgruparPor='EMP' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista empresas</EMPRESA>';
			ELSIF SUBSTR(IDEMPRESA,1,4)='SEL_' THEN	--	25jun14 Selecciones personalizadas
				v_Texto:=v_Texto||'<EMPRESA>'||MVM.ScapeHTMLString(EISSelecciones_PCK.NombreSeleccion(SUBSTR(IDEMPRESA,5,20)))||'</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<EMPRESA>'||MVM.ScapeHTMLString(Utilidades_PCK.NombreEmpresa(IDEMPRESA))||'</EMPRESA>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<EMPRESA>Todas</EMPRESA>';
		END IF;

		v_Status:='Dentro del cursor de indicadores.4.';
		IF	IDCENTRO IS NOT NULL AND	IDCENTRO<>'-1' AND IDCENTRO<>'99999Total' THEN
			IF p_AgruparPor='CEN' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista centros</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<CENTRO>'||MVM.ScapeHTMLString(Utilidades_PCK.NombreCentro(IDCENTRO))||'</CENTRO>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<CENTRO>Todos</CENTRO>';
		END IF;

		v_Status:='Dentro del cursor de indicadores.5.';
		IF	IDUSUARIOSEL IS NOT NULL AND IDUSUARIOSEL<>'-1' AND IDUSUARIOSEL<>'99999Total' THEN
			IF p_AgruparPor='USU' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista usuarios</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<USUARIOSEL>'||MVM.ScapeHTMLString(Usuarios_PCK.NombreUsuario(IDUSUARIOSEL))||'</USUARIOSEL>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<USUARIOSEL>Todos</USUARIOSEL>';
		END IF;

		v_Status:='Dentro del cursor de indicadores.6.';
		IF	IDEMPRESA2 IS NOT NULL AND IDEMPRESA2<>'-1' AND IDEMPRESA2<>'99999Total' THEN
			IF p_AgruparPor='EMP2' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista empresas</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<EMPRESA2>'||MVM.ScapeHTMLString(Utilidades_PCK.NombreEmpresa(IDEMPRESA2))||'</EMPRESA2>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<EMPRESA2>Todas</EMPRESA2>';
		END IF;

		/*	2may13
		IF	IDPRODUCTO IS NOT NULL AND IDPRODUCTO<>'-1' AND IDPRODUCTO<>'99999Total' THEN
			IF p_AgruparPor='PRO' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista productos</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<PRODUCTO>'||MVM.ScapeHTMLString(SUBSTR(Utilidades_PCK.NombreProducto(IDPRODUCTO),1,100))||'</PRODUCTO>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<PRODUCTO>Todos</PRODUCTO>';
		END IF;*/
		
		IF	IDPRODUCTOESTANDAR IS NOT NULL AND IDPRODUCTOESTANDAR<>'-1' AND IDPRODUCTOESTANDAR<>'99999Total' THEN
			IF p_AgruparPor='PRO' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista productos</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<PRODUCTO>'||MVM.ScapeHTMLString(SUBSTR(Utilidades_PCK.NombreProducto(IDPRODUCTOESTANDAR),1,100))||'</PRODUCTO>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<PRODUCTO>Todos</PRODUCTO>';
		END IF;

		--	4abr12	Volvemos a trabajar con el ID de familia
		IF	IDFAMILIA IS NOT NULL AND IDFAMILIA<>'-1' AND IDFAMILIA<>'99999Total' THEN
			IF p_AgruparPor='FAM' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista familias</EMPRESA>';
			ELSE
				--8may12	v_Texto:=v_Texto||'<FAMILIA>'||MVM.ScapeHTMLString(SUBSTR(CatalogoPrivado_Seg_PCK.NombreFamilia(IDFAMILIA),1,100))||'</FAMILIA>';
				v_Texto:=v_Texto||'<FAMILIA>'||MVM.ScapeHTMLString(TRIM(utilidades_pck.piece(IDFAMILIA,':',1)))||'</FAMILIA>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<FAMILIA>Todas</FAMILIA>';
		END IF;

		/*	4abr12	Ahora estamos pasando Ref: NombreNorm
		IF	IDFAMILIA IS NOT NULL AND IDFAMILIA<>'-1' AND IDFAMILIA<>'99999Total' THEN
			IF p_AgruparPor='FAM' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista familias</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<FAMILIA>'||IDFAMILIA||'</FAMILIA>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<FAMILIA>Todas</FAMILIA>';
		END IF;*/



		IF	IDESTADO IS NOT NULL AND IDESTADO<>'-1' AND IDESTADO<>'99999Total' THEN
			IF p_AgruparPor='EST' AND v_VariosGrupos='S' THEN
				v_Texto:=v_Texto||'<EMPRESA>Lista estados</EMPRESA>';
			ELSE
				v_Texto:=v_Texto||'<ESTADO>'||MVM.ScapeHTMLString(SUBSTR(Utilidades_PCK.NombreEstado(r.EIS_CB_TIPO, IDESTADO),1,100))||'</ESTADO>';
			END IF;
		ELSE
			v_Texto:=v_Texto||'<ESTADO>Todos</ESTADO>';
		END IF;
/*	24feb11	Dejamos de utilizar las incidencias
		IF r.EIS_IN_F_TIPOINCIDENCIAS='S' THEN
			IF	IDTIPOINCIDENCIA IS NOT NULL AND IDTIPOINCIDENCIA<>'-1' AND IDTIPOINCIDENCIA<>'99999Total' THEN
				v_Texto:=v_Texto||'<TIPOINCIDENCIA>'||MVM.ScapeHTMLString(SUBSTR(Incidencias_PCK.NombreTipo(IDTIPOINCIDENCIA),1,100))||'</TIPOINCIDENCIA>';
			ELSE
				v_Texto:=v_Texto||'<TIPOINCIDENCIA>Todos</TIPOINCIDENCIA>';
			END IF;
		END IF;

		IF r.EIS_IN_F_GRAVEDAD='S' THEN
			IF	IDGRAVEDAD IS NOT NULL AND IDGRAVEDAD<>'-1' AND IDGRAVEDAD<>'99999Total' THEN
				v_Texto:=v_Texto||'<GRAVEDAD>'||MVM.ScapeHTMLString(SUBSTR(Incidencias_PCK.NombreGravedad(IDGRAVEDAD),1,100))||'</GRAVEDAD>';
			ELSE
				v_Texto:=v_Texto||'<GRAVEDAD>Todos</GRAVEDAD>';
			END IF;
		END IF;
*/
		IF	REFERENCIA IS NOT NULL AND REFERENCIA<>'-1' AND REFERENCIA<>'99999Total' THEN
			v_Texto:=v_Texto||'<REFERENCIA>'||MVM.ScapeHTMLString(REFERENCIA)||'</REFERENCIA>';
		ELSE
			v_Texto:=v_Texto||'<REFERENCIA>Todas</REFERENCIA>';
		END IF;

		IF	p_Codigo IS NOT NULL AND p_Codigo<>'-1' THEN
			v_Texto:=v_Texto||'<CODIGO>'||MVM.ScapeHTMLString(p_Codigo)||'</CODIGO>';
		ELSE
			v_Texto:=v_Texto||'<CODIGO>Todos</CODIGO>';
		END IF;

		--
		--	Faltan nomenclator y urgencias
		--

		v_Texto	:=v_Texto	||	'<REGISTROS>';

		v_Status:='Devolviendo registros';
		HTP.P(v_Texto);

		--	Nombre de la empresa 2
		IF v_IDIDioma=0 THEN
			vNombreEmpresa2:=r.EIS_IN_NOMBREEMPRESA2;	--Cliente, proveedor, reclamante, reclamado, etc.
		ELSE
			vNombreEmpresa2:=r.EIS_IN_NOMBREEMPRESA2_BR;	--8jun12	Cliente, proveedor, reclamante, reclamado, etc.
		END IF;


		

		IF r.EIS_IN_ACUMULACION='ID' THEN
			v_Agregar:='1';
		ELSE
			v_Agregar:=r.EIS_IN_ACUMULACION;
		END IF;

		v_Sql:=					'SELECT  ID, Fecha, '|| v_Agregar ||' Total, IDEmpresa, Empresa, IDCentro, '
							||	' Centro, IDEmpresa2, Empresa2, IDUsuario, Usuario, IDEstado, Estado, Codigo,'
							||	' TO_CHAR(FECHA,''MM'') MES, TO_CHAR(FECHA,''YYYY'') ANYO'
							||	' FROM ('||r.EIS_CB_CONSULTA
							||	' '||vFiltroInternoSQL	--25may09	ET
							||	' )';

		--utilidades_pck.debug('EIS. Listados. Mes: '|| p_Mes||' Anno:'||p_Anno);

		IF p_Mes=99 THEN	--	Estamos en el total de
			IF	p_Anno=9999 THEN

				vAnnoInicio:=to_number(TO_CHAR(SYSDATE,'YYYY'))-1;
				vMesInicio:=to_number(TO_CHAR(SYSDATE,'MM'))+1;

				IF vMesInicio>12 THEN
					vAnnoInicio:=vAnnoInicio+1;
					vMesInicio:=vMesInicio-12;
				END IF;

				v_Sql:=	v_Sql	||	' WHERE FECHA>=TO_DATE(''1/'||vMesInicio||'/'||vAnnoInicio||''',''dd/mm/yyyy'')';
			ELSE
				--4may09	ET	No se estaba tratando el caso de que el año no fuera 9999
				vAnnoInicio:=p_Anno;
				vMesInicio:=to_number(TO_CHAR(SYSDATE,'MM'))+1;

				IF vMesInicio>12 THEN
					vAnnoInicio:=vAnnoInicio+1;
					vMesInicio:=vMesInicio-12;
				END IF;

				v_Sql:=	v_Sql	||	' WHERE FECHA>=TO_DATE(''1/1/'||p_Anno||''',''dd/mm/yyyy'')'
								||	' AND FECHA<TO_DATE(''1/1/'||TO_CHAR(p_Anno+1)||''',''dd/mm/yyyy'')';
			END IF;
		ELSE
			v_Sql:=	v_Sql	||	' WHERE TO_CHAR(FECHA,''YYYY'')='||p_Anno;
			IF 	p_Mes<=12 THEN
				v_Sql:=	v_Sql	||	' AND TO_CHAR(FECHA,''MM'')='||p_Mes;
			END IF;
		END IF;


		v_Sql:=	v_Sql		||	vFiltroSQL
							||	' GROUP BY ID,Fecha, IDEmpresa, Empresa, IDCentro, '
							||	' 		Centro, IDEmpresa2, Empresa2, IDUsuario, Usuario,IDEstado, Estado, Codigo,'
							||	'		TO_CHAR(FECHA,''MM''), TO_CHAR(FECHA,''YYYY'')'
							||	' ORDER BY FECHA DESC';

		Total:=0;

		v_Status:='Entrando en el bucle de valores';

		--utilidades_pck.debug('ListaResultados AgruparPor:'||p_AgruparPor||' IDProd:'||IDPRODUCTOESTANDAR||' Ref:'||REFERENCIA||' SQL:'||	v_SQL);		--solodebug!
		
		HTP.P('<SQL>'||MVM.ScapeHTMLString(v_SQL) ||'</SQL>');		--26abr13	Para poder generar listados excel
		--HTP.P('<SQL_ESC>'||mvm.ScapeHTMLString(NORMALIZAR_PCK.ParaJavascript(v_SQL)) ||'</SQL_ESC>');		--solodebug
		
		OPEN v_cur FOR v_SQL;
		FETCH v_cur INTO v_reg;
		--WHILE v_cur%found AND v_Count<100 LOOP
		WHILE v_cur%found LOOP

			v_Count:=v_Count+1;

			Enlace := r.EIS_CB_ENLACE;
			Enlace:=REPLACE(Enlace, '#ID#', v_reg.ID);
			Enlace:=REPLACE(Enlace, '#ESTADO#', v_reg.IDEstado);
			--Enlace:=REPLACE(Enlace, '#USUARIO#', 'NO_VALIDAR' ); --Necesario antes para ver multiofertas
			Enlace:=REPLACE(Enlace, '#USUARIO#', v_reg.IDUsuario);	--No se utiliza, pero por si es necesario mas adelante...

			v_Texto	:=		'<REGISTRO>'
						||	'<ID>'			||	v_reg.ID								||'</ID>'
						||	'<FECHA>'		||	to_char(v_reg.Fecha,'dd/mm/yyyy')		||'</FECHA>'
						||	'<MES>'			||	v_reg.Mes								||'</MES>'
						||	'<ANNO>'		||	v_reg.Anyo								||'</ANNO>'
						||	'<CODIGO>'		||	v_reg.Codigo							||'</CODIGO>'
						||	'<IDEMPRESA>'	||	v_reg.IDEmpresa							||'</IDEMPRESA>'
						||	'<EMPRESA>'		|| 	MVM.ScapeHTMLString(v_reg.Empresa)		||'</EMPRESA>'
						||	'<IDCENTRO>'	||	v_reg.IDCentro							||'</IDCENTRO>'
						||	'<CENTRO>'		|| 	MVM.ScapeHTMLString(v_reg.Centro)		||'</CENTRO>'
						||	'<IDUSUARIO>'	||	v_reg.IDUsuario							||'</IDUSUARIO>'
						||	'<USUARIO>'		|| 	MVM.ScapeHTMLString(v_reg.Usuario)		||'</USUARIO>'
						||	'<IDEMPRESA2>'	||	v_reg.IDEmpresa2						||'</IDEMPRESA2>'
						||	'<EMPRESA2>'	|| 	MVM.ScapeHTMLString(v_reg.Empresa2)		||'</EMPRESA2>'
						||	'<IDESTADO>'	||	v_reg.IDEstado							||'</IDESTADO>'
						||	'<ESTADO>'		|| 	MVM.ScapeHTMLString(v_reg.Estado)		||'</ESTADO>'
						||	'<CONTADOR>'	|| v_Count									||'</CONTADOR>'		--	ET 11jul06	Contador
						||	'<TOTAL>'		|| 	Formato.Formato(v_reg.Total,1)			||'</TOTAL>';


			HTP.P(v_Texto);
			v_Texto	:=		'<ENLACE>'		||	MVM.ScapeHTMLString(DirEntorno||Enlace)	||'</ENLACE>'
						||	'</REGISTRO>';

			--	utilidades_pck.debug(Enlace);


			HTP.P(v_Texto);
			IF v_reg.Total IS NOT NULL THEN
				Total:=	Total + v_reg.Total;
			END IF;
			FETCH v_cur INTO v_reg;
		END LOOP;
		CLOSE v_cur;

		v_Texto	:=		'<TOTAL>'		|| 	Formato.Formato(Total,1)			||'</TOTAL>'
					||	'</REGISTROS>'
					||	'</INDICADOR>';

		HTP.P(v_Texto);

	END LOOP;

  	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.ListaResultados:','Indicador:'||p_IDIndicador||' Problema en:'||v_Status||' SQLERRM:'||sqlerrm);
		utilidades_pck.debug ('EIS_PCK.ListaResultados (ERROR). Indicador:'||p_IDIndicador||' SQL:'||v_SQL);
END;




--	PROCEDURE	ConsultaPredefinida
--	Recibe un ID de una consulta predefinida y prepara la llamada adecuada para devolver el XML
--	9oct09	Permitimos incluir parámetros necesarios para llamar a esta función desde el buscador de productos en plantillas
--	16jul15	Para empresas con IVA hay que sustituir el cuadro de mando por defecto
PROCEDURE	ConsultaPredefinida
(
	p_IDUSUARIO			VARCHAR2,
	p_IDCONSULTA		VARCHAR2,
	p_IDEmpresa			VARCHAR2 DEFAULT NULL,
	p_REFERENCIA		VARCHAR2 DEFAULT NULL
)
IS

	CURSOR cConsulta(IDConsulta VARCHAR2) IS
		SELECT 		*
			FROM 	EIS_CONSULTASPREDEFINIDAS
			WHERE	EIS_CP_ID=IDConsulta;


	v_Anno				VARCHAR2(4);
	v_IDCONSULTA		EIS_CONSULTASPREDEFINIDAS.EIS_CP_ID%TYPE;

	v_IDCuadro			EIS_CONSULTASPREDEFINIDAS.EIS_CP_IDCUADRO%TYPE;			--	16jul15 Parche para mostrar por defecto el cuador de mando de pedidos con IVA
BEGIN

	v_IDCONSULTA:=p_IDCONSULTA;

	IF v_IDCONSULTA IS NULL THEN

		--v_IDCONSULTA:='COPedidosPorCentroEur';

		--	Llama al EIS sin seleccionar ningun cuadro de mando
		--	16abr13	Cambiamos los parámetros según los cambios en la función
		CuadroDeMando
		(
			p_IDUSUARIO,					--	Usuario
			null,							--	Cuadro de mando
			9999,							--	Año = Año actual
			p_IDEmpresa,					--	IDEmpresa
			null,							--	IDCentro
			null,							--	IDUsuario 2
			null,							--	IDEmpresa 2
			null,							--	IDCENTRO2
			null,							--	IDProducto
			null,							--	IDGrupo
			null,							--	IDSubfamilia
			null,							--	IDCategoria
			null,							--	IDEstado
			p_REFERENCIA,					--	Ref Producto
			null,							--	Codigo documento	--	24nov06	ET
			null,							--	Agrupar Por
			null,							--	Resultados
			null,							--	Restriccion
			'TABLADATOS',					--	FormatoResultados (tabla de datos, grafico)
			null							--	RatioSobre
		);

	ELSE
	
		--	Carga los datos de la consulta y prepara la llamada
		FOR Consulta IN cConsulta(v_IDCONSULTA) LOOP	-- 1 solo registro

			IF v_IDCONSULTA='VEProgramasEur' THEN	--	ET	11jul07	Esto podria parametrizarse, pero era urgente solucionarlo para que los proveedores vean los programas
				v_Anno:=to_char(SYSDATE,'yyyy');
			ELSE

				v_Anno:=9999;


				--
				--	31mar16	solo para las demos del 4/4/16: v_Anno:=2015;
				--	


			END IF;
			
			IF v_IDCONSULTA='COPedidosPorEmpEur' AND Empresas_PCK.PreciosConIva(NVL(p_IDEmpresa, utilidades_pck.EmpresaDelUsuario(p_IDUSUARIO)))='N' THEN
				v_IDCuadro:=Consulta.EIS_CP_IDCUADRO;
			ELSE
				v_IDCuadro:='CO_Pedidos_IVA_Eur';
			END IF;
			--utilidades_pck.debug('EIS_PCK.ConsultaPredefinida IDEmpresa:'||p_IDEmpresa|| ' IDCuadro:'||v_IDCuadro);

			--	Llama al cuadro de mando correspondiente
			CuadroDeMando
			(
				p_IDUSUARIO,					--	Usuario
				v_IDCuadro,						--	Cuadro de mando
				v_Anno, 						--	9999,		--	Año = Ultimos 12 meses
				p_IDEmpresa,
				Consulta.EIS_CP_IDCENTRO,
				Consulta.EIS_CP_IDUSUARIO,
				Consulta.EIS_CP_IDEMPRESA2,
				Consulta.EIS_CP_IDPRODUCTO,
				Consulta.EIS_CP_IDFAMILIA,
				Consulta.EIS_CP_IDNOMENCLATOR,
				Consulta.EIS_CP_IDURGENCIAS,
				Consulta.EIS_CP_IDESTADO,
				null,							--	tipo de incidencia
				null,							--	gravedad de incidencia
				p_REFERENCIA,
				null,							--	Codigo documento	--	24nov06	ET
				Consulta.EIS_CP_AGRUPARPOR,
				Consulta.EIS_CP_RESULTADOS,		--	Resultados (acumulado 'NULL', porc. mensual 'PORCV', porc. horizontal 'PORCH', ratio 'RATIO')
				Consulta.EIS_CP_RESTRICCION,
				'TABLADATOS',					--	FormatoResultados (tabla de datos, grafico)
				Consulta.EIS_CP_RATIOSOBRE		--	RatioSobre
			);

		END LOOP;

	END IF;

EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.ConsultaPredefinida','',sqlcode,sqlerrm,null);
END;


/*

	Funciones de actualizacion de los indicadores del EIS

*/


/*
	PROCEDURE	ActualizarResumenEIS

	Crea de nuevo todos los indicadores del resumen EIS

	EXEC EIS_PCK.ActualizarResumenEIS;
	EXEC EIS_PCK.ActualizarResumenEIS(30);
	
	13set13	Utilizamos índice CATSEARCH en lugar de CONTEXT, ralentiza mucho la actualización aunque da mejores prestaciones en las búsquedas
	
	17ago15	No se estaba informando correctamente la descripción estándar de algunos productos. Pongo un parche provisional.
	
	Sesion enganchada:
		EXEC sys.kill_session(276,26236);
*/
PROCEDURE	ActualizarResumenEIS
(
	p_Periodo	INTEGER DEFAULT NULL
)
IS
	CURSOR	cIndicadores	IS
		SELECT	EIS_IN_ID FROM	EIS_INDICADORES;


	--	17ago15	PROVISIONAL
	CURSOR cProdEstandar IS
		SELECT		DISTINCT EIS_VA_IDPRODESTANDAR
			FROM	EIS_VALORES
			WHERE 	EIS_VA_PRODUCTO	IS NULL
			AND		EIS_VA_IDEMPRESA	=7996
			AND		EIS_VA_IDPRODESTANDAR	IS NOT NULL		--	10nov15	En algunos casos se insertaba NULL
			ORDER BY EIS_VA_IDPRODESTANDAR;
			
			
	v_Producto		CATPRIV_PRODUCTOSESTANDAR.CP_PRO_NOMBRE%TYPE;




	v_Sql				VARCHAR2(3000);

	--	Para medir el rendimiento
	v_IDRendimientoT 	NUMBER;				--	Rendimiento completo
	v_IDRendimiento 	NUMBER;
	v_Operacion			VARCHAR2(100);
	Tiempo				INTEGER;

	--	16ene13 variables para la limpieza de la tabla EIS_VALORES
	v_FechaInicio	DATE;
	v_MesInicio		INTEGER;
	v_AnnoInicio	INTEGER;
	
	SIN_PERIODO			EXCEPTION;
BEGIN
	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');

	v_IDRendimientoT := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Proceso completo','','EIS T');


	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Limpieza tablas','','EIS T');
	
	--
	--	Eliminamos el índice CATSEARCH para periodos de cálculo de más de 50 días ya que en este caso es más lento el recálculo que reconstruir el índice
	--
	--17set13	IF p_Periodo>50 THEN
	--13ago17	v_Sql:='DROP INDEX EIS_VA_TIDX_SET';
		
	--13ago17	BEGIN
	--13ago17		EXECUTE IMMEDIATE v_Sql;
	--13ago17	EXCEPTION
	--13ago17		WHEN OTHERS THEN
	--13ago17			utilidades_pck.debug('ActualizarResumenEIS: ya se había eliminado el índice EIS_VA_TIDX_SET. Siguiendo proceso.');
	--13ago17	END;

		v_Sql:='DROP INDEX EIS_VA_TIDX';	--	
		BEGIN
			EXECUTE IMMEDIATE v_Sql;
		EXCEPTION
			WHEN OTHERS THEN
				utilidades_pck.debug('ActualizarResumenEIS: ya se había eliminado el índice EIS_VA_TIDX. Siguiendo proceso.');
		END;

	--17set13	END IF;
	
	--	Limpiamos la tabla temporal
	DELETE EIS_VALORESTEMPORAL;		--17ene06	Importante volver a activar esta limpieza! La quitamos provisionalmente para poder depurar un error
	
	COMMIT;		--	12set13	Para poder confirmar que se han borrado tablas

	--	16ene13	Hacemos la limpieza de EIS_VALORES de una única vez, mejora mucho el rendimiento
	IF p_Periodo IS NOT NULL THEN
		v_FechaInicio:=SYSDATE-p_Periodo;
		v_MesInicio:=TO_NUMBER(TO_CHAR(v_FechaInicio,'mm'));
		v_AnnoInicio:=TO_NUMBER(TO_CHAR(v_FechaInicio,'yyyy'));
		v_FechaInicio:=TO_DATE('01/'||v_MesInicio||'/'||v_AnnoInicio,'dd/mm/yyyy');

		--	Eliminamos todos los registros posteriores a la fecha que volvemos a actualizar
		DELETE		EIS_VALORES
			WHERE	(((EIS_VA_MES>=v_MesInicio) AND (EIS_VA_ANNO=v_AnnoInicio)
			OR		EIS_VA_ANNO>v_AnnoInicio));
			
		
		/*	Eliminar el siguiente bloque tras hacer limpieza		
			
		--29mar17	Eliminamos los indicadores de muestras, ya no se utilizan
		utilidades_pck.debug('ActualizarResumenEIS: Eliminamos los indicadores de muestras, ya no se utilizan');
		DELETE EIS_VALORES WHERE EIS_VA_IDINDICADOR='CO_MUESTRAS_NUM';
		DELETE EIS_VALORES WHERE EIS_VA_IDINDICADOR='VE_MUESTRAS_NUM';			
			
		DELETE EIS_CONSULTASPREDEFINIDAS WHERE EIS_CP_ID='COMuestrasPorCentroNum';
		DELETE EIS_INDICADORESPORCUADRO WHERE EIS_CI_IDCUADRO='CO_Muestras_Num';
		DELETE EIS_CUADROSDEMANDO WHERE EIS_CM_ID='CO_Muestras_Num';
		DELETE EIS_INDICADORES WHERE EIS_IN_ID='CO_MUESTRAS_NUM';
		DELETE EIS_CONSULTABASE WHERE EIS_CB_ID='CO_MUESTRAS_NUM';
		--	Ventas
		DELETE EIS_CONSULTASPREDEFINIDAS WHERE EIS_CP_ID='VEMuestrasPorCentroNum';
		DELETE EIS_INDICADORESPORCUADRO WHERE EIS_CI_IDCUADRO='VE_Muestras_Num';
		DELETE EIS_CUADROSDEMANDO WHERE EIS_CM_ID='VE_Muestras_Num';
		DELETE EIS_INDICADORES WHERE EIS_IN_ID='VE_MUESTRAS_NUM';
		DELETE EIS_CONSULTABASE WHERE EIS_CB_ID='VE_MUESTRAS_NUM';
		
		Eliminar el bloque anterior tras hacer limpieza	*/	
		

	ELSE
		RAISE SIN_PERIODO;
		--	Eliminamos todos los registros
		--	DELETE		EIS_VALORES;
	END IF;
  	RENDIMIENTO_PCK.Terminar(v_IDRendimiento);

	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CalculoIndicadores N','','EIS T');
	COMMIT;		--	12set13	Para poder confirmar que se han borrado tablas


	--
	--	26ago14	Ejecución de todas las tareas pendientes ANTES de recalcular los indicadores
	--
	EjecutarTareas;

	--
	--	Actualizamos todos los indicadores
	--
	FOR Indicador IN cIndicadores LOOP

		ActualizarIndicador(Indicador.EIS_IN_ID, p_Periodo,'N');

	END LOOP;
	
	
	
	--
	--	17ago15	PROVISIONAL
	--
	FOR p IN cProdEstandar LOOP
	
		SELECT		MAX(CP_PRO_NOMBRE)
			INTO	v_Producto
			FROM	CATPRIV_PRODUCTOSESTANDAR
			WHERE	CP_PRO_ID=p.EIS_VA_IDPRODESTANDAR;

		IF v_Producto IS NOT NULL THEN
			UPDATE	EIS_VALORES
				SET		EIS_VA_PRODUCTO		=SUBSTR(v_Producto,1,100)
				WHERE	EIS_VA_PRODUCTO	IS NULL
				AND		EIS_VA_IDEMPRESA	=7996
				AND		EIS_VA_IDPRODESTANDAR=p.EIS_VA_IDPRODESTANDAR;
			utilidades_pck.debug ('Corr.ref.Viamed. Corregido producto sin descripción:'||p.EIS_VA_IDPRODESTANDAR);
		ELSE
			MVM.InsertDBError ('Corr.ref.Viamed', 'ERROR: Producto no encontrado:'||p.EIS_VA_IDPRODESTANDAR);
		END IF;
	END LOOP;



	--	Actualiza la fecha de la actualizacion
	UPDATE		EIS_CONFIGURACION
		SET		EIS_CO_Actualizacion=SYSDATE;

	COMMIT;

	Tiempo:=RENDIMIENTO_PCK.TiempoTranscurrido(v_IDRendimiento );
  	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CorregirDatos N','','EIS T');


	--	26feb13	Estos 2 procesos de corrección ralentizan mucho, los incluimos solo en el batch
	--	6feb12	Corrección masiva de las descripciones de producto que puedan dar lugar a errores
	--CorregirDatosEIS;
	--	3may12	Corrección masiva de las familias de producto que puedan dar lugar a errores
	--CorregirFamiliasEIS;


	--	12set13	Creamos de nuevo el índice
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'Crear índice','','EIS T');

	--17set13	IF p_Periodo>50 THEN
		--	v_Sql:='CREATE INDEX EIS_VA_TIDX_SET ON EIS_VALORES(EIS_VA_TEXTONORM) INDEXTYPE IS CTXSYS.CTXCAT PARAMETERS (''index set EIS_VA_TIDX_SET'')';
		v_Sql:='CREATE INDEX EIS_VA_TIDX ON EIS_VALORES(EIS_VA_TEXTONORM) INDEXTYPE IS CTXSYS.CTXCAT PARAMETERS (''index set EIS_VA_TIDX_SET'')';		--
		EXECUTE IMMEDIATE v_Sql;
	--17set13	END IF;

 	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );

	--	Guardamos constancia del cambio a realizar
	LOGADMINISTRACION_PCK.Insertar
	(
		null,
		'1',
		'EIS',
		null,
		'ActualizarResumenEIS. Periodo:['||p_Periodo||']. Duracion: '|| Tiempo/100||'s.'
	);


 	RENDIMIENTO_PCK.Terminar(v_IDRendimientoT );

/*	Bloque para pruebas de rendimiento

	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CalculoIndicadores v.2','','EIS T');

	--	Limpiamos la tabla temporal
	DELETE EIS_VALORESTEMPORAL;

	--	Actualizamos todos los indicadores
	FOR Indicador IN cIndicadores LOOP

		ActualizarIndicador2(Indicador.EIS_IN_ID);

	END LOOP;

	--	Actualiza la fecha de la actualizacion
	UPDATE	EIS_CONFIGURACION
	SET		EIS_CO_Actualizacion=SYSDATE;

	COMMIT;

  	RENDIMIENTO_PCK.Terminar(v_IDRendimiento ); /* */
EXCEPTION
	WHEN SIN_PERIODO THEN
		MVM.InsertDBError ('EIS_PCK.ActualizarResumenEIS','No se ha informado del periodo');
END;




--Devuelve la fecha de actualización del EIS
FUNCTION	FechaActualizacionEIS	RETURN VARCHAR2
IS
	FechaActualizacion	DATE;
BEGIN

	SELECT	MAX(EIS_CO_Actualizacion)
	INTO	FechaActualizacion
	FROM	EIS_CONFIGURACION;

	RETURN	to_char(FechaActualizacion,'dd/mm/yyyy hh24:mi:ss');
EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.FechaActualizacionEIS: ',sqlerrm);
		RETURN NULL;
END;

/*
	PROCEDURE	ActualizarIndicador

	Actualiza un indicador EIS
	
	14jul10	Para los pedidos programados, no se está guardando el año en curso
	25feb13	Para mejorar el rendimiento incluiremos la restricción sobre fechas en la consulta interna
	
	
	EXEC EIS_PCK.ActualizarIndicador('CO_PEDPROG_EUR', 180);
	
	
*/
PROCEDURE	ActualizarIndicador
(
	p_IDIndicador	VARCHAR2,
	p_Periodo		INTEGER DEFAULT NULL,
	p_Limpiar		VARCHAR2 DEFAULT 'S'
)
IS
	CURSOR	cIndicador(pID VARCHAR2)	IS
		SELECT		EIS_IN_ID, EIS_CB_CONSULTA, EIS_IN_ACUMULACION, EIS_IN_NOMBRE,
					EIS_IN_RESTRICCIONES						--	26ago13	No se estaba teniendo en cuenta!!!
			FROM	EIS_INDICADORES, EIS_CONSULTABASE
			WHERE	EIS_IN_IDCONSULTABASE=EIS_CB_ID
			AND		EIS_IN_ID=pID;

	TYPE TRegResumen IS RECORD
	(
		ID	 					NUMBER,
		Total 					NUMBER,
		IDPais					NUMBER,
		IDProducto				NUMBER,
		Producto				VARCHAR2(500),
		IDFamilia				NUMBER,
		Familia					VARCHAR2(300),
		IDEmpresa				NUMBER,
		Empresa					VARCHAR2(300),
		IDCentro				NUMBER,
		Centro					VARCHAR2(300),
		IDEmpresa2				NUMBER,
		Empresa2				VARCHAR2(300),
		IDUsuario				NUMBER,
		Usuario					VARCHAR2(300),
		IDEstado				VARCHAR2(100), 	--	Las facturas utilizan un estado no numerico
		Estado					VARCHAR2(300),
		--10abr13	IDTipoIncidencia		NUMBER,
		--10abr13	TipoIncidencia			VARCHAR2(300),
		--10abr13	IDGravedadIncidencia	NUMBER,
		--10abr13	GravedadIncidencia		VARCHAR2(300),
		IDProductoEstandar		NUMBER, 
		IDCentro2				NUMBER, 
		Centro2					VARCHAR2(300), 
		RefProveedor			VARCHAR2(100),
		Referencia				VARCHAR2(300),
		Codigo					VARCHAR2(100),
		MES						NUMBER,
		ANYO					NUMBER
	);



	v_cur 					REF_CURSOR;
	v_reg 					TRegResumen;
	v_Count					INTEGER;
	v_Sql					VARCHAR2(3000);
	v_Agrupar				VARCHAR2(100);
	v_Status				VARCHAR2(1000);
	v_IDRendimiento 		NUMBER;
	v_Operacion				VARCHAR2(100);

	v_Restriccion			VARCHAR2(1000);
	v_RestriccionInterna	VARCHAR2(1000);

	v_Sqldebug				VARCHAR2(3000);--debug

	v_FechaInicio			DATE;
	v_MesInicio				INTEGER;
	v_AnnoInicio			INTEGER;

	WRITES_FINAL			NUMBER;
	WRITES_INICIO			NUMBER;

	SALIR					EXCEPTION;
BEGIN

	--29mar17	Eliminar indicadores de muestras
	--29mar17	IF p_IDIndicador IN ('CO_MUESTRAS_NUM', 'VE_MUESTRAS_NUM') THEN
	--29mar17		RAISE SALIR;
	--29mar17	END IF;

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CalculoInd('||p_Periodo||'):'||p_IDIndicador,'','EIS T');

	COMMIT;

	--20set04 ET	Ya no es necesario definir los segmentos de rollback
	--IF utilidades_PCK.Entorno='NUCLEO' THEN
	--	SET TRANSACTION USE ROLLBACK SEGMENT r_large;
	--END IF;

	--SELECT		SUM(WRITES)
	--	INTO	WRITES_INICIO
	--	FROM	V$ROLLSTAT;

	IF p_Periodo IS NOT NULL THEN
		v_FechaInicio:=SYSDATE-p_Periodo;
		v_MesInicio:=TO_NUMBER(TO_CHAR(v_FechaInicio,'mm'));
		v_AnnoInicio:=TO_NUMBER(TO_CHAR(v_FechaInicio,'yyyy'));
		v_FechaInicio:=TO_DATE('01/'||v_MesInicio||'/'||v_AnnoInicio,'dd/mm/yyyy');
	END IF;

	FOR Indicador IN cIndicador(p_IDIndicador) LOOP

		v_Status:='Entrando';

		IF p_Limpiar='S' THEN

			IF p_Periodo IS NOT NULL THEN
				--	Eliminamos todos los registros posteriores a la fecha que volvemos a actualizar
				DELETE		EIS_VALORES
					WHERE	EIS_VA_IDINDICADOR=p_IDIndicador
					-- 		AND	EIS_VA_MES>=v_MesInicio AND EIS_VA_ANNO>=v_AnnoInicio
					AND		(((EIS_VA_MES>=v_MesInicio) AND (EIS_VA_ANNO=v_AnnoInicio)
					OR		EIS_VA_ANNO>v_AnnoInicio));

					--utilidades_pck.debug('Inicio:'||v_MesInicio||'/'||v_AnnoInicio);

			ELSE
				--	Eliminamos todos los registros
				DELETE		EIS_VALORES
					WHERE	EIS_VA_IDINDICADOR=p_IDIndicador;
			END IF;
		END IF;

		IF Indicador.EIS_IN_ACUMULACION='ID' THEN
			v_Agrupar:='ID,';
		ELSE
			v_Agrupar:='';
		END IF;

		IF  p_Periodo IS NOT NULL THEN
			--25feb13	v_Restriccion:=' WHERE Fecha>=TO_DATE(''01/'||v_MesInicio||'/'||v_AnnoInicio||''',''dd/mm/yyyy'')';
			v_RestriccionInterna:=' AND Fecha>=TO_DATE(''01/'||v_MesInicio||'/'||v_AnnoInicio||''',''dd/mm/yyyy'')';
		ELSE
			--25feb13	v_Restriccion:=null;
			v_RestriccionInterna:=null;
		END IF;
		
		--	26ago13	No se estaba teniendo en cuenta!!!
		IF Indicador.EIS_IN_RESTRICCIONES IS NOT NULL THEN
			v_RestriccionInterna:=v_RestriccionInterna||' AND '||Indicador.EIS_IN_RESTRICCIONES;
		END IF;

		--ET 21/5/2001 el campo a acumular lo incluimos en Indicador.EIS_IN_ACUMULACION
		--ET 14/10/2003 Restringimos para poder actualizar solo los datos a partir de una fecha dada
		v_Sql:=	'SELECT	ID, '|| Indicador.EIS_IN_ACUMULACION ||' Total, IDPais, IDProducto, Producto, IDFamilia, Familia, IDEmpresa, Empresa, IDCentro, '
			||	'	Centro, IDEmpresa2, Empresa2, IDUsuario, Usuario, IDEstado, Estado,'
			--10abr13	campos eliminados	||	'	IDTipoIncidencia, TipoIncidencia, IDGravedadIncidencia, GravedadIncidencia,'
			||	'	IDProductoEstandar, IDCentro2, Centro2, RefProveedor, '	--	10abr13	Nuevos campos
			||	'	Referencia, Codigo, TO_CHAR(FECHA,''MM'') MES, TO_CHAR(FECHA,''YYYY'') ANYO'
			||	' FROM'
			||	' ('
			||	Indicador.EIS_CB_CONSULTA
			||	v_RestriccionInterna			--	25feb13
			||	' )'
			--||	v_Restriccion				--	25feb13 Ya no es necesaria
			||	' GROUP BY	ID, '||v_Agrupar||' IDPais,IDProducto, Producto, IDFamilia, Familia, IDEmpresa, Empresa, IDCentro, Centro, IDEmpresa2, '
			||	' Empresa2, IDUsuario, Usuario, IDEstado, Estado, '
			--10abr13	campos eliminados	||	IDTipoIncidencia, TipoIncidencia, IDGravedadIncidencia, GravedadIncidencia,Referencia, Codigo,'
			||	'	IDProductoEstandar, IDCentro2, Centro2, RefProveedor, '	--	10abr13	Nuevos campos
			||	' Referencia, Codigo, TO_CHAR(FECHA,''MM''), TO_CHAR(FECHA,''YYYY'')';


		v_Count:=0;

		--solodebug	IF p_IDIndicador='CO_PEDPROG_EUR' THEN						--solodebug
		--solodebug		utilidades_pck.debug('Indicador pedidos: '||v_SQL);		--solodebug
		--solodebug	END IF;														--solodebug

		--utilidades_pck.debug('Indicador '||p_IDIndicador||': '||v_SQL);

		v_Status:=' Abriendo cursor.';

		--	Abre el cursor sobre esta consulta
		OPEN v_cur FOR v_SQL;
		FETCH v_cur INTO v_reg;

		v_Status:=' Dentro del cursor.';

		WHILE v_cur%found LOOP

			v_Status:=' Insertando Registro. Mes:'||v_reg.Mes||' Año:'||v_reg.Anyo||' EMP:'||v_reg.Empresa
							||' CEN:'||v_reg.Centro||' EMP2:'||v_reg.Empresa2||' Ref.proveedor:'||v_reg.RefProveedor;

			--debug	IF v_reg.IDEmpresa=1640 AND p_IDIndicador='CO_PED_EUR' AND v_reg.RefProveedor IS NOT NULL THEN
			--debug		utilidades_pck.debug(v_Status);
			--debug	END IF;
			
			BEGIN
			InsertarValor
			(
				p_IDIndicador,	--Indicador
				v_reg.ID,
				v_reg.Mes,
				v_reg.Anyo,
				v_reg.Codigo,
				v_reg.IDPais,
				v_reg.IDEmpresa,
				SUBSTR(v_reg.Empresa,1,50),
				v_reg.IDCentro,
				SUBSTR(v_reg.Centro,1,50),
				v_reg.IDUsuario,
				SUBSTR(v_reg.Usuario,1,50),
				v_reg.IDEmpresa2,
				SUBSTR(v_reg.Empresa2,1,50),
				v_reg.IDCentro2,  						--10abr13
				SUBSTR(v_reg.Centro2,1,50),  			--10abr13
				v_reg.IDProductoEstandar, 				--10abr13
				--SUBSTR(v_reg.Referencia,50),
				v_reg.IDProducto,
				SUBSTR(v_reg.Producto,1,100),			--Tamaño de columna para producto: 100
				SUBSTR(v_reg.RefProveedor,1,50), 			--10abr13
				--19abr13	v_reg.IDFamilia,
				--19abr13	SUBSTR(v_reg.Familia,1,100),
				--19abr13	null,
				--19abr13	null,
				--19abr13	null,
				--19abr13	null,
				v_reg.IDEstado,
				SUBSTR(v_reg.Estado,1,50),
				--10abr13	v_reg.IDTipoIncidencia,
				--10abr13	SUBSTR(v_reg.TipoIncidencia,1,50),
				--10abr13	v_reg.IDGravedadIncidencia,
				--10abr13	SUBSTR(v_reg.GravedadIncidencia,1,50),
				v_reg.Total,
				0
			);
			v_Count:=v_Count+1;
			EXCEPTION
				WHEN OTHERS THEN
					MVM.InsertDBError ('EIS_PCK.ActualizarIndicador:'||p_IDIndicador,' Estado:'||v_Status||' SQL:'||v_SQL||' SQLERRM:'||sqlerrm);
			END;

			FETCH v_cur INTO v_reg;
		END LOOP;

		UPDATE 		EIS_INDICADORES
			SET		EIS_IN_ACTUALIZACION=SYSDATE
			WHERE	EIS_IN_ID=p_IDIndicador;
		
		COMMIT;	--	22abr13	COmmit a nivel de cada indicador
		
		--	Solo debug
		--	Cuidado!!! Generaba un casque en el indicador de accesos!
		--Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicadorEIS:'||Indicador.EIS_IN_NOMBRE||' creados '||v_Count||' registros');

	END LOOP;

	--SELECT		SUM(WRITES)
	--	INTO	WRITES_FINAL
	--	FROM	V$ROLLSTAT;

	--	Solo debug
	--	Cuidado!!! Generaba un casque en el indicador de accesos!
	--Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicadorEIS: '||Indicador.EIS_IN_NOMBRE||' creados '||v_Count||' registros. Rollback: '||to_char(WRITES_FINAL-WRITES_INICIO));

	--	21dic12 Informamos el resumen de centros para este indicador
	ResumenCentros(p_IDIndicador);
	
	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
	
EXCEPTION
	WHEN SALIR THEN
		--MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.ActualizarIndicador: '||p_IDIndicador,' Estado:'||v_Status||'Indicador desactivado');
	WHEN OTHERS THEN
		--MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.ActualizarIndicador: '||p_IDIndicador,' Estado:'||v_Status||' SQL:'||v_SQL||' SQLERRM:'||sqlerrm);
END;

/*
	PROCEDURE	ActualizarConsultaBase

	Actualiza una consulta base del EIS

	Para poder actualizar solo las consultas base necesitamos que incluyan todos los campos que necesitaremos
	posteriormente para restringir las consultas

*/
/*
PROCEDURE	ActualizarConsultaBase
(
	p_IDIndicador	VARCHAR2
)
IS
	CURSOR	cIndicador(pID VARCHAR2)	IS
		SELECT	EIS_IN_ID, EIS_CB_CONSULTA, EIS_IN_ACUMULACION, EIS_IN_NOMBRE
		FROM	EIS_INDICADORES, EIS_CONSULTABASE
		WHERE	EIS_IN_IDCONSULTABASE=EIS_CB_ID
			AND	EIS_IN_ID=pID;

	v_cur 			REF_CURSOR;
	v_reg 			TRegResumen;
	v_Count			INTEGER;
	v_Sql			VARCHAR2(3000);
	v_Agrupar		VARCHAR2(100);
	v_Status		VARCHAR2(1000);
	v_IDRendimiento NUMBER;
	v_Operacion		VARCHAR2(100);

	v_Sqldebug			VARCHAR2(3000);--debug

	WRITES_FINAL	NUMBER;
	WRITES_INICIO	NUMBER;

BEGIN

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CalculoIndicador','','EIS T');

	COMMIT;

	--SELECT		SUM(WRITES)
	--	INTO	WRITES_INICIO
	--	FROM	V$ROLLSTAT;

	FOR Indicador IN cIndicador(p_IDIndicador) LOOP

		v_Status:='Entrando';


		DELETE		EIS_VALORES
			WHERE	EIS_VA_IDINDICADOR=p_IDIndicador;

		IF Indicador.EIS_IN_ACUMULACION='ID' THEN
			v_Agrupar:='ID,';
		ELSE
			v_Agrupar:='';
		END IF;

		--ET 21/5/2001 el campo a acumular lo incluimos en Indicador.EIS_IN_ACUMULACION
		v_Sql:=	'SELECT	'|| Indicador.EIS_IN_ACUMULACION ||' Total, IDProducto, Producto, IDFamilia, Familia, IDEmpresa, Empresa, IDCentro, '
			||	'	Centro, IDEmpresa2, Empresa2, IDUsuario, Usuario, IDEstado, Estado,'
			||	'	IDTipoIncidencia, TipoIncidencia, IDGravedadIncidencia, GravedadIncidencia,'
			||	'	Referencia, Codigo, TO_CHAR(FECHA,''MM'') MES, TO_CHAR(FECHA,''YYYY'') ANYO'
			||	' FROM'
			||	' ('
			||	Indicador.EIS_CB_CONSULTA
			||	' )'
			||	' GROUP BY	'||v_Agrupar||' IDProducto, Producto, IDFamilia, Familia, IDEmpresa, Empresa, IDCentro, Centro, IDEmpresa2, '
			||	' Empresa2, IDUsuario, Usuario, IDEstado, Estado, IDTipoIncidencia, TipoIncidencia, IDGravedadIncidencia, GravedadIncidencia,Referencia, Codigo,'
			||	' TO_CHAR(FECHA,''MM''), TO_CHAR(FECHA,''YYYY'')';


		v_Count:=0;

			--IF p_IDIndicador='INF_EV_PROD' THEN								--solodebug
			--	utilidades_pck.debug('Indicador Informes: '||v_SQL);		--solodebug
			--END IF;															--solodebug

		v_Status:=v_Status||' Abriendo cursor.';

		--	Abre el cursor sobre esta consulta
		OPEN v_cur FOR v_SQL;
		FETCH v_cur INTO v_reg;

		v_Status:=v_Status||' Dentro del cursor.';

		WHILE v_cur%found LOOP

			v_Status:=' Insertando Registro. Mes='||v_reg.Mes||' Año='||v_reg.Anyo||' EMP='||v_reg.Empresa
							||' CEN='||v_reg.Centro||' EMP2='||v_reg.Empresa2;

			InsertarValor
			(
				p_IDIndicador,	--Indicador
				v_reg.Mes,
				v_reg.Anyo,
				v_reg.Codigo,
				v_reg.IDEmpresa,
				SUBSTR(v_reg.Empresa,1,50),
				v_reg.IDCentro,
				SUBSTR(v_reg.Centro,1,50),
				v_reg.IDUsuario,
				SUBSTR(v_reg.Usuario,1,50),
				v_reg.IDEmpresa2,
				SUBSTR(v_reg.Empresa2,1,50),
				v_reg.IDProducto,
				SUBSTR(v_reg.Producto,1,100),
				v_reg.IDFamilia,
				SUBSTR(v_reg.Familia,1,100),
				null,
				null,
				null,
				null,
				v_reg.IDEstado,
				SUBSTR(v_reg.Estado,1,50),
				v_reg.IDTipoIncidencia,
				SUBSTR(v_reg.TipoIncidencia,1,50),
				v_reg.IDGravedadIncidencia,
				SUBSTR(v_reg.GravedadIncidencia,1,50),
				v_reg.Referencia,
				v_reg.Total,
				0
			);
			v_Count:=v_Count+1;

			FETCH v_cur INTO v_reg;
		END LOOP;


		UPDATE 		EIS_INDICADORES
			SET		EIS_IN_ACTUALIZACION=SYSDATE
			WHERE	EIS_IN_ID=p_IDIndicador;

		--	Solo debug
		--	Cuidado!!! Generaba un casque en el indicador de accesos!
		--Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicadorEIS:'||Indicador.EIS_IN_NOMBRE||' creados '||v_Count||' registros');


	END LOOP;

	--SELECT		SUM(WRITES)
	--	INTO	WRITES_FINAL
	--	FROM	V$ROLLSTAT;

	--	Solo debug
	--	Cuidado!!! Generaba un casque en el indicador de accesos!
	--Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicadorEIS: '||Indicador.EIS_IN_NOMBRE||' creados '||v_Count||' registros. Rollback: '||to_char(WRITES_FINAL-WRITES_INICIO));

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.ActualizarIndicador: '||p_IDIndicador||' Estado:'||v_Status,'',sqlcode,sqlerrm,null);
		Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicadorEIS:'||p_IDIndicador||' SQL:'||v_SQL);
END;
*/


/*
	PROCEDURE	ActualizarIndicador

	Actualiza un indicador EIS

	Se está utilizando ActualizarIndicador, para evitar confusiones comentamos este procedimiento

PROCEDURE	ActualizarIndicador2
(
	p_IDIndicador	VARCHAR2,
	p_Debug			VARCHAR2	DEFAULT 'N'	--	'S' Inserta la consulta SQL en la tabla LOGEDU
)
IS
	CURSOR	cIndicador(pID VARCHAR2)	IS
		SELECT	EIS_IN_ID, EIS_CB_CONSULTA, EIS_IN_ACUMULACION, EIS_IN_NOMBRE
		FROM	EIS_INDICADORES, EIS_CONSULTABASE
		WHERE	EIS_IN_IDCONSULTABASE=EIS_CB_ID
			AND	EIS_IN_ID=pID;

	v_cur 			REF_CURSOR;
	v_reg 			TRegResumen;
	v_Count			INTEGER;
	v_Sql			VARCHAR2(3000);
	v_Agrupar		VARCHAR2(100);
	v_Status		VARCHAR2(1000);
	v_IDRendimiento NUMBER;
	v_Operacion		VARCHAR2(100);

	v_Sqldebug			VARCHAR2(3000);--debug

	WRITES_FINAL	NUMBER;
	WRITES_INICIO	NUMBER;

BEGIN
	--	Insertamos la consulta en la tabla de lOGEDU
	IF p_Debug='S' THEN
		Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicador2:'||p_IDIndicador);
	END IF;

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CalculoIndicador v2:'||p_IDIndicador,'','EIS T');

	COMMIT;

	--20set04 ET	Ya no es necesario definir los segmentos de rollback
	--IF utilidades_PCK.Entorno='NUCLEO' THEN
	--	SET TRANSACTION USE ROLLBACK SEGMENT r_large;
	--END IF;

	--SELECT		SUM(WRITES)
	--	INTO	WRITES_INICIO
	--	FROM	V$ROLLSTAT;

	FOR Indicador IN cIndicador(p_IDIndicador) LOOP

		v_Status:=Indicador.EIS_IN_NOMBRE;


		DELETE		EIS_VALORES
			WHERE	EIS_VA_IDINDICADOR=p_IDIndicador;

		IF Indicador.EIS_IN_ACUMULACION='ID' THEN
			v_Agrupar:='ID,';
		ELSE
			v_Agrupar:='';
		END IF;

		--ET 21/5/2001 el campo a acumular lo incluimos en Indicador.EIS_IN_ACUMULACION

		--ET	28oct08	UTILIZAMOS BIND VARIABLES
		v_Sql:=	'SELECT	'|| Indicador.EIS_IN_ACUMULACION ||' Total, IDProducto, Producto, IDFamilia, Familia, IDEmpresa, Empresa, IDCentro, '
			||	'	Centro, IDEmpresa2, Empresa2, IDUsuario, Usuario, IDEstado, Estado,'
			||	'	IDTipoIncidencia, TipoIncidencia, IDGravedadIncidencia, GravedadIncidencia,'
			||	'	Referencia, Codigo, TO_CHAR(FECHA,''MM'') MES, TO_CHAR(FECHA,''YYYY'') ANYO'
			||	' FROM'
			||	' ('
			||	Indicador.EIS_CB_CONSULTA
			||	' )'
			||	' GROUP BY	'||v_Agrupar||' IDProducto, Producto, IDFamilia, Familia, IDEmpresa, Empresa, IDCentro, Centro, IDEmpresa2, '
			||	' Empresa2, IDUsuario, Usuario, IDEstado, Estado, IDTipoIncidencia, TipoIncidencia, IDGravedadIncidencia, GravedadIncidencia,Referencia, Codigo,'
			||	' TO_CHAR(FECHA,''MM''), TO_CHAR(FECHA,''YYYY'')';


		v_Count:=0;

		IF p_IDIndicador='CO_AHO_EUR' THEN								--solodebug
			utilidades_pck.debug('Indicador Informes: '||v_SQL);		--solodebug
		END IF;															--solodebug

		v_Sql:=		'INSERT	INTO EIS_VALORES('
				||	' EIS_VA_IDINDICADOR, EIS_VA_MES, EIS_VA_ANNO, EIS_VA_CODIGO, EIS_VA_IDEMPRESA, EIS_VA_EMPRESA,'
				||	' EIS_VA_IDCENTRO, EIS_VA_CENTRO, EIS_VA_IDUSUARIO, EIS_VA_USUARIO, EIS_VA_IDEMPRESA2, EIS_VA_EMPRESA2,'
				||	' EIS_VA_IDPRODUCTO, EIS_VA_PRODUCTO, EIS_VA_IDFAMILIA,	EIS_VA_FAMILIA, EIS_VA_IDNOMENCLATOR,'
				||	' EIS_VA_CCNOMENCLATOR,	EIS_VA_IDURGENCIAS, EIS_VA_URGENCIAS, EIS_VA_IDESTADO, EIS_VA_ESTADO, '
				||	' EIS_VA_IDTIPOINCIDENCIA, EIS_VA_TIPOINCIDENCIA, EIS_VA_IDGRAVEDAD, EIS_VA_GRAVEDAD, EIS_VA_REFPRODUCTO,'
				||	' EIS_VA_VALOR, EIS_VA_IDDIVISA	) '
				--||	' SELECT '''||p_IDIndicador||''', Mes, Anyo, SUBSTR(Codigo,1,50),  IDEmpresa,  SUBSTR(Empresa,1,50),'
				||	' SELECT :Indicador, Mes, Anyo, SUBSTR(Codigo,1,50),  IDEmpresa,  SUBSTR(Empresa,1,50),'
				||	' IDCentro,  SUBSTR(Centro,1,50), IDUsuario, SUBSTR(Usuario,1,50), IDEmpresa2, '
				||	' SUBSTR(Empresa2,1,50), IDProducto, SUBSTR(Producto,1,100), IDFamilia,  SUBSTR(Familia,1,100),'
				||	' null, null, null, null, IDEstado, SUBSTR(Estado,1,50), IDTipoIncidencia, '
				||	' SUBSTR(TipoIncidencia,1,50), IDGravedadIncidencia,  SUBSTR(GravedadIncidencia,1,50),'
				||	' Referencia, Total, 0'
				||	' FROM ('
				||	v_Sql
				||	')';



		--	Abre el cursor sobre esta consulta
		EXECUTE IMMEDIATE v_Sql using p_IDIndicador;

		UPDATE 		EIS_INDICADORES
			SET		EIS_IN_ACTUALIZACION=SYSDATE
			WHERE	EIS_IN_ID=p_IDIndicador;

		--	Insertamos la consulta en la tabla de lOGEDU
		IF p_Debug='S' THEN
			Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicador2:'||Indicador.EIS_IN_NOMBRE||' creados '||v_Count||' registros');
			Utilidades_PCK.Debug( 'EIS_PCK.ActualizarIndicador2:'||Indicador.EIS_IN_NOMBRE||' SQL: '||v_Sql);
		END IF;


	END LOOP;


	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
EXCEPTION
	WHEN OTHERS THEN
		MVM.StatusDBError;
		MVM.InsertDBError ('EIS_PCK.ActualizarIndicador2: '||p_IDIndicador, v_Status||' SQL:'||v_Sqldebug||' SQLERRM:'||sqlerrm);
END;
*/

--	12abr13	Nuevos niveles del cat.priv., ID y Nombre
--	19abr13	Referencias correspondientes al cat.priv.
--	!!! Revisar, este sistema requiere consultar el catalogo privado para cada consulta, seguro que se puede optimizar
PROCEDURE	InsertarValor
(
	--	Indicador
	p_IDINDICADOR			VARCHAR2,
	p_IDDocumento			VARCHAR2,		--	6may13
	--	Mes y año
	p_MES					VARCHAR2,
	p_ANNO					VARCHAR2,
	p_CODIGO				VARCHAR2,
	p_IDPAIS				VARCHAR2,		--	21nov11
	p_IDEmpresa				VARCHAR2,
	p_EMPRESA				VARCHAR2,
	p_IDCENTRO				VARCHAR2,
	p_CENTRO				VARCHAR2,
	p_IDUSUARIO				VARCHAR2,
	p_USUARIO				VARCHAR2,
	p_IDEmpresa2			VARCHAR2,	--Proveeedor en Compras, Cliente en Ventas
	p_EMPRESA2				VARCHAR2,
	p_IDCentro2				VARCHAR2,  						--10abr13
	p_Centro2				VARCHAR2,  			--10abr13
	p_IDProductoEstandar	VARCHAR2, 				--10abr13
	--p_REFPRODUCTO			VARCHAR2,
	p_IDPRODUCTO			VARCHAR2,
	p_PRODUCTO				VARCHAR2,
	p_RefProveedor			VARCHAR2, 			--10abr13
	--19abr13	p_IDFAMILIA			VARCHAR2,
	--19abr13	p_FAMILIA			VARCHAR2,
	--19abr13	p_IDNOMENCLATOR		VARCHAR2,
	--19abr13	p_CCNOMENCLATOR		VARCHAR2,
	--19abr13	p_IDURGENCIAS		VARCHAR2,
	--19abr13	p_URGENCIAS			VARCHAR2,
	p_IDESTADO				VARCHAR2,
	p_ESTADO				VARCHAR2,
	--10abr13	p_IDTipoIncidencia		VARCHAR2,
	--10abr13	p_TipoIncidencia		VARCHAR2,
	--10abr13	p_IDGravedadIncidencia	VARCHAR2,
	--10abr13	p_GravedadIncidencia	VARCHAR2,
	--	Valor de la celda
	p_VALOR					VARCHAR2,
	p_IDDIVISA				VARCHAR2	-- -1 si no es un importe monetario
)
IS
	v_ProductoEstandar	CATPRIV_PRODUCTOSESTANDAR.CP_PRO_NOMBRE%TYPE;
	v_RefCliente		CATPRIV_PRODUCTOSESTANDAR.CP_PRO_REFERENCIA%TYPE;
	v_IDGrupo			CATPRIV_GRUPOS.CP_GRU_ID%TYPE;
	v_Grupo				CATPRIV_GRUPOS.CP_GRU_NOMBRE%TYPE;
	v_RefGrupo			CATPRIV_GRUPOS.CP_GRU_REFERENCIA%TYPE;
	v_IDSubfamilia		CATPRIV_SUBFAMILIAS.CP_SF_ID%TYPE;
	v_Subfamilia		CATPRIV_SUBFAMILIAS.CP_SF_NOMBRE%TYPE;
	v_RefSubfamilia		CATPRIV_SUBFAMILIAS.CP_SF_REFERENCIA%TYPE;
	v_IDFamilia    		CATPRIV_FAMILIAS.CP_FAM_ID%TYPE;
	v_Familia			CATPRIV_FAMILIAS.CP_FAM_NOMBRE%TYPE;
	v_RefFamilia		CATPRIV_FAMILIAS.CP_FAM_REFERENCIA%TYPE;
	v_IDCategoria	 	CATPRIV_CATEGORIAS.CP_CAT_ID%TYPE;
	v_Categoria			CATPRIV_CATEGORIAS.CP_CAT_NOMBRE%TYPE;
	v_RefCategoria		CATPRIV_CATEGORIAS.CP_CAT_REFERENCIA%TYPE;
	
	v_Count				INTEGER;		--solodebug
	
	v_Parametros		VARCHAR2(1000);
BEGIN
	--	23abr13	IF p_IDEmpresa=1640 AND p_IDIndicador='CO_PED_EUR' AND p_RefProveedor IS NOT NULL THEN
	--	23abr13		utilidades_pck.debug('EIS_PCK.InsertarValor. Indicador: '||p_IDINDICADOR||' IDEMPRESA:'||p_IDEMPRESA||' IDProductoEstandar:'||p_IDProductoEstandar||' RefProveedor:'||p_RefProveedor);
	--	23abr13	END IF;

	v_Parametros:='Indicador: '||p_IDINDICADOR||' IDDocumento:'||p_IDDocumento||' IDEMPRESA:'||p_IDEMPRESA||' IDCENTRO:'||p_IDCENTRO||' IDUSUARIO:'||p_IDUSUARIO
				||' IDPROVEEDOR:'||p_IDEmpresa2||' IDProductoEstandar:'||p_IDProductoEstandar||' p_IDPRODUCTO:'||p_IDPRODUCTO
				||' MES:'||p_MES||' ANNO:'||p_ANNO||' CODIGO:'||p_CODIGO||' IDPAIS:'||p_IDPAIS
				||' RefProveedor:'||p_RefProveedor||' IDESTADO:'||p_IDESTADO
				||' VALOR:'||p_VALOR||' IDDIVISA:'||p_IDDIVISA;

	IF p_VALOR IS NOT NULL THEN
	
	--	10abr13 consulta los datos del cat.priv.
		IF p_IDProductoEstandar IS NOT NULL THEN
			SELECT 			CP_PRO_NOMBRE, NVL(CP_PRO_REFCLIENTE, CP_PRO_REFERENCIA),
							CP_GRU_ID, CP_GRU_NOMBRE, NVL(CP_GRU_REFCLIENTE, CP_GRU_REFERENCIA),
							CP_SF_ID,CP_SF_NOMBRE, NVL(CP_SF_REFCLIENTE, CP_SF_REFERENCIA),
							CP_FAM_ID,CP_FAM_NOMBRE, NVL(CP_FAM_REFCLIENTE, CP_FAM_REFERENCIA),
							CP_CAT_ID,CP_CAT_NOMBRE, NVL(CP_CAT_REFCLIENTE,CP_CAT_REFERENCIA)
				INTO		v_ProductoEstandar, v_RefCliente,
							v_IDGrupo, v_Grupo, v_RefGrupo,
							v_IDSubfamilia, v_Subfamilia, v_RefSubfamilia,
							v_IDFamilia, v_Familia, v_RefFamilia,
							v_IDCategoria, v_Categoria,v_RefCategoria
				FROM		CATPRIV_PRODUCTOSESTANDAR, CATPRIV_GRUPOS, CATPRIV_SUBFAMILIAS, CATPRIV_FAMILIAS, CATPRIV_CATEGORIAS
				WHERE	 	CP_PRO_IDGRUPO=CP_GRU_ID
				AND  		CP_GRU_IDSUBFAMILIA=CP_SF_ID
				AND  		CP_SF_IDFAMILIA=CP_FAM_ID
				AND  		CP_FAM_IDCATEGORIA=CP_CAT_ID
				AND			CP_PRO_ID=p_IDProductoEstandar;
				
				
			--	solodebug, solo insertamos si no hay una inserción previa para el mismo producto estándar
			IF v_ProductoEstandar IS NULL THEN
			
				SELECT		COUNT(*)
					INTO	v_Count
					FROM	LOGEDU
					WHERE	TXT LIKE 'EIS_PCK.InsertarValor%'||p_IDProductoEstandar||'%';
			
				IF v_Count=0 THEN
					utilidades_pck.debug('EIS_PCK.InsertarValor. Indicador: '||p_IDINDICADOR||' IDEMPRESA:'||p_IDEMPRESA||' IDProductoEstandar:'||p_IDProductoEstandar||' No se ha encontrado descripción estandar');
				END IF;
			END IF;
		END IF;
	
		INSERT	INTO EIS_VALORES
		(
			--	Indicador
			EIS_VA_IDINDICADOR,
			EIS_VA_IDDOCUMENTO,
			--	Mes y año
			EIS_VA_MES,
			EIS_VA_ANNO,
			--	Por ahora hasta 8 parametros por indicador, algunos opcionales
			EIS_VA_CODIGO,
			EIS_VA_IDPAIS,	--21nov11
			EIS_VA_IDEMPRESA,
			EIS_VA_EMPRESA,
			EIS_VA_IDCENTRO,
			EIS_VA_CENTRO,
			EIS_VA_IDUSUARIO,
			EIS_VA_USUARIO,
			EIS_VA_IDEMPRESA2,	--Proveeedor en Compras, Cliente en Ventas
			EIS_VA_EMPRESA2,
			EIS_VA_IDPRODUCTO,
			EIS_VA_PRODUCTO,
			EIS_VA_REFPROVEEDOR,
			--10abr13	EIS_VA_IDNOMENCLATOR,
			--10abr13	EIS_VA_CCNOMENCLATOR,
			--10abr13	EIS_VA_IDURGENCIAS,
			--10abr13	EIS_VA_URGENCIAS,
			EIS_VA_IDESTADO,
			EIS_VA_ESTADO,
			--10abr13	EIS_VA_IDTIPOINCIDENCIA,
			--10abr13	EIS_VA_TIPOINCIDENCIA,
			--10abr13	EIS_VA_IDGRAVEDAD,
			--10abr13	EIS_VA_GRAVEDAD,
			--	10abr13	Campos correspondientes al catálogo privado	
			EIS_VA_IDPRODESTANDAR,
			EIS_VA_PRODESTANDAR,
			EIS_VA_REFPRODUCTO,
			EIS_VA_IDGRUPO,
			EIS_VA_GRUPO,
			EIS_VA_REFGRUPO,
			EIS_VA_IDSUBFAMILIA,
			EIS_VA_SUBFAMILIA,
			EIS_VA_REFSUBFAMILIA,
			EIS_VA_IDFAMILIA,
			EIS_VA_FAMILIA,
			EIS_VA_REFFAMILIA,
			EIS_VA_IDCATEGORIA,
			EIS_VA_CATEGORIA,
			EIS_VA_REFCATEGORIA,
			EIS_VA_IDCENTRO2,
			EIS_VA_CENTRO2,
			--	Valor de la celda
			EIS_VA_VALOR,
			--17may13	EIS_VA_IDDIVISA,		-- -1 si no es un importe mo5netario
			--	Campo de texto normalizado para busquedas
			EIS_VA_TEXTONORM,
			EIS_VA_INDICEFECHA
		)
		VALUES
		(
			p_IDINDICADOR,
			p_IDDocumento,
			p_MES,
			p_ANNO,
			p_CODIGO,
			p_IDPAIS,							--	21nov11
			p_IDEmpresa	,
			SUBSTR(p_EMPRESA,1,50),
			p_IDCENTRO	,
			SUBSTR(p_CENTRO,1,50),
			p_IDUSUARIO	,
			SUBSTR(p_USUARIO,1,50),
			p_IDEmpresa2,						--Proveeedor en Compras, Cliente en Ventas
			SUBSTR(p_EMPRESA2,1,50),
			p_IDPRODUCTO,
			SUBSTR(p_PRODUCTO,1,100),
			p_RefProveedor, 					--10abr13
			--10abr13	p_IDNOMENCLATOR,
			--10abr13	p_CCNOMENCLATOR,
			--10abr13	p_IDURGENCIAS,
			--10abr13	p_URGENCIAS	,
			p_IDESTADO	,
			SUBSTR(p_ESTADO,1,50),
			--10abr13	p_IDTipoIncidencia,
			--10abr13	p_TipoIncidencia,
			--10abr13	p_IDGravedadIncidencia,
			--10abr13	p_GravedadIncidencia,
			p_IDProductoEstandar, 					--10abr13
			SUBSTR(v_ProductoEstandar,1,200), 		--12abr13
			v_RefCliente,							--19abr13
			v_IDGrupo,  							--12abr13
			SUBSTR(v_Grupo,1,100),  				--12abr13
			v_RefGrupo,								--19abr13
			v_IDSubfamilia,  						--12abr13
			SUBSTR(v_Subfamilia,1,100),  			--12abr13
			v_RefSubfamilia,
			v_IDFAMILIA,
			SUBSTR(v_FAMILIA,1,100),
			v_RefFamilia,							--19abr13
			v_IDCategoria,  						--12abr13
			SUBSTR(v_Categoria,1,100), 				--12abr13
			v_RefCategoria,							--19abr13
			p_IDCentro2,  							--10abr13
			SUBSTR(p_Centro2,1,50),  				--10abr13
			p_VALOR,
			--17may13	p_IDDIVISA,		-- -1 si no es un importe monetario
			--	8mar10	normalizar_pck.NormalizarString(p_FAMILIA||' '||p_REFPRODUCTO||' '||p_PRODUCTO)
			--	27nov12	normalizar_pck.NormalizarString(p_REFPRODUCTO||' '||p_PRODUCTO)
			SUBSTR(normalizar_pck.NormalizarID(v_RefCliente)||' '||normalizar_pck.NormalizarID(p_RefProveedor)||' '||normalizar_pck.NormalizarString(v_ProductoEstandar),1,250),
			TO_DATE('1/'||p_MES||'/'||p_ANNO,'dd/mm/yyyy')
		);

		--COMMIT;
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.InsertarValor',v_Parametros||' SQLERRM:'||sqlerrm);
END;


--	Devuelve el nombre de un cuadro de mando
--	10mar15	Según el idioma: 0:Español, 2:Portugués
FUNCTION	NombreCuadroMando
(
	p_IDCuadro 				VARCHAR2,
	p_IDIdioma 				VARCHAR2
)	RETURN VARCHAR2
IS
	--25mar17	Nombre		EIS_CUADROSDEMANDO.EIS_CM_Nombre%TYPE;
BEGIN

	RETURN Utilidades_pck.TextoMensaje(p_IDIdioma,'EIS_CM_'||p_IDCuadro);
	
	/*	25mar17
	SELECT		DECODE(p_IDIdioma, 0, EIS_CM_Nombre, 2, EIS_CM_NOMBRE_BR, EIS_CM_Nombre)
		INTO	Nombre
		FROM 	EIS_CUADROSDEMANDO
		WHERE	EIS_CM_ID=p_IDCuadro;
		
	--utilidades_pck.debug('EIS_PCK.NombreCuadroMando. IDCuadro:'||p_IDCuadro||' IDIdioma:'||p_IDIdioma||' Nombre:'||Nombre);

	RETURN	Nombre;*/
	
EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.NombreCuadroMando','IDCuadro:'||p_IDCuadro||' IDIdioma:'||p_IDIdioma||' SQLERRM:'||SQLERRM);
END;


/*
	FUNCTION	RetrasoPedido

	Devuelve:
		El pedido no se ha retrasado: 	0
		El pedido se ha retrasado: 		NUMERO ENTERO de dias de retraso
		
	SELECT	EIS_PCK.RetrasoPedido(SYSDATE-0.5, SYSDATE) FROM DUAL;
*/
FUNCTION	RetrasoPedido
(
	p_FECHAENTREGA		DATE,
	p_FECHAENTREGAREAL	DATE
)	RETURN NUMBER
IS
	Res	INTEGER:=0;
BEGIN
	-- nacho 1.7.2005
	-- los pedidos que todavia no han sido aceptados por la clinica como recibidos(total o parcialmente)
	-- no tienen informado el campo fechaentregareal (null)
	-- y no se cumple la condicion.
	-- en ese caso  asumo como fecha de entrega real la fecha actual
	IF NVL(p_FECHAENTREGAREAL,SYSDATE)>p_FECHAENTREGA THEN
		Res:=FLOOR(NVL(p_FECHAENTREGAREAL,SYSDATE)-p_FECHAENTREGA);
	END IF;
	RETURN Res;
END;

--	6feb12	Corrige directamente en las líneas de multioferta y en el EIS
--			productos con descripciones que puedan dar lugar a errores
--			Por ahora, solo para ASISA, el resto de empresas las utilizaremos para pruebas
--			El origen del problema es (NORMALIZAR_PCK.NormalizarString(EIS_VA_PRODUCTO)) que pierde algunas diferencias entre productos generando duplicados
--		EXEC EIS_PCK.ActualizarResumenEIS(60);		--> en el batch se hace el cálculo ahora con 180, pero en desarrollo es prohibitivo
--		EXEC EIS_PCK.CorregirDatosEIS;
--	22nov12	Revisamos esta función, ha generado problemas graves al borrar referencias estándar: solo corregimos la descripción estándar si el producto está emplantillado
/*
PROCEDURE	CorregirDatosEIS
IS
	v_CountEIS	INTEGER;
	v_CountMO	INTEGER;
	
	CURSOR cValores IS
		SELECT 		DISTINCT LMO_REFERENCIA REFERENCIA, LMO_NOMBRE||'|'||CP_PRO_NOMBRE||'|'||EIS_VA_PRODUCTO||'|' NOMBRE
			FROM 	lineasmultioferta, CATPRIV_PRODUCTOSESTANDAR, EIS_VALORES
			WHERE	CP_PRO_REFERENCIA=LMO_REFERENCIA 					--Join Lineas multioferta-Cat.Priv.
			AND		EIS_VA_REFPRODUCTO=LMO_REFERENCIA 					--Join Lineas multioferta-EIS
			AND 	LMO_IDMULTIOFERTA IN (SELECT MO_ID FROM MULTIOFERTAS WHERE MO_IDCLIENTE=1640 AND MO_FECHA>=TO_DATE('1/1/2012','dd/mm/yyyy'))	--	26feb13	2011
			AND 	CP_PRO_IDEMPRESA=1640
			AND		EIS_VA_IDEMPRESA=1640
			AND		EIS_VA_ANNO>=2012	--	26feb13	2011
			AND		EIS_VA_REFPRODUCTO IN
			(
				SELECT EIS_VA_REFPRODUCTO FROM
				(
					SELECT EIS_VA_REFPRODUCTO, COUNT(*) TOTAL FROM
					(
						SELECT DISTINCT EIS_VA_REFPRODUCTO, EIS_VA_PRODUCTO	
							FROM 	EIS_VALORES
							WHERE	EIS_VA_ANNO>=2012	--	26feb13	2011
							AND		EIS_VA_IDEMPRESA=1640
					)
					GROUP BY EIS_VA_REFPRODUCTO
				)
				WHERE TOTAL>=2
			)
			ORDER BY LMO_REFERENCIA;

	--	3abr12	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion	VARCHAR2(100);
BEGIN

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CorregirDatosEIS','','EIS T');

	--
	--
	--	Correcciones por duplicados en el EIS
	--
	--	Contador
	SELECT	count(*)
	INTO	v_CountEIS
	FROM	EIS_VALORES
	WHERE 	EIS_VA_ANNO IN (2011,2012)
	AND		EIS_VA_IDEMPRESA=1640
	AND		EIS_VA_REFPRODUCTO IN
	(
		SELECT EIS_VA_REFPRODUCTO FROM
		(
			SELECT EIS_VA_REFPRODUCTO, COUNT(*) TOTAL FROM
			(
				SELECT DISTINCT EIS_VA_REFPRODUCTO, EIS_VA_PRODUCTO	
					FROM 	EIS_VALORES
					WHERE	EIS_VA_ANNO>=2012
					AND		EIS_VA_IDEMPRESA=1640
			)
			GROUP BY EIS_VA_REFPRODUCTO
		)
		WHERE TOTAL>=2
	);

	IF v_CountEIS>0 THEN
	
		--	Insertamos la info en la tabla de DEBUG
		FOR r IN cValores LOOP
			MVM.InsertDBError ('EIS_PCK.CorregirDatosEIS','Error en ref:'||r.REFERENCIA||' Nombres encontrados (LMO|CP|EIS):' ||r.NOMBRE);
		END LOOP;
	
		--	Corrección
		UPDATE	EIS_VALORES
		SET		EIS_VA_PRODUCTO=(SELECT SUBSTR(CP_PRO_NOMBRE,1,100) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=EIS_VA_REFPRODUCTO AND CP_PRO_IDEMPRESA=1640)
		WHERE 	EIS_VA_ANNO>=2012
		AND		EIS_VA_IDEMPRESA=1640
		--	22nov12	Comprobar que sigue catalogado
		AND		(SELECT SUBSTR(CP_PRO_NOMBRE,1,100) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=EIS_VA_REFPRODUCTO AND CP_PRO_IDEMPRESA=1640) IS NOT NULL
		--	Comprobar referencias modificados
		AND		EIS_VA_REFPRODUCTO IN
		(
			SELECT EIS_VA_REFPRODUCTO FROM
			(
				SELECT EIS_VA_REFPRODUCTO, COUNT(*) TOTAL FROM
				(
					SELECT DISTINCT EIS_VA_REFPRODUCTO, EIS_VA_PRODUCTO	
						FROM 	EIS_VALORES
						WHERE	EIS_VA_ANNO>=2012
						AND		EIS_VA_IDEMPRESA=1640
				)
				GROUP BY EIS_VA_REFPRODUCTO
			)
			WHERE TOTAL>=2
		);
	END IF;
	
	
	--
	--	Lineas de multioferta
	--
	--	Contador
	SELECT	count(*)
	INTO	v_CountMO
	FROM	lineasmultioferta
		WHERE	LMO_IDMULTIOFERTA IN (SELECT MO_ID FROM MULTIOFERTAS WHERE MO_IDCLIENTE=1640 AND MO_FECHA>=TO_DATE('1/1/2012','dd/mm/yyyy'))	--26feb13	2011
		AND		LMO_REFERENCIA IN
		(
			SELECT LMO_REFERENCIA FROM
			(
				SELECT LMO_REFERENCIA, COUNT(*) TOTAL FROM
				(
					SELECT DISTINCT LMO_REFERENCIA, LMO_NOMBRE
						FROM 	lineasmultioferta
						WHERE	LMO_IDMULTIOFERTA IN (SELECT MO_ID FROM MULTIOFERTAS WHERE MO_IDCLIENTE=1640 AND MO_FECHA>=TO_DATE('1/1/2012','dd/mm/yyyy'))	--26feb13	2011
				)
				GROUP BY LMO_REFERENCIA
			)
			WHERE TOTAL>=2
		);

	--	Corrección
	IF v_CountMO>0 THEN
		UPDATE 		lineasmultioferta
			SET		LMO_NOMBRE=(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=LMO_REFERENCIA AND CP_PRO_IDEMPRESA=1640)
			WHERE	LMO_IDMULTIOFERTA IN (SELECT MO_ID FROM MULTIOFERTAS WHERE MO_IDCLIENTE=1640 AND MO_FECHA>=TO_DATE('1/1/2012','dd/mm/yyyy'))--26feb13	2011
			--	22nov12	Comprobar que sigue catalogado
			AND		(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=LMO_REFERENCIA AND CP_PRO_IDEMPRESA=1640) IS NOT NULL
			--	Comprobar referencias modificados
			AND		LMO_REFERENCIA IN
			(
				SELECT LMO_REFERENCIA FROM
				(
					SELECT LMO_REFERENCIA, COUNT(*) TOTAL FROM
					(
						SELECT DISTINCT LMO_REFERENCIA, LMO_NOMBRE
							FROM 	lineasmultioferta
							WHERE	LMO_IDMULTIOFERTA IN (SELECT MO_ID FROM MULTIOFERTAS WHERE MO_IDCLIENTE=1640 AND MO_FECHA>=TO_DATE('1/1/2012','dd/mm/yyyy'))--26feb13	2011
					)
					GROUP BY LMO_REFERENCIA
				)
				WHERE TOTAL>=2
			);
	END IF;

	--	Guardamos constancia del cambio realizado
	LOGADMINISTRACION_PCK.Insertar
	(
		null,
		'1',
		'EIS',
		null,
		'CorregirDatosEIS. Correcciones por duplicados:'|| v_CountEIS||' en EIS_VALORES, '|| v_CountMO||' en Multiofertas'
	);

/ *

	SELECT	DISTINCT EIS_VA_REFPRODUCTO||DUMP(EIS_VA_PRODUCTO)
		FROM 	EIS_VALORES
		WHERE	EIS_VA_ANNO>=2010
		AND	EIS_VA_IDEMPRESA=1640
		AND EIS_VA_REFPRODUCTO IN
		(
	    	'07431201',
	    	'07382130',
	    	'02020100',
	    	'05111022',
	    	'05111212',
	    	'05111032',
	    	'01030402',
	    	'01020305',
	    	'05111236',
	    	'07434108',
	    	'07321207',
			'30010907'
		)
		ORDER BY EIS_VA_REFPRODUCTO||DUMP(EIS_VA_PRODUCTO);


	--	Catálogo privado
	SELECT CP_PRO_NOMBRE
	FROM CATPRIV_PRODUCTOSESTANDAR
	WHERE CP_PRO_NOMBRE<>TRIM(CP_PRO_NOMBRE)
	AND CP_PRO_IDEMPRESA=1640;
* /

	--
	--	Correcciones por cambios en descripciones
	--

	--	Tabla de valores del EIS
	--	Contador EIS
	SELECT	count(*)
	INTO	v_CountEIS
	FROM	EIS_VALORES
	WHERE 	EIS_VA_ANNO>=2012--26feb13	2011
	AND		EIS_VA_IDEMPRESA=1640
	AND		EIS_VA_PRODUCTO<>(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=EIS_VA_REFPRODUCTO AND CP_PRO_IDEMPRESA=1640);
	
	
	--	Corrección
	IF v_CountEIS>0 THEN
		UPDATE	EIS_VALORES
		SET		EIS_VA_PRODUCTO=(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=EIS_VA_REFPRODUCTO AND CP_PRO_IDEMPRESA=1640)
		WHERE 	EIS_VA_ANNO>=2012--26feb13	2011
		AND		EIS_VA_IDEMPRESA=1640
		AND		EIS_VA_PRODUCTO<>(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=EIS_VA_REFPRODUCTO AND CP_PRO_IDEMPRESA=1640)
		AND (SELECT SUBSTR(CP_PRO_NOMBRE,1,100) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=EIS_VA_REFPRODUCTO AND CP_PRO_IDEMPRESA=1640) IS NOT NULL;
	END IF;
	
	--	Lineas de multioferta
	--	Contador
	SELECT	count(*)
	INTO	v_CountMO
	FROM	lineasmultioferta
	WHERE	LMO_IDMULTIOFERTA IN (SELECT MO_ID FROM MULTIOFERTAS WHERE MO_IDCLIENTE=1640 AND MO_FECHA>=TO_DATE('1/1/2012','dd/mm/yyyy'))	--26feb13	2011
	AND		LMO_NOMBRE<>(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=LMO_REFERENCIA AND CP_PRO_IDEMPRESA=1640)
	AND		(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=LMO_REFERENCIA AND CP_PRO_IDEMPRESA=1640) IS NOT NULL;	--	22nov12

	--	Corrección
	IF v_CountMO>0 THEN
		UPDATE 		lineasmultioferta
			SET		LMO_NOMBRE=(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=LMO_REFERENCIA AND CP_PRO_IDEMPRESA=1640)
			WHERE	LMO_IDMULTIOFERTA IN (SELECT MO_ID FROM MULTIOFERTAS WHERE MO_IDCLIENTE=1640 AND MO_FECHA>=TO_DATE('1/1/2012','dd/mm/yyyy'))	--26feb13	2011
			AND		LMO_NOMBRE<>(SELECT SUBSTR(CP_PRO_NOMBRE,1,300) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=LMO_REFERENCIA AND CP_PRO_IDEMPRESA=1640)
			AND		(SELECT SUBSTR(CP_PRO_NOMBRE,1,100) FROM CATPRIV_PRODUCTOSESTANDAR WHERE CP_PRO_REFERENCIA=LMO_REFERENCIA AND CP_PRO_IDEMPRESA=1640) IS NOT NULL;	--	22nov12
	END IF;

	--	Guardamos constancia del cambio realizado
	LOGADMINISTRACION_PCK.Insertar
	(
		null,
		'1',
		'EIS',
		null,
		'CorregirDatosEIS. Correcciones por cambios en descripciones:'|| v_CountEIS||' en EIS_VALORES, '|| v_CountMO||' en Multiofertas'
	);

	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.CorregirDatosEIS','SQLERRM:'||sqlerrm);
END;


--	3may12	Corrige todas las familias mal informadas en el EIS
/*

--	31oct12 Para deuprar el procedimiento, que da algunos problemas
EXEC EIS_PCK.ActualizarResumenEIS(60);
EXEC EIS_PCK.CorregirFamiliasEIS;



SELECT 	DISTINCT EIS_VA_IDFAMILIA||':::'||SUBSTR(EIS_VA_REFPRODUCTO,1,2)||':::'||EIS_VA_FAMILIA
FROM 	EIS_VALORES
WHERE	EIS_VA_IDEMPRESA=1640
AND	 	EIS_VA_ANNO=2012;


SELECT 		DISTINCT EIS_VA_REFPRODUCTO 
						FROM 	EIS_VALORES 
						WHERE	EIS_VA_IDEMPRESA=1640				--CP_FAM_IDEMPRESA 
						AND 	EIS_VA_FAMILIA IS NULL
						AND		EIS_VA_ANNO>=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1;

EIS_VA_REFPRODUCTO
--------------------------------------------------

KG2A
603639
KG1A
605388.1


*/
/*
PROCEDURE CorregirFamiliasEIS
IS
	--	Haremos el cambio empresa a empresa, incluyendo las borradas por si fuera necesario recuperarlas
	CURSOR cEmpresas IS
		SELECT 		EMP_ID, EMP_NOMBRE
			FROM 	EMPRESAS, TIPOSEMPRESAS
			WHERE	EMP_IDTIPO=TE_ID
			AND		TE_ROL='COMPRADOR'	--	Solo compradores
			--AND 	EMP_ID IN (SELECT DISTINCT EIS_VA_IDEMPRESA FROM EIS_VALORES WHERE EIS_VA_ANNO>=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1);--	31oct12 Para que no amplie demasiado la búsqueda
			AND 	EMP_ID IN (SELECT DISTINCT EIS_CEN_IDEMPRESA FROM EIS_CENTROS);	--	16ene13	Mejora mucho el rendimiento
			
	--	Recorremos para cada empresa las familias informadas en el EIS
	CURSOR cFamilias(IDEmpresa NUMBER) IS
	/ *	4mar13	COmpactamos la select, debería ser más eficiente
		SELECT 		CP_FAM_ID, CP_FAM_NOMBRE, CP_PRO_REFERENCIA
			FROM	CATPRIV_FAMILIAS, CATPRIV_SUBFAMILIAS, CATPRIV_PRODUCTOSESTANDAR
			WHERE	CP_PRO_IDSUBFAMILIA=CP_SF_ID
			AND		CP_SF_IDFAMILIA=CP_FAM_ID
			AND		CP_PRO_REFERENCIA IN 
					(
					SELECT 		DISTINCT EIS_VA_REFPRODUCTO 
						FROM 	EIS_VALORES 
						WHERE	EIS_VA_IDEMPRESA=CP_FAM_IDEMPRESA 
						AND 	EIS_VA_FAMILIA IS NULL
						AND		EIS_VA_ANNO>=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1	--	31oct12 Para que no amplie demasiado la búsqueda
					)
			AND		CP_FAM_IDEMPRESA=IDEmpresa;* /
			
	SELECT 			DISTINCT CP_FAM_ID, CP_FAM_NOMBRE, CP_PRO_REFERENCIA
			FROM	CATPRIV_FAMILIAS, CATPRIV_SUBFAMILIAS, CATPRIV_PRODUCTOSESTANDAR, EIS_VALORES
			WHERE	CP_PRO_IDSUBFAMILIA=CP_SF_ID
			AND		CP_SF_IDFAMILIA=CP_FAM_ID
			AND		CP_PRO_REFERENCIA=EIS_VA_REFPRODUCTO
			AND		EIS_VA_IDEMPRESA=CP_FAM_IDEMPRESA 
			AND 	EIS_VA_FAMILIA IS NULL
			AND		EIS_VA_ANNO>=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1
			AND		CP_FAM_IDEMPRESA=IDEmpresa;

	--	Recorremos las referencias estándar que todavía no han podido informarse
	CURSOR cValoresSinFamilia(IDEmpresa NUMBER) IS
		SELECT 		DISTINCT EIS_VA_REFPRODUCTO REFPRODUCTO
			FROM 	EIS_VALORES 
			WHERE	EIS_VA_FAMILIA IS NULL
			AND		LENGTH(EIS_VA_REFPRODUCTO) IN (8,9)								--	longitud válida de las ref. estándar
			AND		EIS_VA_ANNO>=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'))-1				--	22nov12
			AND 	EIS_VA_IDEMPRESA=IDEmpresa;
	
	v_IDFamilia				CATPRIV_FAMILIAS.CP_FAM_ID%TYPE;
	v_Familia				CATPRIV_FAMILIAS.CP_FAM_NOMBRE%TYPE;
	v_CountEmp				INTEGER:=0;		
	v_CountFam				INTEGER:=0;		

	--	3may12	Para calculo de rendimiento
	v_IDRendimiento NUMBER;
	v_Operacion	VARCHAR2(100);
BEGIN

	v_Operacion:=to_char(SYSDATE,'ddmmyyyyhhmiss');
	v_IDRendimiento := RENDIMIENTO_PCK.Iniciar(v_Operacion,  'CorregirFamiliasEIS','','EIS T');


	--	Recorremos las empresas
	FOR rEmp IN cEmpresas LOOP
		
		v_CountEmp:=v_CountEmp+1;
		
		/ *	nOOOOO!!!! Se utiliza el ID, no la ref
		--	Inicializamos el EIS
		UPDATE 		EIS_VALORES SET
					EIS_VA_IDFAMILIA=SUBSTR(EIS_VA_REFPRODUCTO,1,2)
			WHERE 	EIS_VA_IDEMPRESA=rEmp.EMP_ID;* /

		v_CountFam:=0;
		
		--	Recorremos las familias
		FOR rFam IN cFamilias(rEmp.EMP_ID) LOOP
		
			v_CountFam:=v_CountFam+1;
			
			--	--31oct12	CUIDADO! REACTIVAR!
			UPDATE 		EIS_VALORES SET
						EIS_VA_FAMILIA=SUBSTR(rFam.CP_FAM_NOMBRE,1,100),
						EIS_VA_IDFAMILIA=rFam.CP_FAM_ID
				WHERE 	EIS_VA_IDEMPRESA=rEmp.EMP_ID
				AND		EIS_VA_REFPRODUCTO=rFam.CP_PRO_REFERENCIA
				AND		EIS_VA_FAMILIA IS NULL;						--	Solo incializamos las que no están informadas
			
			utilidades_pck.debug( 'EIS_PCK.CorregirFamiliasEIS*1 (NombreFamilia no informado)*: Empresa:'||rEmp.EMP_ID||' Ref.producto:'||rFam.CP_PRO_REFERENCIA||'. Actualizando Familia:'||SUBSTR(rFam.CP_FAM_NOMBRE,1,100)||'('||rFam.CP_FAM_ID||')');
		
		END LOOP;
		
		
		--	Para las familias que todavía no están informadas, las informamos a partir de la ref. estándar
		FOR r IN cValoresSinFamilia(rEmp.EMP_ID) LOOP
			
			--	recupera los datos de la familia
			BEGIN
				SELECT 		CP_FAM_ID, CP_FAM_NOMBRE
					INTO	v_IDFamilia, v_Familia
					FROM	CATPRIV_FAMILIAS
					WHERE	CP_FAM_IDEMPRESA=rEmp.EMP_ID
					AND		CP_FAM_REFERENCIA=SUBSTR(r.REFPRODUCTO,1,2);
					
				--31oct12	CUIDADO! RAECTIVAR!
				UPDATE 		EIS_VALORES SET
							EIS_VA_FAMILIA=SUBSTR(v_Familia,1,100),
							EIS_VA_IDFAMILIA=v_IDFamilia
					WHERE 	EIS_VA_IDEMPRESA=rEmp.EMP_ID
					AND		EIS_VA_REFPRODUCTO=r.REFPRODUCTO;

				utilidades_pck.debug( 'EIS_PCK.CorregirFamiliasEIS*2 (IDFamilia no informado)*: Empresa:'||rEmp.EMP_ID||' Ref.producto:'||r.REFPRODUCTO||'. Actualizando Familia:'||SUBSTR(v_Familia,1,100)||'('||v_IDFamilia||')');
				
			EXCEPTION
				WHEN OTHERS THEN
					utilidades_pck.debug( 'EIS_PCK.CorregirFamiliasEIS: ERROR: Empresa:'||rEmp.EMP_NOMBRE||'. no se ha podido actualizar:'||r.REFPRODUCTO);
			END;			
		END LOOP;

		utilidades_pck.debug( 'EIS_PCK.CorregirFamiliasEIS: Empresa:'||rEmp.EMP_NOMBRE||'. Familias:'||v_CountFam);
		COMMIT;
	END LOOP;

	LOGADMINISTRACION_PCK.Insertar(1, 2, 'EIS_PCK.CorregirFamiliasEIS', null, '  Empresas tratadas:'||v_CountEmp);
	RENDIMIENTO_PCK.Terminar(v_IDRendimiento );
EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.CorregirFamiliasEIS','SQLERRM:'||sqlerrm);
END;
*/

--	21dic12	Creamos una tabla de resumen de los centros informados por indicador ya que en los informes de rendimiento esta consulta penaliza mucho
/*

	8oct14	Comprobamos un error creando esta tabla para indicadores de ventas, el problema estaba en un pedido corregido manualmente con el MO_IDUSUARIOVENDEDOR mal definido

	DELETE EIS_CENTROS WHERE EIS_CEN_IDINDICADOR='VE_PED_EUR';

	SELECT 		EIS_VA_IDCENTRO||':'||EIS_VA_IDEMPRESA
	FROM
	(
	SELECT 		DISTINCT EIS_VA_IDCENTRO, EIS_VA_IDEMPRESA,'VE_PED_EUR'
		FROM 	EIS_VALORES 
		WHERE 	EIS_VA_IDINDICADOR='VE_PED_EUR'
	) ORDER BY EIS_VA_IDCENTRO||':'||EIS_VA_IDEMPRESA;

	INSERT INTO EIS_CENTROS
	(
		EIS_CEN_ID, 
		EIS_CEN_IDEMPRESA,
		EIS_CEN_IDINDICADOR
	)
	SELECT 		DISTINCT EIS_VA_IDCENTRO, EIS_VA_IDEMPRESA,'VE_PED_EUR'
		FROM 	EIS_VALORES 
		WHERE 	EIS_VA_IDINDICADOR='VE_PED_EUR'
		AND		EIS_VA_IDCENTRO IS NOT NULL
		AND		;
		
4341:2058
4341:2230

	SELECT 		DISTINCT IDProveedor
		FROM 	vLineasPedidosCompras
		WHERE	IDCentroProveedor=4341; 
		
		
	SELECT EMP_ID||':'||EMP_NOMBRE
		FROM EMPRESAS
		WHERE EMP_ID IN(2058,2230);
	--> 2058:B. Braun Medical
	--> 2230:Braun Surgical
		
	SELECT CEN_NOMBRE, CEN_IDEMPRESA FROM CENTROS WHERE CEN_ID=4341;
	--> Vialta, 2230
	
	SELECT 		MO_ID, US_ID
		FROM	MULTIOFERTAS, USUARIOS
		WHERE	MO_IDPROVEEDOR=2058
		AND		MO_IDUSUARIOVENDEDOR=US_ID
		AND		US_IDCENTRO=4341;
	
	934267
	
*/
PROCEDURE ResumenCentros
(
	p_IDIndicador		VARCHAR2
)
IS
BEGIN
	DELETE EIS_CENTROS WHERE EIS_CEN_IDINDICADOR=p_IDIndicador;

	INSERT INTO EIS_CENTROS
	(
		EIS_CEN_ID, 
		EIS_CEN_IDEMPRESA,
		EIS_CEN_IDINDICADOR
	)
	SELECT 		DISTINCT EIS_VA_IDCENTRO, EIS_VA_IDEMPRESA,p_IDIndicador
		FROM 	EIS_VALORES 
		WHERE 	EIS_VA_IDINDICADOR=p_IDIndicador;

EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.ResumenCentros','IDIndicador:'||p_IDIndicador||' SQLERRM:'||sqlerrm);
END;


--	21dic12	Creamos una tabla de resumen de los centros informados para todos los indicadores
--	EXEC EIS_PCK.ResumenCentros;
PROCEDURE ResumenCentros
IS
	CURSOR cIndicadores IS
		SELECT EIS_IN_ID FROM EIS_INDICADORES;
BEGIN
	FOR r IN cIndicadores LOOP
		ResumenCentros(r.EIS_IN_ID);
	END LOOP;
END;

--	25abr13 Devuelve un desplegable bloqueado, para simplificar la construccion de la cabecera del EIS
PROCEDURE DesplegableBloqueado_XML
(
	p_Control		VARCHAR2,
	p_Etiqueta		VARCHAR2
)
IS
BEGIN
	--	Cabecera del desplegable
	HTP.P('<field label="'|| p_Etiqueta||'" name="'||p_Control||'" current="-1" disabled="disabled">'
		||'<dropDownList>'
		||'</dropDownList>'
		||'</field>');
END;


--	16ene14 Guarda la selección de un usuario
PROCEDURE GuardarSeleccion_XML
(
	p_IDUsuario			VARCHAR2,
	p_IDEmpresa			VARCHAR2,				--	Solo cuando la seleccion sea pública para todos los usuarios de la empresa
	p_Nombre			VARCHAR2,				--	Nombre de la selección
	p_Tipo				VARCHAR2,
	p_Seleccion			VARCHAR2,				--	IDs separados por '|'
	p_Excluir			VARCHAR2 DEFAULT NULL	--	Excluir la lista de seleccionados
)
IS
BEGIN
	EISSelecciones_pck.GuardarSeleccion_XML
	(
		p_IDUsuario,
		p_IDEmpresa,
		p_Nombre,
		p_Tipo,
		p_Seleccion,
		p_Excluir
	);
END;

--	16ene14 Borra la selección de un usuario
PROCEDURE BorrarSeleccion_XML
(
	p_IDUsuario			NUMBER,
	p_IDSeleccion		NUMBER
)
IS
BEGIN
	EISSelecciones_pck.BorrarSeleccion_XML
	(
		p_IDUsuario,
		p_IDSeleccion
	);
END;


--	12feb14	Controla errores en las lineas de pedido a nivel de la catalogación para el último año (plazo de recálculo del EIS)
--	28ago15	Comprobamos también que el campo LMO_NOMBRE esté correctamente informado, hemos tenido algunos errores con esto
--	EXEC EIS_PCK.RevisarLineasPedidos(100);
PROCEDURE RevisarLineasPedidos
(
	p_Dias		INTEGER
)
IS

	CURSOR	cLineas(Dias INTEGER) IS
		SELECT	MO_ID, LMO_ID, MO_IDCLIENTE, MO_FECHA,
				CP_FAM_IDCATEGORIA,
				CP_FAM_ID,
				CP_SF_ID,
				CP_PRO_IDGRUPO,
				CP_PRO_ID,CP_PRO_NOMBRE,
				 LMO_IDFAMILIA,
				 LMO_REFCLIENTE,
				 LMO_IDPRODUCTOESTANDAR,
				 LMO_IDSUBFAMILIA,
				 LMO_IDGRUPO,
				 LMO_IDCATEGORIA,
				 LMO_NOMBRE,
				 LMO_MARCA,
				 LMO_REFERENCIA,
				 LMO_IDPRODUCTO_NORM
			FROM 	LINEASMULTIOFERTA, MULTIOFERTAS, CATPRIV_PRODUCTOSESTANDAR, CATPRIV_SUBFAMILIAS, CATPRIV_FAMILIAS
			--	Joins
			WHERE	LMO_IDMULTIOFERTA=MO_ID
			AND		CP_SF_IDFAMILIA=CP_FAM_ID
			AND		CP_PRO_IDSUBFAMILIA=CP_SF_ID
			AND		CP_PRO_ID=LMO_IDPRODUCTOESTANDAR
			--	Ámbito
			AND		MO_FECHA>=SYSDATE-Dias
			--	Errores
			AND		
			(
						LMO_IDFAMILIA<>CP_FAM_ID
				OR		LMO_IDSUBFAMILIA<>CP_SF_ID
				OR		LMO_IDGRUPO<>CP_PRO_IDGRUPO
				OR		LMO_IDCATEGORIA<>CP_FAM_IDCATEGORIA
				OR		NVL(LMO_NOMBRE,'SINNOMBREPRODUCTO')<>NVL(CP_PRO_NOMBRE,'SINNOMBREESTANDAR')				--	28ago15, 5oct15: en el caso de NULL no se devolvían bien los datos 
				OR		LMO_IDPRODUCTO_NORM<>SUBSTR(NVL(lmo_refcliente,lmo_referencia),1,12)||':'||SUBSTR(NORMALIZAR_PCK.NormalizarID(LMO_NOMBRE),1,80)	--	30mar16
			);
		
	v_Count			INTEGER:=0;
	v_Total			INTEGER:=0;
	v_Debug			VARCHAR2(3000);
	v_Registro		VARCHAR2(3000);
BEGIN

	v_Debug:='Comprobando líneas erróneas';
	
	SELECT		count(*)
		INTO	v_Total
		FROM 	LINEASMULTIOFERTA, MULTIOFERTAS, CATPRIV_PRODUCTOSESTANDAR, CATPRIV_SUBFAMILIAS, CATPRIV_FAMILIAS
		--	Joins
		WHERE	LMO_IDMULTIOFERTA=MO_ID
		AND		CP_SF_IDFAMILIA=CP_FAM_ID
		AND		CP_PRO_IDSUBFAMILIA=CP_SF_ID
		AND		CP_PRO_ID=LMO_IDPRODUCTOESTANDAR
		--	Ámbito
		AND		MO_FECHA>=SYSDATE-p_Dias				--	TO_DATE('1/1/2013','dd/mm/yyyy')
		--	Errores
		AND		
		(
					LMO_IDFAMILIA<>CP_FAM_ID
			OR		LMO_IDSUBFAMILIA<>CP_SF_ID
			OR		LMO_IDGRUPO<>CP_PRO_IDGRUPO
			OR		LMO_IDCATEGORIA<>CP_FAM_IDCATEGORIA
			OR		NVL(LMO_NOMBRE,'SINNOMBREPRODUCTO')<>NVL(CP_PRO_NOMBRE,'SINNOMBREESTANDAR')				--	28ago15, 5oct15: en el caso de NULL no se devolvían bien los datos 
			OR		LMO_IDPRODUCTO_NORM<>SUBSTR(NVL(lmo_refcliente,lmo_referencia),1,12)||':'||SUBSTR(NORMALIZAR_PCK.NormalizarID(LMO_NOMBRE),1,80)	--	30mar16
		);

	IF v_Total>0 THEN
		
		FOR r IN cLineas(p_Dias) LOOP

			v_Count		:=v_Count+1;

			v_Registro	:='IDCLiente:'||r.MO_IDCLIENTE||' MO_ID:'||r.MO_ID||' LMO_ID:'||r.LMO_ID||' Fecha:'||r.MO_FECHA
				||' IDCategoria:'	||r.CP_FAM_IDCATEGORIA
				||' IDFamilia:'		||r.CP_FAM_ID
				||' IDSubfamilia:'	||r.CP_SF_ID
				||' IDGrupo:'		||r.CP_PRO_IDGRUPO
				||' IDProdEstandar:'||r.CP_PRO_ID
				||' Nombre:'||r.CP_PRO_NOMBRE
				||' Marca:'||r.LMO_MARCA;

			v_Debug		:='Corrigiendo línea '||v_Count||' de '||v_Total||' Situación:'||v_Registro||'.';
			
			IF	r.LMO_IDCATEGORIA<>r.CP_FAM_IDCATEGORIA THEN
				v_Debug		:=v_Debug||' IDCategoria incorrecto en linea multioferta:'||r.LMO_IDCATEGORIA;
			END IF;

			IF	r.LMO_IDFAMILIA<>r.CP_FAM_ID THEN
				v_Debug		:=v_Debug||' IDFamilia incorrecto en linea multioferta:'||r.LMO_IDFAMILIA;
			END IF;
			
			IF	r.LMO_IDSUBFAMILIA<>r.CP_SF_ID THEN
				v_Debug		:=v_Debug||' IDSubfamilia incorrecto en linea multioferta:'||r.LMO_IDSUBFAMILIA;
			END IF;
			
			IF	r.LMO_IDGRUPO<>r.CP_PRO_IDGRUPO THEN
				v_Debug		:=v_Debug||' IDGrupo incorrecto en linea multioferta:'||r.LMO_IDGRUPO;
			END IF;
			
			IF	NVL(r.LMO_NOMBRE,'SINNOMBREPRODUCTO')<>NVL(r.CP_PRO_NOMBRE,'SINNOMBREESTANDAR') THEN
				v_Debug		:=v_Debug||' Nombreproducto incorrecto en linea multioferta:'||r.LMO_NOMBRE;
			END IF;
			
			IF	r.LMO_IDPRODUCTO_NORM<>SUBSTR(NVL(r.lmo_refcliente,r.lmo_referencia),1,12)||':'||SUBSTR(NORMALIZAR_PCK.NormalizarID(r.LMO_NOMBRE),1,80) THEN
				v_Debug		:=v_Debug||' Nombreproducto normalizado incorrecto en linea multioferta:'||r.LMO_IDPRODUCTO_NORM;
			END IF;

		/*
			SELECT	
				CP_PRO_REFERENCIA||':'||CP_PRO_REFCLIENTE||':'||CP_PRO_NOMBRE
			FROM 	CATPRIV_PRODUCTOSESTANDAR
			WHERE	CP_PRO_ID=207673;

			SELECT	
				CP_GRU_REFERENCIA||':'||CP_GRU_REFCLIENTE||':'||CP_GRU_NOMBRE
			FROM 	CATPRIV_GRUPOS
			WHERE	CP_GRU_ID=83483;

			SELECT	
				CP_GRU_REFERENCIA||':'||CP_GRU_REFCLIENTE||':'||CP_GRU_NOMBRE
			FROM 	CATPRIV_GRUPOS
			WHERE	CP_GRU_ID=83075;
		*/
			UPDATE LINEASMULTIOFERTA SET
						LMO_IDFAMILIA		=r.CP_FAM_ID,
						LMO_IDSUBFAMILIA	=r.CP_SF_ID,
						LMO_IDGRUPO			=r.CP_PRO_IDGRUPO,
						LMO_IDCATEGORIA		=r.CP_FAM_IDCATEGORIA,
						LMO_NOMBRE			=SUBSTR(r.CP_PRO_NOMBRE,1,300),		--	28ago15
						LMO_IDPRODUCTO_NORM	=SUBSTR(NVL(lmo_refcliente,lmo_referencia),1,12)||':'||SUBSTR(NORMALIZAR_PCK.NormalizarID(LMO_NOMBRE),1,80)
				WHERE	LMO_ID				=r.LMO_ID;

			v_Debug:=v_Debug||'. CORREGIDO.';

			MVM.InsertDBError ('EIS_PCK.RevisarLineasPedidos', v_Debug);

			IF MOD(v_Count, 100)=0 THEN
				COMMIT;
			END IF;

		END LOOP;
		
		v_Debug:='EIS_PCK.RevisarLineasPedidos: corregidos '||v_Count||' de '||v_Total||' errores encontrados, revisar LOG ERRORES para consultar registros afectados.';
		
		mensajeria_pck.SEND_MAIL ( 'etorrellas@medicalvm.com', 'etorrellas@medicalvm.com', NULL,'[MVM] URGENTE - EIS_PCK.RevisarLineasPedidos', v_Debug ,'HTML');
		multiofertas_pck.debug(v_Debug);

	ELSE
	
		multiofertas_pck.debug('EIS_PCK.RevisarLineasPedidos: No se han encontrado errores');
	END IF;


EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.RevisarLineasPedidos',v_Debug||' SQLERRM:'||sqlerrm);
END;


--	20may14	prepara la tabla para acelerar los desplegables dinámicos
--	21may14	Antes del 1/1/2012 no está informada la estructura del cat.priv. en los pedidos
--	EXEC EIS_PCK.PrepararDesplegablesDinamicos;
PROCEDURE PrepararDesplegablesDinamicos
IS
	v_FechaInicio		DATE;
	v_Debug				VARCHAR2(1000);
BEGIN
	v_FechaInicio:=TO_DATE('1/1/2012','dd/mm/yyyy');
	
	v_Debug:='Limpiando registros.';
	DELETE EIS_DESPLEGABLESDINAMICOS;
	
	v_Debug:='Insertando CEN.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'CEN',EIS_VA_IDEMPRESA,EIS_VA_IDCENTRO,EIS_VA_CENTRO
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	
	v_Debug:='Insertando CAT.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'CAT',EIS_VA_IDEMPRESA,EIS_VA_IDCATEGORIA,EIS_VA_CATEGORIA
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	
	v_Debug:='Insertando FAM.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'FAM',EIS_VA_IDCATEGORIA,EIS_VA_IDFAMILIA,EIS_VA_FAMILIA
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	
	v_Debug:='Insertando FAMEMP.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'FAMEMP',EIS_VA_IDEMPRESA,EIS_VA_IDFAMILIA,EIS_VA_FAMILIA
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	v_Debug:='Insertando SF.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'SF',EIS_VA_IDFAMILIA,EIS_VA_IDSUBFAMILIA,EIS_VA_SUBFAMILIA
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	v_Debug:='Insertando GRU.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'GRU',EIS_VA_IDSUBFAMILIA,EIS_VA_IDGRUPO,EIS_VA_GRUPO
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	v_Debug:='Insertando PRO.';	
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'PRO',EIS_VA_IDGRUPO,EIS_VA_IDPRODESTANDAR,EIS_VA_PRODESTANDAR
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	
	v_Debug:='Insertando PROSF.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'PROSF',EIS_VA_IDSUBFAMILIA,EIS_VA_IDPRODESTANDAR,EIS_VA_PRODESTANDAR
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;
	
	
	v_Debug:='Insertando CEN2.';
	INSERT INTO EIS_DESPLEGABLESDINAMICOS
	(
		EIS_DD_IDTIPO,
		EIS_DD_IDPADRE,
		EIS_DD_ID,
		EIS_DD_NOMBRE
	)
	SELECT DISTINCT 'CEN2',EIS_VA_IDEMPRESA2,EIS_VA_IDCENTRO2,EIS_VA_CENTRO2
		FROM EIS_VALORES
		WHERE EIS_VA_IDINDICADOR='CO_PED_EUR'
		AND	EIS_VA_INDICEFECHA>=v_FechaInicio;

EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.PrepararDesplegablesDinamicos',v_Debug||' SQLERRM:'||sqlerrm);
END;


--	26ago14	Tareas para procesar durante el proceso batch, antes del cálculo de los indicadores
--	Para insertar tarea: EXEC EIS_PCK.PrepararTarea(,);
PROCEDURE PrepararTarea
(
	p_IDTipo			VARCHAR2,
	p_IDRegistro		NUMBER,
	p_IDRegistro2		NUMBER DEFAULT NULL	
)
IS
	v_Existe			INTEGER;
BEGIN

	--	Comprueba que no exista ya una tarea similar sobre el mismo registro
	--	Pensado especialmente para cambios en el catálogo privado, pero también para varias correcciones repetidas de un nombre empresa, centro, etc
	SELECT		COUNT(*)
		INTO	v_Existe
		FROM	EIS_TAREASPENDIENTES
		WHERE	SUBSTR(EIS_TP_IDTIPO,1,18)		=SUBSTR(p_IDTipo,1,18)
		AND		EIS_TP_IDREGISTRO				=p_IDRegistro
		AND		NVL(EIS_TP_IDREGISTRO2,-1)		=NVL(p_IDRegistro2,-1);
	
	IF v_Existe=0 THEN
		INSERT INTO EIS_TAREASPENDIENTES
		(
			EIS_TP_ID,
			EIS_TP_FECHA,
			EIS_TP_IDTIPO,
			EIS_TP_IDREGISTRO,
			EIS_TP_IDREGISTRO2
		)
		VALUES (EIS_TP_ID_SEQ.NEXTVAL, SYSDATE, p_IDTipo, p_IDRegistro, p_IDRegistro2);
		
	ELSE
	
		utilidades_pck.debug('EIS_PCK.PrepararTarea. IDTipo:'||p_IDTipo||' IDRegistro:'||p_IDRegistro||' Ya existe una tarea idéntica');
	END IF;
	
EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.PrepararTarea','IDTipo:'||p_IDTipo||' IDRegistro:'||p_IDRegistro||' SQLERRM:'||sqlerrm);
END;

--	26ago14	Ejecutar tareas (durante el proceso batch, antes del cálculo de los indicadores)
--			EXEC EIS_PCK.EjecutarTareas;
PROCEDURE EjecutarTareas
IS
	CURSOR cTareas IS
		SELECT * FROM EIS_TAREASPENDIENTES;
		
	v_Inicio		DATE;
	v_Res			VARCHAR2(1000);
	v_Debug			VARCHAR2(1000);
BEGIN

	FOR t IN cTareas LOOP
	
		v_Debug:='ID:'||t.EIS_TP_ID||' Tipo:'||t.EIS_TP_IDTIPO||' IDRegistro:'||t.EIS_TP_IDREGISTRO;
	
		--	Ejecuta una tarea, si no hay error guarda la info en la tabla de tareas realizadas
		v_Inicio:=SYSDATE;
		
		v_Res:=EjecutarTarea(t.EIS_TP_IDTIPO, t.EIS_TP_IDREGISTRO, t.EIS_TP_IDREGISTRO2);
		
		INSERT INTO EIS_TAREASREALIZADAS
		(
			EIS_TR_ID,
			EIS_TR_FECHA,
			EIS_TR_FECHAINICIO,
			EIS_TR_FECHAFINAL,
			EIS_TR_IDTIPO,
			EIS_TR_IDREGISTRO,
			EIS_TR_IDREGISTRO2,
			EIS_TR_RESULTADO
		)
		VALUES (t.EIS_TP_ID, t.EIS_TP_FECHA, v_Inicio, SYSDATE, t.EIS_TP_IDTIPO, t.EIS_TP_IDREGISTRO, t.EIS_TP_IDREGISTRO2, v_Res);
		
		--	Si no hay error, quitamos de la tabla de tareas pendientes
		IF SUBSTR(v_Res,1,5)<>'ERROR' THEN
			DELETE EIS_TAREASPENDIENTES WHERE EIS_TP_ID=t.EIS_TP_ID;
		END IF;
		
		COMMIT;	--	por si hay tareas muy lentas, poder controlarlas una a una
		
	END LOOP;

EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.EjecutarTareas',v_Debug||' SQLERRM:'||sqlerrm);
END;


--	26ago14	Ejecutar tareas (durante el proceso batch, antes del cálculo de los indicadores)
--	26mar15	Nuevo tipo de tareas: Catalogar proveedores de licitación
FUNCTION EjecutarTarea
(
	p_IDTipo		VARCHAR2,
	p_IDRegistro	NUMBER,
	p_IDRegistro2	NUMBER DEFAULT NULL
) RETURN VARCHAR2
IS
	v_ProductoEstandar	CATPRIV_PRODUCTOSESTANDAR.CP_PRO_NOMBRE%TYPE;
	v_RefEstandar		CATPRIV_PRODUCTOSESTANDAR.CP_PRO_REFERENCIA%TYPE;
	v_RefProveedor		PRODUCTOS.PRO_REFERENCIA%TYPE;
	v_RefCliente		CATPRIV_PRODUCTOSESTANDAR.CP_PRO_REFCLIENTE%TYPE;
	v_IDGrupo			CATPRIV_GRUPOS.CP_GRU_ID%TYPE;
	v_Grupo				CATPRIV_GRUPOS.CP_GRU_NOMBRE%TYPE;
	v_RefGrupo			CATPRIV_GRUPOS.CP_GRU_REFERENCIA%TYPE;
	v_IDSubfamilia		CATPRIV_SUBFAMILIAS.CP_SF_ID%TYPE;
	v_Subfamilia		CATPRIV_SUBFAMILIAS.CP_SF_NOMBRE%TYPE;
	v_RefSubfamilia		CATPRIV_SUBFAMILIAS.CP_SF_REFERENCIA%TYPE;
	v_IDFamilia    		CATPRIV_FAMILIAS.CP_FAM_ID%TYPE;
	v_Familia			CATPRIV_FAMILIAS.CP_FAM_NOMBRE%TYPE;
	v_RefFamilia		CATPRIV_FAMILIAS.CP_FAM_REFERENCIA%TYPE;
	v_IDCategoria	 	CATPRIV_CATEGORIAS.CP_CAT_ID%TYPE;
	v_Categoria			CATPRIV_CATEGORIAS.CP_CAT_NOMBRE%TYPE;
	v_RefCategoria		CATPRIV_CATEGORIAS.CP_CAT_REFERENCIA%TYPE;
	
	v_IDProdEstandarOrigen	CATPRIV_PRODUCTOSESTANDAR.CP_PRO_ID%TYPE;
	v_IDProdEstandarDestino	CATPRIV_PRODUCTOSESTANDAR.CP_PRO_ID%TYPE;
	
	v_IDUsuarioCatalogo	USUARIOS.US_ID%TYPE;

	v_Res				VARCHAR2(1000);
	v_Debug				VARCHAR2(1000);
BEGIN

	v_Debug:=' Tipo:'||p_IDTipo||' IDRegistro:'||p_IDRegistro;

	IF p_IDTipo IN ('CATPRIV:CAT:CAMBIONOMBRE', 'CATPRIV:CAT:CAMBIOREFCLIENTE', 'CATPRIV:CAT:CAMBIOREFERENCIA') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. CATPRIV:Actualizar info categoria. IDRegistro:'||p_IDRegistro);
		
		UPDATE		EIS_VALORES
			SET		EIS_VA_CATEGORIA=(SELECT CP_CAT_NOMBRE FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VA_IDCATEGORIA),
					EIS_VA_REFCATEGORIA=(SELECT NVL(CP_CAT_REFCLIENTE,CP_CAT_REFERENCIA)  FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VA_IDCATEGORIA)
			WHERE	(EIS_VA_CATEGORIA<>(SELECT CP_CAT_NOMBRE FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VA_IDCATEGORIA)
				OR	EIS_VA_REFCATEGORIA<>(SELECT NVL(CP_CAT_REFCLIENTE,CP_CAT_REFERENCIA)  FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VA_IDCATEGORIA))
			AND		EIS_VA_IDCATEGORIA=p_IDRegistro;
			
		--	13ago15	También actualizamos el resumen anual
		UPDATE		EIS_VALORES_ANUALES
			SET		EIS_VAN_CATEGORIA=(SELECT CP_CAT_NOMBRE FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VAN_IDCATEGORIA),
					EIS_VAN_REFCATEGORIA=(SELECT NVL(CP_CAT_REFCLIENTE,CP_CAT_REFERENCIA)  FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VAN_IDCATEGORIA)
			WHERE	(EIS_VAN_CATEGORIA<>(SELECT CP_CAT_NOMBRE FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VAN_IDCATEGORIA)
				OR	EIS_VAN_REFCATEGORIA<>(SELECT NVL(CP_CAT_REFCLIENTE,CP_CAT_REFERENCIA)  FROM CATPRIV_CATEGORIAS WHERE CP_CAT_ID=EIS_VAN_IDCATEGORIA))
			AND		EIS_VAN_IDCATEGORIA=p_IDRegistro;
			
		v_Res:='OK';
		
	ELSIF p_IDTipo IN ('CATPRIV:FAM:CAMBIONOMBRE', 'CATPRIV:FAM:CAMBIOREFCLIENTE', 'CATPRIV:FAM:CAMBIOREFERENCIA') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. CATPRIV:Actualizar info familia. IDRegistro:'||p_IDRegistro);
		
		UPDATE		EIS_VALORES
			SET		EIS_VA_FAMILIA=(SELECT CP_FAM_NOMBRE FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VA_IDFAMILIA),
					EIS_VA_REFFAMILIA=(SELECT NVL(CP_FAM_REFCLIENTE,CP_FAM_REFERENCIA)  FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VA_IDFAMILIA)
			WHERE	(EIS_VA_FAMILIA<>(SELECT CP_FAM_NOMBRE FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VA_IDFAMILIA)
				OR	EIS_VA_REFFAMILIA<>(SELECT NVL(CP_FAM_REFCLIENTE,CP_FAM_REFERENCIA)  FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VA_IDFAMILIA))
				AND	EIS_VA_IDFAMILIA=p_IDRegistro;

		--	13ago15	También actualizamos el resumen anual
		UPDATE		EIS_VALORES_ANUALES
			SET		EIS_VAN_FAMILIA=(SELECT CP_FAM_NOMBRE FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VAN_IDFAMILIA),
					EIS_VAN_REFFAMILIA=(SELECT NVL(CP_FAM_REFCLIENTE,CP_FAM_REFERENCIA)  FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VAN_IDFAMILIA)
			WHERE	(EIS_VAN_FAMILIA<>(SELECT CP_FAM_NOMBRE FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VAN_IDFAMILIA)
				OR	EIS_VAN_REFFAMILIA<>(SELECT NVL(CP_FAM_REFCLIENTE,CP_FAM_REFERENCIA)  FROM CATPRIV_FAMILIAS WHERE CP_FAM_ID=EIS_VAN_IDFAMILIA))
				AND	EIS_VAN_IDFAMILIA=p_IDRegistro;

			
		v_Res:='OK';
	
	ELSIF p_IDTipo IN ('CATPRIV:SF:CAMBIONOMBRE', 'CATPRIV:SF:CAMBIOREFCLIENTE', 'CATPRIV:SF:CAMBIOREFERENCIA') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. CATPRIV:Actualizar info subfamilia. IDRegistro:'||p_IDRegistro);
		
		UPDATE		EIS_VALORES
			SET		EIS_VA_SUBFAMILIA=(SELECT CP_SF_NOMBRE FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VA_IDSUBFAMILIA),
					EIS_VA_REFSUBFAMILIA=(SELECT NVL(CP_SF_REFCLIENTE,CP_SF_REFERENCIA)  FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VA_IDSUBFAMILIA)
			WHERE	(EIS_VA_SUBFAMILIA<>(SELECT CP_SF_NOMBRE FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VA_IDSUBFAMILIA)
				OR	EIS_VA_REFSUBFAMILIA<>(SELECT NVL(CP_SF_REFCLIENTE,CP_SF_REFERENCIA)  FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VA_IDSUBFAMILIA))
			AND		EIS_VA_IDSUBFAMILIA=p_IDRegistro;

		--	13ago15	También actualizamos el resumen anual
		UPDATE		EIS_VALORES_ANUALES
			SET		EIS_VAN_SUBFAMILIA=(SELECT CP_SF_NOMBRE FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VAN_IDSUBFAMILIA),
					EIS_VAN_REFSUBFAMILIA=(SELECT NVL(CP_SF_REFCLIENTE,CP_SF_REFERENCIA)  FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VAN_IDSUBFAMILIA)
			WHERE	(EIS_VAN_SUBFAMILIA<>(SELECT CP_SF_NOMBRE FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VAN_IDSUBFAMILIA)
				OR	EIS_VAN_REFSUBFAMILIA<>(SELECT NVL(CP_SF_REFCLIENTE,CP_SF_REFERENCIA)  FROM CATPRIV_SUBFAMILIAS WHERE CP_SF_ID=EIS_VAN_IDSUBFAMILIA))
			AND		EIS_VAN_IDSUBFAMILIA=p_IDRegistro;
			
		v_Res:='OK';
	
	ELSIF p_IDTipo IN ('CATPRIV:GRU:CAMBIONOMBRE', 'CATPRIV:GRU:CAMBIOREFCLIENTE', 'CATPRIV:GRU:CAMBIOREFERENCIA') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. CATPRIV:Actualizar info grupo. IDRegistro:'||p_IDRegistro);
		
		UPDATE		EIS_VALORES
			SET		EIS_VA_GRUPO=(SELECT CP_GRU_NOMBRE FROM CATPRIV_GRUPOS WHERE CP_GRU_ID=EIS_VA_IDGRUPO),
					EIS_VA_REFGRUPO=(SELECT NVL(CP_GRU_REFCLIENTE,CP_GRU_REFERENCIA)  FROM CATPRIV_GRUPOS WHERE CP_GRU_ID=EIS_VA_IDGRUPO)
			WHERE	(EIS_VA_GRUPO<>(SELECT CP_GRU_NOMBRE FROM CATPRIV_GRUPOS WHERE CP_GRU_ID=EIS_VA_IDGRUPO)
				OR	EIS_VA_REFGRUPO<>(SELECT NVL(CP_GRU_REFCLIENTE,CP_GRU_REFERENCIA)  FROM CATPRIV_GRUPOS WHERE CP_GRU_ID=EIS_VA_IDGRUPO))
			AND		EIS_VA_IDGRUPO=p_IDRegistro;

		--	13ago15	Aqui no actualizamos el resumen anual ya que no baja a nivel de grupo
			
		v_Res:='OK';
	
	ELSIF p_IDTipo IN ('CATPRIV:PRO:CAMBIONOMBRE', 'CATPRIV:PRO:CAMBIOREFCLIENTE', 'CATPRIV:PRO:CAMBIOREFERENCIA', 'CATPRIV:PRO:MOVERHISTORICOS') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. CATPRIV:Actualizar info producto estándar IDTipo:'||p_IDTipo||' IDRegistro:'||p_IDRegistro);
		
		v_IDProdEstandarOrigen	:=p_IDRegistro;
		
		IF p_IDTipo='CATPRIV:PRO:MOVERHISTORICOS' THEN
			--	15ago15	Habia un error y se inicializaba la variable despues del intento de UPDATE, que cascaba
			v_IDProdEstandarDestino	:=p_IDRegistro2;
			UPDATE CATPRIV_PRODUCTOS_PRODESTANDAR SET CP_PRE_IDPRODUCTOESTANDAR=v_IDProdEstandarDestino WHERE CP_PRE_IDPRODUCTOESTANDAR=v_IDProdEstandarOrigen;
			--	15ago15	v_IDProdEstandarDestino	:=p_IDRegistro2;
		ELSE
			v_IDProdEstandarDestino	:=p_IDRegistro;
		END IF;
		
		SELECT 			CP_PRO_NOMBRE, CP_PRO_REFERENCIA, NVL(CP_PRO_REFCLIENTE, CP_PRO_REFERENCIA),
						CP_GRU_ID, CP_GRU_NOMBRE, NVL(CP_GRU_REFCLIENTE, CP_GRU_REFERENCIA),
						CP_SF_ID,CP_SF_NOMBRE, NVL(CP_SF_REFCLIENTE, CP_SF_REFERENCIA),
						CP_FAM_ID,CP_FAM_NOMBRE, NVL(CP_FAM_REFCLIENTE, CP_FAM_REFERENCIA),
						CP_CAT_ID,CP_CAT_NOMBRE, NVL(CP_CAT_REFCLIENTE,CP_CAT_REFERENCIA)
			INTO		v_ProductoEstandar, v_RefEstandar, v_RefCliente,
						v_IDGrupo, v_Grupo, v_RefGrupo,
						v_IDSubfamilia, v_Subfamilia, v_RefSubfamilia,
						v_IDFamilia, v_Familia, v_RefFamilia,
						v_IDCategoria, v_Categoria,v_RefCategoria
			FROM		CATPRIV_PRODUCTOSESTANDAR, CATPRIV_GRUPOS, CATPRIV_SUBFAMILIAS, CATPRIV_FAMILIAS, CATPRIV_CATEGORIAS
			WHERE	 	CP_PRO_IDGRUPO=CP_GRU_ID
			AND  		CP_GRU_IDSUBFAMILIA=CP_SF_ID
			AND  		CP_SF_IDFAMILIA=CP_FAM_ID
			AND  		CP_FAM_IDCATEGORIA=CP_CAT_ID
			AND			CP_PRO_ID=p_IDRegistro;

		utilidades_pck.debug('EIS_PCK.EjecutarTarea. CATPRIV:Actualizar info producto estándar IDTipo:'||p_IDTipo||' IDRegistro:'||p_IDRegistro||' RefCliente:'||v_RefCliente||' DescEstandar:'||v_ProductoEstandar);
		
		--	Solo actualizamos las líneas que han sufrido cambios
    	UPDATE LINEASMULTIOFERTA SET
					LMO_IDPRODUCTOESTANDAR	=v_IDProdEstandarDestino,
            		LMO_REFCLIENTE			=v_RefCliente,
            		LMO_REFERENCIA			=v_RefEstandar,
					LMO_NOMBRE				=SUBSTR(v_ProductoEstandar,200),
            		LMO_IDCATEGORIA			=v_IDCategoria,					--	1set14
            		LMO_IDFAMILIA			=v_IDFamilia,	
            		LMO_IDSUBFAMILIA		=v_IDSubfamilia,
            		LMO_IDGRUPO				=v_IDGrupo,
            		LMO_TEXTONORM			=normalizar_pck.NormalizarReferencia(LMO_REFPROVEEDOR||' '||v_RefEstandar||' '||v_RefCliente||' '||v_ProductoEstandar),
            		LMO_IDPRODUCTO_NORM		=SUBSTR(NVL(v_RefCliente,v_RefEstandar),1,12)||':'||SUBSTR(NORMALIZAR_PCK.NormalizarID(v_ProductoEstandar),1,80)
 			WHERE	(LMO_IDPRODUCTOESTANDAR	<>v_IDProdEstandarDestino
				OR	LMO_REFCLIENTE			<>v_RefCliente
            	OR	LMO_REFERENCIA			<>v_RefEstandar
            	OR	LMO_NOMBRE				<>v_ProductoEstandar			--	1set14
           	 	OR	LMO_IDFAMILIA			<>v_IDFamilia
            	OR	LMO_IDSUBFAMILIA		<>v_IDSubfamilia
            	OR	LMO_IDGRUPO				<>v_IDGrupo)
			AND		LMO_IDPRODUCTOESTANDAR=v_IDProdEstandarOrigen;
			
		--	16ago15 Faltaba actualizar el indice de la tabla de lineas pedidos
		UPDATE LINEASPEDIDOS SET
					LPE_TEXTONORM=(SELECT LMO_TEXTONORM FROM LINEASMULTIOFERTA WHERE LPE_IDLINEAMULTIOFERTA=LMO_ID)
				WHERE	LPE_IDLINEAMULTIOFERTA IN
				(
					SELECT		LMO_ID
						FROM	LINEASMULTIOFERTA
						WHERE	LMO_IDPRODUCTOESTANDAR=v_IDProdEstandarOrigen
				)
				AND		LPE_TEXTONORM<>(SELECT LMO_TEXTONORM FROM LINEASMULTIOFERTA WHERE LPE_IDLINEAMULTIOFERTA=LMO_ID);

		--	Actualizamos todas las líneas, sino hay que poner muchas restricciones
		--	13ago15	Se producian errores con productos con nombres largos, aprovechamos para cortar todas las cadenas
		UPDATE EIS_VALORES SET 
				EIS_VA_IDPRODESTANDAR	=v_IDProdEstandarDestino,
 				EIS_VA_PRODUCTO			=SUBSTR(v_ProductoEstandar,1,100),			
 				EIS_VA_PRODESTANDAR		=SUBSTR(v_ProductoEstandar,1,200),
				EIS_VA_REFPRODUCTO		=v_RefCliente,
				EIS_VA_IDGRUPO			=v_IDGrupo,
				EIS_VA_REFGRUPO			=SUBSTR(v_RefGrupo,1,10),
				EIS_VA_GRUPO			=SUBSTR(v_Grupo,1,100),
				EIS_VA_IDSUBFAMILIA		=v_IDSubfamilia,
				EIS_VA_REFSUBFAMILIA	=SUBSTR(v_RefSubfamilia,1,10),
				EIS_VA_SUBFAMILIA		=SUBSTR(v_Subfamilia,1,100),
				EIS_VA_IDFAMILIA		=v_IDFamilia,
				EIS_VA_REFFAMILIA		=SUBSTR(v_RefFamilia,1,10),
				EIS_VA_FAMILIA			=SUBSTR(v_Familia,1,100),
				EIS_VA_IDCATEGORIA		=v_IDCategoria,
				EIS_VA_REFCATEGORIA		=SUBSTR(v_RefCategoria,1,10),
				EIS_VA_CATEGORIA		=SUBSTR(v_Categoria,1,100),
				EIS_VA_TEXTONORM		=SUBSTR(normalizar_pck.NormalizarID(v_RefCliente)||' '||normalizar_pck.NormalizarID(EIS_VA_REFPROVEEDOR)||' '||normalizar_pck.NormalizarString(v_ProductoEstandar),1,250)
		WHERE 	EIS_VA_IDPRODESTANDAR	=v_IDProdEstandarOrigen
		AND		EIS_VA_IDINDICADOR		IN
			(
				'CO_AHO_EUR',
				'CO_MUESTRAS_NUM',
				'CO_OFE_EUR',
				'CO_PEDPROG_EUR',
				'CO_PED_CANT',
				'CO_PED_EUR',
				'CO_PED_IVA_EUR',
				'CO_PED_NUM'
			);

		--	13ago15	Aqui no actualizamos el resumen anual ya que no baja a nivel de producto estándar
			
		v_Res:='OK';
		
	ELSIF p_IDTipo IN ('CATPRIV:MOVERPRODUCTOSDEGRUPO') THEN
	
		SELECT		MAX(US_ID)
			INTO 	v_IDUsuarioCatalogo
			FROM	USUARIOS, CENTROS, EMPRESAS, CATPRIV_GRUPOS
			WHERE	US_IDCENTRO=CEN_ID
			AND		CEN_IDEMPRESA=EMP_ID
			AND		CP_GRU_IDEMPRESA=EMP_ID
			AND		US_USUARIOGERENTE=1
			AND		CP_GRU_ID=p_IDRegistro;
		
		v_Res:=Catalogoprivado_Mant_Pck.MoverProductosDeUnGrupoAOtro(v_IDUsuarioCatalogo,p_IDRegistro,p_IDRegistro2,'S');

		v_Res:='OK'||'|Productos movidos:'||v_Res;
	
	ELSIF p_IDTipo IN ('CATPROV:CAMBIOREFERENCIA') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. PRODUCTO:Actualizar referencia. IDRegistro:'||p_IDRegistro);
		
		SELECT		PRO_REFERENCIA
			INTO 	v_RefProveedor
			FROM	PRODUCTOS
			WHERE	PRO_ID=p_IDRegistro;
		
    	UPDATE LINEASMULTIOFERTA SET 																																										    	 
            	LMO_REFPROVEEDOR		=v_RefProveedor,																																								    	 --
            	LMO_TEXTONORM			=normalizar_pck.NormalizarReferencia(v_RefProveedor||' '||LMO_REFERENCIA||' '||LMO_REFCLIENTE||' '||LMO_NOMBRE)
 			WHERE 	LMO_IDPRODUCTO		=p_IDRegistro
			AND		LMO_REFPROVEEDOR	<>v_RefProveedor;

		UPDATE EIS_VALORES SET 
				EIS_VA_REFPROVEEDOR		=v_RefProveedor,
				EIS_VA_TEXTONORM		=SUBSTR(normalizar_pck.NormalizarID(EIS_VA_REFPRODUCTO)||' '||normalizar_pck.NormalizarID(v_RefProveedor)||' '||normalizar_pck.NormalizarString(EIS_VA_PRODUCTO),1,250)
			WHERE 	EIS_VA_IDPRODUCTO	=p_IDRegistro
			AND		EIS_VA_REFPROVEEDOR	<>v_RefProveedor;

		--	13ago15	Aqui no actualizamos el resumen anual ya que no baja a nivel de producto estándar

		v_Res:='OK';
	
	ELSIF p_IDTipo IN ('EMPRESAS:CAMBIONOMBRE') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. EMPRESA:Actualizar nombre. IDRegistro:'||p_IDRegistro);
		
		--	NOMBRE EMPRESA
		--	24ago15	Nombres plantillas
		UPDATE		PLANTILLAS
			SET		PL_NOMBRE=(SELECT NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE) FROM EMPRESAS WHERE EMP_ID=PL_IDPROVEEDOR)
			WHERE	PL_IDPROVEEDOR=p_IDRegistro;
		
		--	1.- Campo IDEMPRESA2 para consultas de compras
		UPDATE 		EIS_VALORES
			SET 	EIS_VA_EMPRESA=(SELECT SUBSTR(NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE),1,50) FROM EMPRESAS WHERE EMP_ID=EIS_VA_IDEMPRESA)
			WHERE 	EIS_VA_IDEMPRESA=p_IDRegistro;

		--	2.- Campo IDEMPRESA2 para consultas de compras
		UPDATE 		EIS_VALORES
			SET 	EIS_VA_EMPRESA2=(SELECT SUBSTR(NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE),1,50) FROM EMPRESAS WHERE EMP_ID=EIS_VA_IDEMPRESA2)
			WHERE 	EIS_VA_IDEMPRESA2=p_IDRegistro;
			
		--	13ago15	También actualizamos el resumen anual
		--	1.- Campo IDEMPRESA2 para consultas de compras
		UPDATE 		EIS_VALORES_ANUALES
			SET 	EIS_VAN_EMPRESA=(SELECT SUBSTR(NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE),1,50) FROM EMPRESAS WHERE EMP_ID=EIS_VAN_IDEMPRESA)
			WHERE 	EIS_VAN_IDEMPRESA=p_IDRegistro;

		--	2.- Campo IDEMPRESA2 para consultas de compras
		UPDATE 		EIS_VALORES_ANUALES
			SET 	EIS_VAN_EMPRESA2=(SELECT SUBSTR(NVL(EMP_NOMBRECORTOPUBLICO, EMP_NOMBRE),1,50) FROM EMPRESAS WHERE EMP_ID=EIS_VAN_IDEMPRESA2)
			WHERE 	EIS_VAN_IDEMPRESA2=p_IDRegistro;

		--
		--	Faltaría actualizar pedidos
		--

	
		v_Res:='OK';
	
	ELSIF p_IDTipo IN ('CENTROS:CAMBIONOMBRE') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. CENTRO:Actualizar nombre. IDRegistro:'||p_IDRegistro);
		
		--
		--	Faltaría actualizar pedidos
		--
		
		--	NOMBRE CENTRO
		--	1.- Campo centro
		UPDATE 		EIS_VALORES
			SET 	EIS_VA_CENTRO=(SELECT SUBSTR(NVL(CEN_NOMBRECORTO, CEN_NOMBRE),1,50) FROM CENTROS WHERE CEN_ID=EIS_VA_IDCENTRO)
			WHERE 	EIS_VA_IDCENTRO=p_IDRegistro; 

		--	2.- Campo IDCENTRO2 para consultas de ventas
		UPDATE 		EIS_VALORES
			SET 	EIS_VA_CENTRO2=(SELECT SUBSTR(NVL(CEN_NOMBRECORTO, CEN_NOMBRE),1,50) FROM CENTROS WHERE CEN_ID=EIS_VA_IDCENTRO2)
			WHERE 	EIS_VA_IDCENTRO2=p_IDRegistro;

		--	13ago15	También actualizamos el resumen anual
		--	1.- Campo centro
		UPDATE 		EIS_VALORES_ANUALES
			SET 	EIS_VAN_CENTRO=(SELECT SUBSTR(NVL(CEN_NOMBRECORTO, CEN_NOMBRE),1,50) FROM CENTROS WHERE CEN_ID=EIS_VAN_IDCENTRO)
			WHERE 	EIS_VAN_IDCENTRO=p_IDRegistro; 

		--	2.- Campo IDCENTRO2 para consultas de ventas
		UPDATE 		EIS_VALORES_ANUALES
			SET 	EIS_VAN_CENTRO2=(SELECT SUBSTR(NVL(CEN_NOMBRECORTO, CEN_NOMBRE),1,50) FROM CENTROS WHERE CEN_ID=EIS_VAN_IDCENTRO2)
			WHERE 	EIS_VAN_IDCENTRO2=p_IDRegistro;
	
		v_Res:='OK';
		
	ELSIF p_IDTipo IN ('PLANTILLA:COPIAR') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. PLANTILLA:Copiar a otra empresa. IDPlantilla:'||p_IDRegistro||' IDClienteDestino:'||p_IDRegistro2);

		v_Res:=CatalogoAutomatico_pck.CopiarPlantilla(1,p_IDRegistro,p_IDRegistro2);
		
		v_Res:='OK'||'|'||v_Res;

	ELSIF p_IDTipo IN ('LICITACION:CATALOGARPROVEEDORES') THEN
		
		utilidades_pck.debug('EIS_PCK.EjecutarTarea. LICITACIONES:Catalogar proveedores. IDLicitacion:'||p_IDRegistro);

		v_Res:=LICITACIONES_PCK.CrearCatalogoProveedor(1, p_IDRegistro, NULL, 'N', NULL);	--10abr15	faltaba la 'N' entre los 2 NULL
		
		v_Res:='OK'||'|'||v_Res;
	END IF;
	
	RETURN v_Res;

EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.EjecutarTarea',v_Debug||' SQLERRM:'||sqlerrm);
		RETURN 'ERROR:'||sqlerrm;
END;


--	16feb15 Comprueba si el año actual está en la tabla de anyos, si no lo inserta
PROCEDURE ControlCambioAnyo
IS
	v_AnyoActual	NUMBER(4);
	v_Existe		INTEGER;
BEGIN
	v_AnyoActual:=TO_NUMBER(TO_CHAR(SYSDATE,'yyyy'));
	
	SELECT		COUNT(*)
		INTO	v_Existe
		FROM	EIS_ANYOS
		WHERE	EIS_AN_ID=v_AnyoActual;
		
	IF v_Existe=0 THEN
		INSERT INTO	EIS_ANYOS(EIS_AN_ID) VALUES (v_AnyoActual);
	END IF;

EXCEPTION
	WHEN OTHERS THEN
		MVM.InsertDBError ('EIS_PCK.ControlCambioAnyo','SQLERRM:'||sqlerrm);
END;


END;	--	EIS_PCK
/

SHOW ERRORS;
EXIT;
