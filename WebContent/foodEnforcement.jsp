<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>RecallsFeed | powered by FDA</title>

<link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
<link href="css/recalls.css" rel="stylesheet" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link rel="stylesheet" href="css/datepicker.css">
<link href="css/dataTables.bootstrap.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,600' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/sharewidget-4.0.css" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,600'
	rel='stylesheet' type='text/css'>
<script>
	window["adrum-app-key"] = "AD-AAB-AAB-AUS";
	window["adrum-start-time"] = new Date().getTime();
</script>
<script src="js/adrum.js"></script>

<script src="js/jquery-1.11.3.js"></script>
<script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="assets/bootstrap-datepicker/css/datepicker.css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript"
	src="assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>

<!-- jQuery -->
<!-- DataTables -->
<script type="text/javascript" src="js/jquery-dataTables.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.js"></script>
<script type="text/javascript" src="css/dataTables.bootstrap.css"></script>


<!--Carousel-->
<script type="text/javascript">
	$(function() {
		var carouselWidth = $("#carouselwrapper").width();
		A11y.carousel();
		if (carouselWidth > 440 && carouselWidth < 980) {
			var a = $("#myCarousel li");
			if (a.parent().is("ul.item")) {
				a.unwrap();
			}
			do {
                    $(a.slice(0, 3)).wrapAll("<ul class="item row" role="presentation"></ul>");
			} while ((a = a.slice(3)).length > 0);
			$("#myCarousel ul.item").first().addClass("active");
		} else {
			var a = $("#myCarousel li");
			a.unwrap();
                $("#myCarousel li").wrapAll("<ul class="carousel-inner" role="list"></ul>");
			$(".left.carousel-control").hide();
			$(".right.carousel-control").hide();
		}
	});
</script>


<%
	DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	String toDate = df.format(new Date());
	Calendar c = Calendar.getInstance();
	c.setTime(df.parse(toDate));
	c.add(Calendar.DATE, -90); // number of days to add
	String fromDate = df.format(c.getTime());
