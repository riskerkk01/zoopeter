<route> 
<template id="clicklog">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				클릭로그 
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
					<select class="form-control" style="width:140px:" v-model="request.camp_no">
						<option value="">캠페인 선택</option> 
						<option v-for="listValue in campaignlist" :selected="request.camp_no == listValue.campaignid" :value="listValue.campaignid">{{listValue.name}}</option>
					</select>
				</div>
				<div class="col-5">
					<div class="input-group"> 
						<div class="input-group-btn" >
							<select class="form-control" style="width:140px:" v-model="request.searchtype">
								<option disabled value="">선택</option> 
								<option v-for="listValue in searchcate" :selected="request.searchtype == listValue.val" :value="listValue.val">{{listValue.name}}</option>
							</select>
						</div>
						<input type="text" class="form-control"  placeholder="검색어를 입력하세요" name="searchkeyword" value="" v-model="request.searchkeyword" v-on:keyup.enter="searchbtn()">
						<span class="input-group-btn">
							<input type="button" class="btn btn-primary" value="검색" v-on:click="searchbtn()">
						</span>
					</div><!-- /input-group -->

				</div>
				<div class="col-4 text-right">
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
		    			<th width="140px" class="text-center">등록일시</th>   
		    			<th width="180px" class="text-center">CAMP NO / ID</th>
		    			<th xwidth="100px" class="text-center">CLICK_ID</th>
		    			<th width="80px" class="text-center">PUB_ID</th>
		    			<th width="100px" class="text-center">SUB_PUB_ID</th>
		    			<th width="100px" class="text-center">IP</th> 
		    			<th width="80px" class="text-center">비고</th>
		    		</tr> 
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.seq}}</a></td>
						<td class="text-center">{{data.rtime.substring(0,16)}}</td>
						<td class="text-center">[{{data.camp_no}}] {{data.camp_id}}</td> 
						<td class="text-left">{{data.click_id}}</td>
						<td class="text-center">{{data.pub_id}}</td>
						<td class="text-center">{{data.sub_pub_id}}</td>
						<td class="text-center">{{data.ip}}</td>
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
							<div class="col-sm-2" >등록일시</div>
							<div class="col-sm-10">{{requestupdate.rtime}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-2" >CAMP_CODE</div> 
							<div class="col-sm-10">{{requestupdate.camp_no}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-2">CAMP_ID</div> 
							<div class="col-sm-10">{{requestupdate.camp_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-2">CLICK_ID</div> 
							<div class="col-sm-10">{{requestupdate.click_id}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-2">PUB_ID</div> 
							<div class="col-sm-10">{{requestupdate.pub_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-2">SUB_PUB_ID</div> 
							<div class="col-sm-10">{{requestupdate.sub_pub_id}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-2">SUB_PARAM1</div> 
							<div class="col-sm-10">{{requestupdate.sub_param1}}</div>
						</div>								 
		            	<div class="row">
							<div class="col-sm-2">SUB_PARAM2</div> 
							<div class="col-sm-10">{{requestupdate.sub_param2}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-2">SUB_PARAM3</div> 
							<div class="col-sm-10">{{requestupdate.sub_param3}}</div>
						</div>							
		            	<div class="row">
							<div class="col-sm-2">SUB_PARAM4</div> 
							<div class="col-sm-10">{{requestupdate.sub_param4}}</div>
						</div>	
		            	<div class="row">
							<div class="col-sm-2">IDFA</div>  
							<div class="col-sm-10">{{requestupdate.idfa}}</div>
						</div>
		            	<div class="row">
							<div class="col-sm-2">ADID</div> 
							<div class="col-sm-10">{{requestupdate.adid}}</div>
						</div>																			
		            	<div class="row">
							<div class="col-sm-2">IP ADDRESS</div> 
							<div class="col-sm-10">{{requestupdate.ip}}</div>
						</div>																			
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
jQuery(document).ready(function() { 
});
require(['input-mask']);

var clicklog = Vue.component('clicklog', {
	template : '#clicklog',
	props : ['camp_no'],
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ { name :'CAMPAIGN_ID', val : 'camp_id' }, { name:'CAMPAIGN_CODE', val:'camp_no'}, {name:'IDFA',val:'idfa'}, {name:'ADID', val:'adid'}, {name:'CLICK_ID', val:'click_id'}, {name:'PUB_ID', val:'pub_id'}, {name:'SUB_PUB_ID', val:'sub_pub_id'} ],
			listdata : [],
			listexcel : [],
			campaignlist : [],
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
	    	requestupdate : {
	    		
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val; 
		
		console.log("clicklog created");
	},
	mounted : function() {
		if( this.camp_no != '' && this.camp_no != undefined ) {
			this.request.camp_no = this.camp_no;
		}
		console.log('clicklog');
		//this.getList();

		this.getCampaignList();
		this.setMonth();
		console.log( this.camp_no );
	},
	updated: function() {
	},
	methods : {
		getCampaignList : function() {
		      var self = this
		      self.requesttmp.category = '';
		      axios.post('/api/campaign/list', self.requesttmp).then(res => {
			        self.campaignlist = res.data.content;
		      }).catch(err => { console.log(err); alert("캠페인 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },	
		updateform : function(data) {
			var self = this
		    axios.get('/api/clicklog/'+data.seq).then(res => {
			        var tmp = res.data;
			        if( tmp.seq == "" || tmp.seq == 0 ) {
			        	alert("정보가 없습니다");
			        } else {
			        	self.requestupdate = tmp;
 						$('#updatemodal').modal('show');
 					}
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
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
		      axios.post('/api/clicklog/list', self.request).then(res => {
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
		    axios.post('/api/clicklog/list', tmp).then(res => {
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
				           tmp3.push("CAMP_ID")
				           tmp3.push("CAMP_NO")
				           tmp3.push("CLICK_ID")
				           tmp3.push("PUB_ID")
				           tmp3.push("SUB_PUB_ID")
				           tmp3.push("SUB_PARAM1")
				           tmp3.push("SUB_PARAM2")
				           tmp3.push("SUB_PARAM3")
				           tmp3.push("SUB_PARAM4")
				           tmp3.push("IDFA")
				           tmp3.push("ADID")
				           tmp3.push("IP")
				           tmp3.push("RTIME")
				           flag = 1;
				           tmp.push(tmp3)
			        }
			        tmp2.push(data.seq)
			        tmp2.push(data.camp_id)
			        tmp2.push(data.camp_no)
			        tmp2.push(data.click_id)
			        tmp2.push(data.pub_id)
			        tmp2.push(data.sub_pub_id)
			        tmp2.push(data.sub_param1)
			        tmp2.push(data.sub_param2)
			        tmp2.push(data.sub_param3)
			        tmp2.push(data.sub_param4)
			        tmp2.push(data.idfa)
			        tmp2.push(data.adid)
			        tmp2.push(data.ip)
			        tmp2.push(data.rtime.substring(0,16))
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
		      var data = XLSX.writeFile(wb, today+'_click_log_list.xlsx', {compression:true, bookType:'xlsx'})
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
		"request.camp_no" : function(val) {
			this.request.page = 0;
			this.getList();
		} 
	},	
	computed: {
		
	}
});
</script>
</route>