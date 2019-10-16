<route> 
<template id="adjust">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				Adjust 
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
					<select class="form-control" style="width:140px:" v-model="request.campaign_name">
						<option value="">캠페인 선택</option> 
						<option v-for="listValue in campaignlist" :selected="request.campaign_name == listValue.code" :value="listValue.code">{{listValue.name}}</option>
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
		    			<th width="120px" class="text-center">APP_ID</th>
		    			<th xwidth="100px" class="text-center">CAMPAIGN_NAME</th>
		    			<th width="130px" class="text-center">Install TIME</th>
		    			<th width="100px" class="text-center">CLICK_TIME</th> 
		    			<th width="100px" class="text-center">EVENT</th>
		    			<th width="130px" class="text-center">REVENUE</th> 
		    			<th width="80px" class="text-center">비고</th>
		    		</tr> 
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.seq}}</a></td>
						<td class="text-center">{{data.regtime.substring(0,16)}}</td>
						<td class="text-center">{{data.app_id}}</td> 
						<td class="text-left">{{data.campaign_name}}</td>
						<td class="text-center">{{data.install_at.substring(0,16)}}</td>
						<td class="text-center">{{data.click_time}}</td> 
						<td class="text-center">{{data.event}}</td>
						<td class="text-center">{{Number(data.revenue).toLocaleString()}}</td>
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
							<div class="col-sm-3" >ADID</div> 
							<div class="col-sm-9">{{requestupdate.adid}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">APP_ID</div> 
							<div class="col-sm-9">{{requestupdate.app_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">APP_NAME</div> 
							<div class="col-sm-9">{{requestupdate.app_name}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-3">IDFA</div> 
							<div class="col-sm-9">{{requestupdate.idfa}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CLICK_ID</div> 
							<div class="col-sm-9">{{requestupdate.click_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">APP_VERSION</div> 
							<div class="col-sm-9">{{requestupdate.app_version}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-3">CAMPAIGN_NAME</div> 
							<div class="col-sm-9">{{requestupdate.campaign_name}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-3">INSTALL_AT</div> 
							<div class="col-sm-9">{{requestupdate.install_at}}</div>
						</div>							
		            	<div class="row">
							<div class="col-sm-3">CLICK_TIME</div> 
							<div class="col-sm-9">{{requestupdate.click_time}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-3">COUNTRY</div>  
							<div class="col-sm-9">{{requestupdate.country}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">REGION</div> 
							<div class="col-sm-9">{{requestupdate.region}}</div>
						</div>																			
		            	<div class="row">
							<div class="col-sm-3">SDK_VERSION</div> 
							<div class="col-sm-9">{{requestupdate.sdk_version}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">OS_VERSION</div> 
							<div class="col-sm-9">{{requestupdate.OS_VERSION}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">OS_NAME</div> 
							<div class="col-sm-9">{{requestupdate.os_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">EVENT</div> 
							<div class="col-sm-9">{{requestupdate.event}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">EVENT_NAME</div> 
							<div class="col-sm-9">{{requestupdate.event_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">IP_ADDRESS</div> 
							<div class="col-sm-9">{{requestupdate.ip_address}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">NETWORK_NAME</div> 
							<div class="col-sm-9">{{requestupdate.network_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">REVENUE</div> 
							<div class="col-sm-9">{{requestupdate.revenue}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CURRENCY</div> 
							<div class="col-sm-9">{{requestupdate.currency}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">REVENUE_FLOAT</div> 
							<div class="col-sm-9">{{requestupdate.revenue_float}}</div>
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

var adjust = Vue.component('adjust', {
	template : '#adjust',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ {name:"선택", val:''}, { name :'APP_ID', val : 'app_id' }, { name:'APP_NAME', val:'app_name'} ],
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
	      		campaign_name : "",
	      		publisher_id : ""
	    	},
	    	requestupdate : {
	    		
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val; 
		this.request.campaign_name = this.searchcate[0].val;
		console.log("adjust created");
	},
	mounted : function() {
		console.log('adjust');
		//
		//this.getPublisherList();
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
		      			if( t[i].trackercode == 'adjust' ) {
		      				self.campaignlist.push( t[i] );
		      			}
		      		}
		      }).catch(err => { console.log(err); alert("캠페인 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },	
		updateform : function(data) {
			var self = this
		    axios.get('/api/adjust/'+data.seq).then(res => {
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
			axios.post('/api/adjust/delete/'+self.requestupdate.seq, self.requestupdate).then(res => {
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
		      axios.post('/api/adjust/list', self.request).then(res => {
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
        	/*
        	if( tmp.startdate == "" && tmp.enddate == "" ) {
        		alert( "검색기간을 입력하여 주세요");return;
        	}
        	if( self.listdata.totalElements == 0 ) {
        		alert( "데이타가 없습니다.");return;
        	}
        	*/
		    axios.post('/api/adjust/list', tmp).then(res => {
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
				           tmp3.push("ADID")
				           tmp3.push("APP_ID")
				           tmp3.push("APP_NAME")
				           tmp3.push("IDFA")
				           tmp3.push("CLICK_ID")
				           tmp3.push("APP_VERSION")
				           tmp3.push("CAMPAIGN_NAME")
				           tmp3.push("INSTALL_AT")
				           tmp3.push("CLICK_TIME")
				           tmp3.push("COUNTRY")
				           tmp3.push("REGION")
				           tmp3.push("SDK_VERSION")
				           tmp3.push("OS_VERSION")
				           tmp3.push("OS_NAME")
				           tmp3.push("EVENT")
				           tmp3.push("EVENT_NAME")
				           tmp3.push("IP_ADDRESS")
				           tmp3.push("NETWORK_NAME")
				           tmp3.push("REVENUE")
				           tmp3.push("CURRENCY")
				           tmp3.push("REVENUE_FLOAT")
				           
				           flag = 1;
				           tmp.push(tmp3)
			        }
			        tmp2.push(data.seq)
			        tmp2.push(data.regtime)
			        tmp2.push(data.adid)
			        tmp2.push(data.app_id)
			        tmp2.push(data.app_name)
			        tmp2.push(data.idfa)
			        tmp2.push(data.click_id)
			        tmp2.push(data.app_version)
			        tmp2.push(data.campaign_name)
			        tmp2.push(data.install_at)
			        tmp2.push(data.click_time)
			        tmp2.push(data.country)
			        tmp2.push(data.region)
			        tmp2.push(data.sdk_version)
			        tmp2.push(data.os_version)
			        tmp2.push(data.os_name)
			        tmp2.push(data.event)
			        tmp2.push(data.event_name)
			        tmp2.push(data.ip_address)
			        tmp2.push(data.network_name)
			        tmp2.push(data.revenue)
			        tmp2.push(data.currency)
			        tmp2.push(data.revenue_float)
			        
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
		      var data = XLSX.writeFile(wb, today+'_adjust.xlsx', {compression:true, bookType:'xlsx'})
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
		"request.campaign_name" : function(val) {
			this.spublisherlist = [];
			if( val == "" ) {
				this.spublisherlist = this.publisherlist;
				return;
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
			
		} 
	},
	computed: {
		
	},
	filters: {
		
	}


});
</script>
</route>