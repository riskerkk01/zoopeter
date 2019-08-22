<route> 
<template id="dashboard">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				대쉬보드 
			</h1>
		</div>	
		
		<div class="alert alert-primary">
			<div class="row">
                <div class="col-6 form-inline xpull-left" style="margin-bottom:10px;">
                    <input type="button" class="btn btn-primary xbtn-sm" value="Week" v-on:click="setWeek()">&nbsp;
                    <input type="button" class="btn btn-warning xbtn-sm" value="Month" v-on:click="setMonth()">&nbsp;
                    
                    <date-picker style="width:100px;" v-model="request.startdate" :config="{format:'YYYY-MM-DD'}" class="form-control xform-control-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true" placeholder="0000-00-00"></date-picker>
                    &nbsp;&nbsp;~&nbsp;&nbsp;
                    <date-picker style="width:100px;" v-model="request.enddate" :config="{format:'YYYY-MM-DD'}" class="form-control xform-control-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true" placeholder="0000-00-00"></date-picker>
                </div> 
				<div class="col-6 text-right">
					  <div class="input-group">  
						<select class="form-control" style="width:140px:" v-model="request.camp_no">
							<option value="">캠페인 선택</option> 
							<option v-for="listValue in campaignlist" :selected="request.camp_no == listValue.campaignid" :value="listValue.campaignid">{{listValue.name}}</option>
						</select>	 
						<span class="input-group-btn">
							<input type="button" class="btn btn-primary" value="검색" v-on:click="searchbtn()">
						</span>
					</div><!-- /input-group -->
				</div>
			</div>
			
		</div>
		
		<div class="card" v-if="listdata.content && listdata.content.length == 0">
			<div class="card-header">
                <h3 class="card-title">정보가 없습니다.</h3>
            </div>
		</div> 
		<div class="card" v-if="loading == 1">
			<div class="card-header">
                <h3 class="card-title">정보가 가져오는 중입니다.</h3>
            </div>
		</div> 
		<div class="card" v-if="listdata.content && listdata.content.length > 0">
			<div class="row">
				<div class="col-3">
					<highcharts :options="options1" ref="highcharts"></highcharts>
				</div>
				<div class="col-3">
					<highcharts :options="options2" ref="highcharts"></highcharts> 
				</div> 
				<div class="col-3">
					<highcharts :options="options3" ref="highcharts"></highcharts>
				</div>
				<div class="col-3">
					<highcharts :options="options4" ref="highcharts"></highcharts>
				</div>
			</div>
			
           	<div style="" class="table-responsive" > 
				<table class="table card-table table-vcenter xtext-nowrap" >
					<thead> 
		    		<tr xclass="table-info">
		    			<th width="100px" class="text-center" rowspan="2">날짜</th>
		    			<th width="80px" class="text-center" colspan="4" v-for="(data, index) in p_pub_ids">{{data}}</th>
		    		</tr> 
		    		<tr xclass="table-info">
		    			<th class="text-center" width="80px" v-for="(data, index) in p_pub_ids.length*4">
		    				<span v-if="index % 4 == 0">Install</span> 
		    				<span v-if="index % 4 == 1">Click</span>
		    				<span v-if="index % 4 == 2">Cvr</span>
		    				<span v-if="index % 4 == 3">Revenue</span> 
		    			</th>
		    		</tr>  
					</thead>
					<tr v-for="(dates, index) in p_dates">
						<td class="text-center">{{dates}}</td> 
						<td class="text-center" v-for="(pub_id, index) in p_pub_ids.length*4">
							<span v-if="getData(dates,index)>0" class="tag tag-pink" v-on:click="viewdetail(dates,index)">{{Number(getData(dates,index)).toLocaleString()}}</span>
							<span v-else>0</span>
						</td>
					</tr>
		  		</table>
			</div>
		</div>
			

		<div class="modal fade" id="detailmodal">
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		            	<h4 class="modal-title">상세보기 - {{requestdetail.pub_id}} - {{requestdetail.regtime}}</h4>
		                <button type="button" xclass="close" data-dismiss="modal">&times;</button>
		            </div> 
		            <div class="modal-body">
		            	<table class="table card-table table-vcenter xtext-nowrap" >
							<thead> 
				    		<tr xclass="table-info">
				    			<th width="100px" class="text-center" >하위 매체</th>
				    			<th width="100px" class="text-center" >Install</th>
				    			<th width="100px" class="text-center" >Click</th>
				    			<th width="100px" class="text-center" >CVR</th>
				    			<th width="100px" class="text-center" >Revenue</th>
				    		</tr>
				    		</thead> 
				    		<tr xclass="table-info" v-for="(data, index) in listdetaildata.content">
				    			<td class="text-center">{{data.sub_pub_id}}</td>
				    			<td class="text-center">
				    				<span v-if="data.installcnt > 0" class="tag tag-pink">{{Number(data.installcnt).toLocaleString()}}</span>
				    				<span v-else>{{data.installcnt}}</span>
				    			</td>
				    			<td class="text-center">
				    				<span v-if="data.clickcnt > 0" class="tag tag-pink">{{Number(data.clickcnt).toLocaleString()}}</span>
				    				<span v-else>{{data.clickcnt}}</span>
				    			</td>
				    			<td class="text-center">
				    				<span v-if="data.cvr > 0" class="tag tag-pink">{{data.cvr}}</span>
				    				<span v-else>{{data.cvr}}</span>
								</td> 
				    			<td class="text-center">
				    				<span v-if="data.revenue > 0" class="tag tag-pink">{{Number(data.revenue).toLocaleString()}}</span> 
				    				<span v-else>{{data.revenue}}</span>
				    			</td>
				    		</tr>
				    		<tr v-if="listdetaildata.content && listdetaildata.content.length == 0" height="100px">
				    			<td colspan="4">정보가 없습니다.</td>
				    		</tr>  
				    		<tr v-if="!listdetaildata.content" height="100px">
				    			<td colspan="4">정보를 가져오는 중입니다.</td>
				    		</tr>
				  		</table>
		            																			
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button> 
		            </div>
		        </div>
		    </div>
		</div>
				
	</div>
