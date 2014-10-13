<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="US-ASCII">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<h1>GET favors</h1>

<p>Retrieve a list of favors (1) you have asked of others or (2) have been asked of you.</p>


<table>
<tr>
<td>
<img src="img/FlashTask-StateChart.png" />
</td>
<td width="100%" valign="top">
<p>The state-chart diagram to the left indicates the series of states that a favor request
may go through and the transitions between those states that are possible based on the
actions of <b>the requestor (A)</b> and/or <b>the requestee (B)</b> of the favor.<br/><br/>
The service may be used on behalf of an individual user to get a list of all of the favors
(1) they have requested of others, or (2) have been requested of them, or both.<br/><br/>

This list of favors requested may also be filtered by a specific range of dates and times
 using the (1) start and (2) end parameters.<br/><br/>
 
This list of favors requested may also be filtered by the <b>status</b> of the favor request. A favor request may be
in one of 4 possible states at any time. However, these states map to only 2 statuses. 
The following table describes that mapping...
<br/><br/>

<table align="center" border="1">
<tr>
<th>state</th>
<th>status</th>
</tr>
<tr>
<td>requested</td>
<td>active</td>
</tr>
<tr>
<td>accepted</td>
<td>active</td>
</tr>
<tr>
<td>completed (finished)</td>
<td>inactive</td>
</tr>
<tr>
<td>cancelled (quit)</td>
<td>inactive</td>
</tr>
<tr>
<td>rejected (quit)</td>
<td>inactive</td>
</tr>


</table>

<br/>
</p>
</td>
</tr>
</table>



<p>This service can be used with or without filters:<br/>
All filters are optional.<br/>
Filters may be specified in any order.<br/>
</p>


<table border="1">
<tr>
  <th>Filter</th>
  <th>Example</th>
</tr>
<tr>
  <td>inOut</td>
  <td>
  <b>GET /flashTask/favors/inOut/in</b><br/>
  <b>GET /flashTask/favors/inOut/out</b><br/>
  <b>GET /flashTask/favors/inOut/both</b> &nbsp;&nbsp;(Default)
  </td>
</tr>

<tr>
  <td>status</td>
  <td>
  <b>GET /flashTask/favors/status/active</b><br/>
  <b>GET /flashTask/favors/status/inactive</b><br/>
  <b>GET /flashTask/favors/status/both</b> &nbsp;&nbsp;(Default)
  </td>
</tr>

<tr>
  <td>start & end</td>
  <td>
  <b>GET /flashTask/favors/start/1355280430000/end/1418352430000</b><br/>
  <b>GET /flashTask/favors/start/1355280430000</b><br/>
  <b>GET /flashTask/favors/end/1418352430000</b><br/>
  </td>
</tr>

<tr>
  <td></td>
  <td>
  <b>GET /flashTask/favors</b>
  </td>
</tr>

</table>

<br/><hr/>
<h2>HTTP Request: Headers</h2>

<p>The request method is GET.<br/>
For example:</p>

<pre>
GET /flashTask/favors/inOut/out/status/active/start/1355280430000/end/1418352430000
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=
</pre>

<p>NOTE: This service requires that the user be authenticated.</p>

<p>NOTE: The authenticated user of this service may only retrieve favors which
(1) they requested of others or (2) which were requested by others of them.</p>

<br/><hr/>
<h2>HTTP Request: Headers: Request Method Parameters</h2>

<p> When the request method is GET or DELETE, 
the conventional way to pass data to the service is via 
the parameters of the "request method" 
in the "headers" section of the HTTP request.<br/>
</p>

<h3>Example</h3>

<pre>
GET /flashTask/favors/inOut/out/status/active/start/1355280430000/end/1418352430000
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=
</pre>

<h3>Description</h3>

<p>For each individual input parameter ...</p>

<table width="100%" border="1">

<tr>
<td>inOut<br/>(optional)</td>
<td>One of {"in", "out", "both"}<br/><br/>

<table border="1">
<tr>
<th>parameter</th>
<th>value</th>
</tr>
<tr>
<td>in</td>
<td>GET favor requests that have been <b>received from</b> others<br/></td>
</tr>
<tr>
<td>out</td>
<td>GET favor requests that have been <b>sent to</b> others</td>
</tr>
<tr>
<td>both</td>
<td>GET both.<br/>
NOTE: This is the default behavior.<br/>
If this optional paramter is not specified, both will be returned.</td>
</tr>
</table>
<br/>

