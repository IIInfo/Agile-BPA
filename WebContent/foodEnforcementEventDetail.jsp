<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Enforcement Reports</title>

<link rel="stylesheet" href="assets/libs/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/style.css" />
<script src="assets/libs/bootstrap/bootstrap.min.js"></script>
<script src="assets/js/jquery-2.1.4.js"></script>
<!-- jQuery -->
<!-- DataTables -->
<script type="text/javascript" src="assets/js/jquery-dataTables.js"></script>
<script>
  $(document).foundation();
 </script>
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
				alert("Search found no results");
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

	function processResult(data) {
			var metaTotal = data.results.length;
			var dataArray = new Array();
			for( var ndx = 0; ndx < metaTotal; ndx++) {
				var rowArray = new Array();
			
				var thisRow = data.results[ndx];
				
				if(ndx == 0){
				  loadTable(thisRow.event_id,
				  thisRow.product_type,thisRow.status,thisRow.recalling_firm,thisRow.city,thisRow.state,
				  thisRow.country,thisRow.voluntary_mandated,thisRow.recall_initiation_date,thisRow.initial_firm_notification, 
				  thisRow.distribution_pattern);	           
				}
				
				rowArray.push(thisRow.product_description);
	           	rowArray.push(thisRow.code_info);
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
				
			 } );
		}

</script>
<style>
/* Max width before this PARTICULAR table gets nasty. This query will take effect for any screen smaller than 760px and also iPads specifically. */
@media 
only screen and (max-width: 760px),
(min-device-width: 768px) and (max-device-width: 1024px)  {

	/* Force table to not be like tables anymore */
	table, thead, tbody, th, td, tr { display: block; }
	
	/* Hide table headers (but not display: none;, for accessibility) */
	table.product thead tr { position:absolute; top:-9999px; left:-9999px; }
	table.product tr { border:1px solid #ccc; }
	table.product td { border:none; border-bottom:1px solid #eee; position:relative; padding-left:40%; }
	table.product td:before { position: absolute; top:6px; left:6px; width:45%; padding-right:10px; white-space:nowrap; }
	
	/* Label the data */
	table.product td:nth-of-type(1):before { content: "Product Description"; font-weight:bold; }
	table.product td:nth-of-type(2):before { content: "Code Info"; font-weight:bold; }
	table.product td:nth-of-type(3):before { content: "Classification"; font-weight:bold; }
	table.product td:nth-of-type(4):before { content: "Reason for Recall"; font-weight:bold; }
	table.product td:nth-of-type(5):before { content: "Recalling Firm"; font-weight:bold; }
	table.product td:nth-of-type(6):before { content: "Distribution Pattern"; font-weight:bold; }
	table.product td:nth-of-type(7):before { content: "Event Details"; font-weight:bold; }
}
</style>

</head>
<body>

<div id="page-wrap">
    
    <div class="page-banner"><img src="assets/images/banner.jpg" class="img-responsive" alt="Banner" /></div>

	<div class="page-content">
	 <a href="FoodEnforcementServlet?event=Home">Home</a>
	<h1>Enforcement Report - Details for Event ID <%= request.getParameter("eventId") %></h1>
 
    <form>
    <input type="hidden" name="eventId" id="eventId" value="<%= request.getParameter("eventId") %>"/>
    <input type="hidden" name="comingFrom" id="comingFrom" value="foodEnforcementEventDetail"/>
    </form>
    
    <h3>Event Detail</h3>
	<table class="product" summary="" id="eventtblResults">
		<thead>
        <tr>
            <th scope="row">Event Id</th>
            <td id="1" style="text-align: left"></td>
         </tr>
        <tr>
			<th scope="row">Product Type</th>
			<td id="2" style="text-align: left"></td>
		</tr>
		<tr>
			<th scope="row">Status</th>
			<td id="3" style="text-align: left"></td>
		</tr>
		<tr>
			<th scope="row">Recalling Firm</th>
			<td id="4" style="text-align: left"></td>
		</tr>
		<tr>
			<th scope="row">City</th>
			<td id="5" style="text-align: left"></td>
		</tr>
		<tr>
			<th scope="row">State</th>
			<td id="6" style="text-align: left"></td>
		</tr>
		<tr>
			<th scope="row">Country</th>
			<td id="7" style="text-align: left"></td>
		</tr>
		<tr>
           
            <th scope="row">Voluntary/Mandated</th>
            <td id="8" style="text-align: left"></td>
      </tr>
      <tr>
            <th scope="row">Recall Initiation Date</th>
            <td id="9" style="text-align: left"></td>
       </tr>
       <tr>
        
            <th scope="row">Initial Firm Notification of Consignee or Public</th>
            <td id="10" style="text-align: left"></td>
       </tr>
       <tr>
            <th scope="row">Distribution Pattern</th>
            <td id="11" style="text-align: left"></td>
       </tr>
		
		</thead>
	</table>
    
    <h3 class="bumpDown10">Product Detail</h3>
	<table class="product" summary="" id="tblResults">
		<thead>
		<tr>
			<th scope="row">Product Description</th>
			<th scope="row">Code Info</th>
			<th scope="row">Classification</th>
			<th scope="row">Reason for Recall</th>
			<th scope="row">Product Quantity</th>
            <th scope="row">Recall Number</th>
		</tr>
		</thead>
	</table>
    </div>
	
    <footer class="footer"></footer>

</div>
		
</body>
</html>