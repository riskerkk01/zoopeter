<#import "/spring.ftl" as spring>
<#setting number_format="computer">
<#assign messagetags=JspTaglibs["http://www.springframework.org/tags"]/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
	<#if error_message?exists>
	<br>
	<div class="alert alert-danger">
    	<strong>Error!</strong> ${error_message}
  	</div> 
  	</#if>
  	
  	<h2>Guide</h2> 
  	<table class="table table-bordered">
    <thead>
      	<tr>
	        <th width="25%">Parameter</th>
	        <th width="25%">Value</th>
	        <th>Note</th>
      	</tr>
    </thead>
    <tbody>
	  	<tr>
	        <td>camp_id <code>(require)</code> </td>
	        <td>String</td>
	        <td>Fixed Campaign ID</td>
	  	</tr>
	  	<tr>
	        <td>pub_id <code>(require)</code></td>
	        <td>String</td>
	        <td>Fixed Your ID</td>
	  	</tr>
	  	<tr>
	        <td>sub_pub_id</td>
	        <td>String</td>
	        <td>Fixed Your sub publisher ID</td>
	  	</tr>
		<tr>
	        <td>click_id <code>(require)</code></td>
	        <td>String</td>
	        <td>Your client click ID</td>
	  	</tr>
		<tr>
	        <td>sub_param1</td>
	        <td>String</td>
	        <td>Your parameter, after postback</td>
	  	</tr>
		<tr>
	        <td>sub_param2</td>
	        <td>String</td>
	        <td>Your parameter, after postback</td>
	  	</tr> 
		<tr>
	        <td>sub_param3</td>
	        <td>String</td>
	        <td>Your parameter, after postback</td>
	  	</tr> 
		<tr>
	        <td>sub_param4</td>
	        <td>String</td>
	        <td>Your parameter, after postback</td>
	  	</tr> 
		<tr>
	        <td>IDFA</td>
	        <td>String</td>
	        <td>IOS IDFA</td>
	  	</tr>
		<tr>
	        <td>ADID</td>
	        <td>String</td>
	        <td>Android ADID</td>
	  	</tr>	  		  		  		  		  	 	  	      
    </tbody>
  </table>
  
</div>
 
</body>
</html>