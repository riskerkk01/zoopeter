<route> 
<template id="sample1">
	<div class="alert alert-primary">
		<div>sample11111</div>
		<p>samplexxxx</p>
	</div>
</template> 
<script type="text/javascript">
var sample1 = Vue.component('sample1', {
	template : '#sample1',
	data : function() { return {
		xxx: '1'
		}
	},
	created : function() {
		console.log("sample1 created");
	},
	mounted : function() {
		//console.log( $store.state.sessionInfo );
		console.log('sample1');
	},
	updated: function() {
	},
	method : {
	}
});
</script>
</route>