%>
<script>
	var openFdaEnforcementSite = 'https://api.fda.gov/food/enforcement.json';
	var openFdaApiKey = '?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB';
	var openFdaLimit = '&limit=100';

	$(document)
			.ready(
					function() {
						var fromDateValue = document
								.getElementById("fromDateValue").value;
						var toDateValue = document
								.getElementById("toDateValue").value;
						var reasonForRecallValue = document
								.getElementById("reasonForRecallValue").value;
						var classificationValue = document
								.getElementById("classificationValue").value;

						if ((fromDateValue != '' && toDateValue != ''
								&& fromDateValue != "null"
								&& toDateValue != "null"
								&& fromDateValue != null && toDateValue != null)
								|| (reasonForRecallValue != ''
										&& reasonForRecallValue != null && reasonForRecallValue != "null")
								|| (classificationValue != ''
										&& classificationValue != null && classificationValue != "null")) {
							searchResultsByDate();
						} else {
							retrieveResults();
						}
					});

	function searchResultsByDate() {
		var openFdaEnforcementSite = 'https://api.fda.gov/food/enforcement.json';
		var openFdaApiKey = '?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB';
		var openFdaLimit = '&limit=100';

		var fromDate = document.getElementById("fromDateValue").value;
		var toDate = document.getElementById("toDateValue").value;
		var reasonForRecall = document.getElementById("reasonForRecallValue").value;
		var classification = document.getElementById("classificationValue").value;
		var fromDateParameter = "";
		var toDateParameter = "";
		//alert(fromDate);
		//alert(toDate);
		if (fromDate != '' && toDate != '' && fromDate != "null"
				&& toDate != "null" && fromDate != null && toDate != null) {
			var fromDateParts = fromDate.slice(0, 10).split('/');
			fromDateParameter = fromDateParts[2] + fromDateParts[0]
					+ fromDateParts[1];
			//alert(fromDateParameter);
			var toDateParts = toDate.slice(0, 10).split('/');
			toDateParameter = toDateParts[2] + toDateParts[0] + toDateParts[1];
			//alert(toDateParameter);
			document.getElementById("fromDate").value = document
					.getElementById("fromDateValue").value;
			document.getElementById("toDate").value = document
					.getElementById("toDateValue").value;
		} else {
			var today = new Date();
			fromDateParameter = date_by_subtracting_days(today, 90);
			toDateParameter = getFormattedDate(today);

			var fromYear = fromDateParameter.substring(0, 4);
			var fromMonth = fromDateParameter.substring(4, 6);
			var fromDay = fromDateParameter.substring(6, 8);
			var fromDateFieldValue = fromMonth + "/" + fromDay + "/" + fromYear;

			var toYear = toDateParameter.substring(0, 4);
			var toMonth = toDateParameter.substring(4, 6);
			var toDay = toDateParameter.substring(6, 8);
			var toDateFieldValue = toMonth + "/" + toDay + "/" + toYear;

			document.getElementById("fromDate").value = fromDateFieldValue;
			document.getElementById("toDate").value = toDateFieldValue;
		}

		var openFdaSearchFoodEnforcements = '&search=report_date:['
				+ fromDateParameter + '+TO+' + toDateParameter + ']';
		var searchWithReasonForRecall = "";
		var searchWithClassification = "";

		if (reasonForRecall != '' && reasonForRecall != null
				&& reasonForRecall != "null") {
			searchWithReasonForRecall = '+reason_for_recall:"'
					+ reasonForRecall + '"';
			document.getElementById("reasonForRecall").value = document
					.getElementById("reasonForRecallValue").value;
		}
		if (classification != null && classification != "null") {
			searchWithClassification = '+classification:"' + classification
					+ '"';
			document.getElementById("classification").value = document
					.getElementById("classificationValue").value;
		}
		//var openFdaSearchIndications='&search=openfda.indications_and_usage:{search}';

		var fdaUrl = openFdaEnforcementSite + openFdaApiKey + openFdaLimit
				+ openFdaSearchFoodEnforcements + searchWithReasonForRecall
				+ searchWithClassification;
		//alert(fdaUrl);

		$.ajax({
			url : fdaUrl,
			type : "GET",
			dataType : "json"
		}).done(function(data) {
			console.log(data);
			processResult(data);
		}).fail(function(data) {
			$("body").css("cursor", "default");
			if (data.statusText == "Not Found") {
				$('#fromDatePicker input').datepicker();
				$('#fromDatePickerGlyph').click(function () {
		        	$('#fromDatePicker input').datepicker('show');
		        });
				$('#toDatePicker input').datepicker();
				$('#toDatePickerGlyph').click(function () {
		        	$('#toDatePicker input').datepicker('show');
		        });
				alert("No records found.");
			}
		});
		
		window.locaion.reload();

	}

	function getFormattedDate(date) {
		var year = date.getFullYear();
		var month = 0;
		month = (1 + date.getMonth()).toString();
		month = month.length > 1 ? month : '0' + month;
		var day = date.getDate().toString();
		day = day.length > 1 ? day : '0' + day;

		return year + month + day;
	}

	function date_by_subtracting_days(date, days) {
		var fromDate = new Date(date.getFullYear(), date.getMonth(), date
				.getDate()
				- days);

		fromDate = getFormattedDate(fromDate);
		return fromDate;
	}

	function retrieveResults() {
		var today = new Date();
		var formattedFromDate = date_by_subtracting_days(today, 90);
		var formattedToDate = getFormattedDate(today);

		var openFdaSearchFoodEnforcements = '&search=report_date:['
				+ formattedFromDate + '+TO+' + formattedToDate + ']';
		var fdaUrl = openFdaEnforcementSite + openFdaApiKey + openFdaLimit
				+ openFdaSearchFoodEnforcements;

		//alert(fdaUrl);

		$.ajax({
			url : fdaUrl,
			type : "GET",
			dataType : "json"
		}).done(function(data) {
			console.log(data);
			processResult(data);
		}).fail(function(data) {
			$("body").css("cursor", "default");
			if (data.statusText == "Not Found") {
				$('#fromDatePicker input').datepicker();
				$('#fromDatePickerGlyph').click(function () {
		        	$('#fromDatePicker input').datepicker('show');
		        });
				$('#toDatePicker input').datepicker();
				$('#toDatePickerGlyph').click(function () {
		        	$('#toDatePicker input').datepicker('show');
		        });
				alert("No records found.");
			}
		});
	}

	function downloadCsv(){
		document.getElementById("event").value = "downloadCsv";
		document.forms['formsubmit'].submit(); 
		return false;
	}
	
	function formatRecallInitationDate(recall_initiation_date){
			var year = recall_initiation_date.substring(0, 4);
			var month = recall_initiation_date.substring(4, 6);
			var day = recall_initiation_date.substring(6, 8);
   		 	var recallInitiationDate = month +"/"+ day +"/"+ year;
   		 	return recallInitiationDate;
		}

	var dataArray;

	function processResult(data) {

		$('#fromDatePicker input').datepicker();
		$('#fromDatePickerGlyph').click(function () {
        	$('#fromDatePicker input').datepicker('show');
        });
		$('#toDatePicker input').datepicker();
		$('#toDatePickerGlyph').click(function () {
        	$('#toDatePicker input').datepicker('show');
        });
        
		var metaTotal = data.results.length;
		dataArray = new Array();
		var comingFrom = document.getElementById("comingFrom").value;

		var detailArray = new Array();

		for (var ndx = 0; ndx < metaTotal; ndx++) {
			var rowArray = new Array();

			// Get the details of the row.
			var thisRow = data.results[ndx];

			// Save it in the details array and local storage.
			detailArray.push(thisRow);

			var recallNumber = thisRow.recall_number;
			
			rowArray.push(formatRecallInitationDate(thisRow.report_date));
			rowArray.push(thisRow.product_description);
			rowArray.push(thisRow.classification);
			rowArray.push(thisRow.reason_for_recall);
			rowArray.push(thisRow.recalling_firm);
			rowArray.push(thisRow.distribution_pattern);
			var prodDetailLink = "&nbsp;&nbsp;&nbsp;<a href=\"FoodEnforcementServlet?recallNumber="
					+ recallNumber
					+ "&comingFrom="
					+ comingFrom
					+ "\"><i class=\"fa fa-lg fa-external-link\"></i>&nbsp;Details</a>";
			rowArray.push(prodDetailLink);
			dataArray.push(rowArray);
		}

		localStorage.setItem('resultObject', JSON.stringify(detailArray));
		sessionStorage.setItem('session_foodEnforcement_results',
										JSON.stringify(detailArray));
	
		document.getElementById("dataObject").value = JSON.stringify(detailArray);

		// Generate the data table
		var table = $('#tblResults')
				.DataTable(
						{
							data : dataArray,
							stateSave : true,
							//"sDom":"flrtip",
							"lengthMenu" : [ [ 10, 25, 50, -1 ],
									[ 10, 25, 50, "All" ] ],
							"stateSaveCallback" : function(settings, data) {
								localStorage.setItem('foodEnforcement_results',
										JSON.stringify(data));
							},
							"stateLoadCallback" : function(settings) {
								return JSON.parse(localStorage
										.getItem('foodEnforcement_results'));
							},
							"oLanguage" : {
								"sSearch" : "Filter Dataset Below: ",
								"sEmptyTable" : "No results found."
							},
							"order": [[ 0, "desc" ]]
						});
	}
	

