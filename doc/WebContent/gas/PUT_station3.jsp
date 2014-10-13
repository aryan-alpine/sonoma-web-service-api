<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>

<jsp:include page="inc/putStationUsages.jsp" />

<h1>Usage 1: PUT station/[stationId]</h1>

<p>Update gas prices for a particular gas stations.</p>


<br/><hr/>
<h2>HTTP Request: HEAD: Headers</h2>

<p>
The content of the POST must be JSON.<br/>
Therefore, the following header is appropriate to include in the request:<br/>
Content-Type: application/json
</p>


<br/><hr/>
<h2>HTTP Request: HEAD: Parameters</h2>

<table width="100%" border="1">
<tr>
<td>stationId<br/>(required)</td>
<td>This is the "station" id.<br/>
A unique identifier for each gas station.<br/>
This will always be an integer and is provided by myGasFeed.com</td>
</tr>
</table>


<br/><hr/>
<h2>HTTP Request: BODY: Parameters</h2>


<table width="100%" border="1">




<td><span style="color:red">dev</span><br/>(required)</td>
<td>This is the deviceId of the device sending the request.<br/>
dev, app and user are required for most Alpine data-changing operations.</td>
</tr>

<td><span style="color:red">app</span><br/>(required)</td>
<td>
The name of the application making the request. e.g. "SnapGas"<br/>
dev, app and user are required for most Alpine data-changing operations.</td>
</tr>

<td><span style="color:red">user</span><br/>(required)</td>
<td>
The email address of the person making the change.<br/>
dev, app and user are required for most Alpine data-changing operations.</td>
</tr>

<tr>
<td>id<br/>(required)</td>
<td>This is the "station" id.<br/>
A unique identifier for each gas station.<br/>
This will always be an integer and is provided by myGasFeed.com</td>
</tr>

<tr>
<td>createTime<br/>(required)</td>
<td>An integer. Milliseconds since the epoch.<br/>
This is the time that the user of the device initiated the operation.<br/>
It may be very different than the time that the request is actually received by the server.</td>
</tr>


<tr>
<td>name<br/>(optional)</td>
<td>The name of the gas station. e.g. Shell, Chevron, 76, etc.<br/>
NOTE: This should typically NOT be sent.<br/>
The purpose of this service is to update the gas prices at a partcular gas station.</td>
</tr>

<tr>
<td>notes<br/>(optional)</td>
<td>Notes about the station</td>
</tr>

<tr>
<td>lat<br/>(required)</td>
<td>latitude</td>
</tr>

<tr>
<td>lng<br/>(required)</td>
<td>longitude</td>
</tr>

<tr>
<td>address<br/>(optional)</td>
<td></td>
</tr>

<tr>
<td>city<br/>(optional)</td>
<td></td>
</tr>

<tr>
<td>region<br/>(optional)</td>
<td>state or province</td>
</tr>

<tr>
<td>country<br/>(optional)</td>
<td></td>
</tr>

<tr>
<td>telephone<br/>(optional)</td>
<td></td>
</tr>

<tr>
<td>prices<br/>(required)</td>
<td>An array of prices. There must be at least one gas price in this submission.</td>
</tr>

<tr>
<td>prices.type<br/>(required)</td>
<td>The type of gas</td>
</tr>

<tr>
<td>prices.price<br/>(required)</td>
<td>The price of the gas</td>
</tr>

<tr>
<td>pics.title<br/>(optional)</td>
<td>An array of pictures of the gas station. Pictures are entriely optional.</td>
</tr>

<tr>
<td>pics.title<br/>(optional)</td>
<td>The title given to an individual picture.</td>
</tr>

<tr>
<td>pics.base64<br/>(optional)</td>
<td>Pictures are transmitted to the server via the HTTP POST in ASCII base64 encoding.</td>
</tr>

</table>

<br/><hr/>
<h2>HTTP Request: Example</h2>

<pre>
{
    "apiKey": "secret",
    "uuid": "asdfasfsad0adsfa",
    "id": "99510",
    "name": "unbranded",
    "createTime": 1374094424,
    "reportedBy": "icantdrive55",
    "notes": "fuzz is there usually on friday nights",
    "lat": "37.385681",
    "lng": "-122.052696",
    "address": "789 E Evelyn Ave",
    "city": "Mountain View",
    "region": "California",
    "country": "United States",
    "zipCode": "",
    "telephone": "",
    "prices": [
        {
            "type": "reg",
            "price": "4.16"
        },
        {
            "type": "mid",
            "price": "4.36"
        },
        {
            "type": "pre",
            "price": "4.46"
        }
    ],
    "pics": [
        {
            "title": "my picture of this gas station",
            "base64": "AAAAAA"
        },
        {
            "title": "my other picture of this gas station",
            "base64": "BBBBB"
        }
    ]
}
</pre>

<br/><hr/>
<h2>HTTP Response: Example</h2>

<pre>
51e708270d860b0c8bd0c354
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