</template>  
<script type="text/javascript">
/* Number.prototype.to2 = function(){return this<10?'0'+this:this;} */

jQuery(document).ready(function() { 
});
require(['input-mask']);

var options1 = {
  title: { text: 'Revenue', x: -20   }, 
  xAxis: { categories: [] },
 // yAxis: { title: { text: 'Temperature (°C)' },  plotLines: [ {  value: 0,  width: 1, color: '#058DC7' } ] },
  tooltip: { valueSuffix: '' },
  //legend: { layout: 'vertical', align: 'right', verticalAlign: 'middle', borderWidth: 0 },
  series: []
};
var options2 = {
  title: { text: 'Install', x: -20   },
  xAxis: { categories: [] },
  //yAxis: { title: { text: 'Temperature (°C)' },  plotLines: [ {  value: 0,  width: 1, color: ''#50B432' } ] },
  tooltip: { valueSuffix: '' },
  //legend: { layout: 'vertical', align: 'right', verticalAlign: 'middle', borderWidth: 0 },
  series: []
};
var options3 = {
  title: { text: 'CVR', x: -20   },
  xAxis: { categories: [] },
  //yAxis: { title: { text: 'Temperature (°C)' },  plotLines: [ {  value: 0,  width: 1, color: '#ED561B' } ] },
  tooltip: { valueSuffix: '' },
  //legend: { layout: 'vertical', align: 'top', verticalAlign: 'middle', borderWidth: 0 },
  series: []
};
var options4 = {
  title: { text: 'Click', x: -20   }, 
  xAxis: { categories: [] },
  //yAxis: { title: { text: 'Temperature (°C)' },  plotLines: [ {  value: 0,  width: 1, color: '#DDDF00' } ] },
  tooltip: { valueSuffix: '' },
  //legend: { layout: 'vertical', align: 'right', verticalAlign: 'middle', borderWidth: 0 },
  series: []
};

var linecolor = ['#058DC7', '#6AF9C4', '#ED561B', '#DDDF00', '#64E572','#50B432', '#DDDF00', '#24CBE5', '#FF9655', '#FFF263' ];  

/*
  	{
	    name: 'Tokyo',
	    data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
	  }, {
	    name: 'New York',
	    data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
	  }, {
	    name: 'Berlin',
	    data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
	  }, {
	    name: 'London',
	    data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
	  } 
  ]
};
*/

