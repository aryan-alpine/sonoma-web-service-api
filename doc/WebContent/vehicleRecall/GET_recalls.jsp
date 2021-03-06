<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="US-ASCII">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<h1>GET recalls</h1>

<p>Get the list of recalls for a vehicle with a specific make, model and year.</p>

<br/><hr/>
<h2>HTTP Request: Headers</h2>

<p>The request method is GET.<br/>
For example:</p>

<pre>
GET /vehicleRecall/recalls/make/FORD/model/MUSTANG/year/2007
Host: test.alpineconnectivity.com:8888
</pre>

<br/><hr/>
<h2>HTTP Request: Headers: Request Method Parameters</h2>

<p> When the request method is GET or DELETE, 
the conventional way to pass data to the service is via 
the parameters of the "request method" 
in the "headers" section of the HTTP request.<br/>
</p>

<h3>Example</h3>

<pre>
GET /vehicleRecall/recalls/make/FORD/model/MUSTANG/year/2007
Host: test.alpineconnectivity.com:8888
</pre>

<h3>Description</h3>

<p>For each individual input parameter ...</p>

<table width="100%" border="1">

<tr>
<td><span style="color:red">make</span><br/>(required)</td>
<td>The "make" of the vehicle.
</td>
</tr>


<tr>
<td><span style="color:red">model</span><br/>(required)</td>
<td>The "model" of the vehicle.
</td>
</tr>


<tr>
<td><span style="color:red">year</span><br/>(required)</td>
<td>The "year" of the vehicle
</td>
</tr>


</table>

<!-- 
<br/><hr/>
<h2>HTTP Request: BODY: Parameters</h2>

<p>Another way to pass data to a service is via the body of the HTTP request.<br/>
This method is not used when the request method is GET.<br/>
This service does NOT pass data in this fashion..</p>
 -->

<br/><hr/>
<h2>HTTP Response: HEAD: Headers</h2>

<p>The following response codes are possible from this service.<br/>
(Client code must handle each of them.):</p>

<ul>
<li><b>200 Success</b></li>
<li><b>400 Bad Request</b></li>
<li><b>401 Not Authorized</b></li>
<li><b>500 Server Error</b></li>
</ul>

<p>
The content of the body of the HTTP Response will always be JSON.<br/>
Therefore, the following header will always be sent:<br/>
<b>Content-Type: application/json</b>
</p>


<br/><hr/>
<h2>HTTP Response: Body</h2>

<p>The body of the response should always contain JSON.<br/>
The type of JSON returned varies by the response code.<br/>
3 types of JSON are possible.</p>


<h3>(1) Response Code = 200: &quot;Success&quot;</h3>
<p>If the service executed successfully<br/>
JSON like the following will be returned in the body of the response:</p>

<pre>
HTTP/1.1 200 Success

