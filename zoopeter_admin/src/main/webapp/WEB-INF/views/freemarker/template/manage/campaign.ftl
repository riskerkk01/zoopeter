<route> 
<template id="campaign">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				캠페인 관리 
				<small v-if="totalCount > 0">( 전체 갯수 : {{Number(totalCount).toLocaleString()}} )</small> 
			</h1>
		</div>	
		
		<div class="alert alert-primary">
			
			<div class="row">
				<div class="col-9">
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
				<div class="col-3 text-right">
					<a href="javascript:;" class="btn btn-success" v-on:click="createform()" xdata-toggle="modal" xdata-target="#createmodal">등록하기</a>
				</div>
			</div>
			
		</div>
	
		<div class="card">
           	<div style="" class="table-responsive">
				<table class="table card-table table-vcenter xtext-nowrap">
					<thead>
		    		<tr xclass="table-info">
		    			<th width="80px" class="text-center">CampID</th>
		    			<th width="120px" class="text-center">코드</th>   
		    			<th xwidth="140px" class="text-center">이름</th>
		    			<th width="100px" class="text-center">시작일</th>
		    			<th width="100px" class="text-center">종료일</th>
		    			<th width="100px" class="text-center">등록일</th> 
		    			<th width="100px" class="text-center">수정일</th>
		    			<th width="200px" class="text-center">트래커</th> 
		    			<th width="80px" class="text-center">비고</th>  
		    		</tr>
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.campaignid}}</a></td>
						<td class="text-center">{{data.code}}</td>
						<td class="text-left">{{data.name}}</td>
						<td class="text-center">{{data.startdate}}</td>
						<td class="text-center">{{data.enddate}}</td>
						<td class="text-center">{{data.rtime.substring(0,10)}}</td>
						<td class="text-center">{{data.mtime.substring(0,10)}}</td>
						<td class="text-center">{{data.trackername}}</td>
						<td class="text-center">
							<a href="javascript:;" class="btn btn-warning btn-sm" v-on:click="updateform(data)">수정</a>
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
			
		<div class="modal fade" id="createmodal">
		    <div class="modal-dialog modal-xl">
		        <div class="modal-content">
		            <div class="modal-header">
		            	<h4 class="modal-title">등록하기 </h4>
		                <button type="button" xclass="close" data-dismiss="modal">&times;</button>
		            </div>
		            <div class="modal-body">
		            	<form name="createform">
		            	<div class="row">
                    		<div class="col-md-6">
								<div class="form-group">						 
									<label for="name" class="form-label">이름</label>
									<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" v-model="requestwrite.name">
								</div>
							</div> 
							<div class="col-md-6">	
								<div class="form-group">						 
									<label for="code" class="form-label">CODE</label>
									<input type="text" class="form-control" name="code" placeholder="CODE를 입력하여 주세요" v-model="requestwrite.code">
								</div>
							</div>
						</div>
						<div class="row">
                    		<div class="col-md-6">
								<div class="form-group">						 
									<label for="startdate" class="form-label">시작일</label>
									<date-picker v-model="requestwrite.startdate" :config="{format:'YYYY-MM-DD'}" class="input-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true"></date-picker>
								</div>
							</div> 
							<div class="col-md-6">					 	
								<div class="form-group">						 
									<label for="enddate" class="form-label">종료일</label>
									<date-picker v-model="requestwrite.enddate" :config="{format:'YYYY-MM-DD'}" class="input-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true"></date-picker>
								</div>
							</div>
						</div>
						<div class="row">
                    		<div class="col-md-6">
								<div class="form-group">						 
									<label for="trackercode" class="form-label">트래커</label>
									<select class="form-control" v-model="requestwrite.trackercode">
										<option disabled value="">선택</option> 
										<option v-for="listValue in trackerlist" :selected="requestwrite.trackercode == listValue.code" :value="listValue.code">{{listValue.value}}</option>
									</select>
									
								</div>		 
							</div> 
							<div class="col-md-6">					 	
								<div class="form-group">						 
									<label for="tmppublisherids" class="form-label">매체들</label>
									<vue-multiselect v-model="requestwrite.tmppublisherids" :options="publisherlist" label="name" :multiple="true" :searchable="true" track-by="publisherid">
								</div>
							</div>
						</div>		
						<div class="form-group">						 
							<label for="launchingurl" class="form-label">Launching URL</label>
							<input type="text" class="form-control" name="launchingurl" placeholder="Launching URL을 입력하여 주세요" v-model="requestwrite.launchingurl">
						</div>		

						<div class="form-group">						 
							<label for="note" class="form-label">메모</label> 
							<textarea v-model="requestwrite.note" rows="7" class="form-control"></textarea>
						</div>		
						</form> 
		            </div>
		            <div class="modal-footer">
		            	<button type="button" class="btn btn-success" v-on:click="createsave()">저장</button>
		                <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
		            </div>
		        </div>
		    </div>
		</div>
		<div class="modal fade" id="updatemodal">
		    <div class="modal-dialog modal-xl">
		        <div class="modal-content">
		            <div class="modal-header">
		            	<h4 class="modal-title">수정하기 </h4>
		                <button type="button" xclass="close" data-dismiss="modal">&times;</button>
		            </div>
		            <div class="modal-body">
		            	<form name="updateform">
		            	<div class="row">
                    		<div class="col-md-6">
								<div class="form-group">						 
									<label for="name" class="form-label">이름</label>
									<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" v-model="requestupdate.name">
								</div>
							</div> 
							<div class="col-md-6">	
								<div class="form-group">						 
									<label for="code" class="form-label">CODE</label>
									<input type="text" class="form-control" name="code" placeholder="CODE를 입력하여 주세요" v-model="requestupdate.code">
								</div>
							</div>
						</div>
						<div class="row">
                    		<div class="col-md-6">
								<div class="form-group">						 
									<label for="startdate" class="form-label">시작일</label>
									<date-picker v-model="requestupdate.startdate" :config="{format:'YYYY-MM-DD'}" class="input-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true" placeholder="시작일을 입력하여 주세요 (0000-00-00)"></date-picker>
								</div>
							</div> 
							<div class="col-md-6">					 	
								<div class="form-group">					 	 
									<label for="enddate" class="form-label">종료일</label>
									<date-picker v-model="requestupdate.enddate" :config="{format:'YYYY-MM-DD'}" class="input-sm" data-mask="0000-00-00" data-mask-clearifnotmatch="true" placeholder="종료일을 입력하여 주세요 (0000-00-00)"></date-picker>
								</div>
							</div>
						</div>
						<div class="row">
                    		<div class="col-md-6">
								<div class="form-group">						 
									<label for="trackercode" class="form-label">트래커</label>
									<select class="form-control" v-model="requestupdate.trackercode">
										<option disabled value="">선택</option> 
										<option v-for="listValue in trackerlist" :selected="requestwrite.trackercode == listValue.code" :value="listValue.code">{{listValue.value}}</option>
									</select>
									
								</div>		 
							</div> 
							<div class="col-md-6">					 	
								<div class="form-group">						 
									<label for="tmppublisherids" class="form-label">매체들</label>
									<vue-multiselect v-model="requestupdate.tmppublisherids" :options="publisherlist" label="name" :multiple="true" :searchable="true" track-by="publisherid">
								</div>
							</div>
						</div>		
						<div class="form-group">						 
							<label for="launchingurl" class="form-label">Launching URL</label>
							<input type="text" class="form-control" name="launchingurl" placeholder="Launching URL을 입력하여 주세요" v-model="requestupdate.launchingurl">
						</div>

						<div class="form-group" v-for="tmppub in requestupdate.tmppublisherids">						 
							<label for="" class="form-label">{{tmppub.name}}
								<span>
									<button class="btn btn-primary btn-sm" type="button" v-on:click="copylink(tmppub)">복사하기</button>
                             	</span>
							</label>
							<input type="text" v-bind:id="tmppub.code" class="form-control" v-model="publink(tmppub)">
						</div>
						
						<div class="form-group">						 
							<label for="note" class="form-label">메모</label> 
							<textarea v-model="requestupdate.note" rows="7" class="form-control"></textarea>
						</div>		
						</form>
		            </div>
		            <div class="modal-footer">
		            	<button type="button" class="btn btn-success" v-on:click="updatesave()">저장</button>
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

