<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>PUT station</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<jsp:include page="inc/putStationUsages.jsp" />

<h1>Usage 1: PUT station/[stationId]</h1>

<p>Update gas prices for a particular gas stations.</p>


<br/><hr/>
<h2>HTTP Request: Headers</h2>

<p>The request method is PUT.<br/>
For example:</p>

<pre>
PUT /station/99510 HTTP/1.1
Host: dev5:8888
</pre>


<br/><hr/>
<h2>HTTP Request: Headers: Request Method Parameters</h2>

<p>One way to pass data to a service is via the parameters of the request method 
in the "headers" section of the HTTP request.<br/>
This service utilizes this approach to pass the data described below ...</p>

<table width="100%" border="1">
<tr>
<td>stationId<br/>(required)</td>
<td>This is the "station" id.<br/>
A unique identifier for each gas station.<br/>
This will always be an integer and is provided by an external service.</td>
</tr>
</table>


<br/><hr/>
<h2>HTTP Request: Body: Parameters</h2>

<p>Another way to pass data to a service is via the body of the HTTP request.<br/>
This service passes data in this fashion in a JSON data structure.<br/>
An example of the data structure and a detailed description of its elements follows...</p>

<h3>Example</h3>

<p>An example of the JSON to put in the body ...</p>

<pre>
{
    "apiKey": "secret",
    "dev": "asdfasfsad0adsfa",
    "app": "snapGas",
    "user": "alexryan@gmail.com",
    "stationId": "99510",
    "updateTime": 1375921800776,
    "prices": [
        {
            "fuelType": "reg",
            "price": "4.16"
        },
        {
            "fuelType": "mid",
            "price": "4.36"
        },
        {
            "fuelType": "pre",
            "price": "4.46"
        }
    ]
}
</pre>


<h3>Description</h3>

<p>A detailed description of this data ...</p>

<table width="100%" border="1">

<tr>
<td><span style="color:red">apiKey</span><br/>(required)</td>
<td>The apiKey which identifies which developer is requesting to use the service.<br/>
apiKey, dev, app and user are required for most Alpine data-changing operations.</td>
</tr>


<tr>
<td><span style="color:red">dev</span><br/>(required)</td>
<td>This is the deviceId of the device sending the request.<br/>
apiKey, dev, app and user are required for most Alpine data-changing operations.</td>
</tr>

<tr>
<td><span style="color:red">app</span><br/>(required)</td>
<td>
The name of the application making the request. e.g. "SnapGas"<br/>
apiKey, dev, app and user are required for most Alpine data-changing operations.</td>
</tr>

<tr>
<td><span style="color:red">user</span><br/>(required)</td>
<td>
The email address of the person making the change.<br/>
apiKey, dev, app and user are required for most Alpine data-changing operations.</td>
</tr>

<tr>
<td>stationId<br/>(required)</td>
<td>This is the "station" id.<br/>
A unique identifier for each gas station.<br/>
This will always be an integer and is provided by myGasFeed.com</td>
</tr>

<tr>
<td>updateTime<br/>(required)</td>
<td>An integer. Milliseconds since the epoch.<br/>
This is the time that the user of the device initiated the operation.<br/>
It may be very different than the time that the request is actually received by the server.<br/><br/>
Note that we currently only validate the updateTime submitted, 
by checking to make sure that <br/>
(1) it is not in the future<br/>
(2) it is not too far in the past<br/>
If the time is more than 10 mins into the future<br/>
or more than 365 days into the past<br/>
the PUT will be rejected.<br/><br/>
Currently, we do NOT check to make sure that the time submitted is NEWER
than the time we are overwriting in the database.<br/>
That means that a user may upload a price from several weeks ago and 
overwrite a price that was submitted by another user a few seconds ago.<br/>
</td>
</tr>

<tr>
<td>prices<br/>(required)</td>
<td>An array of prices. There must be at least one gas price in this submission.</td>
</tr>

<tr>
<td>prices.type<br/>(required)</td>
<td>The type of gas<br/>
The type must be one of {"reg", "mid", "pre", "diesel"}<br/>
If the type for any of the gas prices submitted is anything else, the PUT will be rejected.
</td>
</tr>

