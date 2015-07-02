<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>RecallsFeed | powered by FDA</title>

    <link href="css/bootstrap/bootstrap.min.css" rel="stylesheet" />
    <link href="css/dataTables.bootstrap.css" rel="stylesheet" />
    <link href="css/recalls.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/font-awesome.min.css" />
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,600' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="css/sharewidget-4.0.css" />
    
 <!--Script-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.js"></script>
    <script src="js/sharewidget-4.0.js"></script>
<!-- jQuery -->
<!-- DataTables -->
<script type="text/javascript" src="js/jquery-dataTables.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.js"></script>
<script>
	window["adrum-app-key"] = "AD-AAB-AAB-AUS";
	window["adrum-start-time"] = new Date().getTime();
</script>
<script src="js/adrum.js"></script>
<script>
	
	$(document).ready(function(){
		retrieveResults() ;	
	});
	
	function retrieveResults() {
		var eventId = document.getElementById("eventId").value;
		var openFdaEnforcementSite='https://api.fda.gov/food/enforcement.json';
		var openFdaApiKey='?api_key=kb68BYbRY8GJX5g7DkFD9U6trS5l4sl0gGvHwjOB';
		var openFdaSearchFoodEnforcements='&search=event_id:'+eventId+'';
		var openFdaLimit='&limit=100';
		
		var fdaUrl=openFdaEnforcementSite + openFdaApiKey + openFdaLimit + openFdaSearchFoodEnforcements;
		
		//alert(fdaUrl);
		
		$.ajax( {
			url: fdaUrl,
			type:"GET",
			dataType:"json"
		} )
		.done(function( data) {
			console.log(data);
			processResult(data);
		} )
		.fail(function( data) {
			$("body").css("cursor", "default");
			if( data.statusText == "Not Found")
			{
				alert("No records found.");
			}
		} );
	}
	
	function loadTable(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,
		param11){
		document.getElementById("1").innerHTML = param1;
		document.getElementById("2").innerHTML = param2;
		document.getElementById("3").innerHTML = param3;
		document.getElementById("4").innerHTML = param4;
		document.getElementById("5").innerHTML = param5;
		document.getElementById("6").innerHTML = param6;
		document.getElementById("7").innerHTML = param7;
		document.getElementById("8").innerHTML = param8;
		document.getElementById("9").innerHTML = param9;
		document.getElementById("10").innerHTML = param10;
		document.getElementById("11").innerHTML = param11;
		
	}
	
	function formatRecallInitationDate(recall_initiation_date){
			var year = recall_initiation_date.substring(0, 4);
			var month = recall_initiation_date.substring(4, 6);
			var day = recall_initiation_date.substring(6, 8);
   		 	var recallInitiationDate = month +"/"+ day +"/"+ year;
   		 	return recallInitiationDate;
		}

	function processResult(data) {
			var metaTotal = data.results.length;
			var dataArray = new Array();
			for( var ndx = 0; ndx < metaTotal; ndx++) {
				var rowArray = new Array();
			
				var thisRow = data.results[ndx];
				
				if(ndx == 0){
				  loadTable(thisRow.event_id,
				  thisRow.product_type,thisRow.status,formatRecallInitationDate(thisRow.recall_initiation_date),thisRow.distribution_pattern,
				  thisRow.recalling_firm,thisRow.city,thisRow.state,
				  thisRow.country,thisRow.voluntary_mandated,thisRow.initial_firm_notification);	           
				}
				
				rowArray.push(thisRow.product_description);
	           	//rowArray.push(thisRow.code_info);
	           	rowArray.push(thisRow.classification);
	           	rowArray.push(thisRow.reason_for_recall);
	           	rowArray.push(thisRow.product_quantity);
				rowArray.push(thisRow.recall_number);
				
				dataArray.push(rowArray);
			}
			// Generate the data table
			$('#tblResults').DataTable( { 
				data: dataArray,
				stateSave: true,	
				"stateSaveCallback": function (settings, data) {
		     		localStorage.setItem('foodEnforcement_results' , JSON.stringify(data));
		  		},
		  		"stateLoadCallback": function (settings) {
		    		return JSON.parse(localStorage.getItem('foodEnforcement_results' ));
		 		},
		 		"lengthMenu" : [ [ 10, 25, 50, -1 ],
									[ 10, 25, 50, "All" ] ],
				"oLanguage" : {
								"sSearch" : "Keyword Search for Results Below: ",
								"sEmptyTable" : "No results found."
							}
				
			 } );
		}

