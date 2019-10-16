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
			        	<a href="<@spring.url '/' />" class="nav-link <#if menu_home?exists>active</#if>"><i class="fe fe-home"></i> Home</a>
			      	</li>
			      	<li class="nav-item">
			        	<a href="<@spring.url '/admin/' />" class="nav-link <#if menu_admin?exists>active</#if>"><i class="fe fe-image"></i> 관리자 관리</a>
			      	</li>
			      	<li class="nav-item">
			        	<a href="<@spring.url '/publisher/' />" class="nav-link <#if menu_publisher?exists>active</#if>"><i class="fe fe-user"></i> 매체 관리</a>
			      	</li>
			      	
			      	<li class="nav-item">
			       	 	<a href="dashboard.php" class="nav-link "><i class="fe fe-file-text"></i> Dashboard</a>
			      	</li>
					<li class="nav-item">
						<#assign is_admin=false>
						<#if menu_admin?exists><#assign is_admin=true></#if>
						<#if menu_publisher?exists><#assign is_admin=true></#if>
						<#if menu_contactus?exists><#assign is_admin=true></#if>
						<#if menu_sitecode?exists><#assign is_admin=true></#if>
                    	<a href="javascript:void(0)" class="nav-link <#if is_admin = true>active</#if>" data-toggle="dropdown"><i class="fe fe-box"></i> 관리메뉴들</a>
                    	<div class="dropdown-menu dropdown-menu-arrow">
                    		<a href="<@spring.url '/admin/' />" class="dropdown-item <#if menu_admin?exists>active</#if>"><i class="fe fe-image"></i> 관리자 관리</a>
                    		<a href="<@spring.url '/publisher/' />" class="dropdown-item <#if menu_publisher?exists>active</#if>"><i class="fe fe-user"></i> 매체 관리</a>
                    		<a href="<@spring.url '/contactus/' />" class="dropdown-item <#if menu_contactus?exists>active</#if>"><i class="fa fa-fax"></i> Contactus 관리</a>
                    		<a href="<@spring.url '/sitecode/' />" class="dropdown-item <#if menu_sitecode?exists>active</#if>"><i class="fa fa-diamond"></i> 사이트코드 관리</a>
                    		<!--
                      		<a href="./cards.html" class="dropdown-item ">Cards design</a>
                      		<a href="./charts.html" class="dropdown-item ">Charts</a>
                      		<a href="./pricing-cards.html" class="dropdown-item ">Pricing cards</a>
                      		-->
                    	</div>
                  	</li>			      
			    </ul>
			</div>
		</div>
	
	</div>
</div>

		
