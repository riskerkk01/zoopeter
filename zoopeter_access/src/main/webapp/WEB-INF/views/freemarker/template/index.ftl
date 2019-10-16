<route> 
<template id="index">
	<div>
		<div class="row row-cards">

			<div class="col-xl-3 col-md-6 mb-4" v-for="(data, index) in listdata.content" v-if="data.enddate > enddate"> 
                <div class="card border-left-primary shadow xh-100 py-2"> 
                    <div class="card-body">
                        <h5 class="card-title text-danger font-weight-bold">[{{data.campaignid}}] {{data.name}}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">
                            {{data.code}}
                            <span v-if="data.trackercode == 'appsflyer'" class="badge badge-success" >{{data.trackercode}}</span>
                            <span v-if="data.trackercode == 'adbrix'" class="badge badge-warning" >{{data.trackercode}}</span>
                            <span v-if="data.trackercode == 'adbrixre'" class="badge badge-warning" >{{data.trackercode}}</span>
                            <span v-if="data.trackercode == 'adjust'" class="badge badge-primary" >{{data.trackercode}}</span>
                            <span v-if="data.trackercode == 'branch'" class="badge badge-danger" >{{data.trackercode}}</span> 
                        </h6> 
                        <p class="card-text"> 
                            Clicks : {{Number(data.clickcnt).toLocaleString()}}<br> 
                            Installs : {{Number(data.installcnt).toLocaleString()}}<br>
                            Revenues : {{Number(data.revenue).toLocaleString()}} 
                        </p> 
                        <a href="javascript:;" v-on:click="clicklink(data)" class="card-link btn btn-info btn-sm">Click List</a>
                        <a href="javascript:;" v-on:click="dashboardlink(data)" class="card-link btn btn-success btn-sm">Dashboard</a>
                    </div>
                </div>
            </div>
			<div v-if="listdata.content && listdata.content.length == 0" height="100px">
				<div class="alert alert-info">정보가 없습니다.</div>
			</div> 
			<div v-if="!listdata.content" height="100px">
				<div class="alert alert-info">정보를 가져오는 중입니다.</div>
			</div>	
		</div>
				
	</div>
</template>  
<script type="text/javascript">
jQuery(document).ready(function() { 
});

var index = Vue.component('index', {
	template : '#index',
	data : function() {  
		return { 
			loading : false,
			enddate : "",
			totalCount : 0,
			listdata : [],
	    	request : {
	      		page : 0, 
	      		size : 1000,
	    	},
	    } 
	},
	
	created : function() {
		console.log("index created"); 
	},
	mounted : function() {
		console.log('index');
		this.getList();
		
	},
	updated: function() {
	},
	methods : {
		getList : function() {
		    var self = this
		    this.loading = false; 
		    axios.post('/api/campaign/listdetail', self.request).then(res => {
		      		self.totalCount = res.data.totalElements;
			        self.listdata = res.data;
			        self.loading = true;
			        console.log( res.data );  
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
	    clicklink : function(obj) { 
	    	var url = "/clicklog?camp_no="+obj.campaignid;
	    	this.$router.push( url );
	    	//return url;  
		}, 
	    dashboardlink : function(obj) { 
	    	var url = "/dashboard?camp_no="+obj.campaignid;
	    	this.$router.push( url );
	    	//return url;
		}
	},
	computed: {
		
	}
});
</script>
</route>