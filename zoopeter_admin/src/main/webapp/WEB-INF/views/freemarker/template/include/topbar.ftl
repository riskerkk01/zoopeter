<template id="fix_topbar">
<div class="header py-4">
				<div class="container">
					<div class="d-flex">
						<a class="header-brand" href="/">
							Admin - zoopeter
							<!--
							<img src="/tabler/dist/demo/brand/tabler.svg" class="header-brand-img" alt="Access zoopeter logo">
							-->
						</a>

						<div class="d-flex order-lg-2 ml-auto">

							<div class="dropdown">
								<a href="#" class="nav-link pr-0 leading-none" data-toggle="dropdown">
									<span class="ml-2 d-none d-lg-block">
										<span class="text-default">
										{{name}}
										</span>
										<small class="text-muted d-block mt-1">{{id}}</small>
									</span>
								</a>
								<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
									<!--
									<a class="dropdown-item" href="#">
										<i class="dropdown-icon fe fe-user"></i> Profile
									</a>
									<a class="dropdown-item" href="#">
										<i class="dropdown-icon fe fe-settings"></i> Settings
									</a>
									<a class="dropdown-item" href="#">
										<span class="float-right"><span class="badge badge-primary">6</span></span>
										<i class="dropdown-icon fe fe-mail"></i> Inbox
									</a>
									<a class="dropdown-item" href="#">
										<i class="dropdown-icon fe fe-send"></i> Message
									</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="#">
										<i class="dropdown-icon fe fe-help-circle"></i> Need help?
									</a>
									-->
									<a class="dropdown-item" href="<@spring.url '/logout' />">
										<i class="dropdown-icon fe fe-log-out"></i> Sign out
									</a>
								</div>
							</div>

						</div>

						<a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse">
							<span class="header-toggler-icon"></span>
						</a>
					</div>
				</div>
			</div> <!-- end header -->
				


</template>
<script>
var topbar = Vue.component('fix_topbar', {
	  template : '#fix_topbar',
	  data : function () {
	    return {
	    	name : '<#if SESSION_USERAUTH?exists>${SESSION_USERAUTH.name}</#if>',
	    	id : '<#if SESSION_USERAUTH?exists>${SESSION_USERAUTH.id}</#if>',
	    }
	  },
	  mounted : function() {
	    
	  },
	  methods : {
	    logout : function(){
	      axios.get('/api/logout').then(res => {
	        location.href = "http://hexa.nmn.io/signout?redirectUrl="+location.origin
	      })
	    },
	  }
	});
</script>