[
    {
        "id": "52e198e703647b232f8ae5ca",
        "vehicleMake": "FORD",
        "vehicleModel": "MUSTANG",
        "year": "2007",
        "manufacturerFilingDefect": "EIBACH SPRINGS, INC.",
        "beginDateOfManufacturing": "",
        "endDateOfManufacturing": "",
        "recallType": "E",
        "unitsAffected": "400",
        "dateNotifiedByMfr": "",
        "recallInitiator": "MFR",
        "manufacturer": "Ford Motor Company",
        "reportReceivedDate": "20061027",
        "reportCreationDate": "20061027",
        "regulationPartNumber": "",
        "fmvssNumber": "",
        "defectSummary": "CERTAIN AFTERMARKET EIBACH BRANDED FRONT STRUTS ONLY, PART NO. 35101.8001, AND EIBACH BRANDED FRONT STRUTS AS SUSPENSION KITS, PART NOS. 35101.840, 35101.680, 35101.780, 35100.680, 35100.780, 4.10135.680, AND 4.10035.780, SOLD FOR USE ON 2005 THROUGH 2007 FORD MUSTANG  VEHICLES.  THE FRONT ANTI ROLL BAR ATTACHMENT BRACKET ON THE FRONT STRUT CAN SEPARATE FROM THE STRUT HOUSING DUE TO INCONSISTENT WELDING.  THIS COULD RESULT IN A CLUNKING NOISE AND OR POOR HANDLING IN EXTREME OR EMERGENCY MANEUVERS.",
        "consequenceSummary": "IF THE BROKEN BRACKET CONTACTS THE TIRE, SIDEWALL DAMAGE CAN OCCUR, POSSIBLY RESULTING IN A VEHICLE CRASH.",
        "correctiveSummary": "EIBACH WILL NOTIFY OWNERS AND OFFER TO PROVIDE NEW STRUTS FREE OF CHARGE. THE RECALL IS EXPECTED TO BEGIN ON DECEMBER 1, 2006.  OWNERS MAY CONTACT EIBACH AT 951-256-8300.",
        "recallNotes": "THIS RECALL ONLY PERTAINS TO AFTERMARKET EIBACH BRANDED FRONT STRUTS AND SUSPENSION KITS AND HAS NO RELATION TO ANY ORIGINAL EQUIPMENT INSTALLED ON FORD MUSTANG GT VEHICLES MANUFACTURED BY FORD MOTOR COMPANY.CUSTOMERS MAY CONTACT THE NATIONAL HIGHWAY TRAFFIC SAFETY ADMINISTRATION'S VEHICLE SAFETY HOTLINE AT 1-888-327-4236 (TTY: 1-800-424-9153); OR GO TO HTTP://WWW.SAFERCAR.GOV.",
        "recallComponentId": "000023053000219072000000023",
        "created": 1390516455609,
        "updated": 1390516455609
    },
    {
        "id": "52e198ee03647b232f8b4ebd",
        "vehicleMake": "FORD",
        "vehicleModel": "MUSTANG",
        "year": "2007",
        "manufacturerFilingDefect": "FORD MOTOR COMPANY",
        "beginDateOfManufacturing": "20050422",
        "endDateOfManufacturing": "20080131",
        "recallType": "V",
        "unitsAffected": "434593",
        "dateNotifiedByMfr": "20080303",
        "recallInitiator": "OVSC",
        "manufacturer": "Ford Motor Company",
        "reportReceivedDate": "20080225",
        "reportCreationDate": "20080226",
        "regulationPartNumber": "571",
        "fmvssNumber": "208",
        "defectSummary": "FORD IS RECALLING 434,593 MY 2008 MUSTANG VEHICLES FOR FAILING TO COMPLY WITH ONE OF THE NECK INJURY REQUIREMENTS OF FEDERAL MOTOR VEHICLE SAFETY STANDARD NO. 208, \"OCCUPANT CRASH PROTECTION,\" FOR AN UNBELTED 5TH PERCENTILE FEMALE SITTING IN THE PASSENGER SEAT WHILE IT IS IN THE FULL FORWARD POSITION.  ",
        "consequenceSummary": "DURING AN AIR BAG DEPLOYMENT, IF A SMALL FEMALE IN THE FRONT PASSENGER SEAT IS NOT WEARING THE SAFETY BELT, AND HAS THE SEAT IN THE FULL FORWARD POSITION, THERE MAY BE AN INCREASED POTENTIAL FOR A NECK INJURY.",
        "correctiveSummary": "DEALERS WILL REPROGRAM THE RESTRAINT CONTROL MODULE FREE OF CHARGE.  THE RECALL BEGAN ON MARCH 3, 2008.  OWNERS MAY CONTACT FORD AT 1-866-436-7332 OR THROUGH EMAIL TO WWW.OWNERCONNECTION.COM. ",
        "recallNotes": "FORD RECALL NO. 08C02.CUSTOMERS MAY ALSO CONTACT THE NATIONAL HIGHWAY TRAFFIC SAFETY ADMINISTRATION'S VEHICLE SAFETY HOTLINE AT 1-888-327-4236 (TTY 1-800-424-9153), OR GO TO HTTP://WWW.SAFERCAR.GOV.",
        "recallComponentId": "000026113000219072000000257",
        "created": 1390516462129,
        "updated": 1390516462129
    },
    {
        "id": "52e198f003647b232f8b74e9",
        "vehicleMake": "FORD",
        "vehicleModel": "MUSTANG",
        "year": "2007",
        "manufacturerFilingDefect": "SABERSPORT",
        "beginDateOfManufacturing": "",
        "endDateOfManufacturing": "",
        "recallType": "E",
        "unitsAffected": "16270",
        "dateNotifiedByMfr": "20090511",
        "recallInitiator": "OVSC",
        "manufacturer": "Ford Motor Company",
        "reportReceivedDate": "20090407",
        "reportCreationDate": "20090407",
        "regulationPartNumber": "571",
        "fmvssNumber": "108",
        "defectSummary": "SABERSPORT IS RECALLING 16,270 COMBINATION CORNER AND BUMPER LAMP ASSEMBLIES OF VARIOUS PART NUMBERS SOLD FOR USE AS AFTERMARKET EQUIPMENT FOR VARIOUS PASSENGER VEHICLES.  THESE HEADLAMPS FAIL TO CONFORM TO THE REQUIREMENTS OF FEDERAL MOTOR VEHICLE SAFETY STANDARD NO. 108, \"LAMPS, REFLECTIVE DEVICES, AND ASSOCIATED EQUIPMENT.\"  THESE LAMPS DO NOT CONTAIN THE REQUIRED AMBER SIDE REFLECTORS.",
        "consequenceSummary": "DECREASED LIGHTING VISIBILITY MAY RESULT IN A VEHICLE CRASH.",
        "correctiveSummary": "SABERSPORT WILL NOTIFY OWNERS AND OFFER A FULL REFUND FOR THE NONCOMPLIANT COMBINATION LAMPS.  THE SAFETY RECALL BEGAN ON MAY 11, 2009.  OWNERS MAY CONTACT SABERSPORT AT 1-909-598-7589.  ",
        "recallNotes": "THIS RECALL ONLY PERTAINS TO AFTERMARKET REPLACEMENT EQUIPMENT AND HAS NO RELATION TO ANY ORIGINAL EQUIPMENT INSTALLED ON VEHICLES PRODUCED BY THE VEHICLE MANUFACTURER.IN ORDER TO DETERMINE IF YOUR AFTERMARKET LAMP ASSEMBLY IS AFFECTED BY THIS NONCOMPLIANCE, PLEASE REVIEW THE LIST OF MODEL NUMBERS PROVIDED TO US BY SABERSPORT.THE LIST CAN BE FOUND UNDER \"DOCUMENT SEARCH\" LOCATED AT THE BOTTOM OF YOUR SCREEN.OWNERS MAY ALSO CONTACT THE NATIONAL HIGHWAY TRAFFIC SAFETY ADMINISTRATION'S VEHICLE SAFETY HOTLINE AT 1-888-327-4236 (TTY 1-800-424-9153), OR GO TO <A HREF=HTTP://WWW.SAFERCAR.GOV>HTTP://WWW.SAFERCAR.GOV</A> .",
        "recallComponentId": "000030698000219072000000216",
        "created": 1390516464820,
        "updated": 1390516464820
    },
    {
        "id": "52e198f103647b232f8b7e71",
        "vehicleMake": "FORD",
        "vehicleModel": "MUSTANG",
        "year": "2007",
        "manufacturerFilingDefect": "DOPE, INC.",
        "beginDateOfManufacturing": "",
        "endDateOfManufacturing": "",
        "recallType": "E",
        "unitsAffected": "42540",
        "dateNotifiedByMfr": "20090728",
        "recallInitiator": "OVSC",
        "manufacturer": "Ford Motor Company",
        "reportReceivedDate": "20090511",
        "reportCreationDate": "20090511",
        "regulationPartNumber": "571",
        "fmvssNumber": "108",
        "defectSummary": "DOPE, INC. IS RECALLING 42,540 COMBINATION CORNER AND BUMPER LAMP ASSEMBLIES OF VARIOUS PART NUMBERS SOLD FOR USE AS AFTERMARKET EQUIPMENT FOR VARIOUS PASSENGER VEHICLES.  THESE HEADLAMPS FAIL TO CONFORM TO THE REQUIREMENTS OF FEDERAL MOTOR VEHICLE SAFETY STANDARD NO. 108, \"LAMPS, REFLECTIVE DEVICES, AND ASSOCIATED EQUIPMENT.\"  THESE LAMPS DO NOT CONTAIN THE REQUIRED AMBER SIDE REFLECTORS.",
        "consequenceSummary": "DECREASED LIGHTING VISIBILITY MAY RESULT IN A VEHICLE CRASH.",
        "correctiveSummary": "DOPE, INC. WILL NOTIFY OWNERS AND OFFER A FULL REFUND FOR THE NONCOMPLIANT COMBINATION LAMPS.  THE SAFETY RECALL BEGAN ON JULY 28, 2009.  OWNERS MAY CONTACT DOPE, INC. AT 1-626-272-1798.  ",
        "recallNotes": "THIS RECALL ONLY PERTAINS TO AFTERMARKET REPLACEMENT EQUIPMENT AND HAS NO RELATION TO ANY ORIGINAL EQUIPMENT INSTALLED ON VEHICLES PRODUCED BY THE VEHICLE MANUFACTURER.IN ORDER TO DETERMINE IF YOUR AFTERMARKET LAMP ASSEMBLY IS AFFECTED BY THIS NONCOMPLIANCE, PLEASE REVIEW THE LIST OF MODEL NUMBERS PROVIDED TO US BY DOPE, INC.THE LIST CAN BE FOUND UNDER \"DOCUMENT SEARCH\" LOCATED AT THE BOTTOM OF YOUR SCREEN. OWNERS MAY ALSO CONTACT THE NATIONAL HIGHWAY TRAFFIC SAFETY ADMINISTRATION'S VEHICLE SAFETY HOTLINE AT 1-888-327-4236 (TTY 1-800-424-9153), OR GO TO <A HREF=HTTP://WWW.SAFERCAR.GOV>HTTP://WWW.SAFERCAR.GOV</A> .",
        "recallComponentId": "000031517000219072000000217",
        "created": 1390516465374,
        "updated": 1390516465374
    }
]
</pre>


