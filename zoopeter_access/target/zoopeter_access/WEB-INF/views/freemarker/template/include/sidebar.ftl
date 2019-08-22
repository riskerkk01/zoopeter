<template id="fix_sidebar">
<div class="header collapse d-lg-flex p-0" id="headerMenuCollapse">
	<div class="container">
		<div class="row align-items-center">

			<div class="col-lg order-lg-first">
			    <ul class="nav nav-tabs border-0 flex-column flex-lg-row">
			      	<li class="nav-item">
						<router-link to="clicklog" class="nav-link" active-class="nav-link active"><i class="fa fa-diamond"></i> 클릭 로그</router-link>
			      	</li>
 
			      	<li class="nav-item">
			      		<router-link to="dashboard" class="nav-link" active-class="nav-link active"><i class="fe fe-user"></i> 대쉬보드</router-link>
			      	</li>
			    </ul>
			</div>
		</div>
	
	</div>
</div>
</template>

<script>
	var sidebar = Vue.component('fix_sidebar', {
		template : '#fix_sidebar',
		data : function(){
		  return {
		  	isAdmin : false,
		  	isGuide : false,
		  	isPostback : false,
  			//menulist: null
		  }
		},
		mounted : function() {
			console.log( this.$route );
			this.checkRoute(this.$route);
		},		
		methods : { 
			checkRoute : function(obj) {
			},
		},

		watch : {
			'$route' (to,from) {
				this.checkRoute( to );
			}
		},
	});

</script>