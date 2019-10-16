<script>
const routes = [
  { path : '/', component : index, name : 'index'}
  ,{ path : '/clicklog', component : clicklog, name : 'clicklog', props: (route) => ({ camp_no: route.query.camp_no }) }
  ,{ path : '/dashboard', component : dashboard, name : 'dashboard' , props: (route) => ({ camp_no: route.query.camp_no }) }
]
  
const router = new VueRouter({
  routes:routes,
  saveScrollPosition: true,
  history : true,
  
})

router.beforeEach(function(to, from, next){
	
	axios.get('/api/session').then(res => {
		if(res.data.id != ""){
			next()
		}else{
			window.location.href="/login";
		}
	}).catch(err => {
		if(err.status == 403)
			router.history.go(-1);
	});
	
})

Vue.use(Vuex)

var store = new Vuex.Store({
  state: {
    loading : false,
    sessionInfo : null,
  },
})



// 권한 필요시(senior), 어디에서든 this.isAuth('') 이용시, 권한 검사가 가능하다
var mixin = Vue.mixin({
    created : function(){
      
    },
    methods : {
    	isLogin() {
	      	var self = this
	      	axios.get('/api/session').then(res => {
	      		if( res.data.id == "" ) {
	      			window.location.href="/login";
	      		}
	        });
	    },
    	sessionInfo(){
	      var self = this
	      axios.get('/api/session').then(res => {
	        self.$store.state.sessionInfo = res.data;
	        self.$store.state.loading = true})
	    },
	    tapCheck(){
	        return (location.hash.indexOf('#/modal/') == -1)
	    },
	    
   	}
})
  
  
var app = new Vue({
  router : router,
  store : store,
  data : function(){
    return {}
  },
  created(){
    console.log("created");
    
  },
  mounted : function(){
    var self = this
    //유저 정보 호출
	//this.sessionInfo();
	console.log("mounted");
  },
  methods : {
    
    sessionInfo(){
      var self = this
      axios.get('/api/session').then(res => {
        self.$store.state.sessionInfo = res.data;
        self.$store.state.loading = true})
    },
    
  }
}).$mount('#main')

</script>