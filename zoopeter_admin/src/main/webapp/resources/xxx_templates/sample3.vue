<template>
	<div class="alert alert-primary">
		<div>sample</div>
		<p>samplexxxx</p>
	</div>
</template>
<script type="text/javascript">
module.exports = {

	name : 'sample3',
	data : function() { return {
		xxx: '1'
		}
	},
	created : function() {
		console.log("sample3 created");
	},
	mounted : function() {
		console.log('sample3');
	},
	updated: function() {
	},
	method : {
	}
};
</script>