</script>
<style type="text/css">
@media 
only screen and (max-width: 760px),
(min-device-width: 768px) and (max-device-width: 1024px)  {
/*
	Label the data
	*/
	td:nth-of-type(1):before { content: "Product Description"; }
	td:nth-of-type(2):before { content: "Classification"; }
	td:nth-of-type(3):before { content: "Reason for Recall"; }
	td:nth-of-type(4):before { content: "Product Quantity"; }
	td:nth-of-type(5):before { content: "Recall Number"; }
}
</style>
</head>
<body>

	<div class="header">
        <div class="container">
            <div class="row banner">
                <div class="col-xs-9">
                    <a href="index.html"><div class="header">
                        <img class="logoimg" src="images/logo.png" alt="Recallsfeed logo">
                        <img class="logo" src="images/logo.svg" alt="Recallsfeed: Toss it or keep it?">
                    </div></a>
                </div>
                <div class="col-xs-3">
                    <p class="headerRight">powered by <strong>openFDA</strong> (prototype)</p>
                </div>
            </div>
        </div>
    </div>
    
    <form>
        <input type="hidden" name="eventId" id="eventId" value="<%= request.getParameter("eventId") %>"/>
        <input type="hidden" name="comingFrom" id="comingFrom" value="foodEnforcementEventDetail"/>
    </form>

	<div class="container">
  		<div class="row">  
        	<div class="col-xs-12">
    		<ol class="breadcrumb">
                <li><a href="FoodEnforcementServlet?event=Home">Home</a></li>
                <li class="active">Event Detail Report</li>
                <a href="#" class="pull-right"><i class="fa fa-envelope-square text-muted"></i></a>
                <a href="#" class="pull-right"><i class="fa fa-twitter-square text-muted"></i></a>
                <a href="#" class="pull-right"><i class="fa fa-facebook-square text-muted"></i></a>
                <a href="#" class="pull-right"><i class="fa fa-rss-square text-muted"></i></a>
            </ol>
            </div>
    	</div><!--END ROW-->
    
		<div class="row">
			<div class="col-xs-12">
				<h1>Event Detail Report</h1>
			</div>
            <div class="col-xs-12"><h2 class="margin-top10">Event Details</h2></div>
        </div>
        <div class="row boxGray">
            <div class="col-sm-6 col-xs-12">
                <dl>
                    <dt>Event ID</dt>
                    <dd id="1"></dd>
                    <dt>Product Type</dt>
                    <dd id="2"></dd>
                    <dt>Status</dt>
                    <dd id="3"></dd>
                    <dt>Recall Initiation Date</dt>
                    <dd id="4"></dd>
                    <dt>Distribution Pattern</dt>
                    <dd id="5"></dd>
                </dl>
            </div>
            <div class="col-sm-6 col-xs-12">
                 <dl>
                    <dt>Recalling Firm</dt>
                    <dd id="6">Nuevotanicals</dd>
                    <dt>City</dt>
                    <dd id="7">Fort Worth</dd>
                    <dt>State</dt>
                    <dd id="8">TX</dd>
                    <dt>Country</dt>
                    <dd id="9">USA</dd>
                    <dt>Voluntary/Mandated</dt>
                    <dd id="10">Voluntary: Firm Initiated</dd>
                    <dt>Initial Firm Notification of Consignee or Public</dt>
                    <dd id="11">Letter</dd>
                </dl>
            </div>
            
        </div><!--END ROW-->
    
     	<div class="row margin-bottom30">
            <div class="col-xs-12">
                <h2>Product Details</h2>
			<table summary="Product Details" class="product" id="tblResults">
				<thead>
                <tr>
                    <th scope="row">Product Description</th>
                    <th scope="row">Classification</th>
                    <th scope="row">Reason for Recall</th>
                    <th scope="row">Product Quantity</th>
                    <th scope="row">Recall Number</th>
                </tr>
				</thead>
			</table>
            </div>

        </div><!--END ROW-->
        
     </div>

    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-4">
                    <a href="https://open.fda.gov/" target="_blank"><img class="fda-logo" src="images/openfda-logo.png" alt="openFDA" /></a>
                </div>
                <div class="col-xs-12 col-sm-8">
                	<p>This website was created as a prototype to display our capabilities to create intuitive and user friendly web application. This website is not official  FDA website.</p>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>