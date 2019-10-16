<route> 
<template id="publisher">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				매체 관리 
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
		    			<th width="80px" class="text-center">ID</th>
		    			<th width="140px" class="text-center">이름/코드</th>   
		    			<th xwidth="80px" class="text-center">코드/Postback/Event</th>
		    			<th width="80px" class="text-center">비고</th>
		    		</tr>
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.publisherid}}</a></td>
						<td class="text-center"> 
							{{data.name}}<br>
							<h4><span class="badge badge-info">{{data.code}}</span></h4> 
						</td>
						<td class="text-left">
							POSTBACK : {{data.postback_url}}<br>
							EVENT : {{data.event_url}}
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
						<div class="form-group">						 
							<label for="postback_url" class="form-label">Postback URL</label>
							<input type="text" class="form-control" name="postback_url" placeholder="Postback URL을 입력하여 주세요"  v-model="requestwrite.postback_url">
						</div>		
						<div class="form-group">						 
							<label for="event_url" class="form-label">Postback URL</label>
							<input type="text" class="form-control" name="event_url" placeholder="Event URL을 입력하여 주세요" v-model="requestwrite.event_url">
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
						<div class="form-group">						 
							<label for="postback_url" class="form-label">Postback URL</label>
							<input type="text" class="form-control" name="postback_url" placeholder="Postback URL을 입력하여 주세요"  v-model="requestupdate.postback_url">
						</div>		
						<div class="form-group">						 
							<label for="event_url" class="form-label">Postback URL</label>
							<input type="text" class="form-control" name="event_url" placeholder="Event URL을 입력하여 주세요" v-model="requestupdate.event_url">
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
var publisher = Vue.component('publisher', {
	template : '#publisher',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ { name :'PublisherId', val : 'publisherid' }, { name:'이름', val:'name'}, {name:'코드',val:'code'} ], 
			listdata : [],
	    	request : {
	    		searchtype : 'publisherid',
	    		searchkeyword : "",
	      		page : 0, 
	      		size : 10,
	      		searchtype : "",
	      		searchkey : "",
	    	},
	    	requestwrite : {
	    		name : "",
	    		code : "",
	    		postback_url : "",
	    		event_url : "",
	      		note : "", 
	    	},
	    	requestupdate : {
	    		publisherid : 0,
				name : "",
	    		code : "",
	    		postback_url : "",
	    		event_url : "",
	      		note : "",  
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val;
		console.log("publisher created");
	},
	mounted : function() {
		console.log('publisher');
		this.getList();
	},
	updated: function() {
	},
	methods : {
		updateform : function(data) {
			var self = this
		    axios.get('/api/publisher/'+data.publisherid).then(res => {
			        var tmp = res.data;
			        if( tmp.publisherid == "" || tmp.publisherid == 0 ) {
			        	alert("정보가 없습니다");
			        } else {
			        	self.requestupdate = tmp;
 						$('#updatemodal').modal('show');
 					}
		    }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
		},
		updatesave : function() {
			self = this;
			var tf = document.updateform;
			if( self.requestupdate.publisherid == 0 ) {
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
			if( self.requestupdate.code == "" ) {
				alert("CODE값을 입력하세요.");
				tf.code.focus();
				return;
			}			
				
			axios.post('/api/publisher/update/'+self.requestupdate.publisherid, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.name = "";
 					self.requestupdate.code = "";
 					self.requestupdate.postback_url = "";
 					self.requestupdate.event_url = "";
 					self.requestupdate.note = "";
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
			if( self.requestupdate.publisherid == 0 ) {
				alert("잘못된 파라미터 입니다.");
				$('#updatemodal').modal('hide');
				self.getList();
				return;
			}
			axios.post('/api/publisher/delete/'+self.requestupdate.publisherid, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
					self.requestupdate.name = "";
 					self.requestupdate.code = "";
 					self.requestupdate.postback_url = "";
 					self.requestupdate.event_url = "";
 					self.requestupdate.note = "";
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
			if( self.requestwrite.code == "" ) {
				alert("CODE값을 입력하세요.");
				tf.code.focus();
				return;
			}			
			axios.post('/api/publisher/create', self.requestwrite).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
					self.requestwrite.name = "";
 					self.requestwrite.code = "";
 					self.requestwrite.postback_url = "";
 					self.requestwrite.event_url = "";
 					self.requestwrite.note = "";
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
		      axios.post('/api/publisher/list', self.request).then(res => {
		      		self.totalCount = res.data.totalElements;
			        self.listdata = res.data;
			        //console.log( res.data ); 
		      }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
	}
});
</script>
</route>