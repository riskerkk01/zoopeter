<route> 
<template id="siteconfig">
	<div>
		<!-- Page Heading -->
		<div class="page-header">
			<h1 class="page-title">
				사이트설정 관리
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
				<table class="table card-table table-vcenter text-nowrap ">
					<thead>
		    		<tr class="info">
		    			<th width="80px" class="text-center">SEQ</th>
		    			<th width="150px" class="text-center">이름</th>
		    			<th xwidth="80px" class="text-center">값</th>
		    			<th width="80px" class="text-center">비고</th>
		    		</tr>
					</thead>
					<tr v-for="(data, index) in listdata.content">
						<td class="text-center"><a href="javascript:;" v-on:click="updateform(data)">{{data.seq}}</a></td>
						<td class="text-center">
							{{data.name}}
						</td>
						<td class="">
							{{data.value}}
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
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		            	<h4 class="modal-title">등록하기 </h4>
		                <button type="button" xclass="close" data-dismiss="modal">&times;</button>
		            </div>
		            <div class="modal-body">
		            	<form name="createform">
						<div class="form-group">						 
							<label for="name" class="form-label">이름</label>
							<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" value="" v-model="requestwrite.name">
						</div>
						<div class="form-group">						 
							<label for="value" class="form-label">값</label>
							<input type="text" class="form-control" name="value" placeholder="값을 입력하여 주세요" value="" v-model="requestwrite.value">
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
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		            	<h4 class="modal-title">수정하기 </h4>
		                <button type="button" xclass="close" data-dismiss="modal">&times;</button>
		            </div>
		            <div class="modal-body">
		            	<form name="updateform">
						<div class="form-group">						 
							<label for="name" class="form-label">CODE</label>
							<input type="text" class="form-control" name="name" placeholder="이름을 입력하여 주세요" value="" v-model="requestupdate.name">
						</div>
						<div class="form-group">						 
							<label for="value" class="form-label">값</label>
							<input type="text" class="form-control" name="value" placeholder="값을 입력하여 주세요" value="" v-model="requestupdate.value">
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
var siteconfig = Vue.component('siteconfig', {
	template : '#siteconfig',
	data : function() {  
		return {
			totalCount : 0,
			searchcate : [ { name :'이름', val : 'name' }, { name:'값', val:'value'} ],
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
	    		value : "",

	    	},
	    	requestupdate : {
	    		seq : 0,
	    		name : "",
	    		value : "",
	    	},	    	
	    } 
	},
	
	created : function() {
		this.request.searchtype = this.searchcate[0].val;
		console.log("siteconfig created");
	},
	mounted : function() {
		console.log('siteconfig');
		this.getList();
	},
	updated: function() {
	},
	methods : {
		updateform : function(data) {
			var self = this
		    axios.get('/api/siteconfig/'+data.seq).then(res => {
			        var tmp = res.data;
			        if( tmp.seq == "" || tmp.seq == 0 ) {
			        	alert("정보가 없습니다");
			        } else {
			        	this.requestupdate = tmp;
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
			if( self.requestupdate.value == "" ) {
				alert("값을 입력하세요.");
				tf.value.focus();
				return;
			}			
			axios.post('/api/siteconfig/update/'+self.requestupdate.seq, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.name = "";
 					self.requestupdate.value = "";
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
			axios.post('/api/siteconfig/delete/'+self.requestupdate.seq, self.requestupdate).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestupdate.name = "";
 					self.requestupdate.value = "";
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
				alert("이름을 입력하세요.");
				tf.name.focus();
				return;
			}			
			if( self.requestwrite.value == "" ) {
				alert("값을 입력하세요.");
				tf.value.focus();
				return;
			}			
			axios.post('/api/siteconfig/create', self.requestwrite).then(res => {
				if( res.data.result == 'ok' ) {
 					console.log('ok');
 					self.requestwrite.name = "";
 					self.requestwrite.value = "";
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
		      axios.post('/api/siteconfig/list', self.request).then(res => {
		      		self.totalCount = res.data.totalElements;
			        self.listdata = res.data;
			        //console.log( res.data ); 
		      }).catch(err => { console.log(err); alert("정보를 가져오는데 실패하였습니다. 잠시 후 이용하여 주세요."+err); });
	    },
	}
});
</script>
</route>