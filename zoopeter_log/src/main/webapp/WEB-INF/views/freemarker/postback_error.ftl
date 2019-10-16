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
  
</div>
 
</body>
</html>