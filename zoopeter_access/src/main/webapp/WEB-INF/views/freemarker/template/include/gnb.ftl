<#import "/spring.ftl" as spring>
<#setting number_format="computer">
<#assign messagetags=JspTaglibs["http://www.springframework.org/tags"]/>
<!doctype html>
<html lang="ko" dir="ltr">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta http-equiv="Content-Language" content="en" />
    <meta name="msapplication-TileColor" content="#2d89ef">
    <meta name="theme-color" content="#4188c9">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">

	<title>Access - zoopeter</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,400,400i,500,500i,600,600i,700,700i&amp;subset=latin-ext">
	
	<script src="https://cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/http-vue-loader"></script>
	
	<!-- include vue-treeselect & its styles. you can change the version tag to better suit your need. -->
	<!--
	<script src="https://cdn.jsdelivr.net/npm/@riophae/vue-treeselect@0.0.28/dist/vue-treeselect.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@riophae/vue-treeselect@0.0.28/dist/vue-treeselect.min.css">
  	-->
  	
	<script src="https://cdn.jsdelivr.net/npm/vue-router@3.0.2/dist/vue-router.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vuex@3.1.0/dist/vuex.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue-multiselect@2.1.0"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/vue-multiselect@2.1.0/dist/vue-multiselect.min.css">

	<!-- tooltip -->
	<script src="https://cdn.jsdelivr.net/npm/v-tooltip@2.0.0-rc.33/dist/v-tooltip.min.js"></script>

	<!-- Color Picker -->
	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/vue-color/2.7.0/vue-color.min.js"></script> -->
	<!-- naver editor -->
	
	<script src="https://cdn.jsdelivr.net/npm/axios@0.17.1/dist/axios.min.js"></script>	

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<!-- Vue-highcharts -->
	<script src="https://cdn.jsdelivr.net/npm/highcharts@6/highcharts.js"></script>
	<!-- vue-highcharts should be load after Highcharts -->
	<script src="https://cdn.jsdelivr.net/npm/vue-highcharts/dist/vue-highcharts.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/xlsx@0.14.1/dist/xlsx.full.min.js"></script>
  	
    <!-- datetimepicker -->
    
	<script src="https://cdn.jsdelivr.net/npm/vue-bootstrap-datetimepicker"></script>
	<!--
	<script src="https://cdn.jsdelivr.net/npm/pc-bootstrap4-datetimepicker@4.17.50/src/js/bootstrap-datetimepicker.js"></script>
	-->
	<script src="https://cdn.jsdelivr.net/npm/pc-bootstrap4-datetimepicker@4.17/build/js/bootstrap-datetimepicker.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/pc-bootstrap4-datetimepicker@4.17/build/css/bootstrap-datetimepicker.min.css" rel="stylesheet">

	<script type="text/javascript" language="javascript" src="<@spring.url '/scripts/sha256.js' />"></script>
	
    <script src="/assets/js/require.min.js"></script>
    <script>
    /* 지우지 말것 */
    Number.prototype.to2 = function(){return this<10?'0'+this:this;} 
    
    requirejs.config({
          baseUrl: '/'
    });
    </script>
	
    <!-- Dashboard Core -->
    <link href="/assets/css/dashboard.css" rel="stylesheet" />
    <script src="/assets/js/dashboard.js"></script>
    <!-- c3.js Charts Plugin -->
    <link href="/assets/plugins/charts-c3/plugin.css" rel="stylesheet" />
    <script src="/assets/plugins/charts-c3/plugin.js"></script>

    <!-- Input Mask Plugin -->
    <script src="/assets/plugins/input-mask/plugin.js"></script>
    <!-- Datatables Plugin -->
    <script src="/assets/plugins/datatables/plugin.js"></script>
</head>
