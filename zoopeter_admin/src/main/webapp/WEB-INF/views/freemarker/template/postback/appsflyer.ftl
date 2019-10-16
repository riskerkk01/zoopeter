<route> 
<template id="appsflyer">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				Appsflyer 
				<small v-if="totalCount > 0">( 전체 갯수 : {{Number(totalCount).toLocaleString()}} )</small> 
			</h1>
		</div>	
		
		<div class="alert alert-primary">
			<div class="row">
                <div class="col-12 form-inline xpull-left" style="margin-bottom:10px;">
                    <input type="button" class="btn btn-success xbtn-sm" value="Today" v-on:click="setToday()">&nbsp;
                    <input type="button" class="btn btn-primary xbtn-sm" value="Week" v-on:click="setWeek()">&nbsp;
                    <input type="button" class="btn btn-warning xbtn-sm" value="Month" v-on:click="setMonth()">&nbsp;
                    
                    <date-picker style="width:100px;" v-model="request.startdate" :config="{format:'YYYY-MM-DD'}" class="form-control xform-control-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true" placeholder="0000-00-00"></date-picker>
                    &nbsp;&nbsp;~&nbsp;&nbsp;
                    <date-picker style="width:100px;" v-model="request.enddate" :config="{format:'YYYY-MM-DD'}" class="form-control xform-control-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true" placeholder="0000-00-00"></date-picker>
                </div>  
            </div>
			<div class="row">
				<div class="col-3 text-right">
					<select class="form-control" style="width:140px:" v-model="request.campaign">
						<option value="">캠페인 선택</option> 
						<option v-for="listValue in campaignlist" :selected="request.campaign == listValue.code" :value="listValue.code">{{listValue.name}}</option>
					</select>
				</div>
				<div class="col-2 text-right">
					<select class="form-control" style="width:140px:" v-model="request.publisher_id">
						<option value="">매체 선택</option> 
						<option v-for="listValue in spublisherlist" :selected="request.publisher_id == listValue.code" :value="listValue.code">{{listValue.name}}</option>
					</select>
					  
				</div>
				<div class="col-5">
					<div class="input-group"> 
						<div class="input-group-btn" >
							<select class="form-control" style="width:140px:" v-model="request.searchtype">
								<option v-for="listValue in searchcate" :selected="request.searchtype == listValue.val" :value="listValue.val">{{listValue.name}}</option>
							</select>
						</div>
						<input type="text" class="form-control"  placeholder="검색어를 입력하세요" name="searchkeyword" value="" v-model="request.searchkeyword" v-on:keyup.enter="searchbtn()">
						<span class="input-group-btn">
							<input type="button" class="btn btn-primary" value="검색" v-on:click="searchbtn()">
						</span>
					</div><!-- /input-group -->

				</div>
				<div class="col-2 text-right">
					<input type="button" class="btn btn-info" value="Excel다운" v-on:click="exportExcel()">
				</div>
			</div>
			
		</div>
	
		<div class="card">
           	<div style="" class="table-responsive">
				<table class="table card-table table-vcenter xtext-nowrap">
					<thead>
		    		<tr xclass="table-info">
		    			<th width="80px" class="text-center">SEQ</th>
		    			<th width="130px" class="text-center">등록일시</th>   
		    			<th xwidth="100px" class="text-center">CLICK_ID</th>
		    			<th width="130px" class="text-center">CLICK_TS</th>
		    			<th width="130px" class="text-center">INSTALL_TS</th>
		    			<th width="100px" class="text-center">PUB_ID</th> 
		    			<th width="100px" class="text-center">PUB_SUB_ID</th>
		    			<th width="100px" class="text-center">EVENT_NAME</th>
		    			<th width="80px" class="text-center">비고</th>
		    		</tr> 
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.seq}}</a></td>
						<td class="text-center">{{data.regtime.substring(0,16)}}</td>
						<td class="text-left">{{data.clickid}}</td> 
						<td class="text-center">{{data.click_ts.substring(0,16)}}</td>
						<td class="text-center">{{data.install_unix_ts.substring(0,16)}}</td>
						<td class="text-center">{{data.publisher_id}}</td> 
						<td class="text-center">{{data.publisher_sub_id}}</td>
						<td class="text-center">{{data.event_name}}</td>
						<td class="text-center">
							<a href="javascript:;" class="btn btn-warning btn-sm" v-on:click="updateform(data)">보기</a>
						</td>									
					</tr>
					<tr v-if="listdata.content && listdata.content.length == 0" height="100px">
						<td colspan="10" class="text-center">정보가 없습니다.</td>
					</tr>
					<tr v-if="!listdata.content" height="100px">
						<td colspan="10" class="text-center">정보를 가져오는 중입니다.</td>
					</tr>
		  		</table>
			</div>
			<div class="card-footer text-center" v-if="listdata.content && listdata.content.length > 0">
				<pagination_simple v-bind:p_request="request" v-bind:p_data="listdata" v-bind:p_keyword="false" 
					v-on:get-list="paging()" v-bind:p_size="false" style=""></pagination_simple>
			</div>
		</div>
			

		<div class="modal fade" id="updatemodal">
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		            	<h4 class="modal-title">보기 </h4>
		                <button type="button" xclass="close" data-dismiss="modal">&times;</button>
		            </div> 
		            <div class="modal-body">
		            	
		            	<div class="row">
							<div class="col-sm-3" >등록일시</div>
							<div class="col-sm-9">{{requestupdate.regtime}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3" >PID</div> 
							<div class="col-sm-9">{{requestupdate.pid}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CLICKID</div> 
							<div class="col-sm-9">{{requestupdate.clickid}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">IDFA</div> 
							<div class="col-sm-9">{{requestupdate.idfa}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-3">ADVERTISERID</div> 
							<div class="col-sm-9">{{requestupdate.advertiserid}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">ANDROID_ID</div> 
							<div class="col-sm-9">{{requestupdate.android_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">APP_ID</div> 
							<div class="col-sm-9">{{requestupdate.app_id}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-3">WIFI</div> 
							<div class="col-sm-9">{{requestupdate.wifi}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-3">INSTALL_TS</div> 
							<div class="col-sm-9">{{requestupdate.install_unix_ts}}</div>
						</div>							
		            	<div class="row">
							<div class="col-sm-3">CLICK_TS</div> 
							<div class="col-sm-9">{{requestupdate.click_ts}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-3">CAMPAIGN</div>  
							<div class="col-sm-9">{{requestupdate.campaign}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">PUBLISHER_ID</div> 
							<div class="col-sm-9">{{requestupdate.publisher_id}}</div>
						</div>																			
		            	<div class="row">
							<div class="col-sm-3">PUBLISHER_SUB_ID</div> 
							<div class="col-sm-9">{{requestupdate.publisher_sub_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">COUNRY_CODE</div> 
							<div class="col-sm-9">{{requestupdate.country_code}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CITY</div> 
							<div class="col-sm-9">{{requestupdate.city}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">DEVICE_BRAND</div> 
							<div class="col-sm-9">{{requestupdate.device_brand}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CARRIER</div> 
							<div class="col-sm-9">{{requestupdate.carrier}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">IP</div> 
							<div class="col-sm-9">{{requestupdate.ip}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">device_model</div> 
							<div class="col-sm-9">{{requestupdate.device_model}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">LANGUAGE</div> 
							<div class="col-sm-9">{{requestupdate.language}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">APPSPLYER_DEVICE_ID</div> 
							<div class="col-sm-9">{{requestupdate.appsflyer_device_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">SDK_VERSION</div> 
							<div class="col-sm-9">{{requestupdate.sdk_version}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">APP_VERSION_NAME</div> 
							<div class="col-sm-9">{{requestupdate.app_version_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">USER_AGENT</div> 
							<div class="col-sm-9">{{requestupdate.user_agent}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">VENDORID</div> 
							<div class="col-sm-9">{{requestupdate.vendorid}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">OS_VERSION</div> 
							<div class="col-sm-9">{{requestupdate.os_version}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">APP_NAME</div> 
							<div class="col-sm-9">{{requestupdate.app_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">MATCH_TYPE</div> 
							<div class="col-sm-9">{{requestupdate.match_type}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">GP_REFERER_CLICK_TS</div> 
							<div class="col-sm-9">{{requestupdate.gp_referer_click_ts}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">GP_REFERER_INSTALL_TS</div> 
							<div class="col-sm-9">{{requestupdate.gp_referer_install_ts}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">EVENT_NAME</div> 
							<div class="col-sm-9">{{requestupdate.event_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">MAPPED_IAE</div> 
							<div class="col-sm-9">{{requestupdate.MAPPED_IAE}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">MONETARY</div> 
							<div class="col-sm-9">{{requestupdate.monetary}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">ORIG_MONETARY</div> 
							<div class="col-sm-9">{{requestupdate.orig_monetary}}</div>
						</div>						
		            	<div class="row">
							<div class="col-sm-3">CURRENCY</div> 
							<div class="col-sm-9">{{requestupdate.currency}}</div>
						</div>
						<div class="row">
							<div class="col-sm-3">TIMESTAMP</div> 
							<div class="col-sm-9">{{requestupdate.timestamp}}</div>
						</div>
						<div class="row">
							<div class="col-sm-3">EVENT_VALUE</div> 
							<div class="col-sm-9">{{requestupdate.event_value}}</div>
						</div>
						<div class="row">
							<div class="col-sm-3">EVENT</div> 
							<div class="col-sm-9">{{requestupdate.event}}</div>
						</div>						
						<div class="row">
							<div class="col-sm-3">JSON</div> 
							<div class="col-sm-9">{{requestupdate.json}}</div>
						</div>						
						<div class="row">
							<div class="col-sm-3">AF_QUANTITY</div> 
							<div class="col-sm-9">{{requestupdate.af_quantity}}</div>
						</div>						
						<div class="row">
							<div class="col-sm-3">AF_REVENUE</div> 
							<div class="col-sm-9">{{requestupdate.af_revenue}}</div>
						</div>						
						<div class="row">
							<div class="col-sm-3">AF_CURRENCY</div> 
							<div class="col-sm-9">{{requestupdate.af_currency}}</div>
						</div>						
						<div class="row">
							<div class="col-sm-3">AF_CONTENT_ID</div> 
							<div class="col-sm-9">{{requestupdate.af_content_id}}</div>
						</div>						
						<div class="row">
							<div class="col-sm-3">AF_CONTENT_TYPE</div> 
							<div class="col-sm-9">{{requestupdate.af_content_type}}</div>
						</div>						
																									
		            </div>
		            <div class="modal-footer">
		            	<button type="button" class="btn btn-danger" v-on:click="deleteact()">삭제</button>
		                <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button> 
		            </div>
		        </div>
		    </div>
		</div>
				
	</div>
</template>  
<script type="text/javascript">
jQuery(document).ready(function() { 
});
require(['input-mask']);

var appsflyer = Vue.component('appsflyer', {
	template : '#appsflyer',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ {name:"선택", val:''}, { name :'APP_ID', val : 'app_id' },  {name:'PUBLISHER_SUB_ID', val:'publihser_sub_id'} ],
			listdata : [],
			listexcel : [],
			campaignlist : [],
			publisherlist : [],
			spublisherlist : [],
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
	      		campaign : "",
	      		publisher_id : "",
	    	},
	    	requestupdate : {
	    		
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val; 
		this.request.campaign = this.searchcate[0].val;
		console.log("appsflyer created");
	},
	mounted : function() {
		console.log('appsflyer');
		//
		this.getPublisherList();
		this.getCampaignList();
		//this.setMonth();
		this.getList();
	},
	updated: function() {
	},
	methods : {
		getPublisherList : function() {
		      var self = this
		      axios.post('/api/publisher/list', self.requesttmp).then(res => {
			        self.publisherlist = res.data.content;
			        self.spublisherlist = res.data.content;
		      }).catch(err => { console.log(err); alert("매체 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
		getCampaignList : function() {
		      var self = this
		      self.requesttmp.category = '';
		      axios.post('/api/campaign/list', self.requesttmp).then(res => {
		      		var t = res.data.content;
		      		for( var i=0; i<t.length; i++ ) {
		      			if( t[i].trackercode == 'appsflyer' ) {
		      				self.campaignlist.push( t[i] );
		      			}
		      		}
			        //self.campaignlist = res.data.content;
		      }).catch(err => { console.log(err); alert("캠페인 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },	
		updateform : function(data) { 
			var self = this
		    axios.get('/api/appsflyer/'+data.seq).then(res => {
			        var tmp = res.data;
			        if( tmp.seq == "" || tmp.seq == 0 ) {
			        	alert("정보가 없습니다");
			        } else {
			        	self.requestupdate = tmp;
 						$('#updatemodal').modal('show');
 					}
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
		},
		deleteact : function() {
			self = this;
			if( confirm('삭제하시겠습니까?') == false ) { return; }
			if( self.requestupdate.seq == 0 ) {
				alert("잘못된 파라미터 입니다.");
				$('#updatemodal').modal('hide');
				self.getList();
				return;
			}
			axios.post('/api/appsflyer/delete/'+self.requestupdate.seq, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					self.getList();
 					$('#updatemodal').modal('hide');
				} else {
					alert( res.data.note );
				}
		    }).catch(err => { console.log(err); alert("저장하는 중에 오류가 발생하였습니다. 잠시 후 이용하여 주세요."+err); });
		},			
		searchbtn : function() {
			this.listdata = []; 
			this.request.page = 0;
			this.getList();
		},
		paging : function() {
			console.log( this.request.page );
			this.listdata = [];
			this.getList();
		},
		getList : function() {
		      var self = this
		      axios.post('/api/appsflyer/list', self.request).then(res => {
		      		self.totalCount = res.data.totalElements;
			        self.listdata = res.data;
			        //console.log( res.data ); 
		      }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
	    setToday : function() {
            var today = new Date();
            var str = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ) + '-' + ( today.getDate() );
            this.request.startdate = str;
			this.request.enddate = str;
			this.searchbtn();
        },
        setWeek : function() {
            var today = new Date();
            var endstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ) + '-' + ( today.getDate() );
            today.setDate( today.getDate() - 7 );
            var startstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ) + '-' + ( today.getDate() );

            this.request.startdate = startstr; 
			this.request.enddate = endstr;
			this.searchbtn(); 
        }, 
        setMonth : function () {
            var today = new Date();
            var endstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ) + '-' + ( today.getDate() );
            today.setMonth( today.getMonth() - 1 );
            var startstr = (today.getYear()+1900) + '-' + ( today.getMonth()+1 ) + '-' + ( today.getDate() );
            this.request.startdate = startstr;
			this.request.enddate = endstr;
			this.searchbtn();
        },
        exportExcel() {
        	var self = this
        	var tmp = self.request;
        	tmp.page = 0;
        	tmp.size = self.listdata.totalElements;
        	if( tmp.startdate == "" && tmp.enddate == "" ) {
        		alert( "검색기간을 입력하여 주세요");return;
        	}
        	if( self.listdata.totalElements == 0 ) {
        		alert( "데이타가 없습니다.");return;
        	}
		    axios.post('/api/appsflyer/list', tmp).then(res => {
		      		self.listexcel = res.data.content;
					self.downExcel();
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
		},
		downExcel() {
		      var tmp = []
		      var flag = 0;
		      for(var i=0; i<this.listexcel.length; i++){
			        var data = this.listexcel[i]
			        var tmp2 = []
			        if(flag==0){
				           var tmp3 = []
				           tmp3.push("SEQ")
				           tmp3.push("REGTIME")
				           tmp3.push("PID")
				           tmp3.push("CLICKID")
				           tmp3.push("IDFA")
				           tmp3.push("ADVERTISERID")
				           tmp3.push("ANDROID_ID")
				           tmp3.push("APP_ID")
				           tmp3.push("WIFI")
				           tmp3.push("INSTALL_TS")
				           tmp3.push("CLICK_TS")
				           tmp3.push("CAMPAIGN")
				           tmp3.push("PUBLISHER_ID")
				           tmp3.push("PUBLISHER_SUB_ID")
				           tmp3.push("COUNTRY_CODE")
				           tmp3.push("CITY")
				           tmp3.push("DEVICE_BRAND")
				           tmp3.push("CARRIER")
				           tmp3.push("IP")
				           tmp3.push("DEVICE_MODEL")
				           tmp3.push("LANGUAGE")
				           tmp3.push("APPSFLYER_DEVICE_ID")
				           tmp3.push("SDK_VERSION")
				           tmp3.push("APP_VERSION_NAME")
				           tmp3.push("USER_AGENT")
				           tmp3.push("VENDORID")
				           tmp3.push("OS_VERSION")
				           tmp3.push("APP_NAME")
				           tmp3.push("MATCH_TYPE")
				           tmp3.push("GP_REFERER_CLICK_TS")
				           tmp3.push("GP_REFERER_INSTALL_TS")
				           tmp3.push("EVENT_NAME")
				           tmp3.push("MAPPED_IAE")
				           tmp3.push("MONETARY")
				           tmp3.push("ORIG_MONETARY")
				           tmp3.push("CURRENCY")
				           tmp3.push("TIMESTAMP")
				           tmp3.push("EVENT_VALUE")
				           tmp3.push("EVENT")
				           tmp3.push("JSON")
				           tmp3.push("AF_QUANTITY")
				           tmp3.push("AF_REVENUE")
				           tmp3.push("AF_CURRENCY")
				           tmp3.push("AF_CONTENT_ID")
				           tmp3.push("AF_CONTENT_TYPE")
				           
				           flag = 1;
				           tmp.push(tmp3)
			        }
			        tmp2.push(data.seq)
			        tmp2.push(data.regtime)
			        tmp2.push(data.pid)
			        tmp2.push(data.clickid)
			        tmp2.push(data.idfa)
			        tmp2.push(data.advertiserid)
			        tmp2.push(data.android_id)
			        tmp2.push(data.app_id)
			        tmp2.push(data.wifi)
			        tmp2.push(data.install_unix_ts)
			        tmp2.push(data.click_ts)
			        tmp2.push(data.campaign)
			        tmp2.push(data.publisher_id)
			        tmp2.push(data.publisher_sub_id)
			        tmp2.push(data.country_code)
			        tmp2.push(data.city)
			        tmp2.push(data.device_brand)
			        tmp2.push(data.carrier)
			        tmp2.push(data.ip)
			        tmp2.push(data.device_model)
			        tmp2.push(data.language)
			        tmp2.push(data.appsflyer_device_id)
			        tmp2.push(data.sdk_version)
			        tmp2.push(data.app_version_name)
			        tmp2.push(data.user_agent)
			        tmp2.push(data.vendorid)
			        tmp2.push(data.os_version)
			        tmp2.push(data.app_name)
			        tmp2.push(data.match_type)
			        tmp2.push(data.gp_referer_click_ts)
			        tmp2.push(data.gp_referer_install_ts)
			        tmp2.push(data.event_name)
			        tmp2.push(data.mapped_iae)
			        tmp2.push(data.monetary)
			        tmp2.push(data.orig_monetary)
			        tmp2.push(data.currency)
			        tmp2.push(data.timestamp)
			        tmp2.push(data.event_value)
			        tmp2.push(data.event)
			        tmp2.push(data.json)
			        tmp2.push(data.af_quantity)
			        tmp2.push(data.af_revenue)
			        tmp2.push(data.af_currency)
			        tmp2.push(data.af_content_id)
			        tmp2.push(data.af_content_type)
			        
			        tmp.push(tmp2)
		      }
	
		      var today = new Date();
		      var dd = today.getDate();
		      var mm = today.getMonth()+1; //January is 0!
		      var yyyy = today.getFullYear();
		      yyyy = yyyy.toString().substr(2,2)
		      if(dd<10) {
		        	dd='0'+dd
		      } 
		      if(mm<10) {
		        	mm='0'+mm
		      }
		      today = yyyy+mm+dd;
		      
		      var wb = XLSX.utils.book_new()
		      
		      //var ws = XLSX.utils.json_to_sheet(this.filterLists.originContent, {skipHeader:true})
		      var ws = XLSX.utils.aoa_to_sheet(tmp)
		      XLSX.utils.book_append_sheet(wb, ws, 'sheet');
		      //console.log(data)
		      var data = XLSX.writeFile(wb, today+'_appsflyer.xlsx', {compression:true, bookType:'xlsx'})
		      /*
		      data = 'data:json;charset=cp949,'+data;
		      encodeURI(data)
		      link = document.createElement('a')
		      link.setAttribute('href', data)
		      link.setAttribute('download', 'export.xls')
		      link.click()
		      */
	    },
	},
	watch : { 
		"request.campaign" : function(val) {
			this.spublisherlist = [];
			if( val == "" ) {
				this.spublisherlist = this.publisherlist;
				return;
			}
			for( var i=0; i<this.campaignlist.length; i++ ) {
				var tmp = this.campaignlist[i];
				if( tmp.code == val ) {
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
			
		} 
	},
	computed: {
		
	},
	filters: {
		
	}


});
</script>
</route>