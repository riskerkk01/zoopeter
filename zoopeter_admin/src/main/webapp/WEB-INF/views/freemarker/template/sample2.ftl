<route> 
<template id="sample2">
	<div class="alert alert-primary">
		<div>sample22222</div>
		<p>samplexxxx</p>
	</div>
</template> 
<script type="text/javascript">
var sample2 = Vue.component('sample2', {
	template : '#sample2',
	data : function() { return {
		xxx: '2'
		}
	},
	created : function() {
		console.log("sample2 created");
	},
	mounted : function() {
		console.log('sample2');
	},
	updated: function() {
	},
	method : {
	}
});
</script>
</route>