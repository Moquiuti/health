//	Libreria basica para la manipulacion de documentos XML desde Javascript
//	Utiliza JS puro, no requiere JQuery
//	ET enero 2017

//	LIBRERIA EN DESARROLLO
//	http://www.w3schools.com/xml/dom_nodes_access.asp

//	Ultima revision: ET 16feb17 12:13



//	Parecía que el nodo no limpiaba correctamente los caracteres especiales
function LimpiarCadena(Cadena)
{
	var Res=Cadena.replace('\n','');
	var Res=Res.replace('\r','');
	var Res=Res.replace('\t','');
	
	if (Res!=Cadena)	console.log('LimpiarCadena:'+Cadena+' -> '+Res);
	
	return Res;
}


//	Busca un valor a partir del XSPath, pendiente de aceptar atributos
function obtenerValorPorPath(xmlDoc, Path)
{
	var avancePath=Path,
		nombreNodo,
		Pos=0,count=0,
		posIndice,posIndice2,
		cadIndice,
		Indice,
		Res='';

	//console.log('obtenerValorPorPath Path:'+Path);
	
	//	Recorre el path
	Pos=avancePath.indexOf('/');
	
	//	Si la cadena empieza por "/" quitamos este [PENDIENTE]
	//if (Pos==1)
	//	avancePath=avancePath.substring(Pos+1);

	while ((Pos>0) && (count<100))	//	100 niveles, para evitar errores
	{
		var nodoActual;
		
		count+=1;
		
		nombreNodo=avancePath.substring(0, Pos);
		
		//	Comprueba si aparece un indice de tipo [x]
		posIndice=nombreNodo.indexOf('[');
		if (posIndice>0)
		{

			posIndice2=nombreNodo.indexOf(']');
		
			cadIndice=avancePath.substring(posIndice+1,posIndice2);
			
			//console.log('obtenerValorPorPath INDICE1 nombreNodo:'+nombreNodo+' cadIndice:'+cadIndice);
			
			Indice=parseInt(cadIndice);
		
			nombreNodo=avancePath.substring(0, posIndice);

			//console.log('obtenerValorPorPath INDICE2 nombreNodo:'+nombreNodo+' Indice:'+Indice);
			
		}
		else
			Indice=0;
		
		nodoActual=obtenerNodo(xmlDoc, nombreNodo, Indice);
		
		avancePath=avancePath.substring(Pos+1);

		//console.log('obtenerValorPorPath FINAL nombreNodo:'+nombreNodo+' Indice:'+Indice+' valor:'+nodoActual.nodeValues);
	
		Pos=avancePath.indexOf('/');
	}
	
	Res=obtenerValor(nodoActual, avancePath, 0);

	//console.log('obtenerValorPorPath Path:'+Path+' Res:'+Res);
		
	return LimpiarCadena(Res);
}

//	Busca un valor a partir del XSPath, pendiente de aceptar atributos
function obtenerNodoPorPath(xmlDoc, Path)
{
	var avancePath=Path,
		nombreNodo,
		Pos=0,count=0,
		posIndice,posIndice2,
		cadIndice,
		Indice,
		Res='';

	//console.log('obtenerNodoPorPath Path:'+Path);
	
	//	Recorre el path
	Pos=avancePath.indexOf('/');
	
	//	Si la cadena empieza por "/" quitamos este [PENDIENTE]
	//if (Pos==1)
	//	avancePath=avancePath.substring(Pos+1);
	
	while ((Pos>0) && (count<100))	//	100 niveles, para evitar errores
	{
		var nodoActual;
		
		count+=1;
		
		nombreNodo=avancePath.substring(0, Pos);

		//	Comprueba si aparece un indice de tipo [x]
		posIndice=nombreNodo.indexOf('[');
		if (posIndice>0)
		{

			posIndice2=nombreNodo.indexOf(']');
		
			cadIndice=avancePath.substring(posIndice+1,posIndice2);
			
			//console.log('obtenerValorPorPath INDICE1 nombreNodo:'+nombreNodo+' cadIndice:'+cadIndice);
			
			Indice=parseInt(cadIndice);
		
			nombreNodo=avancePath.substring(0, posIndice);

			//console.log('obtenerValorPorPath INDICE2 nombreNodo:'+nombreNodo+' Indice:'+Indice);
			
		}
		else
			Indice=0;


		nodoActual=obtenerNodo(xmlDoc, nombreNodo, Indice);
		
		avancePath=avancePath.substring(Pos+1);

		//try {
		//	console.log('obtenerNodoPorPath Path:'+Path+' nombreNodo:'+nombreNodo+' valor:'+nodoActual.nodeValues);
		//}
		//catch(err) {
		//	console.log('obtenerNodoPorPath ERROR Path:'+Path+' nombreNodo:'+nombreNodo+' err:'+err);
		//}
		
		Pos=avancePath.indexOf('/');
	}
	
	nodoRes=obtenerNodo(nodoActual, avancePath, 0);
		
	return nodoRes;
}

function obtenerValor(xmlDoc, nombreTag, Indice)
{
	var Res='';
	
	//console.log('obtenerValor nombreTag:'+nombreTag);
	try {
		if (xmlDoc.getElementsByTagName(nombreTag).length>0)
		{
			Res=xmlDoc.getElementsByTagName(nombreTag)[Indice].childNodes[0].nodeValue;
			//console.log('obtenerValor nombreTag:'+nombreTag+' arraylength:'+xmlDoc.getElementsByTagName(nombreTag).length+' value['+Indice+']:'+Res);
		}
	}
	catch(err) {
    	console.log('obtenerValor nombreTag:'+nombreTag+' value['+Indice+']:'+' NO ENCONTRADO');
    	console.log('obtenerValor CONTROL xmlDoc:'+xmlDoc.innerHTML+' nombreTag:'+nombreTag+' value['+Indice+']:'+' NO ENCONTRADO');
	}
	//else
	//	Res='';
		
	return LimpiarCadena(Res);
}

function obtenerNodo(xmlDoc, nombreTag, Indice)
{
	var nodoRes='';
	
	//console.log('obtenerNodo nombreTag:'+nombreTag);
	try {
		if (xmlDoc.getElementsByTagName(nombreTag).length>0)
		{
			nodoRes=xmlDoc.getElementsByTagName(nombreTag)[Indice];
			//console.log('obtenerNodo nombreTag:'+nombreTag+' arraylength:'+xmlDoc.getElementsByTagName(nombreTag).length);
		}
	}
	catch(err) {
    	console.log('obtenerNodo nombreTag:'+nombreTag+' value['+Indice+']:'+' NO ENCONTRADO');
    	console.log('obtenerValor CONTROL xmlDoc:'+xmlDoc.innerHTML+' nombreTag:'+nombreTag+' value['+Indice+']:'+' NO ENCONTRADO');
	}
	//else
	//	nodoRes='';
		
	return nodoRes;
}

