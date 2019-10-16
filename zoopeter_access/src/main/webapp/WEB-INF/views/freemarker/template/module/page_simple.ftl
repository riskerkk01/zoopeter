<route>
<template id="pagination_simple">
	<nav aria-label="Page navigation example" class="text-center">
		<ul class="pagination pagination-sm justify-content-center" v-if="data.totalPages != 0">
			
				<li class="page-item"><a class="page-link" v-if="!data.first" v-on:click="goPage(1)" >처음</a></li>
				<li class="page-item"><a class="page-link" v-if="!data.first" v-on:click="goPage(request.page-9)"><<</a></li>
				<li class="page-item"><a class="page-link" v-if="!data.first" v-on:click="goPage(request.page)"><</a></li>
				<li class="page-item" v-for="d in 10" v-bind:class="[request.page == (d+pageParsing(request.page)-1)? 'page-item active' : 'page-item']">
					<a class="page-link"  
					v-if="data.totalPages >= (d+pageParsing(request.page))" 
					
					v-on:click="goPage(d+pageParsing(request.page))">{{d+pageParsing(request.page)}}</a></li>
				<li class="page-item"><a class="page-link" v-if="!data.last" v-on:click="goPage(request.page+2)">></a></li>
				<li class="page-item"><a class="page-link" v-if="!data.last" v-on:click="goPage(request.page+11)">>></a></li>
				<li class="page-item"><a class="page-link" v-if="!data.last" v-on:click="goPage(data.totalPages)" >마지막</a></li>
		</ul>
	</nav>
</template>




<!-- 
<pagination v-bind:p_request="request" v-bind:p_data = "gameLists" v-on:get-list="getList()" ></pagination>
			
	
	/**
		* p_request ::: search / getList 관련된 parameters
		* p_data ::: pagination 하기위한 데이터 Page<T> generic 데이터를 넣으면 된다.
		* p_keyword ::: keyword 검색 사용 유무 ( 'true' / 'false' )
		* p_size ::: size 사용 유무 ( 'true' / 'false' )
		* v-on:get-list ::: 상위 component에 event를 걸기위한 것이므로 필요함
		
		*** p_request 의 정의는 java File의 RequestDomain을 참고해도 됨
			* size ::: row 갯수
			* page ::: 현 page
			* findStr ::: 찾고자 하는 키워드
	**/
			
 -->
<script>
    
  var pagination_simple = Vue.component('pagination_simple', {
	  template : '#pagination_simple',
	  props : ['p_data', 'p_request'],
	  computed : {
	    data : function(){
	      return this.p_data
	    },
	    request : function(){
	      return this.p_request
	    },
	  },
	  data : function () {
	    return {
	      findStr : '',
	    }
	  },
	  mounted : function() {
	    
	  },
	  methods : {
	    pageParsing : function(page){
	      return parseInt(page/10)*10;
	    },
	    goPage : function(page){
	      if(page < 1) page = 1;
	      if(page > this.data.totalPages) page = this.data.totalPages;
	      //if(this.request.page == page-1) 
	      //  return ;
	      
	      this.request.page = page-1
	      this.GetList()
	    },
	    
	    GetList : function(){
	      this.$emit('get-list')
	      return 
	    },
	  }
	});
	
  
  </script>
  
</route>