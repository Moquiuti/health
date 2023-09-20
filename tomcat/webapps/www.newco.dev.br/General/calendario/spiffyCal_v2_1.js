// Variables Globales

var scImgPath = 'http://www.newco.dev.br/images/calendario/';

var scIE=((navigator.appName == "Microsoft Internet Explorer") || ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion)==5)));
var scNN6=((navigator.appName == "Netscape") && (parseInt(navigator.appVersion)==5));
var scNN=((navigator.appName == "Netscape")&&(document.layers));

//var img_Del=new Image();
//var img_Close=new Image();

//var img_Prev=new Image();
//var img_Next=new Image();

//img_Del.src= scImgPath +"btn_del_small_gif";
//img_Close.src= scImgPath +"btn_close_small_gif";

//img_Prev.src= scImgPath +"btn_prev_gif";
//img_Next.src= scImgPath +"btn_next_gif";

var scBTNMODE_DEFAULT=0;
var scBTNMODE_CUSTOMBLUE=1;
var scBTNMODE_CALBTN=2;
var scBTNMODE_CLASSIC=3;

var focusHack;

/*

     calendar manager

*/

function spiffyCalManager() {

	this.showHelpAlerts = true;
	this.defaultDateFormat='d/M/yyyy';
	this.lastSelectedDate=new Date();
	this.calendars=new Array();
	this.matchedFormat="";
	this.DefBtnImgPath=scImgPath; //'./js/common/calendar/';


	this.getCount= new Function("return this.calendars.length;");

	function addCalendar(objWhatCal) {
		var intIndex = this.calendars.length;
		this.calendars[intIndex] = objWhatCal;
	}
	this.addCalendar=addCalendar;


	function hideAllCalendars(objExceptThisOne) {
		var i=0;
		for (i=0;i<this.calendars.length;i++) {
			if (objExceptThisOne!=this.calendars[i]) {
				this.calendars[i].hide();
			}
		}

	}
	this.hideAllCalendars=hideAllCalendars;

	function swapImg(objWhatCal, strToWhat, blnStick) {

		if (document.images) {
			//return true;
			// this makes it so that the button sticks down when the cal is visible
			if ((!(objWhatCal.visible) || (blnStick))&& (objWhatCal.enabled)) {
				document.images[objWhatCal.btnName].src = eval(objWhatCal.varName+strToWhat + ".src");
				return true;
				/*
				document.images[objWhatCal.btnName].src = eval(objWhatCal.varName+strToWhat + ".src");
				*/
			}
		}
		window.status=' ';
	}
	this.swapImg=swapImg;

	// vacaciones

	//this.Holidays = new Array("Dec-25","Jul-4", "Feb-14","Mar-17","Oct-31");
	//this.HolidaysDesc = new Array("Christmas Day","Independance Day","Valentine's Day","St. Patrick's Day","Halloween");

	this.Holidays = new Array();
	this.HolidaysDesc = new Array();

	function isHoliday(whatDate) {
		var i=0;var found=-1;
		for (i=0;i<this.Holidays.length;i++) {
			if (whatDate==this.Holidays[i]) {
				found=i;
				break;
			}
		}
		return found;
	}
	this.isHoliday=isHoliday;


	this.AllowedFormats = new Array('d/M/yyyy','d/MM/yyyy','dd/MM/yyyy');
	MONTH_NAMES = new Array('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre','Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic');

	this.lastBoxValidated=null;
	this.validateDate=validateDate;


	function validateDate(eInput, bRequired, nombreCalendario, dStartDate, dEndDate){
	  //alert('eInput: '+eInput+' bRequired: '+bRequired+' dStartDate: '+dStartDate+' dEndDate: '+dEndDate);


		var i = 0;
		var strTemp='';
		var formatMatchCount=0;
		var firstMatchAt=0;
		var secondMatchAt=0;
		var bOK = false;
		var bIsEmpty=false;



		/*
		  nacho:
		  si usamos rangos de fechas creamos la cadena con dichas fechas

		*/

		var fechaMin=formatoFecha(dStartDate,'I','E');
		var fechaMax=formatoFecha(dEndDate,'I','E');

		dStartDate=new Date(dStartDate);
		dEndDate=new Date(dEndDate);



		if(this.calendars[this.obtenerIndiceCalendario(nombreCalendario)].useDateRange){


		  var strStart=dStartDate.getDate()+'/'+(Number(dStartDate.getMonth())+1)+'/'+dStartDate.getFullYear();
		  var strEnd=dEndDate.getDate()+'/'+(Number(dEndDate.getMonth())+1)+'/'+dEndDate.getFullYear();

		  var rangeMsg = 'La '+this.calendars[this.obtenerIndiceCalendario(nombreCalendario)].labelCalendario+' debe estar comprendida entre:\n\n   '+
		      strStart+' y '+strEnd+'\n\nPor favor, introduzca una fecha correcta.';
		}

	  /*
	    fin-nacho
	  */

		this.lastBoxValidated=eInput;
		this.matchedFormat="";
		bIsEmpty=(eInput.value=='' || eInput.value==null);
		if (!(bRequired && bIsEmpty)) {
			for(i=0;i<this.AllowedFormats.length;i++){
       //alert('checking=eInput.value='+eInput.value+'  this.AllowedFormats[i]='+this.AllowedFormats[i]+'\nisDate='+isDate(eInput.value, this.AllowedFormats[i]));
				if (isDate(eInput.value, this.AllowedFormats[i])==true){
					bOK = true;
					formatMatchCount+=1;
					if (formatMatchCount==1) {firstMatchAt=i;}
					if (formatMatchCount>1) {

						if (this.AllowedFormats[i].substr(0,1)!=this.AllowedFormats[firstMatchAt].substr(0,1)) {
							secondMatchAt=i; break;
						}
						else { // don't count same format with padded zeros as a different format
							formatMatchCount=1;
						}
					}
				}
			}
		}
		if (formatMatchCount>1){

			if (this.showHelpAlerts) {

				var date1=getDateFromFormat(eInput.value,this.AllowedFormats[firstMatchAt]);
				var choice1 = date1.getDate()+'/'+(Number(date1.getMonth())+1)+'/'+date1.getFullYear();
				var date2=getDateFromFormat(eInput.value,this.AllowedFormats[secondMatchAt]);
				var choice2 = date2.getDate()+'/'+(Number(date2.getMonth())+1)+'/'+date2.getFullYear();
				if (date1.getTime()!=date2.getTime()) {
					var Msg='Ha introducido una fecha ambigua.\n\n Click Aceptar para:\n'+ choice1 +'\n\no Click Cancelar para:\n'+choice2;
					if (confirm(Msg)) {
						bOK=true;
					}
					else {
						firstMatchAt=secondMatchAt;
						bOK=true;
						//return false;
					}
					eInput.focus();
					eInput.select();
				}
			}
			else {
				// continue and take first match in list
				bOK=true;
			}
		}
		if (bOK==true) {
			eInput.className = "cal-TextBox";
			//Check for Start/End Dates

			if (dStartDate!=null) {
				var dThis = getDateFromFormat(eInput.value,this.AllowedFormats[firstMatchAt]);
				if (dStartDate>dThis){
					eInput.className = "cal-TextBoxInvalid";
					if (this.showHelpAlerts) { alert(rangeMsg);}
					eInput.value=fechaMin;
					eInput.focus();
					eInput.select();
					return false;
				}
			}
			if (dEndDate!=null) {
				var dThis = getDateFromFormat(eInput.value,this.AllowedFormats[firstMatchAt]);
				if (dEndDate<dThis) {
					eInput.className = "cal-TextBoxInvalid";
					if (this.showHelpAlerts) {  alert(rangeMsg);}
					eInput.value=fechaMin;
					eInput.focus();
					eInput.select();
					return false;
				}
			}

			/* controlamos los fines de semana */
			if(this.calendars[this.obtenerIndiceCalendario(nombreCalendario)].disableWeekends){


			   var tempDt=obtenerSubCadena(eInput.value,1)+'/'+obtenerSubCadena(eInput.value,2);
			   var intWhatYear=obtenerSubCadena(eInput.value,3);

			  if(this.isWeekend(tempDt,intWhatYear)){
			    /* calculamos el siquiente dia laborable tambien controlamos los casos de vacaciones
			       para ello usamos el flag 'controlarVacacionesEnCalculos'  // no se usa no hay ningun array asigando
			     */
			     var fFecha=new Date(formatoFecha(eInput.value,'E','I'));
			     //fFecha=this.sumaDiasAFecha(fFecha,1);
			     fFecha=this.calcularDiasHabiles(fFecha,1, this.calendars[this.obtenerIndiceCalendario(nombreCalendario)].controlarVacacionesEnCalculos);
			     alert('La '+this.calendars[this.obtenerIndiceCalendario(nombreCalendario)].labelCalendario+' Introducida no corresponde con un d�a laborable.\nSe ha cogido la siguiente fecha correspondiente a un d�a laborable: '+convertirFechaATexto(fFecha));
			     eInput.value=convertirFechaATexto(fFecha);

			     //eInput.focus();
					 //eInput.select();
				   //return false;

				   eInput.focus();
			     eInput.select();
			     focusHack=eInput;
			     setTimeout('focusHack.focus();focusHack.select();');
			     return false;

			  }
			}


			this.matchedFormat=this.AllowedFormats[firstMatchAt];

			this.lastBoxValidated = null;
		}
		else {

			if (bRequired && bIsEmpty) {
				eInput.className = "cal-TextBoxInvalid";
				if (this.showHelpAlerts) {
					alert('El Campo '+this.calendars[this.obtenerIndiceCalendario(nombreCalendario)].labelCalendario+' es obligatorio.\n\nPor favor, introduzca una fecha v�lida antes de continuar.');
				}
			}
			else {
				if (!bRequired && bIsEmpty) {
					eInput.className = "cal-TextBox";
				}
				else {
					eInput.className = "cal-TextBoxInvalid";
					if (this.showHelpAlerts) {
						for(i=0;i<this.AllowedFormats.length;i++){
							strTemp+=this.AllowedFormats[i]+'\t';
						}
						//alert('Por favor, introduzca una fecha v�lida.\n\nEjemplo 01/02/2002\n\nlos formatos v�lidos son:\n\n'+strTemp);
						null;
					}
				}
			}
			eInput.focus();
			eInput.select();
			focusHack=eInput;

			setTimeout('focusHack.focus();focusHack.select();');
			return false;
		}
	}
	this.validateDate=validateDate;



	function isWeekend(whatDate,intWhatYear){

   var fechaTemp=formatDateNacho(whatDate,'dd/MM');
	 var fechaAnyoTemp=formatDateNacho(whatDate+'/'+intWhatYear,'dd/MM/yyyy');

	 var fecha;

	 if(fechaAnyoTemp==''){
	   fecha=fechaTemp;
	 }
	 else{
	   fecha=fechaAnyoTemp;
	 }

		var fFecha=new Date(formatoFecha(fecha,'E','I'));

		if(fFecha.getDay()==0 || fFecha.getDay()==6){
		  esFinde=1;
		}
		else{
		  esFinde=0;
		}

		return esFinde;
	}
	this.isWeekend=isWeekend;



	function formatDateNacho(valor, strFormat) {

		var valorTmp='';
		var fValorTmp;

		var ArrayFormatosTmp = new Array('d/M/yyyy','d/MM/yyyy','dd/M/yyyy','dd/MM/yyyy','d/M','d/MM','dd/M','dd/MM');
		var i = 0;
		var formatMatchCount=0;
		var firstMatchAt=0;
		var secondMatchAt=0;
		var bOK = false;

		for(i=0;i<ArrayFormatosTmp.length;i++){
		  if(isDate(valor, ArrayFormatosTmp[i])==true){
		    bOK = true;
			  formatMatchCount+=1;
				if(formatMatchCount==1){
				  firstMatchAt=i;
				}
				if(formatMatchCount>1){
				  if(ArrayFormatosTmp[i].substr(0,1)!=ArrayFormatosTmp[firstMatchAt].substr(0,1)){
					  secondMatchAt=i;
					  break;
					}
					else{ // don't count same format with padded zeros as a different format
					  formatMatchCount=1;
					}
				}
			}
		}
		if(bOK){
		  var fValorTmp = getDateFromFormat(valor,ArrayFormatosTmp[firstMatchAt]);
		  valorTmp= scFormatDate(fValorTmp, strFormat)
		}
		return valorTmp;
	}
	this.formatDateNacho=formatDateNacho;



	function calcularDiasHabiles(hoy,incremento, conVacaciones){



      // conVacaciones  tenemos en cuenta los dias marcados como vacaciones para los calculos (los tratamos como fin de semana)
   var fechaResultado=hoy;
   var incrementoDiasHabiles=0;

   if(incremento>=0){
     while(incrementoDiasHabiles<incremento){
       fechaResultado=sumaDiasAFecha(fechaResultado,1);
         /* es dia laborable*/
       if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6){
          /* controlamos las vacaciones */
         if(conVacaciones){
              /* no esta marcado como vacaciones */

              var tempDt=obtenerSubCadena(convertirFechaATexto(fechaResultado),1)+'/'+obtenerSubCadena(convertirFechaATexto(fechaResultado),2);
			        var intWhatYear=obtenerSubCadena(convertirFechaATexto(fechaResultado),3);



           if(this.isHoliday(tempDt,intWhatYear)==-1){
             incrementoDiasHabiles++;
           }
         }
         else{
             /* no lo controlamos, se contabiliza el dia */
           incrementoDiasHabiles++;
         }
       }
       else{
         /* es finde */
         null;
         /* no hacemos nada*/
       }
     }
   }
   else{
     while(incrementoDiasHabiles>incremento){
       fechaResultado=sumaDiasAFecha(fechaResultado,-1);
         /* es dia laborable */
       if(fechaResultado.getDay()!=0 && fechaResultado.getDay()!=6){
         /* controlamos las vacaciones */
         if(conVacaciones){
          /* no esta marcado como vacaciones */

              var tempDt=obtenerSubCadena(convertirFechaATexto(fechaResultado),1)+'/'+obtenerSubCadena(convertirFechaATexto(fechaResultado),2);
			        var intWhatYear=obtenerSubCadena(convertirFechaATexto(fechaResultado),3);

           if(this.isHoliday(tempDt,intWhatYear)==-1){
             incrementoDiasHabiles--;
           }
         }
         else{
             /* no lo controlamos, se contabiliza el dia */
           incrementoDiasHabiles--;
         }
       }
     }
   }

   return(fechaResultado);
 }
 this.calcularDiasHabiles=calcularDiasHabiles;



	/*
	  funcion que obtiene el indice del calendario en funcion dela posicion que ocupa en el array a partir de su nombre
	*/



	function obtenerIndiceCalendario(nombreCalendario){
	  for(var n=0;n<this.calendars.length;n++){
	    if(this.calendars[n].varName==nombreCalendario){
	      return n;
	    }
	  }
	}
  this.obtenerIndiceCalendario=obtenerIndiceCalendario;


	function formatDate(eInput, strFormat) {
		//Always called directly following validateDate  - put validate in onchange and format in onblur.
		if(this.matchedFormat!="") {
			var d = getDateFromFormat(eInput.value,this.matchedFormat);
			if(d!=0){
				eInput.value = scFormatDate(d, strFormat);
			}
		}
	}
	this.formatDate=formatDate;

	function isDate(val,format) {
		var date = getDateFromFormat(val,format);
		if (date == 0) { return false; }
		return true;
	}
	this.isDate=isDate;


	function scFormatDate(date,format) {
		format = format+"";
		var result = "";
		var i_format = 0;
		var c = "";
		var token = "";
		var y = date.getFullYear()+"";
		var M = date.getMonth()+1;
		var d = date.getDate();
		var h = date.getHours();
		var m = date.getMinutes();
		var s = date.getSeconds();
		var yyyy,yy,MMM,MM,dd;
		// Convert real date parts into formatted versions
		// Year
		if (y.length < 4) {
			y = y-0+1900;
			}
		y = ""+y;
		yyyy = y;
		yy = y.substring(2,4);
		// Month
		if (M < 10) { MM = "0"+M; }
			else { MM = M; }
		MMM = MONTH_NAMES[M-1+12];
		// Date
		if (d < 10) { dd = "0"+d; }
			else { dd = d; }
		// Now put them all into an object!
		var value = new Object();
		value["yyyy"] = yyyy;
		value["yy"] = yy;
		value["y"] = y;
		value["MMM"] = MMM;
		value["MM"] = MM;
		value["M"] = M;
		value["dd"] = dd;
		value["d"] = d;

		while (i_format < format.length) {
			// Get next token from format string
			c = format.charAt(i_format);
			token = "";
			while ((format.charAt(i_format) == c) && (i_format < format.length)) {
				token += format.charAt(i_format);
				i_format++;
				}
			if (value[token] != null) {
				result = result + value[token];
				}
			else {
				result = result + token;
				}
			}
		return result;
	}
	this.scFormatDate=scFormatDate;

	function _isInteger(val) {
		var digits = "1234567890";
		for (var i=0; i < val.length; i++) {
			if (digits.indexOf(val.charAt(i)) == -1) { return false; }
			}
		return true;
	}

	function _getInt(str,i,minlength,maxlength) {
		for (x=maxlength; x>=minlength; x--) {
			var token = str.substring(i,i+x);
			if (_isInteger(token)) {
				return token;
				}
			}
		return null;
	}

	function getDateFromFormat(val,format) {
		val = val+"";
		format = format+"";
		var i_val = 0;
		var i_format = 0;
		var c = "";
		var token = "";
		var token2= "";
		var x,y;
		var year  = 0;
		var month = 0;
		var date  = 0;
		var bYearProvided = false;
		while (i_format < format.length) {
			// Get next token from format string
			c = format.charAt(i_format);
			token = "";

			while ((format.charAt(i_format) == c) && (i_format < format.length)) {
				token += format.charAt(i_format);
				i_format++;
			}

			// Extract contents of value based on format token
			if (token=="yyyy" || token=="yy" || token=="y") {
				if (token=="yyyy") { x=4;y=4; }// 4-digit year
				if (token=="yy")   { x=2;y=2; }// 2-digit year
				if (token=="y")    { x=2;y=4; }// 2-or-4-digit year
				year = _getInt(val,i_val,x,y);
				bYearProvided = true;
				if (year == null) {
					return 0;
					//Default to current year
				}
				if (year.length != token.length){
					return 0;
				}

				i_val += year.length;
			}
			else if (token=="MMM") { // Month name
				month = 0;
				for (var i=0; i<MONTH_NAMES.length; i++) {
					var month_name = MONTH_NAMES[i];
					if (val.substring(i_val,i_val+month_name.length).toLowerCase() == month_name.toLowerCase()) {
						month = i+1;
						if (month>12) { month -= 12; }
						i_val += month_name.length;
						break;
					}
				}

				if (month == 0) { return 0; }
				if ((month < 1) || (month>12)) {
					return 0
				}
			}
			else if (token=="MM" || token=="M") {
				x=token.length; y=2;
				month = _getInt(val,i_val,x,y);
				if (month == null) { return 0; }
				if ((month < 1) || (month > 12)) { return 0; }
				i_val += month.length;
			}
			else if (token=="dd" || token=="d") {
				x=token.length; y=2;
				date = _getInt(val,i_val,x,y);
				if (date == null) { return 0; }
				if ((date < 1) || (date>31)) { return 0; }
				i_val += date.length;
			}
			else {
				if (val.substring(i_val,i_val+token.length) != token) {
					return 0;
				}
				else {
					i_val += token.length;
				}
			}
		}
		// If there are any trailing characters left in the value, it doesn't match
		if (i_val != val.length) {
			return 0;
		}
		// Is date valid for month?

		if (month == 2) {
			// Check for leap year
			if ( ( (year%4 == 0)&&(year%100 != 0) ) || (year%400 == 0) ) { // leap year
				if (date > 29){ return false; }
			}
			else {
				if (date > 28) { return false; }
			}
		}
		if ((month==4)||(month==6)||(month==9)||(month==11)) {
			if (date > 30) { return false; }
		}

		//JS dates uses 0 based months.
		month = month - 1;

		if (bYearProvided==false) {
			//Default to current
			var dCurrent = new Date();
			year = dCurrent.getFullYear();
		}

		var lYear = parseInt(year);
		if (lYear<=20) {
			year = 2000 + lYear;
		}
		else if (lYear >=21 && lYear<=99) {
			year = 1900 + lYear;
		}

		var newdate = new Date(year,month,date,0,0,0);

		return newdate;
	}
	this.getDateFromFormat=getDateFromFormat;


}



