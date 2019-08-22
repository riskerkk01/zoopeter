<route> 
<template id="contactus">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				ContactUs 관리 
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
					<a href="javascript:;" class="btn btn-success" v-on:click="createform()">등록하기</a>
				</div>
			</div>
			
		</div>
	
		<div class="card">
           	<div style="" class="table-responsive">
				<table class="table card-table table-vcenter xtext-nowrap">
					<thead>
		    		<tr xclass="table-info">
		    			<th width="80px" class="text-center">SEQ</th>
		    			<th width="200px" class="text-center">이름</th>   
		    			<th width="200px" class="text-center">이메일</th>
		    			<th xwidth="80px" class="text-center">제목</th>
		    			<th width="100px" class="text-center">등록일</th>
		    			<th width="80px" class="text-center">비고</th>
		    		</tr>
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.seq}}</a></td>
						<td class="text-left"> 
							{{data.name}}
						</td>
						<td class="text-left"> 
							{{data.email}}
						</td>
						
						<td class="text-left">
							{{data.subject}}
						</td>
						<td class="text-center">
							{{data.rtime.substring(0,10)}}
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
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" v-model="requestwrite.name" >
						</div>
						<div class="form-group">						 
							<label for="email" class="form-label">이메일</label>
							<input type="text" class="form-control" name="email" placeholder="이메일을 입력하여 주세요" v-model="requestwrite.email" >
						</div>						
						<div class="form-group">						 
							<label for="subject" class="form-label">제목</label>
							<input type="text" class="form-control" name="subject" placeholder="제목 입력하여 주세요"  v-model="requestwrite.subject" >
						</div>
						<div class="form-group">						 
							<label for="message" class="form-label">메세지</label>
							<textarea class="form-control" rows="7" v-model="requestwrite.message" ></textarea>
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
		            	<h4 class="modal-title">내용 보기 </h4>
		                <button type="button" xclass="close" data-dismiss="modal">&times;</button>
		            </div>
		            <div class="modal-body">
		            	<form name="updateform">
		                <div class="form-group">						 
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" v-model="requestupdate.name" >
						</div>
						<div class="form-group">						 
							<label for="email" class="form-label">이메일</label>
							<input type="text" class="form-control" name="email" placeholder="이메일을 입력하여 주세요" v-model="requestupdate.email" >
						</div>						
						<div class="form-group">						 
							<label for="subject" class="form-label">제목</label>
							<input type="text" class="form-control" name="subject" placeholder="제목 입력하여 주세요"  v-model="requestupdate.subject" >
						</div>
								
						<div class="form-group">						 
							<label for="message" class="form-label">메세지</label>
							<textarea class="form-control" rows="7" v-model="requestupdate.message" ></textarea>
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
var contactus = Vue.component('contactus', {
	template : '#contactus',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ 
					{ name :'seq', val : 'seq' },
					{ name:'이름', val:'name'},
					{ name:'제목', val:'subject'},
					{ name:'이메일',val:'email'},
					{ name:'메세지',val:'message'}
			], 
			listdata : [],
	    	request : {
	    		searchtype : 'name',
	    		searchkeyword : "",
	      		page : 0, 
	      		size : 10,
	      		searchtype : "",
	      		searchkey : "",
	    	},
	    	requestwrite : {
				name : "",
	    		email : "",
	    		subject : "",
	    		message : ""
	    	},
	    	requestupdate : {
	    		seq : 0,
				name : "",
	    		email : "",
	    		subject : "",
	    		message : "",
	      		rtime : "",  
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[1].val;
		console.log("contactus created");
	},
	mounted : function() {
		console.log('contactus');
		this.getList();
	},
	updated: function() {
	},
	methods : {
		updateform : function(data) {
			var self = this
		    axios.get('/api/contactus/'+data.seq).then(res => {
			        var tmp = res.data;
			        if( tmp.seq == "" || tmp.seq == 0 ) {
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
			if( self.requestupdate.seq == 0 ) {
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
			if( self.requestupdate.email == "" ) {
				alert("이메일을 입력하세요.");
				tf.code.focus();
				return;
			}			
				
			axios.post('/api/contactus/update/'+self.requestupdate.seq, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.name = "";
 					self.requestupdate.email = "";
 					self.requestupdate.subject = "";
 					self.requestupdate.message = "";
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
			if( self.requestupdate.seq == 0 ) {
				alert("잘못된 파라미터 입니다.");
				$('#updatemodal').modal('hide');
				self.getList();
				return;
			}
			axios.post('/api/contactus/delete/'+self.requestupdate.seq, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
					self.requestupdate.name = "";
 					self.requestupdate.email = "";
 					self.requestupdate.subject = "";
 					self.requestupdate.message = "";
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
			if( self.requestwrite.email == "" ) {
				alert("이메일을 입력하세요.");
				tf.email.focus();
				return;
			}			
			if( self.requestwrite.subject == "" ) {
				alert("제목을 입력하세요.");
				tf.subject.focus();
				return;
			}			
			axios.post('/api/contactus/create', self.requestwrite).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
					self.requestwrite.name = "";
 					self.requestwrite.email = "";
 					self.requestwrite.subject = "";
 					self.requestwrite.message = "";
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
		      axios.post('/api/contactus/list', self.request).then(res => {
		      		self.totalCount = res.data.totalElements;
			        self.listdata = res.data;
			        //console.log( res.data ); 
		      }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
	}
});
</script>
</route>