var campaign = Vue.component('campaign', {
	template : '#campaign',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ { name :'CampaignId', val : 'campaignid' }, { name:'이름', val:'name'}, {name:'코드',val:'code'}, {name:'AppName', val:'appname'} ],
			trackerlist : [],
			publisherlist : [], 
			listdata : [],
			requesttmp : {
				category : '',
	      		page : 0, 
	      		size : 10000,
	    	},
	    	request : {
	    		searchtype : 'campaignid',
	    		searchkeyword : "",
	      		page : 0, 
	      		size : 10,
	      		searchtype : "",
	      		searchkey : "",
	    	},
	    	requestwrite : {
	    		name : "",
	    		code : "",
	    		startdate : "",
	    		enddate : "",
	    		note : "",
	    		trackercode : "", 
	    		publisherids : "",
	    		tmppublisherids : [],
	    		launchingurl : "",
	    		state : 0,
	    		appname : ""
	    	},
	    	requestupdate : {
	    		campaignid : 0,
				name : "",
	    		code : "",
	    		startdate : "",
	    		enddate : "",
	    		note : "",
	    		trackercode : "",
	    		publisherids : "",
	    		tmppublisherids : [],
	    		launchingurl : "",
	    		state : 0,
	    		appname : ""
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val; 
		console.log("campaign created");
	},
	mounted : function() {
		console.log('campaign');
		this.getPublisherList();
		this.getTrackerList(); 
		this.getList();
		
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
		getTrackerList : function() {
		      var self = this
		      self.requesttmp.category = 'trackersite';
		      axios.post('/api/sitecode/list', self.requesttmp).then(res => {
			        self.trackerlist = res.data.content;
		      }).catch(err => { console.log(err); alert("트래커 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },	    
		updateform : function(data) {
			var self = this
		    axios.get('/api/campaign/'+data.campaignid).then(res => {
			        var tmp = res.data;
			        if( tmp.campaignid == "" || tmp.campaignid == 0 ) {
			        	alert("정보가 없습니다");
			        } else {
			        	tmp.tmppublisherids = [];
			        	self.requestupdate = tmp;
			        	//self.requestupdate.tmppublisherids = [];
			        	if( self.requestupdate.publisherids != "" && self.requestupdate.publisherids != null ) { 
			        		console.log( self.requestupdate.publisherids );
			        		var tt = self.requestupdate.publisherids.split(',');
			        		for( var i in tt ) { 
			        			var code = tt[i];
			        			for( var p in self.publisherlist ) {
			        				if( code == self.publisherlist[p].code ) { 
			        					self.requestupdate.tmppublisherids.push( self.publisherlist[p] ); 
			        				}
			        			}
			        		}
			        		//console.log( self.requestupdate.tmppublisherids );
			        	}
 						$('#updatemodal').modal('show');
 					}
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
		},
		updatesave : function() {
			self = this;
			var tf = document.updateform;
			if( self.requestupdate.campaignid == 0 ) {
				alert("잘못된 파라미터 입니다.");
				$('#updatemodal').modal('hide');
				self.getList();
				return;
			}
			if( self.requestupdate.name == "" ) {
				alert("이름을 입력하여 주세요.");
				tf.name.focus();
				return;
			}
			if( self.requestupdate.code == "" ) {
				alert("CODE값을 입력하세요.");
				tf.code.focus();
				return;
			}			
			if( self.requestupdate.tmppublisherids.length != 0 ) {
				var tmp = [];
				for( var i=0; i<self.requestupdate.tmppublisherids.length; i++ ) {
					tmp.push( self.requestupdate.tmppublisherids[i].code );
				}
				self.requestupdate.publisherids = tmp.toString();
			}
			axios.post('/api/campaign/update/'+self.requestupdate.campaignid, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.name = "";
 					self.requestupdate.code = "";
 					self.requestupdate.startdate = "";
 					self.requestupdate.enddate = "";
 					self.requestupdate.note = "";
 					self.requestupdate.trackercode = "";
 					self.requestupdate.publisherids = [];
 					self.requestupdate.launchingurl = "";
 					self.requestupdate.state = 0;
 					self.getList();
 					$('#updatemodal').modal('hide');
				} else {
					alert( res.data.note );
				}
		    }).catch(err => { console.log(err); alert("저장하는 중에 오류가 발생하였습니다. 잠시 후 이용하여 주세요."+err); });
		},		
		deleteact : function() {
			self = this;
			if( confirm('삭제하시겠습니까?') == false ) { return; }
			if( self.requestupdate.campaignid == 0 ) {
				alert("잘못된 파라미터 입니다.");
				$('#updatemodal').modal('hide');
				self.getList();
				return;
			}
			axios.post('/api/campaign/delete/'+self.requestupdate.campaignid, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.name = "";
 					self.requestupdate.code = "";
 					self.requestupdate.startdate = "";
 					self.requestupdate.enddate = "";
 					self.requestupdate.note = "";
 					self.requestupdate.trackercode = "";
 					self.requestupdate.publisherids = [];
 					self.requestupdate.launchingurl = "";
 					self.requestupdate.state = 0;
 					self.getList();
 					$('#updatemodal').modal('hide');
				} else {
					alert( res.data.note );
				}
		    }).catch(err => { console.log(err); alert("저장하는 중에 오류가 발생하였습니다. 잠시 후 이용하여 주세요."+err); });
		},			
		createform : function() {
			$('#createmodal').modal('show');
			console.log( "createform" );
		},
		createsave : function() {
			self = this;
			var tf = document.createform;
			if( self.requestwrite.name == "" ) { 
				alert("이름을 입력하여 주세요.");
				tf.name.focus();
				return;
			}
			if( self.requestwrite.code == "" ) {
				alert("CODE값을 입력하세요.");
				tf.code.focus();
				return;
			}			
			//console.log( self.requestwrite.tmppublisherids );
			
			if( self.requestwrite.tmppublisherids.length != 0 ) {
				var tmp = [];
				for( var i=0; i<self.requestwrite.tmppublisherids.length; i++ ) {
					tmp.push( self.requestwrite.tmppublisherids[i].code );
				}
				self.requestwrite.publisherids = tmp.toString();
			}

			axios.post('/api/campaign/create', self.requestwrite).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestwrite.name = "";
 					self.requestwrite.code = "";
 					self.requestwrite.startdate = "";
 					self.requestwrite.enddate = "";
 					self.requestwrite.note = "";
 					self.requestwrite.trackercode = "";
 					self.requestwrite.publisherids = [];
 					self.requestwrite.launchingurl = "";
 					self.requestwrite.state = 0;
 					self.getList();
 					$('#createmodal').modal('hide');
				} else {
					alert( res.data.note );
				}
		    }).catch(err => { console.log(err); alert("저장하는 중에 오류가 발생하였습니다. 잠시 후 이용하여 주세요."+err); });
		},
		searchbtn : function() {
			this.listdata = [];
			this.getList();
		},
		paging : function() {
			console.log( this.request.page );
			this.listdata = [];
			this.getList();
		},
		getList : function() {
		      var self = this
		      axios.post('/api/campaign/list', self.request).then(res => {
		      		self.totalCount = res.data.totalElements;
			        self.listdata = res.data;
			        //console.log( res.data ); 
		      }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
	    copylink : function(obj) {
			var copyText = document.getElementById( obj.code );
			copyText.select();
			document.execCommand( "copy" );
	    },
	    publink : function(obj) { 
	    	var url = "http://click.zoopeter.com/click.php?camp_id="+this.requestupdate.code+"&pub_id="+obj.code+"&sub_pub_id={sub_pub_id}&click_id={click_id}&sub_param1={sub_param1}&sub_param2={sub_param2}&sub_param3={sub_param3}&sub_param4={sub_param4}&ADID={ADID}&IDFA={IDFA}";
	    	return url;
		}
	},
	computed: {
		
	}
});
</script>
</route>