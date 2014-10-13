<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Account Activation</title>
</head>
<body>

<%
String isActivated = request.getParameter("isActivated");
if ("true".equalsIgnoreCase(isActivated)) {
%>
<b>The account has been activated.</b>
<%
} else {
%>
<b>The account has NOT been activated.</b>
<%  
}
%>

<script>
setTimeout(function () {
    window.location.href = "http://alpineconnectivity.com/"; 
 }, 1000); //will call the function after 3 secs.
</script>


</body>
</html>