<h3>Description</h3>

<p>Data in the JSON ...</p>

<table width="100%" border="1">

<tr>
<td><span style="color:red">id</span><br/>(guaranteed)</td>
<td>
Unique ID for this favor.
</td>
</tr>


<tr>
<td><span style="color:red">vehicleMake</span><br/>(guaranteed)</td>
<td>
The "make" of the vehicle.
</td>
</tr>

<tr>
<td><span style="color:red">vehicleModel</span><br/>(guaranteed)</td>
<td>
The "model" of the vehicle.
</td>
</tr>

<tr>
<td><span style="color:red">year</span><br/>(guaranteed)</td>
<td>The "year" of the vehicle.</td>
</tr>

<tr>
<td><span style="color:black">manufacturerFilingDefect</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">beginDateOfManufacturing"</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">endDateOfManufacturing</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">recallType</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">unitsAffected</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">dateNotifiedByMfr</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">recallInitiator</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">manufacturer</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">reportReceivedDate</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">reportCreationDate</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">regulationPartNumber</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">fmvssNumber</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>




<tr>
<td><span style="color:red">defectSummary</span><br/>(guaranteed)</td>
<td>A summary description of the defect.
</td>


<tr>
<td><span style="color:red">consequenceSummary</span><br/>(guaranteed)</td>
<td>A summary of the consequences of the defect.
</td>

