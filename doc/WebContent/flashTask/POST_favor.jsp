<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="US-ASCII">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<h1>POST favor</h1>

<p>Request a favor from another user.<br/><br/>

In addition to creating a record on the server,
this service also sends a notification to the person whom the favor is being requested from 
via Google Cloud Messaging</p>

<br/><hr/>
The following state-chart diagram illustrates the kinds of state transitions
that a favor request may make in it's lifecycle:<br/><br/>

<table>
<tr>
<td>
<img src="img/FlashTask-StateChart.png" />
</td>
<td width="100%" valign="top">
<p>This <b>POST</b> service is used by the <b>requestor (A)</b> to make the request.<br/><br/>
It merely places the favor into the <b>requested</b> state.<br/><br/>
The <b>requestee (B)</b> will also be notified of the request.<br/><br/>
Subsequent state transitions are accomplished via the invocation of the <b>PUT</b> service.<br/><br/>
As the diagram illustrates, some state transitions are only allowed to be made by the requestor (A)
[<b>cancel</b>], <br/><br/>
and some are only allowed to be made by the requestee (B) 
[<b>accept, reject, complete</b>].</p>
</td>
</tr>
</table>






<br/><hr/>
<h2>HTTP Request: Headers</h2>

<p>The request method is POST.<br/>
For example:</p>

<pre>
POST /flashTask/favor HTTP/1.1
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=
</pre>

<p>Note: This service requires that the user be authenticated.</p>

<!--  
<br/><hr/>
<h2>HTTP Request: Headers: Request Method Parameters</h2>

<p>One way to pass data to a service is via the parameters of the request method 
in the "headers" section of the HTTP request.<br/>
This approach is customary when the HTTP method is GET or DELETE.<br/>
The HTTP method of this service is POST.<br/>
This service does not utilize this approach.</p>
-->

<br/><hr/>
<h2>HTTP Request: BODY: Parameters</h2>

<p>One way to pass data to a service is via the body of the HTTP request.<br/>
This service passes data in this fashion in a JSON data structure.<br/>
An example of the data structure and a detailed description of its elements follows...</p>

<h3>Example</h3>

<pre>
POST /flashTask/favor HTTP/1.1
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=

{
    "requestee": "wmcfadden@alpineconnectivity.com",
    "action": "Review the spec for the favor services, and let me know if any changes are required before I start implementing",
    "timeFulfillmentDesired": 1386619200,
}
</pre>

<p>NOTE: The requestor is not specified in the JSON because that information is already 
encoded in the Authorization header.</p>


<h3>Description</h3>

<p>Data in the JSON ...</p>

<table width="100%" border="1">

<tr>
<td><span style="color:red">requestee</span><br/>(required)</td>
<td>
User ID of the person fulfilling the favor.
</td>
</tr>

<tr>
<td><span style="color:red">action</span><br/>(required)</td>
<td>A written description of what the requestor would like to have done.</td>
</tr>

<tr>
<td><span style="color:black">timeFulfillmentDesired</span><br/>(optional)</td>
<td>
The time that the request was made.<br/>
(Specified as an epoch time value).
</tr>

</table>


<br/><br/>
<br/><hr/>
<h2>HTTP Response: HEAD: Headers</h2>

<p>The following response codes are possible from this service.<br/>
(Client code must handle each of them.):</p>

<ul>
<li><b>201 Created</b></li>
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


<h3>(1) Response Code = 201: &quot;Created&quot; </h3>
<p>If the service executed successfully<br/>
JSON like the following will be returned in the body of the response:</p>

<pre>
HTTP/1.1 201 Created

{
    "id": "52002e760d8632cff83812c2",
}
</pre>

<p>Description of the data ...</p>

<table width="100%" border="1">


<tr>
<td><span style="color:red">id</span><br/>(required)</td>
<td>
A unique id that can be used to retrieve or make updates to the favor.
</tr>

</table>


<h3>(2) Response Code = 400: &quot;Bad Request&quot; </h3>
<p>If there was a major error in the request that prevents us from even processing it,<br/>
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
<p>If there was a major error on the server that prevents us fulfilling to the request,<br/>
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
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.alpine.data.http.common.PostResponse;
import com.alpine.data.http.common.RestError;
import com.alpine.data.http.flashTask.common.Favor;
import com.google.gson.Gson;

public class PostFavor {

  private static Logger logger = Logger.getLogger(PostFavor.class.getName());
  
  
  /**
   * @param args
   */
  public static void main(String[] args) {

    /////////////////////////////////////////////////////////////////////////
    // Create the POST request
    /////////////////////////////////////////////////////////////////////////  
    Favor favor = new Favor();
    favor.setRequestor("alexander.j.ryan@gmail.com");
    favor.setRequestee("aryan@alpineconnectivity.com");
    favor.setAction("Keep being awesome!!!");
    favor.setTimeFulfillmentDesired(new Long("1450044907000"));
    
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
    
    DefaultHttpClient httpClient = new DefaultHttpClient();
    HttpHost targetHost = new HttpHost("localhost", 8080, "http");
    
    AuthScope authScope = new AuthScope(targetHost.getHostName(), targetHost.getPort());
    UsernamePasswordCredentials credentials = new UsernamePasswordCredentials("alexander.j.ryan@gmail.com", "beast");
    httpClient.getCredentialsProvider().setCredentials(authScope, credentials);
    
    // Create AuthCache instance
    AuthCache authCache = new BasicAuthCache();
    // Generate BASIC scheme object and add it to the local auth cache
    BasicScheme basicAuth = new BasicScheme();
    authCache.put(targetHost, basicAuth);

    // Add AuthCache to the execution context
    BasicHttpContext localcontext = new BasicHttpContext();
    localcontext.setAttribute(ClientContext.AUTH_CACHE, authCache);
    
    /////////////////////////////////////////////////////////////////////////
    // Send the POST request
    /////////////////////////////////////////////////////////////////////////   
    
    HttpPost httpPost = new HttpPost("http://localhost:8080/flashTask/favor");
    HttpResponse response = null;
    
    try {
            
      /////////////////////////////////////////////////////////////////////////
      // Send the POST request
      /////////////////////////////////////////////////////////////////////////
      StringEntity stringEntity = new StringEntity(json);
      stringEntity.setContentType("application/json");    
      httpPost.setEntity(stringEntity);
      response = httpClient.execute(targetHost, httpPost, localcontext);
      
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
      
        case 201:
          handle201(json2);
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
      httpPost.releaseConnection();      
    }

  } // main
  
  
  /**
   * 
   * @param json2
   */
  public static void handle201(String json2) {
    Gson gson = new Gson();
    PostResponse postResponse = gson.fromJson(json2, PostResponse.class);
    String id = postResponse.getId();
    logger.info("id=|" + id + "|");
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