</td>
</tr>



<tr>
<td>status<br/>(optional)</td>
<td>Filter favor requests by their current status.<br/>
Must be one of {"active", "inactive", "both"}.<br/>
<br/>
<table border="1">
<tr>
<th>parameter</th>
<th>value</th>
</tr>
<tr>
<td>active</td>
<td>GET favor requests that are in a state of <b>requested</b> or <b>accepted</b><br/></td>
</tr>
<tr>
<td>inactive</td>
<td>GET favor requests that are in a state of <b>completed</b>, <b>cancelled</b> or <b>rejected</b><br/></td>
</tr>
<tr>
<td>both</td>
<td>GET all favor requests regardless of their current state.<br/>
NOTE: This is the default behavior.<br/>
If this optional parameter is not specified, results will not be filtered by state.</td>
</tr>
</table>
<br/>

</td>
</tr>


<tr>
<td>start<br/>(optional)</td>
<td>Exclude all favor requests BEFORE this epoch time.
</td>
</tr>

<tr>
<td>end<br/>(optional)</td>
<td>Exclude all favor requests AFTER this epoch time.
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
        "id": "52a67d480364cb0ef3d4f563",
        "requestor": "alexander.j.ryan@gmail.com",
        "requestee": "wmcfadden@alpineconnectivity.com",
        "action": "Review the spec for the favor services, and let me know if any changes are required before I start implementing",
        "timeRequestMade": 1386642760600,
        "timeFulfillmentDesired": 1420070399000,
        "state": 1
    },
    {
        "id": "52a8e7a40364beaef10e92a8",
        "requestor": "alexander.j.ryan@gmail.com",
        "requestee": "aryan@alpineconnectivity.com",
        "action": "Stop being so awesome",
        "timeRequestMade": 1386801060112,
        "state": 3
    },
    {
        "id": "52a911960364b7d9b0ee21d6",
        "requestor": "aryan@alpineconnectivity.com",
        "requestee": "alexander.j.ryan@gmail.com",
        "action": "Stop being so FREEKIN awesome",
        "timeRequestMade": 1386811798533,
        "state": 3
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
<td><span style="color:red">requestor</span><br/>(guaranteed)</td>
<td>
User ID of the person requesting the favor.
</td>
</tr>

<tr>
<td><span style="color:red">requestee</span><br/>(guaranteed)</td>
<td>
User ID of the person fulfilling the favor.
</td>
</tr>

<tr>
<td><span style="color:red">action</span><br/>(guaranteed)</td>
<td>A written description of what the requestor would like to have done.</td>
</tr>


<tr>
<td><span style="color:red">timeRequestMade</span><br/>(guaranteed)</td>
<td>
The time that the request was made.<br/>
(Specified as an epoch time value).
</tr>

<tr>
<td><span style="color:black">timeFulfillmentDesired</span><br/>(NOT guaranteed)</td>
<td>
The time that the request was made.<br/>
(Specified as an epoch time value).
</tr>

<tr>
<td><span style="color:red">state</span><br/>(guaranteed)</td>
<td>At any given moment, a favor request may only be in one of the following 5
valid states: {0, 1, 2, 3, 4}<br/><br/>
Mapping of states to codes ... <br/><br/>
<jsp:include page="favorRequestStates.jsp" />
<br/>

</td>

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
    "data": "userId not specified"
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
package com.alpine.rest.flashTask;

import java.io.IOException;
import java.util.List;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import com.alpine.data.http.common.RestError;
import com.alpine.data.http.flashTask.common.Favor;
import com.alpine.rest.GetEqs;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class GetFavors {

  private static Logger logger = Logger.getLogger(GetEqs.class.getName());
  
  /**
   * @param args
   */
  public static void main(String[] args) {

    //String url = "http://localhost:8080/flashTask/favors/inOut/out/status/both/start/1355280430000/end/1418352430000";
    DefaultHttpClient httpclient = new DefaultHttpClient();
    HttpGet httpget = new HttpGet("/flashTask/favors/inOut/out/status/both/start/1355280430000/end/1418352430000");
    
    /////////////////////////////////////////////////////////////////////////
    // Add Basic Authentication to the Authorization Header
    /////////////////////////////////////////////////////////////////////////
    
    HttpHost targetHost = new HttpHost("localhost", 8080, "http");
    AuthScope authScope = new AuthScope(targetHost.getHostName(), targetHost.getPort());
    UsernamePasswordCredentials credentials = new UsernamePasswordCredentials("alexander.j.ryan@gmail.com", "beast");
    httpclient.getCredentialsProvider().setCredentials(authScope, credentials);
    
    // Create AuthCache instance
    AuthCache authCache = new BasicAuthCache();
    // Generate BASIC scheme object and add it to the local
    // auth cache
    BasicScheme basicAuth = new BasicScheme();
    authCache.put(targetHost, basicAuth);

    // Add AuthCache to the execution context
    BasicHttpContext localcontext = new BasicHttpContext();
    localcontext.setAttribute(ClientContext.AUTH_CACHE, authCache);


    /////////////////////////////////////////////////////////////////////////
    // Execute the request!!!
    /////////////////////////////////////////////////////////////////////////
    
    HttpResponse response = null;
    try {
      //response = httpclient.execute(httpGet);
      response = httpclient.execute(targetHost, httpget, localcontext);
    } catch (IOException e) {
      e.printStackTrace();
      System.exit(1);
    }

    // The underlying HTTP connection is still held by the response object
    // to allow the response content to be streamed directly from the network
    // socket.
    // In order to ensure correct deallocation of system resources
    // the user MUST either fully consume the response content or abort request
    // execution by calling HttpGet#releaseConnection().

    try {

      /////////////////////////////////////////////////////////////////////////
      // What's in the response headers?
      /////////////////////////////////////////////////////////////////////////
      
      StatusLine statusLine = response.getStatusLine();
      int statusCode = statusLine.getStatusCode();
      logger.info("statusCode=|" + statusCode + "|");

      Header[] headers = response.getAllHeaders();
      for (Header header : headers) {
        String name = header.getName();
        String value = header.getValue();
        logger.info(name + ": " + value);
      }
      
      /////////////////////////////////////////////////////////////////////////
      // What's in the body?
      /////////////////////////////////////////////////////////////////////////
      HttpEntity entity = response.getEntity();
      String json2 = EntityUtils.toString(entity);
      logger.info("json2=|" + json2 + "|");
      
      switch (statusCode) {
      
        case 200:
          handleSuccess(json2);
          break;
          
        case 400:
          handleError(json2);
          break;
          
        case 500:
          handleError(json2);
          break;
        
      }      

      
      // Header contentEncodingHeader = entity1.getContentEncoding();
      EntityUtils.consume(entity);

    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      httpget.releaseConnection();
    }


  } // main
  
  
  /**
   * 
   * @param json2
   */
  public static void handleSuccess(String json) {

    Gson gson = new Gson();
    List<Favor> favors =  gson.fromJson(json, new TypeToken<List<Favor>>(){}.getType());

    for (Favor favor : favors) {
      
      String id                   = favor.getId();
      String requestor            = favor.getRequestor();
      String requestee            = favor.getRequestee();
      String action               = favor.getAction();
      Integer state               = favor.getState();
      Long timeRequestMade        = favor.getTimeRequestMade();
      Long timeFulfillmentDesired = favor.getTimeFulfillmentDesired();
      
      DateTimeFormatter fmt = ISODateTimeFormat.dateTime();
      DateTime dt1 = new DateTime(timeRequestMade);
      String timeRequestMadeAsString = fmt.print(dt1);
      
      String timeFulfillmentDesiredAsString = "";
      if (timeFulfillmentDesired != null) {
        DateTime dt2 = new DateTime(timeFulfillmentDesired);
        timeFulfillmentDesiredAsString = fmt.print(dt2);
      }
      
      logger.info("----------------------------------------");
      logger.info("                     id=|" + id + "|");
      logger.info("              requestor=|" + requestor + "|");
      logger.info("              requestee=|" + requestee + "|");
      logger.info("                 action=|" + action + "|");
      logger.info("                  state=|" + state + "|");
      logger.info("        timeRequestMade=|" + timeRequestMadeAsString + "|");
      logger.info(" timeFulfillmentDesired=|" + timeFulfillmentDesiredAsString + "|");
      
    } // for
    
  } // handleSuccess
 
  /**
   * 
   */
  public static void handleError(String json2) {
    Gson gson = new Gson();
    RestError restError = gson.fromJson(json2, RestError.class);

    logger.info("errorCode=|" + restError.getErrorCode() + "|");
    logger.info("errorMessage=|" + restError.getErrorMessage() + "|");  
    logger.info("data=|" + restError.getData() + "|"); 
  }
  
}

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