<tr>
<td>prices.price<br/>(required)</td>
<td>The price of the gas<br/>
The price must be a decimal of the form d.dd where d is a digit between 0 and 9.<br/>
Also the price must be between the range of 0.00 and 5.00.<br/>
If any of the prices submitted does not satisfy this criteria, the PUT will be rejected.
</td>
</tr>

</table>


<br/><br/>
<br/><hr/>
<h2>HTTP Response: HEAD: Headers</h2>

<p>The following response codes are possible from this service.<br/>
(Client code must handle each of them.):</p>

<ul>
<li><b>201 Created</b></li>
<!--  
<li><b>207 Multi-Status</b>: There was at least one error.</li>
-->
<li><b>400 Bad Request</b></li>
<li><b>500 Server Error</b></li>
</ul>

<p>
The content of the body of the HTTP Response will always be JSON.<br/>
Therefore, the following header will always be sent:<br/>
<b>Content-Type: application/json</b>
</p>


<br/><hr/>
<h2>HTTP Response: Body</h2>

<p>The body of the response should aloways contain JSON.<br/>
The type of JSON returned varies by the response code.<br/>
3 types of JSON are possible.</p>


<h3>(1) Response Code = 201: &quot;Created&quot; </h3>
<p>If the service executed successfully<br/>
JSON like the following will be returned in the body of the response:</p>

<pre>
HTTP/1.1 201 Created

{
    "numberOfPriceUpdatesRequested": 3,
    "numberOfPricesUpdated": 3
}
</pre>

<!-- 
<h3>(2) Response Code = 207: &quot;Multi-Status&quot; </h3>
<p>If there were any errors with any of the data,<br/>
the standard JSON describing the error will be returned in the body of the response:</p>

<pre>
HTTP/1.1 207 Multi-Status

{
    "numberOfRecordsReceived": 2,
    "numberOfRecordsProcessed": 1,
    "numberOfErrors": 1,
    errors: [
        {
            "errorCode": 1,
            "errorMessage": "INVALID JSON: ",
            "data:": "apiKey was not specified."
        }
    ]
}
</pre>
 -->

<h3>(2) Response Code = 400: &quot;Bad Request&quot; </h3>
<p>If there was a major error the request that prevents us from even processing it,<br/>
the standard JSON describing the error will be returned in the body of the response:</p>

<pre>
HTTP/1.1 400 Bad Request

{
    "errorCode": 1,
    "errorMessage": "INVALID JSON",
    "data": "No JSON was POSTed!"
}
</pre>


<h3>(3) Response Code = 500: &quot;Server Error&quot; </h3>
<p>If there was a major error the request that prevents us from even processing it,<br/>
the standard JSON describing the error will be returned in the body of the response:</p>

<pre>
HTTP/1.1 500 Server Error

{
    "errorCode": 3,
    "errorMessage": "SERVER ERROR",
    "data": "Unable to read the body of the HTTP POST."
}
</pre>




<br/><hr/>
<h2>HTTP Response: Examples (Failure)</h2>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: apiKey was not specified."
}
</pre>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: dev (deviceId) was not specified"
}
</pre>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: app was not specified"
}
</pre>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: user was not specified"
}
</pre>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: id (station id) was not specified."
}
</pre>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: updateTime was not specified"
}
</pre>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: updateTime (0) is invalid.\nCorresponding DateTime is: 1969-12-31T4:0:00-0800\nCurrent DateTime is: 2013-08-07T5:16:55-0700\nCan't be more than 10 minutes into the future. \nCannot be more than 365 days into the past."
}
</pre>

<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: fuelType had a value of (reg1). fuelType must be one of { reg, mid, pre, diesel }"
}
</pre>


<pre>
{
    "errorCode": 1,
    "errorMessage": "INVALID JSON received in the HTTP REQUEST: price had a value of (5.16). price must either be |N/A| or must match the regular expression: (\\d{1,1}.{1,1}\\d{2,2}). and must also be within the range of 0.00 to 5.00"
}
</pre>

<p>This list is not comprehensive.<br/>
An errorCode of 3 will be returned if there was some sort of server error.<br/>
In general, if you received an errorCode of 1 or 2, the data that you are trying to send is invalid.<br/>
So you probably shouldn't try sending it again.<br/>
However, if you receive an errorCode of 3, there *might* be a temporary problem on the server
that will be resolved at a future time.<br/>
So you *might* want to try to send this again later.</p>


</body>
</html>