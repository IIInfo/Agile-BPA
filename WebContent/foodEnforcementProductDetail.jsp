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
	
	$(document).ready(function(){
		retrieveResults() ;	
	});
	
	function retrieveResults() {
		
		var jsonString=localStorage.getItem('resultObject');		
		var jsonObjects = $.parseJSON(jsonString);
		
		var recallNumberParameter = document.getElementById("recallNumber").value;
		
		var detailsObject ;		
		jQuery.each(jsonObjects, function(index, item) {
   		 		 if ( item.recall_number ==  recallNumberParameter   ) {
   		 		 	detailsObject= item;
   		 		 	return false;
   		 		 }		  
		});
		
		 loadTable(detailsObject.product_description,detailsObject.recall_number,detailsObject.classification,
				  detailsObject.code_info,detailsObject.product_quantity,detailsObject.reason_for_recall,detailsObject.event_id,
				  detailsObject.product_type,detailsObject.status,detailsObject.recalling_firm,detailsObject.city,detailsObject.state,
				  detailsObject.country,detailsObject.voluntary_mandated,formatRecallInitationDate(detailsObject.recall_initiation_date),detailsObject.initial_firm_notification, 
				  detailsObject.distribution_pattern);	  		
		}
		
		function formatRecallInitationDate(recall_initiation_date){
			var year = recall_initiation_date.substring(0, 4);
			var month = recall_initiation_date.substring(4, 6);
			var day = recall_initiation_date.substring(6, 8);
   		 	var recallInitiationDate = month +"/"+ day +"/"+ year;
   		 	return recallInitiationDate;
		}
	
	function loadTable(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,
		param11,param12,param13,param14,param15,param16,param17){
		document.getElementById("1").innerHTML = param1;
		document.getElementById("2").innerHTML = param2;
		document.getElementById("3").innerHTML = param3;
		document.getElementById("4").innerHTML = param4;
		document.getElementById("5").innerHTML = param5;
		document.getElementById("6").innerHTML = param6;
		var comingFrom = document.getElementById("comingFrom").value;
		var eventId=param7;
	    var eventLink = "<a href=\"FoodEnforcementServlet?eventId="+eventId+"&comingFrom="+comingFrom+"\"><i class=\"fa fa-lg fa-external-link\"></i>&nbsp;"+eventId+"</a>";
		document.getElementById("7").innerHTML = eventLink;
		document.getElementById("8").innerHTML = param8;
		document.getElementById("9").innerHTML = param9;
		document.getElementById("10").innerHTML = param10;
		document.getElementById("11").innerHTML = param11;
		document.getElementById("12").innerHTML = param12;
		document.getElementById("13").innerHTML = param13;
		document.getElementById("14").innerHTML = param14;
		document.getElementById("15").innerHTML = param15;
		document.getElementById("16").innerHTML = param16;
		document.getElementById("17").innerHTML = param17;
	}

</script>
</head>
<body>

	<div class="header">
        <div class="container">
            <div class="row">
                <div class="col-xs-9">
                    <a href="index.html">
                        <div class="header">
                            <img class="logoimg" src="images/logo.png" alt="Recallsfeed logo">
                            <img class="logo" src="images/logo.svg" alt="Recallsfeed: Toss it or keep it?">
                        </div>
                    </a>
                </div>
                <div class="col-xs-3">
                    <p class="headerRight">powered by <strong>openFDA</strong></p>
                </div>
            </div>
        </div>
    </div>

	<div class="container">
        <div class="row margin-top15">
            <div class="col-xs-10">
                <h1>Details for Product ID <%= request.getParameter("recallNumber") %></h1>
            </div>
            <div class="col-xs-2 shareContainer">
                <a href="#"><i class="fa fa-2x fa-facebook-square text-muted"></i></a>
                <a href="#"><i class="fa fa-2x fa-twitter-square text-muted"></i></a>
                <a href="#"><i class="fa fa-2x fa-envelope-o text-muted"></i></a>
            </div>
        </div><!--END ROW-->

        <form>
            <input type="hidden" name="recallNumber" id="recallNumber" value="<%= request.getParameter("recallNumber") %>"/>
            <input type="hidden" name="comingFrom" id="comingFrom" value="foodEnforcementProductDetail"/>
        </form>
    
   		<div class="row">
            <div class="col-xs-12"><h2 class="margin-top10">Product Details</h2></div>
        </div>
        <div class="col-xs-12">
            <div class="lineRule"></div>
        </div>
        <div class="row">
            <div class="col-xs-12 boxGray">
                <dl class="dl-horizontal">
                    <dt>Product Description</dt>
                    <dd id="1"></dd>
                    <dt>Recall Number</dt>
                    <dd id="2"></dd>
                    <dt>Classification</dt>
                    <dd id="3"></dd>
                    <dt>Code Info</dt>
                    <dd id="4"></dd>
                    <dt>Product Distributed Qty</dt>
                    <dd id="5"></dd>
                    <dt>Reason for Recall</dt>
                    <dd id="6"></dd>
                </dl>
            </div>
           
            
            
        </div><!--END ROW-->
    
     	<div class="row">
            <div class="col-xs-12"><h2 class="margin-top10">Event Details</h2></div>
        </div>
        <div class="row">
            <div class="col-sm-6 col-xs-12">
                <dl>
                    <dt>Event Id</dt>
                    <dd id="7"></dd>
                    <dt>Product Type</dt>
                    <dd id="8"></dd>
                    <dt>Status</dt>
                    <dd id="9"></dd>
                    <dt>Recalling Firm</dt>
                    <dd id="10"></dd>
                    <dt>Recall Initation Date</dt>
                    <dd id="15"></dd>
                </dl>
            </div>
            <div class="col-sm-6 col-xs-12">
                 <dl>
                    <dt>City</dt>
                    <dd id="11">Fort Worth</dd>
                    <dt>State</dt>
                    <dd id="12">TX</dd>
                    <dt>Country</dt>
                    <dd id="13">USA</dd>
                    <dt>Voluntary/Mandated</dt>
                    <dd id="14">Voluntary: Firm Initiated</dd>
                    <dt>Initial Firm Notification of Consignee or Public</dt>
                    <dd id="16">Letter</dd>
                    <dt>Distribution Pattern</dt>
                    <dd id="17"></dd>
                </dl>
            </div>

        </div>
    </div><!--END ROW-->

	<footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-xs-4">
                    <a href="http://www.fda.gov/"><img class="fda-logo" src="images/openfda-logo.png" alt="openFDA" /></a>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>