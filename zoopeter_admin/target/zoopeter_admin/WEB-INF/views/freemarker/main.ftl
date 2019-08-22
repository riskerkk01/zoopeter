<#include "/template/include/gnb.ftl">

<script type="text/javascript">
Vue.config.devtools = true
//Vue.directive('tooltip', VTooltip.VTooltip)

Vue.component('vue-multiselect', window.VueMultiselect.default)
Vue.component('date-picker', VueBootstrapDatetimePicker);
//Vue.component('swatches-picker', VueColor.Swatches)
</script>


<#include "/template/include/topbar.ftl">
<#include "/template/include/sidebar.ftl">
<#include "/template/module/page_simple.ftl">

<body >

	<div class="page" id="main">
		<div class="flex-fill">
		

			<fix_topbar v-if="tapCheck()"></fix_topbar>
			<fix_sidebar v-if="tapCheck()"></fix_sidebar>
				
			<div class="my-3 my-md-5">
    			<div class="container">
					<router-view ></router-view>
				</div>
			</div>
			<#include "/template/include/footer.ftl">
			
		</div>
		
	</div>
	
</body>

<#include "/template/include/pages.ftl">

<#include "/template/include/route.ftl">

</html>