</script>
<style type="text/css">
@media 
only screen and (max-width: 760px),
(min-device-width: 768px) and (max-device-width: 1024px)  {
/*
	Label the data
	*/
	td:nth-of-type(1):before { content: "Recall Date"; }
	td:nth-of-type(2):before { content: "Product Description"; }
	td:nth-of-type(3):before { content: "Classification"; }
	td:nth-of-type(4):before { content: "Reason for Recall"; }
	td:nth-of-type(5):before { content: "Recalling Firm"; }
	td:nth-of-type(6):before { content: "Distribution Pattern"; }
	td:nth-of-type(7):before { content: "Event Details"; }
}
</style>
</head>
<body>

	<div class="header">
        <div class="container">
            <div class="row">
                <div class="col-xs-9">
                    <a href="index.html"><div class="header">
                        <img class="logoimg" src="images/logo.png" alt="Recallsfeed logo">
                        <img class="logo" src="images/logo.svg" alt="Recallsfeed: Toss it or keep it?">
                    </div></a>
                </div>
                <div class="col-xs-3">
                    <p class="headerRight">powered by <strong>openFDA</strong></p>
                </div>
            </div>
        </div>
    </div>

	<div class="container">
		 <div class="row">
                <div class="col-xs-12">

                    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                        </ol>

                        <!-- Wrapper for slides -->
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">
                                <img src="images/slide1.jpg" alt="...">
                                <div class="carousel-caption">
                                    <p><strong>14 brands of bottled water</strong> recalled due to possible E. coli</p>
                                </div>
                            </div>
                            <div class="item">
                                <img src="images/slide2.jpg" alt="...">
                                <div class="carousel-caption">
                                    <p><strong>300 brands of caramel apples</strong> recalled&mdash;35 people ill</p>
                                </div>
                            </div>
                            <div class="item">
                                <img src="images/slide3.jpg" alt="...">
                                <div class="carousel-caption">
                                    <p><strong>Undeclared ingredient:</strong> peanuts found in cumin powder</p>
                                </div>
                            </div>
                        </div>

                        <!-- Controls -->
                        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

                </div>
            </div>


		<div class="row =">
			<div class="col-xs-12">
				<h1>Enforcement Reports - Recall Information for Food</h1>
				<p>Food and Drug Administration’s Recalls Database tracks and posts all food and beverage recalls. Search by product name, or check the recent recalls feed below.</p>
			</div>
		</div>
		<!--END ROW-->


		<div class="row margin-top15">
			<form id="formsubmit" name="formsubmit" action="FoodEnforcementServlet" method="post">
				<input type="hidden" name="comingFrom" id="comingFrom"
					value="foodEnforcement" /> <input type="hidden"
					name="fromDateValue" id="fromDateValue"
					value="<%=request.getParameter("fromDate")%>" /> <input
					type="hidden" name="toDateValue" id="toDateValue"
					value="<%=request.getParameter("toDate")%>" /> <input
					type="hidden" name="reasonForRecallValue" id="reasonForRecallValue"
					value="<%=request.getParameter("reasonForRecall")%>" /> <input
					type="hidden" name="classificationValue" id="classificationValue"
					value="<%=request.getParameter("classification")%>" />
				<input type="hidden" name="dataObject" id="dataObject" value=""/>
				<input type="hidden" name="event" id="event" value=""/>


				<div class="col-md-4 col-xs-12">
					<div class="form-group">
						<label for="keywords">Food Name</label> <input
							type="search" id="reasonForRecall" name="reasonForRecall"
							placeholder="i.e. Peanut Butter"
							class="form-control">
					</div>
				</div>

				<div class="col-md-2 col-xs-6" id="fromDatePickerID">
					<div class="form-group">
						<label for="datepicker">From Date</label>
						<div class="input-group" id="fromDatePicker">
							<input type="text" aria-describedby="demo1HelpText2"
								maxlength="10" class="form-control hasDatepicker" id="fromDate"
								name="fromDate"><span class="input-group-btn" id="fromDatePickerGlyph"><button
									class="btn btn-default ui-datepicker-trigger" type="button">
									<span><span class="fa fa-calendar "
										style="font-family: 'FontAwesome' !important"><span
											class="sr-only">Calendar icon</span></span><span class="sr-only">Select
											date</span></span>
								</button></span>
						</div>
						<!-- /input-group -->
					</div>
				</div>

				<div class="col-md-2 col-xs-6" id="toDatePickerID">
					<div class="form-group">
						<label for="datepicker">To Date</label>
						<div class="input-group" id="toDatePicker">
							<input type="text" aria-describedby="demo1HelpText2"
								maxlength="10" class="form-control hasDatepicker" id="toDate"
								name="toDate"><span class="input-group-btn"
								id="toDatePickerGlyph"><button
									class="btn btn-default ui-datepicker-trigger" type="button">
									<span><span class="fa fa-calendar"
										style="font-family: 'FontAwesome' !important"><span
											class="sr-only">Calendar icon</span></span><span class="sr-only">Select
											date</span></span>
								</button></span>
						</div>
						<!-- /input-group -->
					</div>
				</div>

				<script>
					$(function() {
						$('#fromDatePicker input').datepicker();
						$('#fromDatePickerGlyph').click(function () {
                        	$('#fromDatePicker input').datepicker('show');
                        });
						
					}); //document ready
					$(function() {
						$('#toDatePicker input').datepicker();
						$('#toDatePickerGlyph').click(function () {
                        	$('#toDatePicker input').datepicker('show');
                        });
					}); //document ready
				</script>

				<div class="col-md-2 col-xs-6">
					<div class="form-group">
						<label for="select">Seriousness</label> <select
							class="form-control" id="classification" name="classification">
							<option>All</option>
							<option>Class I</option>
							<option>Class II</option>
							<option>Class III</option>
						</select>
					</div>
				</div>

				<div class="col-md-2 col-xs-6">
					<input class="btn btn-primary searchButton btn-block" type="submit"
						value="Search">
				</div>

				<div class="col-xs-12">
					<div class="lineRule"></div>
				</div>
			</form>
		</div>
		<!--END ROW-->


		<div class="datesDisplayed">
			<div class="row">
				<div class="col-xs-8 col-md-10">
					<%
						String dateFrom = request.getParameter("fromDate");
						String dateTo = request.getParameter("toDate");
						if ((dateFrom == null && dateTo == null)
								|| (dateFrom == "" && dateTo == "")
								|| (dateFrom == "null" && dateTo == "null")) {
					%>
					Results displayed are from <strong><%=fromDate%></strong> to <strong><%=toDate%></strong>
					<%
						} else {
					%>
					Results displayed are from <strong><%=request.getParameter("fromDate")%></strong>
					to <strong><%=request.getParameter("toDate")%></strong>
					<%
						}
					%>
				</div>
				
				<div class="col-xs-4 col-md-2">
					<a id="enforcementReportDownloadCSV"
						href="#" onclick="javascript:downloadCsv();"><i
						class="fa fa-lg fa-download"></i> Download CSV</a>
				</div>

			</div>
			<!--END ROW-->
		</div>

		<div class="row">
			<div class="col-xs-12">
				<table summary="" class="product" id="tblResults">
					<thead>
						<tr>
							<th scope="row">Recall Date</th>
							<th scope="row">Product Description</th>
							<th scope="row">Classification</th>
							<th scope="row">Reason for Recall</th>
							<th scope="row">Recalling Firm</th>
							<th scope="row">Distribution Pattern</th>
							<th scope="row">Event Details</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>

		<!--END ROW-->

	</div>
	<footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-xs-4">
                    <a href="#"><img class="fda-logo" src="images/openfda-logo.png" alt="openFDA" /></a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>