<tr>
<td><span style="color:red">correctiveSummary</span><br/>(guaranteed)</td>
<td>A summary of the corrective actions to be taken.
</td>


<tr>
<td><span style="color:black">recallNotes</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>

<tr>
<td><span style="color:black">recallComponentId</span><br/>(NOT guaranteed)</td>
<td></td>
</tr>





<tr>
<td><span style="color:red">created</span><br/>(guaranteed)</td>
<td>
The time that this recall was recording by alpine.<br/>
(Specified as an epoch time value).
</tr>

<tr>
<td><span style="color:red">updated</span><br/>(guaranteed)</td>
<td>
The time that this recall was updated by alpine.<br/>
(Specified as an epoch time value).
</tr>



</tr>

</table>


<br/><br/>




<h3>(2) Response Code = 400: &quot;Bad Request&quot; </h3>
<p>If there was a major error in the request that prevents us from even processing it,<br/>
the standard JSON describing the error will be returned in the body of the response:</p>

<pre>
HTTP/1.1 400 Bad Request

{
    "errorCode": 2,
    "errorMessage": "INVALID PARAMS",
    "data": "make not specified"
}
</pre>


<h3>(3) Response Code = 500: &quot;Server Error&quot; </h3>
<p>If there was a major error on the server,<br/>
the standard JSON describing the error will be returned in the body of the response:</p>

<pre>
HTTP/1.1 500 Server Error

{
    "errorCode": 3,
    "errorMessage": "SERVER ERROR",
    "data": "Unable to connect to the database."
}
</pre>


<br/><hr/>
<h2>Example Java code</h2>

<pre>
TBD
</pre>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48110106-1', 'alpineconnectivity.com');
  ga('send', 'pageview');

</script>
</body>
</html>