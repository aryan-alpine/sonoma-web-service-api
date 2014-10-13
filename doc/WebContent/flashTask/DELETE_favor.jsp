<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="US-ASCII">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

<h1>DELETE favor</h1>

<p>Remove a favor request.</p>

<p>Note: This service is only available in development.<br/>
There is no need for this service in production, so please do not use it in your production apps.</p>



<br/><hr/>
<h2>HTTP Request: Headers</h2>

<p>The request method is DELETE.<br/>
For example:</p>

<pre>
DELETE /flashTask/favor/id/52002e760d8632cff83812c2 HTTP/1.1
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=
</pre>

<p>This service may only be used by registered users who are authorized to use it.</p>

<br/><hr/>
<h2>HTTP Request: Headers: Request Method Parameters</h2>

<p><b>GET</b> or <b>DELETE</b> requests
pass data to a service is via the parameters of the request method.
</p>

<h3>Example</h3>

<pre>
DELETE /flashTask/favor/id/52002e760d8632cff83812c2 HTTP/1.1
Host: dev5:8888
Authorization: Basic YWxleGFuZGVyLmoucnlhbkBnbWFpbC5jb206YmVhc3Q=
</pre>

<h3>Description</h3>

<table width="100%" border="1">
<tr>
<td><span style="color:red">id</span><br/>(required)</td>
<td>
The "id" field uniquely specifies which favor to delete.
</tr>

</table>



<!-- 
<br/><hr/>
<h2>HTTP Request: BODY: Parameters</h2>

<p>Another way to pass data to a service is via the body of the HTTP request.<br/>
This service DOES NOT utilize this approach.<br/>
By convention this approach is used when the method is <b>POST</b> or <b>PUT</b></p>
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
<p>If an error occured on the server that prevents us from satisfying the request,<br/>
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
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import com.alpine.data.http.common.RestError;
import com.google.gson.Gson;

public class DeleteFavor {
  private static Logger logger = Logger.getLogger(DeleteFavor.class.getName());
  
  /**
   * @param args
   */
  public static void main(String[] args) {
    
    /////////////////////////////////////////////////////////////////////////
    // Create the DELETE request
    /////////////////////////////////////////////////////////////////////////
    
    String id = "52ab8741036450c0d6436407";
    HttpDelete httpDelete = new HttpDelete("http://localhost:8080/flashTask/favor/" + id);
    
    /////////////////////////////////////////////////////////////////////////
    // Add Basic Authentication to the Authorization Header
    /////////////////////////////////////////////////////////////////////////
    
    DefaultHttpClient httpclient = new DefaultHttpClient();
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

    HttpResponse response = null;
    try {
      
      /////////////////////////////////////////////////////////////////////////
      // Send the DELETE request
      /////////////////////////////////////////////////////////////////////////
      
      response = httpclient.execute(targetHost, httpDelete, localcontext);
      
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
      httpDelete.releaseConnection();      
    }

  } // main
  
  
  /**
   * 
   * @param json2
   */
  public static void handle200(String json2) {
    //No JSON is returned if successful
    logger.info("Terminated!!");
  }
 
  /**
   * 
   */
  public static void handleError(String json2) {
    Gson gson = new Gson();
    RestError restError = gson.fromJson(json2, RestError.class);
    logger.info("   errorCode=|" + restError.getErrorCode() + "|");
    logger.info("errorMessage=|" + restError.getErrorMessage() + "|");  
    logger.info("        data=|" + restError.getData() + "|"); 
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