var dashboard = Vue.component('dashboard', {
	template : '#dashboard',
	props : ['camp_no'],
	data : function() {  
		return {
			loading : 0,
			options1 : [],
			options2 : [],
			options3 : [],
			options4 : [],
			totalCount : 0,
			searchcate : [ { name :'CAMPAIGN_ID', val : 'camp_id' }, { name:'CAMPAIGN_CODE', val:'camp_no'}, {name:'IDFA',val:'idfa'}, {name:'ADID', val:'adid'}, {name:'CLICK_ID', val:'click_id'}, {name:'PUB_ID', val:'pub_id'}, {name:'SUB_PUB_ID', val:'sub_pub_id'} ],
			campaignlist : [],
			publisherlist : [],
			spublisherlist : [],
			p_dates : [],
			p_pub_ids : [],
			listdata : [],
			listdetaildata : [],
			requesttmp : {
				category : '',
	      		page : 0, 
	      		size : 10000, 
	    	},
	    	request : { 
	    		searchtype : 'seq', 
	    		searchkeyword : "",
	      		page : 0, 
	      		size : 10,
	      		startdate : "",
	      		enddate : "",
	      		camp_no : "", 
	    	},
	    	requestdetail : {
	    		camp_no : "",
	    		pub_id : "",
	    		regtime : "",
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val; 
		console.log("dashboard created");
	},
	mounted : function() {
		if( this.camp_no != '' && this.camp_no != undefined ) {
			this.request.camp_no = this.camp_no;
		}
		console.log('dashboard');
		//this.getPublisherList();
		this.getCampaignList();
		this.setMonth();
		//this.getList(); 
	}, 
	updated: function() {
	},
	methods : {
		getPublisherList : function() {
		      var self = this
		      axios.post('/api/publisher/list', self.requesttmp).then(res => {
			        self.publisherlist = res.data.content;
		      }).catch(err => { console.log(err); alert("매체 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
		getCampaignList : function() {
		      var self = this
		      self.requesttmp.category = '';
		      axios.post('/api/campaign/list', self.requesttmp).then(res => {
			        self.campaignlist = res.data.content;
		      }).catch(err => { console.log(err); alert("캠페인 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },	
			
		searchbtn : function() {
			this.listdata = []; 
			this.request.page = 0;
			if( this.request.startdate == '' || this.request.enddate == '' ) {
		      	alert('검색 기간을 입력하여 주세요.'); 
		      	return;
		    }
		    if( this.request.camp_no == '' ) {
		      	alert('캠페인을 선택하여 주세요.');
		      	return;
		    }
			this.getList();
		},
		paging : function() {
			console.log( this.request.page );
			this.listdata = [];
			this.getList();
		},
		getList : function() {
		    var self = this
		    if( this.request.startdate == '' || this.request.enddate == '' ) {
		      	return;
		    }
		    if( this.request.camp_no == '' ) {
		      	return;
		    }
		    if( self.request.startdate > self.request.enddate ) {
		      	var tmp = self.request.startdate;
		      	self.request.startdate = self.request.enddate;
		      	self.request.enddate = tmp;
		    }
		    
		    this.loading = 1;
		    axios.post('/api/dashboard/list', self.request).then(res => {
		    	this.loading = 2;
		     	self.totalCount = res.data.totalElements; 
			    self.listdata = res.data;
			    
			    var list = res.data.content;
			    var dates = [];
			    var pub_ids = [];
			    for( var i=0; i<list.length; i++ ) { 
			    	dates.push( list[i].regtime );
			    	pub_ids.push( list[i].pub_id );
			    }
			    self.p_dates = self.sort_unique( dates );
			    self.p_pub_ids = self.sort_unique( pub_ids );
			    
			    options1.xAxis.categories = self.p_dates;
			    options2.xAxis.categories = self.p_dates;
			    options3.xAxis.categories = self.p_dates;
			    options4.xAxis.categories = self.p_dates;
			    options1.series=[];
			    options2.series=[];
			    options3.series=[];
			    options4.series=[]; 
			    
			    var kk = 0;
			    for( var i=0; i<self.p_pub_ids.length; i++ ) {
			    	var install = { name:'', data: [], color: linecolor[kk%9] }; kk++;
			    	var revenue = { name:'', data: [],  color: linecolor[kk%9] }; kk++;
			    	var click = { name:'', data: [],  color:linecolor[kk%9] }; kk++;
			    	var cvr = { name:'', data: [], color:linecolor[kk%9] }; kk++;
			    	install.name = self.p_pub_ids[i];
			    	revenue.name = self.p_pub_ids[i];
			    	click.name = self.p_pub_ids[i];  
			    	cvr.name = self.p_pub_ids[i];
			    	for( var ii=0; ii<list.length; ii++ ) {  
			    		if( list[ii].pub_id == install.name ) {
			    			install.data.push( list[ii].installcnt );
			    			revenue.data.push( list[ii].revenue );
			    			click.data.push( list[ii].clickcnt );
			    			cvr.data.push( list[ii].cvr );
			    		}
			    	} 
			    	options1.series.push( revenue );
			    	options2.series.push( install );
			    	options3.series.push( cvr );
			    	options4.series.push( click ); 
			    }
			    
			    self.options1 = options1;
			    self.options2 = options2;
			    self.options3 = options3;
			    self.options4 = options4;
			    
			    //console.log( res.data ); 
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
        setWeek : function() {
            var today = new Date();
            var endstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ).to2() + '-' + ( today.getDate() ).to2();
            today.setDate( today.getDate() - 7 );
            var startstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ).to2() + '-' + ( today.getDate() ).to2();

            this.request.startdate = startstr; 
			this.request.enddate = endstr;
			//this.searchbtn(); 
        }, 
        setMonth : function () {
            var today = new Date();
            var endstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ).to2() + '-' + ( today.getDate() ).to2();
            today.setMonth( today.getMonth() - 1 );
            var startstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ).to2() + '-' + ( today.getDate() ).to2();
            this.request.startdate = startstr;
			this.request.enddate = endstr; 
			//this.searchbtn();
        },  
        getData : function( dates, pos ) { 
        	var pub_id = this.p_pub_ids[ Math.floor(pos / 4) ];  
        	//console.log( dates, pub_id, pos );
        	for( var i=0; i<this.listdata.content.length; i++ ) {
        		var rr = this.listdata.content[i]; 
        		if( rr.regtime == dates && rr.pub_id == pub_id ) {
        			if( pos%4 == 0 ) return rr.installcnt;
        			if( pos%4 == 1 ) return rr.clickcnt;
        			if( pos%4 == 2 ) return rr.cvr; 
        			if( pos%4 == 3 ) return rr.revenue; 
        		}
        	} 
        },
        sort_unique : function(arr) {
        	return arr.sort().filter(function(el,i,a) {
        		return (i==a.indexOf(el));
    		});
    	},
    	viewdetail : function(date,pos) {
    		var self = this
    		var pub_id = this.p_pub_ids[ Math.floor(pos / 4) ];
    		this.requestdetail.camp_no = this.request.camp_no;
    		this.requestdetail.regtime = date;
    		this.requestdetail.pub_id = pub_id;
    		axios.post('/api/dashboard/listdetail', self.requestdetail).then(res => {
			    self.listdetaildata = res.data;
			    $('#detailmodal').modal('show');
			}).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
    		
    	}
	},
	computed: {
		
	},
	watch : { 
		"request.camp_no" : function(val) {
			/*
			this.spublisherlist = [];
			if( val == "" ) {
				this.spublisherlist = this.publisherlist;
				//this.request.page = 0;
				//this.getList();
				//return;
			}
			for( var i=0; i<this.campaignlist.length; i++ ) {
				var tmp = this.campaignlist[i];
				if( tmp.campaignid == val ) {
					if( tmp.publisherids == "" || tmp.publisherids == null ) break; 
					
					var tarr = tmp.publisherids.split(",");
					for( var ii=0; ii<tarr.length; ii++ ) {
						for( var iii=0; iii<this.publisherlist.length; iii++ ) {   
							if( this.publisherlist[iii].code == tarr[ii] ) {
								this.spublisherlist.push( this.publisherlist[iii] );
							}
						}
					}
					break;	
				}
			}
			*/
			this.request.page = 0;
			this.listdata = [];
			this.getList();
		},
		
		"request.startdate" : function(val) {
			this.request.page = 0;
			this.listdata = [];
			this.getList();
		} ,
		"request.enddate" : function(val) {
			this.request.page = 0;
			this.listdata = [];
			this.getList();
		}
	},	
});
</script>
</route>