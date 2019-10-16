<route> 
<template id="admin">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				관리자 관리 
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
		    			<th width="80px" class="text-center">AdminID</th>
		    			<th width="80px" class="text-center">타입</th>
		    			<th width="140px" class="text-center">매체</th>
		    			<th width="140px" class="text-center">ID</th>   
		    			<th xwidth="140px" class="text-left">이름</th>
		    			<th width="100px" class="text-center">등록일</th>
		    			<th width="100px" class="text-center">수정일</th>
		    			<th width="80px" class="text-center">상태</th>
		    			<th width="80px" class="text-center">비고</th>
		    		</tr>
					</thead> 
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.adminid}}</a></td>
						<td class="text-center">
							<span v-if="data.type == 1">관리자</span> 
							<span v-if="data.type == 2">매체</span>
						</td>
						<td class="text-center">{{data.publishername}}</td>
						<td class="text-center">{{data.id}}</td>
						<td class="text-left">{{data.name}}</td>
						<td class="text-center">{{data.rtime.substring(0,10)}}</td>
						<td class="text-center">{{data.mtime.substring(0,10)}}</td>
						<td class="text-center">
							<span v-if="data.state == 0">사용중</span> 
							<span v-if="data.state != 0">사용정지</span> 
						</td>
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
		            	<div class="form-group">						 
							<label for="type" class="form-label">타입</label>
		            		<select class="form-control" v-model="requestwrite.type">
								<option value="1">관리자</option> 
								<option value="2">매체</option>
							</select>
						</div>
						<div class="form-group">						 
							<label for="type" class="form-label">매체 ( 타입이 매체일때만 )</label>
		            		<select class="form-control" v-model="requestwrite.publisherid">
		            			<option value="01">매체 선택</option> 
		            			<option v-for="pub in publisherlist" :selected="requestwrite.publihserid == pub.publisherid" :value="pub.publisherid">{{pub.name}}</option>
							</select>
						</div>
						<div class="form-group">						 
							<label for="state" class="form-label">상태</label>
		            		<select class="form-control" v-model="requestwrite.state">
								<option value="0">사용중</option> 
								<option value="1">사용정지</option>
							</select>
						</div>
						<div class="form-group">						 
							<label for="id" class="form-label">ID</label>
							<input type="text" class="form-control" name="id" placeholder="ID을 입력하여 주세요" v-model="requestwrite.id">
						</div>
						<div class="form-group">						 
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" v-model="requestwrite.name">
						</div>
						<div class="form-group">						 
							<label for="passwd" class="form-label">비밀번호</label>
							<input type="text" class="form-control" name="passwd" placeholder="비밀번호를 입력하여 주세요" v-model="requestwrite.passwd">
						</div>						
						<div class="form-group">						 
							<label for="description" class="form-label">설명</label>
							<input type="text" class="form-control" name="description" placeholder="설명을 입력하여 주세요"  v-model="requestwrite.description">
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
		                <div class="form-group">						 
							<label for="type" class="form-label">타입</label>
		            		<select class="form-control" v-model="requestupdate.type">
								<option value="1">관리자</option> 
								<option value="2">매체</option>
							</select>
						</div>
						<div class="form-group">						 
							<label for="type" class="form-label">매체 ( 타입이 매체일때만 )</label>
		            		<select class="form-control" v-model="requestupdate.publisherid">
		            			<option value="01">매체 선택</option> 
		            			<option v-for="pub in publisherlist" :selected="requestwrite.publihserid == pub.publisherid" :value="pub.publisherid">{{pub.name}}</option>
							</select>
						</div>
						<div class="form-group">						 
							<label for="state" class="form-label">상태</label>
		            		<select class="form-control" v-model="requestupdate.state">
								<option value="0">사용중</option> 
								<option value="1">사용정지</option>
							</select>
						</div>
						<div class="form-group">						 
							<label for="id" class="form-label">ID</label>
							<input type="text" class="form-control" name="id" placeholder="ID을 입력하여 주세요" v-model="requestupdate.id" readonly>
						</div>
						<div class="form-group">						 
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" v-model="requestupdate.name">
						</div>
						<div class="form-group">						 
							<label for="passwd" class="form-label">비밀번호</label>
							<input type="text" class="form-control" name="passwd" placeholder="비밀번호를 입력하여 주세요(변경시에만)" v-model="requestupdate.passwd">
						</div>						
						<div class="form-group">						 
							<label for="description" class="form-label">설명</label>
							<input type="text" class="form-control" name="description" placeholder="설명을 입력하여 주세요"  v-model="requestupdate.description">
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
var admin = Vue.component('admin', {
	template : '#admin',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ { name:'이름', val:'name'}, {name:'ID',val:'id'} ], 
			publisherlist : [],
			listdata : [],
			requestpub : {
	      		page : 0, 
	      		size : 100,
	    	},
	    	request : {
	    		searchtype : 'name',
	    		searchkeyword : "",
	      		page : 0, 
	      		size : 10,
	      		searchtype : "",
	      		searchkey : "",
	    	},
	    	requestwrite : {
	    		type : 0,
	    		state : 0,
	    		name : "",
	    		id : "",
	    		passwd : "",
	    		description : "",
	      		publisherid : 0,
	      		passwdsha256 : "" 
	    	},
	    	requestupdate : {
	    		adminid : 0,
	    		type : 0,
	    		state : 0,
	    		name : "",
	    		id : "",
	    		passwd : "",
	    		description : "",
	      		publisherid : 0,
	      		passwdsha256 : ""   
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val;
		console.log("admin created");
	},
	mounted : function() {
		console.log('admin');
		this.getPublisherList();
		this.getList();
	},
	updated: function() {
	},
	methods : {
		getPublisherList : function() {
		      var self = this
		      axios.post('/api/publisher/list', self.requestpub).then(res => {
			        self.publisherlist = res.data.content;
		      }).catch(err => { console.log(err); alert("매체 정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
		updateform : function(data) {
			var self = this
		    axios.get('/api/admin/'+data.adminid).then(res => {
			        var tmp = res.data;
			        if( tmp.adminid == "" || tmp.adminid == 0 ) {
			        	alert("정보가 없습니다");
			        } else {
			        	self.requestupdate = tmp;
			        	self.requestupdate.passwd = "";
			        	self.requestupdate.passwdsha256 = "";
 						$('#updatemodal').modal('show');
 					}
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
		},
		updatesave : function() {
			self = this;
			var tf = document.updateform;
			if( self.requestupdate.adminid == 0 ) {
				alert("잘못된 파라미터 입니다.");
				$('#updatemodal').modal('hide');
				self.getList();
				return;
			}
			if( self.requestupdate.name == "" ) {
				alert("이름을 선택하여 주세요.");
				tf.name.focus();
				return;
			}
			
			if( self.requestupdate.passwd != "" ) {
				self.requestupdate.passwdsha256 = SHA256( self.requestupdate.passwd );
			}
			
			axios.post('/api/admin/update/'+self.requestupdate.adminid, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.type = 0;
 					self.requestupdate.state = 0;
 					self.requestupdate.name = "";
 					self.requestupdate.id = "";
 					self.requestupdate.passwd = "";
 					self.requestupdate.passwdsha256 = "";
 					self.requestupdate.description = "";
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
			if( self.requestupdate.adminid == 0 ) {
				alert("잘못된 파라미터 입니다.");
				$('#updatemodal').modal('hide');
				self.getList();
				return;
			}
			axios.post('/api/admin/delete/'+self.requestupdate.adminid, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.type = 0;
 					self.requestupdate.state = 0;
 					self.requestupdate.name = "";
 					self.requestupdate.id = "";
 					self.requestupdate.passwd = "";
 					self.requestupdate.passwdsha256 = "";
 					self.requestupdate.description = "";
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
				alert("이름을 선택하여 주세요.");
				tf.name.focus();
				return;
			}
			if( self.requestwrite.id == "" ) {
				alert("ID를 입력하세요.");
				tf.id.focus();
				return;
			}
			if( self.requestwrite.passwd == "" ) {
				alert("비밀번호를 입력하세요.");
				tf.passwd.focus();
				return;
			}
			
			self.requestwrite.passwdsha256 = SHA256( self.requestwrite.passwd );
					
			axios.post('/api/admin/create', self.requestwrite).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestwrite.type = 0;
 					self.requestwrite.state = 0;
 					self.requestwrite.name = "";
 					self.requestwrite.id = "";
 					self.requestwrite.passwd = "";
 					self.requestwrite.passwdsha256 = "";
 					self.requestwrite.description = "";
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
		      axios.post('/api/admin/list', self.request).then(res => {
		      		self.totalCount = res.data.totalElements;
			        self.listdata = res.data;
			        console.log( self.listdata.content ); 
		      }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
	}
});
</script>
</route>