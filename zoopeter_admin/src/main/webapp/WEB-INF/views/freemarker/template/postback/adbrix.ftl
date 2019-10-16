<route> 
<template id="adbrix">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				Adbrix 
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
					<select class="form-control" style="width:140px:" v-model="request.cb_param4">
						<option value="">캠페인 선택</option> 
						<option v-for="listValue in campaignlist" :selected="request.cb_param4 == listValue.campaignid" :value="listValue.campaignid">{{listValue.name}}</option>
					</select>
				</div>
				<div class="col-2 text-right">
					<select class="form-control" style="width:140px:" v-model="request.cb_param2">
						<option value="">매체 선택</option> 
						<option v-for="listValue in spublisherlist" :selected="request.cb_param2 == listValue.code" :value="listValue.code">{{listValue.name}}</option>
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
		    			<th width="120px" class="text-center">APPKEY</th>
		    			<th xwidth="100px" class="text-center">Pakckage Name</th>
		    			<th width="130px" class="text-center">Install Time</th>
		    			<th width="100px" class="text-center">Event Type</th> 
		    			<th width="100px" class="text-center">Sales</th>
		    			<th width="130px" class="text-center">Event Time</th> 
		    			<th width="80px" class="text-center">비고</th>
		    		</tr> 
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.seq}}</a></td>
						<td class="text-center">{{data.regtime.substring(0,16)}}</td>
						<td class="text-center">{{data.appkey}}</td> 
						<td class="text-left">{{data.package_name}}</td>
						<td class="text-center">{{data.first_install_time.substring(0,16)}}</td>
						<td class="text-center">{{data.event_type_code}}</td> 
						<td class="text-center">{{Number(data.sales).toLocaleString()}}</td>
						<td class="text-center">{{data.event_time.substring(0,16)}}</td>
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
							<div class="col-sm-3" >APPKEY</div> 
							<div class="col-sm-9">{{requestupdate.appkey}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">PACKAGE_NAME</div> 
							<div class="col-sm-9">{{requestupdate.package_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">GAID</div> 
							<div class="col-sm-9">{{requestupdate.gaid}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-3">IFA</div> 
							<div class="col-sm-9">{{requestupdate.ifa}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">IFV</div> 
							<div class="col-sm-9">{{requestupdate.ifv}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">MODEL</div> 
							<div class="col-sm-9">{{requestupdate.model}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-3">NETWORK</div> 
							<div class="col-sm-9">{{requestupdate.network}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-3">OS_VER</div> 
							<div class="col-sm-9">{{requestupdate.os_ver}}</div>
						</div>							
		            	<div class="row">
							<div class="col-sm-3">SDK_VERSION</div> 
							<div class="col-sm-9">{{requestupdate.sdk_version}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-3">PLATFORM</div>  
							<div class="col-sm-9">{{requestupdate.platform}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">COUNTRY</div> 
							<div class="col-sm-9">{{requestupdate.country}}</div>
						</div>																			
		            	<div class="row">
							<div class="col-sm-3">LANGUAGE</div> 
							<div class="col-sm-9">{{requestupdate.language}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">WIDTH</div> 
							<div class="col-sm-9">{{requestupdate.width}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">HEIGHT</div> 
							<div class="col-sm-9">{{requestupdate.height}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CARRIER</div> 
							<div class="col-sm-9">{{requestupdate.carrier}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">FIRST_INSTALL_TIME</div> 
							<div class="col-sm-9">{{requestupdate.first_install_time}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">EVENT_TYPE_CODE</div> 
							<div class="col-sm-9">{{requestupdate.event_type_code}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CONVERSION_IP</div> 
							<div class="col-sm-9">{{requestupdate.conversion_ip}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">EVENT_TIME</div> 
							<div class="col-sm-9">{{requestupdate.event_time}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">SESSION_ID</div> 
							<div class="col-sm-9">{{requestupdate.session_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CB_PARAM1</div> 
							<div class="col-sm-9">{{requestupdate.cb_param1}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CB_PARAM2</div> 
							<div class="col-sm-9">{{requestupdate.cb_param2}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CB_PARAM3</div> 
							<div class="col-sm-9">{{requestupdate.cb_param3}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CB_PARAM4</div> 
							<div class="col-sm-9">{{requestupdate.cb_param4}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">CB_PARAM5</div> 
							<div class="col-sm-9">{{requestupdate.cb_param5}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">ACTIVITY_GROUP</div> 
							<div class="col-sm-9">{{requestupdate.activity_group}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">ACTIVITY</div> 
							<div class="col-sm-9">{{requestupdate.activity}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">ACTIVITY_PARAM</div> 
							<div class="col-sm-9">{{requestupdate.activity_param}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">ORDER_ID</div> 
							<div class="col-sm-9">{{requestupdate.order_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">PRODUCT_ID</div> 
							<div class="col-sm-9">{{requestupdate.product_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">PRODUCT_NAME</div> 
							<div class="col-sm-9">{{requestupdate.product_name}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">PRICE</div> 
							<div class="col-sm-9">{{requestupdate.price}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-3">QUANTITY</div> 
							<div class="col-sm-9">{{requestupdate.quantity}}</div>
						</div>						
		            	<div class="row">
							<div class="col-sm-3">SALES</div> 
							<div class="col-sm-9">{{requestupdate.sales}}</div>
						</div>
						<div class="row">
							<div class="col-sm-3">CATEGORY</div> 
							<div class="col-sm-9">{{requestupdate.category}}</div>
						</div>
						<div class="row">
							<div class="col-sm-3">CURRENCY</div> 
							<div class="col-sm-9">{{requestupdate.currency}}</div>
						</div>
						<div class="row">
							<div class="col-sm-3">EVENT_DETAIL</div> 
							<div class="col-sm-9">{{requestupdate.event_detail}}</div>
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

var adbrix = Vue.component('adbrix', {
	template : '#adbrix',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ {name:"선택", val:''}, { name :'APPKEY', val : 'appkey' }, { name:'PACKAGE_NAME', val:'package_name'}, {name:'GAID',val:'gaid'}, {name:'EVENT_TYPE_CODE', val:'event_type_code'}, {name:'SUB_PUB_ID', val:'cb_param3'} ],
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
	      		cb_param4 : "",
	      		cb_param2 : "",
	    	},
	    	requestupdate : {
	    		
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val; 
		this.request.cb_param4 = this.searchcate[0].val;
		console.log("adbrix created");
	},
	mounted : function() {
		console.log('adbrix');
		//this.getList();
		this.getPublisherList();
		this.getCampaignList();
		this.setMonth();
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
		      			if( t[i].trackercode == 'adbrix' ) {
		      				self.campaignlist.push( t[i] );
		      			}
		      	}
			    //self.campaignlist = res.data.content;
		    }).catch(err => { console.log(err); alert("캠페인 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },	
		updateform : function(data) {
			var self = this
		    axios.get('/api/adbrix/'+data.seq).then(res => {
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
			axios.post('/api/adbrix/delete/'+self.requestupdate.seq, self.requestupdate).then(res => {
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
		      axios.post('/api/adbrix/list', self.request).then(res => {
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
		    axios.post('/api/adbrix/list', tmp).then(res => {
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
				           tmp3.push("APPKEY")
				           tmp3.push("PACKAGE_NAME")
				           tmp3.push("GAID")
				           tmp3.push("IFA")
				           tmp3.push("IFV")
				           tmp3.push("MODEL")
				           tmp3.push("NETWORK")
				           tmp3.push("OS_VER")
				           tmp3.push("SDK_VERSION")
				           tmp3.push("PLATFORM")
				           tmp3.push("COUNTRY")
				           tmp3.push("LANGUAAGE")
				           tmp3.push("WIDTH")
				           tmp3.push("HEIGHT")
				           tmp3.push("CARRIER")
				           tmp3.push("FIRST_INSTALL_TIME")
				           tmp3.push("EVENT_TYPE_CODE")
				           tmp3.push("CONVERSION_IP")
				           tmp3.push("EVENT_TIME")
				           tmp3.push("SESSION_ID")
				           tmp3.push("CB_PARAM1")
				           tmp3.push("CB_PARAM2")
				           tmp3.push("CB_PARAM3")
				           tmp3.push("CB_PARAM4")
				           tmp3.push("CB_PARAM5")
				           tmp3.push("ACTIVITY_GROUP")
				           tmp3.push("ACTIVITY")
				           tmp3.push("ACTIVITY_PARAM")
				           tmp3.push("ORDER_ID")
				           tmp3.push("PRODUCT_ID")
				           tmp3.push("PRODUCT_NAME")
				           tmp3.push("PRICE")
				           tmp3.push("QUANTITY")
				           tmp3.push("SALES")
				           tmp3.push("CATEGORY")
				           tmp3.push("CURRENCY")
				           tmp3.push("EVENT_DETAIL")
				           flag = 1;
				           tmp.push(tmp3)
			        }
			        tmp2.push(data.seq)
			        tmp2.push(data.regtime)
			        tmp2.push(data.appkey)
			        tmp2.push(data.package_name)
			        tmp2.push(data.gaid)
			        tmp2.push(data.ifa)
			        tmp2.push(data.ifv)
			        tmp2.push(data.model)
			        tmp2.push(data.network)
			        tmp2.push(data.os_ver)
			        tmp2.push(data.sdk_version)
			        tmp2.push(data.platform)
			        tmp2.push(data.country)
			        tmp2.push(data.language)
			        tmp2.push(data.width)
			        tmp2.push(data.height)
			        tmp2.push(data.carrier)
			        tmp2.push(data.first_install_time)
			        tmp2.push(data.event_type_code)
			        tmp2.push(data.conversion_ip)
			        tmp2.push(data.event_time)
			        tmp2.push(data.session_id)
			        tmp2.push(data.cb_param1)
			        tmp2.push(data.cb_param2)
			        tmp2.push(data.cb_param3)
			        tmp2.push(data.cb_param4)
			        tmp2.push(data.cb_param5)
			        tmp2.push(data.activity_group)
			        tmp2.push(data.activity)
			        tmp2.push(data.activity_param)
			        tmp2.push(data.order_id)
			        tmp2.push(data.product_id)
			        tmp2.push(data.product_name0)
			        tmp2.push(data.price)
			        tmp2.push(data.quantity)
			        tmp2.push(data.sales)
			        tmp2.push(data.category)
			        tmp2.push(data.currency)
			        tmp2.push(data.event_detail)
			        
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
		      var data = XLSX.writeFile(wb, today+'_adbrix.xlsx', {compression:true, bookType:'xlsx'})
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
		"request.cb_param4" : function(val) {
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