var calMgr = new spiffyCalManager();



// Calendar Object

function ctlSpiffyCalendarBox(strVarName, strFormName, strTextBoxName, strBtnName, strDefaultValue, intBtnMode, strFunctionesExtra) {

	var msNames     = new makeArray0('Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic');
	var msDays      = new makeArray0(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var msDOW       = new makeArray0('L','M','X','J','V','S','D');



	var blnInConstructor=true;
	var img_DateBtn_UP=new Image();
	var img_DateBtn_OVER=new Image();
	var img_DateBtn_DOWN=new Image();
	var img_DateBtn_DISABLED=new Image();

	var strBtnW;
	var strBtnH;
	var strBtnImg;

	var dteToday=new Date;
	var dteCur=new Date;

	var dteMin=new Date;
	var dteMax=new Date;

	var scX=4; // default where to display calendar
	var scY=4;

	// Defaults
	var strDefDateFmt='d/M/yyyy';

	var intDefBtnMode=0;
	var strDefBtnImgPath=calMgr.DefBtnImgPath;
	/* PROPERTIES =============================================================
	 *
	 */
	// Generic Properties
	this.varName=strVarName;
	this.extraFunctions=strFunctionesExtra;
	this.labelCalendario='fecha';

	var arrMetodosExtra=new Array();
	var arrMetodosExtraTmp = this.extraFunctions.split('#');
	for(var n=0;n<arrMetodosExtraTmp.length;n++){
	  var parEventoFuncion=arrMetodosExtraTmp[n];
	  arrMetodosExtra[arrMetodosExtra.length]=parEventoFuncion.split('|');
	}

	this.enabled=true;
	this.readonly=false;
	this.focusClick=false;
	this.hideButton=false;
	this.visible=false;
	this.displayLeft=false;
	this.displayTop=false;
	// Name Properties
	this.formName=strFormName;
	this.textBoxName=strTextBoxName;
	this.btnName=strBtnName;
	this.required=false;
	this.x=scX;
	this.y=scY;

	this.imgUp=img_DateBtn_UP;
	this.imgOver=img_DateBtn_OVER;
	this.imgDown=img_DateBtn_DOWN;
	this.imgDisabled=img_DateBtn_DISABLED;

	// look
	this.showWeekends=true;
	this.showHolidays=true;
	this.disableWeekends=true;
	this.disableHolidays=true;

	this.textBoxWidth=160;
	this.textBoxHeight=20;
	this.btnImgWidth=strBtnW;
	this.btnImgHeight=strBtnH;
	if ((intBtnMode==null)||(intBtnMode<0 && intBtnMode>3)) {
		intBtnMode=intDefBtnMode
	}
	switch (intBtnMode) {
		case 0 :
			strBtnImg=strDefBtnImgPath+'btn_date_up.gif';
			img_DateBtn_UP.src=strDefBtnImgPath+'btn_date_up.gif';
			img_DateBtn_OVER.src=strDefBtnImgPath+'btn_date_over.gif';
			img_DateBtn_DOWN.src=strDefBtnImgPath+'btn_date_down.gif';
			img_DateBtn_DISABLED.src=strDefBtnImgPath+'btn_date_disabled.gif';
			strBtnW = '18';
			strBtnH = '20';
			break;
		case 1 :
			strBtnImg=strDefBtnImgPath+'btn_date1_up.gif';
			img_DateBtn_UP.src=strDefBtnImgPath+'btn_date1_up.gif';
			img_DateBtn_OVER.src=strDefBtnImgPath+'btn_date1_over.gif';
			img_DateBtn_DOWN.src=strDefBtnImgPath+'btn_date1_down.gif';
			img_DateBtn_DISABLED.src=strDefBtnImgPath+'btn_date1_disabled.gif';
			strBtnW = '22';
			strBtnH = '17';
			break;
		case 2 :
			strBtnImg=strDefBtnImgPath+'btn_date2_up.gif';
			img_DateBtn_UP.src=strDefBtnImgPath+'btn_date2_up.gif';
			img_DateBtn_OVER.src=strDefBtnImgPath+'btn_date2_over.gif';
			img_DateBtn_DOWN.src=strDefBtnImgPath+'btn_date2_down.gif';
			img_DateBtn_DISABLED.src=strDefBtnImgPath+'btn_date2_disabled.gif';
			strBtnW = '34';
			strBtnH = '21';
			break;
		case 3 :
			strBtnImg=strDefBtnImgPath+'btn_date_classic_up.gif';
			img_DateBtn_UP.src=strDefBtnImgPath+'btn_date_classic_up.gif';
			img_DateBtn_OVER.src=strDefBtnImgPath+'btn_date_classic_over.gif';
			img_DateBtn_DOWN.src=strDefBtnImgPath+'btn_date_classic_down.gif';
			img_DateBtn_DISABLED.src=strDefBtnImgPath+'btn_date_classic_disabled.gif';
			strBtnW = '18';
			strBtnH = '18';
	}
	// Date Properties
	this.dateFormat=strDefDateFmt;
	this.useDateRange=true;

	this.minDate=new Date();
	this.maxDate=new Date(dteToday.getFullYear()+2, dteToday.getMonth(), dteToday.getDate());

	this.minDay = function() {
		return this.minDate.getDate();
	}
	this.minMonth = function() {
		return this.minDate.getMonth();
	}
	this.minYear = function() {
		return this.minDate.getFullYear();
	}

	this.maxDay = function() {
		return this.maxDate.getDate();
	}
	this.maxMonth = function() {
		return this.maxDate.getMonth();
	}
	this.maxYear = function() {
		return this.maxYear.getFullYear();
	}

	function getExtraFunction(evento){
	  for(n=0;n<arrMetodosExtra.length;n++){
	    if(arrMetodosExtra[n][0]==evento){
	      return arrMetodosExtra[n][1];
	    }
	  }

	  return '';
	}
	this.getExtraFunction=getExtraFunction;

	function setMinDate(intYear, intMonth, intDay) {
		this.minDate = new Date(intYear, intMonth-1, intDay);
	}
	this.setMinDate=setMinDate;


	function setMaxDate(intYear, intMonth, intDay) {
		this.maxDate = new Date(intYear, intMonth-1, intDay);
	}
	this.setMaxDate=setMaxDate;

	function setTextBoxValue(valor){
    var objTextBox=eval('document.'+this.formName+'.'+this.textBoxName);
    objTextBox.value=valor;
	}
	this.setTextBoxValue=setTextBoxValue;

	this.minYearChoice=dteToday.getFullYear()-1;
	this.maxYearChoice=dteToday.getFullYear()+3;
	this.textBox= function() {
		if (!blnInConstructor) {
			return eval('document.'+this.formName+'.'+this.textBoxName);
		}
	}

	this.getSelectedDate = function () {
		var strTempVal=''; var objEle;
		if ((typeof this.formName !='undefined') && (typeof this.textBoxName!='undefined')) {
			objEle=eval('document.'+this.formName+'.'+this.textBoxName);
			if (objEle && !blnInConstructor) {
				strTempVal=eval('document.'+this.formName+'.'+this.textBoxName+'.value');
			}
			else {
				strTempVal=strDefaultValue;
			}
		}
		else {
			strTempVal=strDefaultValue;
		}
		return strTempVal;
	}

	function setSelectedDate(strWhat) {
		var strTempVal=''; var objEle;
		eval('document.'+this.formName+'.'+this.textBoxName).value=strWhat;

		if (!calMgr.isDate(quote(strWhat),quote(this.dateFormat))) {
			eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBoxInvalid";
		}
		else {
			eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBox";
		}
	}
	this.setSelectedDate=setSelectedDate;


	function disable() {
		this.hide();
		calMgr.swapImg(this,'.imgDisabled',false);
		this.enabled=false;
		eval('document.'+this.formName+'.'+this.textBoxName).disabled=true;
        eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBoxDisabled";
		if (scNN) {
			eval('document.'+this.formName+'.'+this.textBoxName).onFocus= function() {this.blur();};
		}
	}
	this.disable=disable;

	function enable() {
		this.enabled=true;
		calMgr.swapImg(this,'.imgUp',false);
		eval('document.'+this.formName+'.'+this.textBoxName).disabled=false;
        eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBox";
		if (scNN) {
			eval('document.'+this.formName+'.'+this.textBoxName).onFocus= null;
		}

		if (!calMgr.isDate(quote(this.getSelectedDate()),quote(this.dateFormat))) {
			eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBoxInvalid";
		}
	}
	this.enable=enable;



	// behavior Properties
	this.JStoRunOnSelect='';
	this.JStoRunOnClear='';
	this.JStoRunOnCancel='';
	this.hideCombos=true;


	/* METHODS ===============================================================
	 *
	 */

	function makeCalendar(intWhatMonth,intWhatYear,bViewOnly) {
		if (bViewOnly) {intWhatMonth-=1;}
		var strOutput = '';
		var intStartMonth=intWhatMonth;
		var intStartYear=intWhatYear;
		var intLoop;
		var strTemp='';
		var strDateColWidth;
		var isWE = false;

		dteCur.setMonth(intWhatMonth);
		dteCur.setFullYear(intWhatYear);
		dteCur.setDate(dteToday.getDate());
		dteCur.setHours(0);dteCur.setMinutes(0);dteCur.setSeconds(0);dteCur.setMilliseconds(0);
		if (!(bViewOnly)) {
			strTemp='<form name="spiffyCal">';
		}
		// special case for form not to be inside table in Netscape 6
		if (scNN6) {
			strOutput += strTemp +'<table width="185" border="0" class="cal-Table" cellspacing="1" cellpadding="0"><tr>';
		}
		else {
			strOutput += '<table width="185" border="0" class="cal-Table" cellspacing="1" cellpadding="0">'+strTemp+'<tr>';
		}

		/*
		  nacho
		   quitamos el boton de cancelar cambios y retroceso de mes, en su lugar ponemos una imagen de retroceder mes
		*/

		if (!(bViewOnly)) {
		//	strOutput += '<td class="cal-HeadCell" align="center" width="100%"><a href="javascript:'+this.varName+'.clearDay();"><img name="calbtn1" src="'+strDefBtnImgPath+'btn_del_small.gif" border="0" width="12" height="10"></a>&nbsp;&nbsp;<a href="javascript:'+this.varName+'.scrollMonth(-1);" class="cal-DayLink">&lt;</a>&nbsp;<SELECT class="cal-ComboBox" NAME="cboMonth" onChange="'+this.varName+'.changeMonth();">';

	    strOutput += '<td class="cal-HeadCell" align="center" width="100%"><a href="javascript:'+this.varName+'.scrollMonth(-1);"><img name="calbtn3" src="'+strDefBtnImgPath+'btn_prev.gif" border="0" width="12" height="10"></a>&nbsp;&nbsp;&nbsp;&nbsp;<SELECT class="cal-ComboBox" NAME="cboMonth" onChange="'+this.varName+'.changeMonth();">';

    /*
       fin nacho
    */


			for (intLoop=0; intLoop<12; intLoop++) {
				if (intLoop == intWhatMonth) strOutput += '<OPTION VALUE="' + intLoop + '" SELECTED>' + msNames[intLoop] + '<\/OPTION>';
				else  strOutput += '<OPTION VALUE="' + intLoop + '">' + msNames[intLoop] + '<\/OPTION>';
			}


			strOutput += '<\/SELECT><SELECT class="cal-ComboBox" NAME="cboYear" onChange="'+this.varName+'.changeYear();">';

			for (intLoop=this.minYearChoice; intLoop<this.maxYearChoice; intLoop++) {
				if (intLoop == intWhatYear) strOutput += '<OPTION VALUE="' + intLoop + '" SELECTED>' + intLoop + '<\/OPTION>';
				else strOutput += '<OPTION VALUE="' + intLoop + '">' + intLoop + '<\/OPTION>';
			}

			//strOutput += '<\/SELECT>&nbsp;<a href="javascript:'+this.varName+'.scrollMonth(1);" class="cal-DayLink">&gt;</a>&nbsp;&nbsp;<a href="javascript:'+this.varName+'.hide();"><img name="calbtn2" src="'+strDefBtnImgPath+'btn_close_small.gif" border="0" width="12" height="10"></a><\/td><\/tr><tr><td width="100%" align="center">';
			strOutput += '<\/SELECT>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:'+this.varName+'.scrollMonth(1);"><img name="calbtn4" src="'+strDefBtnImgPath+'btn_next.gif" border="0" width="12" height="10"></a><\/td><\/tr><tr><td width="100%" align="center">';
		}
		else {
			strOutput += '<td class="cal-HeadCell" align="center" width="100%">'+msNames[intWhatMonth]+'-'+intWhatYear+'<\/td><\/tr><tr><td width="100%" align="center">';
		}


		firstDay = new Date(intWhatYear,intWhatMonth,1);
		startDay = firstDay.getDay();


		/*
		  nacho: adaptaciones del calendario al formato espagnolo
		*/

		startDay=startDay-1;

		if(startDay==-1){
		  startDay=6;
		}

		/*
		fin nacho
		*/


		if (((intWhatYear % 4 == 0) && (intWhatYear % 100 != 0)) || (intWhatYear % 400 == 0))
			msDays[1] = 29;
		else
			msDays[1] = 28;

		strOutput += '<table class="cal-Table-Days" width="185" cellspacing="1" cellpadding="2" border="0"><tr>';
		// Header ROW showing days of week here
		for (intLoop=0; intLoop<7; intLoop++) {
			if (intLoop==0 || intLoop==6) {
				strDateColWidth="15%"
			}
			else
			{
				strDateColWidth="14%"
			}
			strOutput += '<td class="cal-HeadCell" width="' + strDateColWidth + '" align="center" valign="middle">'+ msDOW[intLoop] +'<\/td>';
		}

		strOutput += '<\/tr><tr>';

		var intColumn = 0;
		var intLastMonth = intWhatMonth - 1;
		var intLastYear = intWhatYear;

		if (intLastMonth == -1) { intLastMonth = 11; intLastYear=intLastYear-1;}
		// Show last month's days in first row
		for (intLoop=0; intLoop<startDay; intLoop++, intColumn++) {

		  /*
			  nacho: adaptaciones del calendario al formato espanyol
			  antes no habia nada
			*/

		  if (intColumn==5 || intColumn==6){
			  isWE=true;
			}
			else{
			  isWE=false;
			}
			/*
			   fin nacho
			*/

			strOutput += this.getDayLink(true,(msDays[intLastMonth]-startDay+intLoop+1),intLastMonth,intLastYear,bViewOnly,isWE);
	  }
		// Show this month's days
		for (intLoop=1; intLoop<=msDays[intWhatMonth]; intLoop++, intColumn++) {



			/*
			  nacho: adaptaciones del calendario al formato espanyol
			*/

			//original
			//if ((intColumn % 6)==0) {isWE=true } else {isWE=false}

			if (intColumn==5 || intColumn==6){
			  isWE=true;
			}
			else{
			  isWE=false;
			}



			/*
			   fin nacho
			*/

			/*
			  nacho:
			  miramos si estan activo los fines de semana (son seleccionables)
			*/

	      var desactivarBoton=false;

			  if(this.disableWeekends && isWE){
			    desactivarBoton=true;
			  }
			/*
			  fin nacho
			*/

			strOutput += this.getDayLink(desactivarBoton,intLoop,intWhatMonth,intWhatYear,bViewOnly,isWE);
			if (intColumn == 6) {
				strOutput += '<\/tr><tr>';
				intColumn = -1;
			}
		}

		var intNextMonth = intWhatMonth+1;
		var intNextYear = intWhatYear;

		if (intNextMonth==12) { intNextMonth=0; intNextYear=intNextYear+1;}
		// Show next month's days in last row
		if (intColumn > 0) {
			for (intLoop=1; intColumn<7; intLoop++, intColumn++) {

			  /*
			  nacho: adaptaciones del calendario al formato espanyol
			  antes no habia nada
			*/

			  if (intColumn==5 || intColumn==6){
			    isWE=true;
			  }
			  else{
			    isWE=false;
			  }

			  /*
			   fin nacho
			*/

				strOutput +=  this.getDayLink(true,intLoop,intNextMonth,intNextYear,bViewOnly,isWE);
			}
			strOutput += '<\/tr><\/table><\/td><\/tr>';
		}
		else {
			strOutput = strOutput.substr(0,strOutput.length-4); // remove the <tr> from the end if there's no last row
			strOutput += '<\/table><\/td><\/tr>';
		}

		if (scNN6) {
			strOutput += '<\/table><\/form>';
		}
		else {
			strOutput += '<\/form><\/table>';
		}
		dteCur.setDate(1);
		dteCur.setHours(0);dteCur.setMinutes(0);dteCur.setSeconds(0);dteCur.setMilliseconds(0);

		dteCur.setMonth(intStartMonth);
		dteCur.setFullYear(intStartYear);

		return strOutput;
	}
	this.makeCalendar=makeCalendar;


	// writeControl -------------------------------------
	//
	function writeControl() {
		var strHold='';
		var strTemp='';
		strTempMinDate='';
		strTempMaxDate='';

		// specify whether you can type in the date box and validate them as well
		// or whether you must use the calendar only to select a date

		if (this.readonly) {
			strTemp=' onFocus="this.blur();" readonly ';
		}
		if (this.focusClick) {
			strTemp=' onFocus="'+this.varName+'.show();" ';
		}

		if (!(this.useDateRange)) {
			strTemp+=' onChange="calMgr.validateDate(document.'+this.formName+'.'+this.textBoxName+','+this.varName+'.required,\''+this.varName+'\');'+this.getExtraFunction('ONCHANGE')+'" onBlur="calMgr.formatDate(document.'+this.formName+'.'+this.textBoxName+','+this.varName+'.dateFormat);'+this.getExtraFunction('ONBLUR')+'" ';
		}
		else {

		  strTempMinDate=(Number(this.minDate.getMonth())+1)+'/'+this.minDate.getDate()+'/'+this.minDate.getFullYear();
			strTempMaxDate=(Number(this.maxDate.getMonth())+1)+'/'+this.maxDate.getDate()+'/'+this.maxDate.getFullYear();


			//strTemp+=' onChange="calMgr.validateDate('+'document.'+this.formName+'.'+this.textBoxName+','+this.varName+'.required,'+this.varName+'.minDate,'+this.varName+'.maxDate);" onBlur="calMgr.formatDate(document.'+this.formName+'.'+this.textBoxName+','+this.varName+'.dateFormat);" ';
			strTemp+=' onChange="calMgr.validateDate('+'document.'+this.formName+'.'+this.textBoxName+','+this.varName+'.required,\''+this.varName+'\',\''+strTempMinDate+'\',\''+strTempMaxDate+'\');'+this.getExtraFunction('ONCHANGE')+'"'
				+ ' onBlur="calMgr.formatDate(document.'+this.formName+'.'+this.textBoxName+','+this.varName+'.dateFormat);'+this.getExtraFunction('ONBLUR')+'"'
				+ ' onclick="'+this.varName+'.show();" ';

		}

		strHold='<table border="0" cellpadding="0" cellspacing="0">'
				+ '<tr><td align="right">'
				+ '<input class="cal-TextBox" type="text" name="' + this.textBoxName + '"' + strTemp + 'size="12" value="' + this.getSelectedDate() + '">'
				+ '<\/td>';

		if (!scIE) {
			strTemp=' href="javascript:calClick();return false;" ';
		}
		else {
			strTemp='';
		}
		if ((this.focusClick==false) || (this.focusClick==true && this.hideButton==false))  {
			strHold+='<td align="left"><a class="so-BtnLink"'+strTemp;

			strHold+=' onmouseover="calMgr.swapImg(' + this.varName + ',\'.imgOver\',false);" ';

			strHold+='onmouseout="calMgr.swapImg(' + this.varName + ',\'.imgUp\',false);" ';

			strHold+='onclick="calMgr.swapImg(' + this.varName + ',\'.imgDown\',true);';

	//		strHold+=this.varName+'.show();return false;">';
			strHold+=this.varName+'.show();">';

			strHold+='<img align="absmiddle" border="0" name="' + this.btnName + '" src="' + strBtnImg +'" width="'+ strBtnW +'" height="'+ strBtnH +'"></a><\/td><\/tr><\/table>';
		}
		document.write(strHold);
	}
	this.writeControl=writeControl;


	// show -------------------------------------
	//
	function show() {
	  eval(getExtraFunction('SHOW'));
		var strCurSelDate = calMgr.lastSelectedDate;

		if (!this.enabled) { return }
		calMgr.hideAllCalendars(this);
		if (this.visible) {
			this.hide();
		}
		else {
// put these next 2 lines in when the tiny cal btns seem to randomly disappear
 			//if (document.images['calbtn1']!=null ) document.images['calbtn1'].src=img_Del.src;
 			//if (document.images['calbtn2']!=null ) document.images['calbtn2'].src=img_Close.src;

 			//if (document.images['calbtn3']!=null ) document.images['calbtn3'].src=img_Prev.src;
 			//if (document.images['calbtn4']!=null ) document.images['calbtn4'].src=img_Next.src;

			if (this.focusClick==true && this.hideButton==true) {
				//if no dropdown button then use user-provided location for it
				scX=this.x;
				scY=this.y;
			}
			else {
				// get correct position of date btn
				if ( scIE ) {
					if (this.displayLeft) {
						scX = getOffsetLeft(document.images[this.btnName])-192+ document.images[this.btnName].width ;
						scX=scX-185+document.images[this.btnName].width;
					}
					else {
						scX = getOffsetLeft(document.images[this.btnName]);
						scX=scX-185+document.images[this.btnName].width;
					}
					if (this.displayTop) {
						scY = getOffsetTop(document.images[this.btnName]) -138 ;
					}
					else {
						scY = getOffsetTop(document.images[this.btnName]) + document.images[this.btnName].height + 2;
					}
				}
				else if (scNN){
					if (this.displayLeft) {
						scX = document.images[this.btnName].x - 192+  document.images[this.btnName].width;
						scX=scX-185+document.images[this.btnName].width;
					}
					else {
						scX = document.images[this.btnName].x;
						scX=scX-185+document.images[this.btnName].width;
					}
					if (this.displayTop) {
						scY = document.images[this.btnName].y -134;
					}
					else {
						scY = document.images[this.btnName].y + document.images[this.btnName].height + 2;
					}
				}
			}
			// hide all combos underneath it
			if (this.hideCombos) {toggleCombos('hidden');}

			// pop calendar up to the correct month and year if there's a date there
			// otherwise pop it up using today's month and year
			if (this.getSelectedDate()==''){
				if (!(dteCur)) {
					domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteToday.getMonth(),dteToday.getFullYear()));
				}
				else {
					domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteCur.getMonth(),dteCur.getFullYear()));
				}
			}
			else {
				if (calMgr.isDate(quote(this.getSelectedDate()),quote(this.dateFormat))) {
				    dteCur = calMgr.getDateFromFormat(quote(this.getSelectedDate()),quote(this.dateFormat));
					dteCur.setHours(0);dteCur.setMinutes(0);dteCur.setSeconds(0);dteCur.setMilliseconds(0);

				}
				else {
					dteCur=calMgr.lastSelectedDate;
				}
				domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteCur.getMonth(),dteCur.getFullYear()));
			}

			this.visible=true;
		}

	}
	this.show=show;


	// hide -------------------------------------
	//
	function hide() {

		domlay('spiffycalendar',0,scX,scY);
		this.visible = false;
		calMgr.swapImg(this,'.imgUp',false);
		if (this.hideCombos) {toggleCombos('visible');}
	}
	this.hide=hide;


	// clearDay -------------------------------------
	//
	function clearDay() {
		eval('document.' + this.formName + '.' + this.textBoxName + '.value = \'\'');
		this.hide();
		if (this.JStoRunOnClear!=null)
			eval(unescape(this.JStoRunOnClear));

		eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBox";
		if (this.required) {
			eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBoxInvalid";
		}
	}
	this.clearDay=clearDay;


	// changeDay -------------------------------------
	//
	function changeDay(intWhatDay) {
		dteCur.setDate(intWhatDay);
		dteCur.setHours(0);dteCur.setMinutes(0);dteCur.setSeconds(0);dteCur.setMilliseconds(0);

		this.textBox().value=calMgr.scFormatDate(dteCur,this.dateFormat);
		this.hide();
		if (this.JStoRunOnSelect!=null)
			eval(unescape(this.JStoRunOnSelect));

		eval('document.'+this.formName+'.'+this.textBoxName).className = "cal-TextBox";
    //eval(this.extraFunctions);
    //alert(getExtraFunction('CHANGEDAY'));
    eval(getExtraFunction('CHANGEDAY'));
	}
	this.changeDay=changeDay;

	// scrollMonth -------------------------------------
	//
	function scrollMonth(intAmount) {
		var intMonthCheck;
		var intYearCheck;

		if (scIE) {
			intMonthCheck = document.forms["spiffyCal"].cboMonth.selectedIndex + intAmount;
		}
		else if (scNN) {
			intMonthCheck = document.spiffycalendar.document.forms["spiffyCal"].cboMonth.selectedIndex + intAmount;
		}
		if (intMonthCheck < 0) {
			intYearCheck = dteCur.getFullYear() - 1;
			if ( intYearCheck < this.minYearChoice ) {
				intYearCheck = this.minYearChoice;
				intMonthCheck = 0;
			}
			else {
				intMonthCheck = 11;
			}
			dteCur.setFullYear(intYearCheck);
		}
		else if (intMonthCheck >11) {
			intYearCheck = dteCur.getFullYear() + 1;
			if ( intYearCheck > this.maxYearChoice-1 ) {
				intYearCheck = this.maxYearChoice-1;
				intMonthCheck = 11;
			}
			else {
				intMonthCheck = 0;
			}
			dteCur.setFullYear(intYearCheck);
		}

		if (scIE) {
			dteCur.setMonth(document.forms["spiffyCal"].cboMonth.options[intMonthCheck].value);
		}
		else if (scNN) {
			dteCur.setMonth(document.spiffycalendar.document.forms["spiffyCal"].cboMonth.options[intMonthCheck].value );
		}
		domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteCur.getMonth(),dteCur.getFullYear()));
	}
	this.scrollMonth=scrollMonth;


	// changeMonth -------------------------------------
	//
	function changeMonth() {
		if (scIE) {
			dteCur.setMonth(document.forms["spiffyCal"].cboMonth.options[document.forms["spiffyCal"].cboMonth.selectedIndex].value);
			domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteCur.getMonth(),dteCur.getFullYear()));
		}
		else if (scNN) {
			dteCur.setMonth(document.spiffycalendar.document.forms["spiffyCal"].cboMonth.options[document.spiffycalendar.document.forms["spiffyCal"].cboMonth.selectedIndex].value);
			domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteCur.getMonth(),dteCur.getFullYear()));
		}
	}
	this.changeMonth=changeMonth;


	// changeYear -------------------------------------
	//
	function changeYear() {
		if (scIE) {
			dteCur.setFullYear(document.forms["spiffyCal"].cboYear.options[document.forms["spiffyCal"].cboYear.selectedIndex].value);
			domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteCur.getMonth(),dteCur.getFullYear()));
		}
		else if (scNN) {
			dteCur.setFullYear(document.spiffycalendar.document.forms["spiffyCal"].cboYear.options[document.spiffycalendar.document.forms["spiffyCal"].cboYear.selectedIndex].value);
			domlay('spiffycalendar',1,scX,scY,this.makeCalendar(dteCur.getMonth(),dteCur.getFullYear()));
		}
	}
	this.changeYear=changeYear;

	function getDayLink(blnIsGreyDate,intLinkDay,intLinkMonth,intLinkYear,bViewOnly,isWE) {
	  //alert('blnIsGreyDate: '+blnIsGreyDate+' intLinkDay: '+intLinkDay+' intLinkMonth: '+intLinkMonth+' intLinkYear: '+intLinkYear+' bViewOnly: '+bViewOnly+' isWE: '+isWE);

		var templink;
		var tempLinkClass='calDay-Link';
		var tempClass='cal-DayCell';
		var tempDt=''; var isHol=-1; var holTxt='';
		if (isWE==true && this.showWeekends==true){
		  tempClass='cal-WeekendCell';
		}
		tempDt=msNames[intLinkMonth]+'-'+intLinkDay;

		if (this.showHolidays){
		  isHol=calMgr.isHoliday(tempDt);
		  if (isHol!=-1){
		    holTxt=' title="'+calMgr.HolidaysDesc[isHol]+'"';
		    tempClass='cal-HolidayCell';
		  }
		}
		if (!(this.useDateRange)) {
			if (blnIsGreyDate) {
				templink='<td align="center" class="cal-GreyDate">' + intLinkDay + '<\/td>';
			}
			else {
				if (isDayToday(intLinkDay)) {
					if (!(bViewOnly)) {
						templink='<td align="center" class="'+tempClass+'">' + '<a class="cal-TodayLink" '+holTxt+' onmouseover="self.status=\' \';return true" href="javascript:'+this.varName+'.changeDay(' + intLinkDay + ');">' + intLinkDay + '<\/a><\/td>';
					}
					else {
						templink='<td align="center" class="'+tempClass+'"><span class="cal-Today">' + intLinkDay +'<\/span><\/td>';
					}
				}
				else {
					if (!(bViewOnly)) {
						templink='<td align="center" class="'+tempClass+'">' + '<a class="cal-DayLink" '+holTxt+' onmouseover="self.status=\' \';return true" href="javascript:'+this.varName+'.changeDay(' + intLinkDay + ');">' + intLinkDay + '<\/a>' +'<\/td>';
					}
					else {
						templink='<td align="center" class="'+tempClass+'"><span class="cal-Day">' + intLinkDay + '<\/span><\/td>';
					}
				}
			}
		}
		else {
			if (this.isDayValid(intLinkDay,intLinkMonth,intLinkYear)) {

				if (blnIsGreyDate){
					templink='<td align="center" class="cal-GreyDate">' + intLinkDay + '<\/td>';
				}
				else {
					if (isDayToday(intLinkDay)) {
						if (!(bViewOnly)) {
							templink='<td align="center" class="'+tempClass+'">' + '<a class="cal-TodayLink" '+holTxt+' onmouseover="self.status=\' \';return true" href="javascript:'+this.varName+'.changeDay(' + intLinkDay + ');">' + intLinkDay + '<\/a>' +'<\/td>';
						}
						else {
							templink='<td align="center" class="'+tempClass+'"><span class="cal-Today">' + intLinkDay + '<\/span><\/td>';
						}
					}
					else {
						if (!(bViewOnly)) {
							templink='<td align="center" class="'+tempClass+'">' + '<a class="cal-DayLink" '+holTxt+' onmouseover="self.status=\' \';return true" href="javascript:'+this.varName+'.changeDay(' + intLinkDay + ');">' + intLinkDay + '<\/a>' +'<\/td>';
						}
						else {
							templink='<td align="center" class="'+tempClass+'"><span class="cal-Day">' +  intLinkDay  +'<\/span><\/td>';
						}
					}
				}
			}
			else {
				templink='<td align="center" class="cal-GreyInvalidDate">'+ intLinkDay + '<\/td>';
			}
		}
		return templink;
	}
	this.getDayLink=getDayLink;


	// EXTRA Private FUNCTIONS ===============================================================

	function toggleCombos(showHow){
		var i; var j;
		var cboX; var cboY;
		for (i=0;i<document.forms.length;i++) {
			for (j=0;j<document.forms[i].elements.length;j++) {
				if (document.forms[i].elements[j].tagName == "SELECT") {
					if (document.forms[i].name != "spiffyCal") {
						cboX = getOffsetLeft(document.forms[i].elements[j]);
						cboY = getOffsetTop(document.forms[i].elements[j]);
							if ( ((cboX>=scX-15) && (cboX<=scX+200)) && ((cboY>=scY-15) && (cboY<=scY+145)) )
								document.forms[i].elements[j].style.visibility=showHow;
							//Check for right hand side overlapping.
							cboX = cboX + parseInt(document.forms[i].elements[j].style.width);
							cboY=cboY+15;//cbo height (default)
							if ( ((cboX>=scX+15) && (cboX<=scX+200)) && ((cboY>=scY-15) && (cboY<=scY+145)) )
								document.forms[i].elements[j].style.visibility=showHow;
					}
				}
			}
		}
	}



	function isDayToday(intWhatDay) {
		if ((dteCur.getFullYear() == dteToday.getFullYear()) && (dteCur.getMonth() == dteToday.getMonth()) && (intWhatDay == dteToday.getDate())) {
			return true;
		}
		else {
			return false;
		}
	}


	function isDayValid(intWhatDay, intWhatMonth, intWhatYear){
		dteCur.setDate(intWhatDay);
		dteCur.setMonth(intWhatMonth);
		dteCur.setFullYear(intWhatYear);
		dteCur.setHours(0);dteCur.setMinutes(0);dteCur.setSeconds(0);dteCur.setMilliseconds(0);
		if ((dteCur>=this.minDate) && (dteCur<=this.maxDate)) {
			return true;
		}
		else {
			return false;
		}
	}
	this.isDayValid=isDayValid;

	calMgr.addCalendar(this);

	blnInConstructor=false;
}



