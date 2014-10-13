<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="US-ASCII">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<h1>PUT favor</h1>

<p>Update the status of a favor request.<br/>
Update options include ...<br/>
The user who requested the favor, may cancel at any time.<br/>
The user who received the request, may accept, reject or mark it as completed.<br/><br/>
In addition to updating the status of the record on the server,
this service also sends a notification to the other party 
to let them know about the change in status via Google Cloud Messaging
</p>

<br/><hr/>
The following state-chart diagram illustrates the kinds of state transitions
that a favor request may make in it's lifecycle:<br/><br/>

<table>
<tr>
<td>
<img src="img/FlashTask-StateChart.png" />
</td>
<td width="100%" valign="top">
<p>The <b>POST</b> service is used by the <b>requestor (A)</b> to make the request.<br/><br/>
It merely places the favor into the <b>requested</b> state.<br/><br/>
The <b>requestee (B)</b> is also be notified of the request.<br/><br/>
Subsequent state transitions are accomplished via the invocation of this <b>PUT</b> service.<br/><br/>
As the diagram illustrates, some state transitions are only allowed to be made by the requestor (A)
[<b>cancel</b>], <br/><br/>
and some are only allowed to be made by the requestee (B) 
[<b>accept, reject, complete</b>].<br/><br/>
Every state transition by one of the parties generates a notification message to the other party.</p>
</td>
</tr>
</table>



<br/><hr/>
<h2>HTTP Request: Headers</h2>

<p>The request method is PUT.<br/>
For example:</p>

<pre>
PUT /flashTask/favor HTTP/1.1
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=
</pre>

<!--  
<br/><hr/>
<h2>HTTP Request: Headers: Request Method Parameters</h2>

<p>One way to pass data to a service is via the parameters of the request method 
in the "headers" section of the HTTP request.<br/>
This service does not utilize this approach.</p>
-->

<br/><hr/>
<h2>HTTP Request: BODY: Parameters</h2>

<p>Data is passed to POST & PUT services via the body of the HTTP request.<br/>
This service passes data in this fashion in a JSON data structure.<br/>
An example of the data structure and a detailed description of its elements follows...</p>

<h3>Example</h3>

<pre>
PUT /flashTask/favor HTTP/1.1
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=

{
    "id": "52002e760d8632cff83812c4",
    "state": "1"
}
</pre>

<p>NOTE: The Authorization header must contain the credentials from either
the requestor or requestee for this favor request.<br/>
The state transitions allowed vary depending on which of these two roles
the user is playing.</p>

<p>NOTE: There are a number of rules involved with the updating of 
a favor request.<br/>
These rules are enforced by the service. If you break any
of these rules, the service will return an error.<br/><br/>

<b>RULE:</b><br/>
Only the requestor and requestee are allowed to update the favor.<br/><br/>

<b>RULE:</b><br/>
After a favor is requested, some fields can be updated, some cannot.<br/><br/>

<b>Updateable fields:</b><br/>
<ul>
<li>state</li>
<li>timeFulfillmentDesired</li>
</ul>

<b>Non-updateable fields:</b><br/>
<ul>
<li>id</li>
<li>requestor</li>
<li>requestee</li>
<li>timeRequestMad</li>
<li>action</li>
</ul>

<br/><br/>
<b>RULE:</b><br/>
Changes to the state of a favor request must object the state transition diagram.<br/>
That means when a favor is in a certain state, only the transitions identified for that
state in the diagram are allowed AND each of these transitions is allowed only by
the requestor or requestee. These rules are enforced by the service. If you try to 
break the rules, an error will be returned.<br/><br/>

<h3>Description</h3>

<p>Data in the JSON ...</p>

<table width="100%" border="1">

<tr>
<td><span style="color:red">id</span><br/>(required)</td>
<td>
The unique identifier for the favor.
</td>
</tr>

<tr>
<td><span style="color:red">state</span><br/>(required)</td>
<td>At any given moment, a favor request may only be in one of the following 5
valid states: {0, 1, 2, 3, 4}<br/><br/>
Mapping of states to codes ... <br/><br/>
<jsp:include page="favorRequestStates.jsp" />
<br/>

