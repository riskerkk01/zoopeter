<template id="fix_sidebar">
<div class="header collapse d-lg-flex p-0" id="headerMenuCollapse">
	<div class="container">
		<div class="row align-items-center">
			<!--
			<div class="col-lg-3 ml-auto">
			    <form class="input-icon my-3 my-lg-0">
			      <input type="search" class="form-control header-search" placeholder="Search&hellip;" tabindex="1">
			      <div class="input-icon-addon">
			        <i class="fe fe-search"></i>
			      </div>
			    </form>
			</div>
			-->
			<div class="col-lg order-lg-first">
			    <ul class="nav nav-tabs border-0 flex-column flex-lg-row">
			      	<li class="nav-item">
						<router-link to="clicklog" class="nav-link" active-class="nav-link active"><i class="fa fa-diamond"></i> 클릭 로그</router-link>
			      	</li>
 
			      	<li class="nav-item">
			      		<router-link to="dashboard" class="nav-link" active-class="nav-link active"><i class="fe fe-user"></i> 대쉬보드</router-link>
			      	</li>
					<li class="nav-item">
						<router-link to="campaign" class="nav-link" active-class="nav-link active"><i class="fa fa-cubes"></i> 캠페인 관리</router-link>
					</li>
					<li class="nav-item">
						<router-link to="publisher" class="nav-link" active-class="nav-link active"><i class="fe fe-user"></i> 매체 관리</router-link>
					</li>
                  	<li class="nav-item">
                    	<a id="menu_postback" href="javascript:void(0)" class="nav-link" data-toggle="dropdown"><i class="fe fe-database"></i> 포스트백</a>
                    	<div class="dropdown-menu dropdown-menu-arrow">
                    		<router-link to="adbrix" class="dropdown-item" active-class="dropdown-item active"><i class="fe fe-codepen"></i> Adbrix</router-link>
                    		<router-link to="adbrixre" class="dropdown-item" active-class="dropdown-item active"><i class="fe fe-box"></i> Adbrix remaster</router-link>
                    		<router-link to="appsflyer" class="dropdown-item" active-class="dropdown-item active"><i class="fe fe-send"></i> Appsflyer</router-link>
                    		<router-link to="adjust" class="dropdown-item" active-class="dropdown-item active"><i class="fe fe-umbrella"></i> Adjust</router-link>
                    		<router-link to="tune" class="dropdown-item" active-class="dropdown-item active"><i class="fe fe-speaker"></i> Branch ( tune )</router-link>
                    	</div>
                  	</li>					
					<li class="nav-item">
                    	<a id="menu_admin" href="javascript:void(0)" class="nav-link" data-toggle="dropdown"><i class="fa fa-cogs"></i> 관리메뉴들</a>
                    	<div class="dropdown-menu dropdown-menu-arrow">
                    		<router-link to="admin" class="dropdown-item" active-class="dropdown-item active"><i class="fa fa-user"></i> 관리자 관리</router-link>
                    		<router-link to="sitecode" class="dropdown-item" active-class="dropdown-item active"><i class="fa fa-diamond"></i> 사이트코드 관리</router-link>
                    		<router-link to="siteconfig" class="dropdown-item" active-class="dropdown-item active"><i class="fa fa-paw"></i> 사이트설정 관리</router-link>
                    		<router-link to="contactus" class="dropdown-item" active-class="dropdown-item active"><i class="fa fa-fax"></i> ContactUs 관리</router-link>
                    	</div>
                  	</li>
                  	<li class="nav-item">

                    	<a id="menu_guide" href="javascript:void(0)" class="nav-link" data-toggle="dropdown"><i class="fa fa-files-o"></i> 가이드들</a>
                    	<div class="dropdown-menu dropdown-menu-arrow">
                    		<router-link to="postbackguide" class="dropdown-item" active-class="dropdown-item active"><i class="fa fa-file-o"></i> 포스트백 가이드</router-link>
                    		<router-link to="serverguide" class="dropdown-item" active-class="dropdown-item active"><i class="fa fa-file-o"></i> 서버설치 가이드</router-link>
                    	</div>
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
		  //this.getMyMenuList();
		},		
		methods : { 
			checkRoute : function(obj) {
				this.isAdmin = false;
				this.isGuide = false;
				this.isPostback = false;
				
				//if( obj.name == 'campaign' ) this.isAdmin = true;
				//if( obj.name == 'publisher' ) this.isAdmin = true;
				if( obj.name == 'sitecode' ) this.isAdmin = true;
				if( obj.name == 'siteconfig' ) this.isAdmin = true;
				if( obj.name == 'contactus' ) this.isAdmin = true;
				if( obj.name == 'admin' ) this.isAdmin = true;
				
				if( obj.name == 'postbackguide' ) this.isGuide = true;
				if( obj.name == 'serverguide' ) this.isGuide = true;
				
				if( obj.name == 'adbrix' ) this.isPostback = true;
				if( obj.name == 'adbrixre' ) this.isPostback = true;
				if( obj.name == 'appsflyer' ) this.isPostback = true;
				if( obj.name == 'adjust' ) this.isPostback = true;
				if( obj.name == 'tune' ) this.isPostback = true;
					
				$('#menu_admin').removeClass('active');
				$('#menu_guide').removeClass('active');
				$('#menu_postback').removeClass('active');
				
				if( this.isAdmin ) {
					$('#menu_admin').addClass('active');
				}
				if( this.isGuide ) {
					$('#menu_guide').addClass('active');
				}
				if( this.isPostback ) {
					$('#menu_postback').addClass('active');
				}
			},
		},

		watch : {
			'$route' (to,from) {
				this.checkRoute( to );
			}
		},
	});

</script>