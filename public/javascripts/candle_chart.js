var chart;

var dataString = "";
var chartData = [];
var maxCandlesticks = 100;
var graph;
var graphType = "candlestick";

var rb1;
var rb2;

window.onload = function() {

	rb1 = document.getElementById("rb1");
	rb2 = document.getElementById("rb2");

 	chart = new AmCharts.AmSerialChart();
 	chart.pathToImages = "javascripts/amcharts/javascript/images/";

  chart.plotAreaBorderColor = "#000000";
  chart.plotAreaBorderAlpha = 1;
	chart.marginTop = 22;
	chart.marginLeft = 40;
	chart.marginRight = 1;
	chart.marginBottom = 15;
	chart.categoryField = "date";
	chart.addListener('dataUpdated', zoom);
	chart.addListener('zoomed', changeGraphType);

	graph = new AmCharts.AmGraph();
	graph.type = "line";   // initial type is line, as we show candlesticks only when zoomed
	graph.lineColor="#7f8da9";
	graph.fillColors="#7f8da9";
	graph.negativeLineColor="#db4c3c";
	graph.negativeFillColors="#db4c3c";
	graph.fillAlphas="[1]";
	graph.openField="open";
	graph.highField="high";
	graph.lowField="low";
	graph.closeField="close";
	graph.valueField="close";
	graph.title="Price:";
	chart.addGraph(graph);

	var catAxis = chart.categoryAxis;
	catAxis.parseDates = true;
	catAxis.minPeriod = "DD";
	catAxis.tickLenght = 0;
	catAxis.inside = true;

	var chartCursor = new AmCharts.ChartCursor();
	chart.addChartCursor(chartCursor);

	var chartScrollbar = new AmCharts.ChartScrollbar();
	chartScrollbar.scrollbarHeight = 30;
	chartScrollbar.graph = graph;
	chartScrollbar.graphType = "line";
	chartScrollbar.hideResizeGrips = false;
	chartScrollbar.gridCount = 4;
	chartScrollbar.color = "#FFFFFF";
	chart.addChartScrollbar(chartScrollbar);
	
	// add listener and display from/to dates
	chart.addListener("zoomed", handleZoom);
	
	chart.write("chartdiv");
}

function changeGraphType(event){
	var startIndex = event.startIndex;
	var endIndex = event.endIndex;

	if(endIndex - startIndex > maxCandlesticks){
		// change graph type
		if (graph.type != "line") {
			graph.type = "line";
			graph.fillAlphas = 0;
			chart.validateNow();
		}
		// disable radio buttons
		rb1.disabled = true;
		rb2.disabled = true;
	}
	else{
		// change graph type
		if (graph.type != graphType) {
			graph.type = graphType;
			graph.fillAlphas = 1;
			chart.validateNow();
		}
		// enable radio buttons
		rb1.disabled = false;
		rb2.disabled = false;
	}
}

// this function is called when user changes type by clicking on radio buttons
function setType(){

	if(rb1.checked){
		graphType = "candlestick";
	}
	else{
		graphType = "ohlc";
	}
	// only change type if selected number of data points is less then maxCandlesticks
	if(chart.endIndex - chart.startIndex < maxCandlesticks){
		graph.type = graphType;
		chart.validateNow();
	}
}

function zoom(){
	chart.zoomToIndexes(chartData.length - 20, chartData.length - 1);
}

function parseData(){
	var rowArray = dataString.split("\n");
	for(var i = rowArray.length - 1; i > - 1 ; i--){
		var row = rowArray[i].split(",");
		var dateArray = row[0].split("-");
		var date = new Date(Number(dateArray[0]), Number(dateArray[1]) - 1, Number(dateArray[2]));
		var open = row[1];
		var high = row[2];
		var low = row[3];
		var close = row[4];
		chartData.push({date:date, open:open, high:high, low:low, close:close});
	}
}

function handleZoom(event){
  var startDate = event.startDate;
  var endDate = event.endDate;
  document.getElementById("startDate").value = AmCharts.formatDate(startDate, "DD/MM/YYYY");
  document.getElementById("endDate").value = AmCharts.formatDate(endDate, "DD/MM/YYYY");
}

function getIndexData() {
  document.getElementById("company").value = "none";
  getSecurityData("index", "indices/get_index_record_data.html");
}

function getCompanyData() {
  document.getElementById("index").value = "none";
  getSecurityData("company", "companies/get_company_record_data.html");
}

function getSecurityData(type, url) {
  var sec = document.getElementById(type);
  var secName = sec.options[sec.selectedIndex].innerHTML;
  var secCode = sec.options[sec.selectedIndex].value;
  document.getElementById("title").innerHTML = "Shart | " + secName;
  document.getElementById("heading").innerHTML = secName;
  document.getElementById("code").innerHTML = secCode;
  
  chartData = [];
  
  var xmlhttp;
  if (window.XMLHttpRequest) {
    xmlhttp = new XMLHttpRequest();
  }
  else {
    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }
  xmlhttp.open("GET", url+"?q="+secCode,false);
  xmlhttp.send();
  dataString = xmlhttp.responseText;
  
  dataString = dataString.substring(0,dataString.length - 1);  // Remove trailing newline
  parseData();
  chart.dataProvider = chartData;
  chart.validateData();
}

function changeZoomDates(){
  var startDateString = document.getElementById("startDate").value;
  var endDateString = document.getElementById("endDate").value;
	var startDate = stringToDate(startDateString);
	var endDate = stringToDate(endDateString);
	chart.zoomToDates(startDate, endDate);
}

function stringToDate(str){
	var dArr = str.split("/");
	var date = new Date(Number(dArr[2]), Number(dArr[1]) - 1, dArr[0]);
	return date;
}