Rules enforced by the service:<br/>
Only the requestor can use <b>cancelled</b><br/>
Only the requestee can use <b>accepted, rejected, completed</b><br/>
Only state transitions specified by the state-transition diagram are allowed.<br/>
For example: A request must be accepted before it can be completed.<br/>
Once a favor has been placed into a completed or cancelled state, no other changes are allowed.<br/>
</td>
</tr>

</table>


<br/><br/>
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
4 types of JSON are possible.</p>


<h3>(1) Response Code = 200: &quot;Success&quot; </h3>
<p>If the service executed successfully<br/>
JSON like the following will be returned in the body of the response:</p>

<pre>
HTTP/1.1 200 Success
</pre>


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


<h3>(3) Response Code = 401: &quot;Not Authorized&quot; </h3>
<p>If a valid username/password was not passed via the Basic Authentication mechanism,
this error code will be returned.</p>

<pre>
HTTP/1.1 401 Not Authorized
WWW-Authenticate: Basic realm="alpineconnectivity.com"

{
    "errorCode": 401,
    "errorMessage": "Not Authorized",
    "data": "Authorization header was not found."
}
</pre>


<h3>(4) Response Code = 500: &quot;Server Error&quot; </h3>
<p>If an error occurred on the server that prevents us from satisfying the request,<br/>
the standard JSON describing the error will be returned in the body of the response:</p>

<pre>
HTTP/1.1 500 Server Error

{
    "errorCode": 3,
    "errorMessage": "SERVER ERROR",
    "data": "Error inserting record into the database.."
}
</pre>


<br/><hr/>
<h2>Example Java code</h2>

<pre>
package com.alpine.rest.flashTask;

import java.io.IOException;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.StatusLine;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.alpine.data.http.common.RestError;
import com.alpine.data.http.flashTask.common.Favor;
import com.google.gson.Gson;

public class PutFavor {

  private static Logger logger = Logger.getLogger(PutFavor.class.getName());
  
  /**
   * @param args
   */
  public static void main(String[] args) {

    /////////////////////////////////////////////////////////////////////////
    // Create the PUT request
    /////////////////////////////////////////////////////////////////////////
    
    Favor favor = new Favor();
    favor.setId("52ab8741036450c0d6436407");
    favor.setState(Favor.ACCEPTED);
    
    Gson gson = new Gson();
    String json = "not null";
    try {
      json = gson.toJson(favor);      
    } catch (Exception e) {
      e.printStackTrace();
      return;
    }
    logger.info("json=|" + json + "|");
    
    
    /////////////////////////////////////////////////////////////////////////
    // Add Basic Authentication to the Authorization Header
    /////////////////////////////////////////////////////////////////////////
    
    DefaultHttpClient httpclient = new DefaultHttpClient();
    HttpHost targetHost = new HttpHost("localhost", 8080, "http");
    
    AuthScope authScope = new AuthScope(targetHost.getHostName(), targetHost.getPort());
    UsernamePasswordCredentials credentials = new UsernamePasswordCredentials("aryan@alpineconnectivity.com", "beast");
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
    
    HttpPut httpPut = new HttpPut("http://localhost:8080/flashTask/favor");
    HttpResponse response = null;
    
    try {
      
      /////////////////////////////////////////////////////////////////////////
      // Send the PUT request
      /////////////////////////////////////////////////////////////////////////
      
      StringEntity stringEntity = new StringEntity(json);
      stringEntity.setContentType("application/json");    
      httpPut.setEntity(stringEntity);
      response = httpclient.execute(targetHost, httpPut, localcontext);
      
      /////////////////////////////////////////////////////////////////////////
      // Response: What's in the headers?
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
      // Response: What's in the body?
      /////////////////////////////////////////////////////////////////////////
      HttpEntity entity2 = response.getEntity();
      String json2 = EntityUtils.toString(entity2);
      logger.info("json2=|" + json2 + "|");
      
      switch (statusCode) {
      
        case 200:
          handle200(json2);
          break;
          
        case 400:
          handleError(json2);
          break;
          
        case 500:
          handleError(json2);
          break;  
      }
            
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      httpPut.releaseConnection();      
    }

  } // main
  
  
  /**
   * 
   * @param json2
   */
  public static void handle200(String json2) {
    // nothing. if successful, no json is returned
  }
 
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