<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Gas Price Bargain Watch</title>
<style>

form {
  width:400px;
  margin-left: auto ;
  margin-right: auto ;
}

input[type="text"] {
 display:block;
 margin-bottom:10px
}

</style>
</head>
<body>

<h1>Get notified of gas price bargains near you</h1>


<form>

<label for="user">User:</label>
<input type="TEXT" name="user" id="user" value="alexander.j.ryan@gmail.com" size="40"></input>


<label for="maxPrice">Max Price:</label>
<input type="TEXT" name="maxPrice" id="maxPrice" value="3.49" size="4"></input>

<label for="longitude">Longitude:</label>
<input type="TEXT" name="longitude" id="longitude" value="-121.961395" size="10" />

<label for="latitude">Latitude:</label>
<input type="TEXT" name="latitude" id="latitude" value="37.379425" size="10"></input>

<label for="radius">Radius:</label>
<input type="TEXT" name="radius" id="radius" value="5" size="4" />

<p>How do you want to be notified?:</p>
<input type="checkbox" name="notifyByEmail" id="notifyByEmail">Send me an email<br>
<input type="checkbox" name="notifyBySms" id="notifyBySms" value="false">Send me a text message<br>
<input type="checkbox" name="notifyByAlert" id="notifyByAlert" value="false">Send me an app alert<br>

<br/>
<label for="name">Name your bargain watch:</label>
<input type="TEXT" name="name" id="need" value="Cheap gas near work" size="40"></input>



<br/>
<input type="BUTTON" name="submit" value="SUBMIT" onclick="submitForm()" />

</form>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script>

function submitForm() {
	
	//alert('submitForm()');
	//console.log('submitForm() 1');
	
	var user = $('#user').val();
	var maxPrice = $('#maxPrice').val();
	var longitude = $('#longitude').val();
	var latitude = $('#latitude').val();
	var radius = $('#radius').val();
	var email=false;
	var sms=false;
	var alert=false;
	var name = $('#name').val();
	
	if ($('#notifyByEmail').is(':checked')) {
	  email=true;
	} 

	if ($('#notifyBySms').is(':checked')) {
    sms=true;
	} 
	
	if ($('#notifyByAlert').is(':checked')) {
	  alert=true;
	} 

	console.log('user=|' + user + "|");
	console.log('maxPrice=|' + maxPrice + "|");
	console.log('longitude=|' + longitude + "|");
	console.log('latitude=|' + latitude + "|");
	console.log('radius=|' + radius + "|");
	console.log('email=|' + email + "|");
	console.log('sms=|' + sms + "|");
	console.log('alert=|' + alert + "|");
	console.log('name=|' + name + "|");
	
  var parameters = {'user': user,
		                'maxPrice': maxPrice,
		                'longitude': longitude,
		                'latitude': latitude,
		                'radius': radius,
		                'email': email,
		                'sms': sms,
		                'alert': alert,
		                'name': name};
  
	//console.log('submitForm() 2');
  
  $.ajax({
	    url: "bargainWatch",
	    type: "post",
	    dataType: "json",
	    data: parameters,
	    statusCode: {
        201: function() {
        	console.log('CREATED');
        }
	    }
	});
 
	//console.log('submitForm() 3'); 
}
</script>
</body>
</html>