// Utility functions----------------------------------


function quote(sWhat) {
	return '\''+sWhat+'\'';
}


function getOffsetLeft (el) {
	var ol = el.offsetLeft;
	while ((el = el.offsetParent) != null)
		ol += el.offsetLeft;
	return ol;
}


function getOffsetTop (el) {
	var ot = el.offsetTop;
	while((el = el.offsetParent) != null)
		ot += el.offsetTop;
	return ot;
}

function calClick() {
	window.focus();
}

function domlay(id,trigger,lax,lay,content) {
	/*
	 * Cross browser Layer visibility / Placement Routine
	 * Done by Chris Heilmann (mail@ichwill.net)
	 * http://www.ichwill.net/mom/domlay/
	 * Feel free to use with these lines included!
	 * Created with help from Scott Andrews.
	 * The marked part of the content change routine is taken
	 * from a script by Reyn posted in the DHTML
	 * Forum at Website Attraction and changed to work with
	 * any layername. Cheers to that!
	 * Welcome DOM-1, about time you got included... :)
	 */
	// Layer visible
	if (trigger=="1"){
		if (document.layers) document.layers[''+id+''].visibility = "show"
		else if (document.all) document.all[''+id+''].style.visibility = "visible"
		else if (document.getElementById) document.getElementById(''+id+'').style.visibility = "visible"
		}
	// Layer hidden
	else if (trigger=="0"){
		if (document.layers) document.layers[''+id+''].visibility = "hide"
		else if (document.all) document.all[''+id+''].style.visibility = "hidden"
		else if (document.getElementById) document.getElementById(''+id+'').style.visibility = "hidden"
		}
	// Set horizontal position
	if (lax){
		if (document.layers){document.layers[''+id+''].left = lax}
		else if (document.all){document.all[''+id+''].style.left=lax}
		else if (document.getElementById){document.getElementById(''+id+'').style.left=lax+"px"}
		}
	// Set vertical position
	if (lay){
		if (document.layers){document.layers[''+id+''].top = lay}
		else if (document.all){document.all[''+id+''].style.top=lay}
		else if (document.getElementById){document.getElementById(''+id+'').style.top=lay+"px"}
		}
	// change content

	if (content){
	if (document.layers){
		sprite=document.layers[''+id+''].document;
		// add father layers if needed! document.layers[''+father+'']...
		sprite.open();
		sprite.write(content);
		sprite.close();
		}
	else if (document.all) document.all[''+id+''].innerHTML = content;
	else if (document.getElementById){
		//Thanx Reyn!
		rng = document.createRange();
		el = document.getElementById(''+id+'');
		rng.setStartBefore(el);
		htmlFrag = rng.createContextualFragment(content)
		while(el.hasChildNodes()) el.removeChild(el.lastChild);
		el.appendChild(htmlFrag);
		// end of Reyn ;)
		}
	}
}

function obtenerSubCadena(fecha, posicion){

         var separador_1;
         var separador_2;

         var separadores=0;

         for(var n=0;n<fecha.length;n++){
           if(fecha.substring(n,n+1)=='/'){
             separadores++;
             if(separadores==1){
               separador_1=n;
             }
             else
               if(separadores==2)
                 separador_2=n;
           }
         }
         if(posicion==1){
           return fecha.substring(0,separador_1);
         }
         else
           if(posicion==2){
             return fecha.substring(separador_1+1,separador_2);
           }
           else{
             return fecha.substring(separador_2+1,fecha.length);
           }

       }

 function convertirFechaATexto(fFecha){
   var fecha=fFecha.getDate()+'/'+(Number(fFecha.getMonth())+1)+'/'+fFecha.getFullYear();
   return fecha;
 }


function makeArray0() {
	for (i = 0; i<makeArray0.arguments.length; i++)
		this[i] = makeArray0.arguments[i];
}

//---------------------------------------
