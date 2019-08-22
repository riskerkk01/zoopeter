<script>
const routes = [
  //{ path : '/', component : dashboard_main, name : 'dashboard_main'}
  { path : '/', component : index, name : 'index'}
  ,{ path : '/home', component : sample1, name : 'sample1'}
  //,{ path : '/sample1', component : sample1, name : 'sample1'} 
  ,{ path : '/sample2', component : sample2, name : 'sample2'}  
  
  ,{ path : '/sitecode', component : sitecode, name : 'sitecode'}
  ,{ path : '/siteconfig', component : siteconfig, name : 'siteconfig'}
  ,{ path : '/publisher', component : publisher, name : 'publisher'}
  ,{ path : '/contactus', component : contactus, name : 'contactus'}
  ,{ path : '/admin', component : admin, name : 'admin'}
  ,{ path : '/campaign', component : campaign, name : 'campaign'}
  
  ,{ path : '/clicklog', component : clicklog, name : 'clicklog', props: (route) => ({ camp_no: route.query.camp_no }) }
  ,{ path : '/dashboard', component : dashboard, name : 'dashboard' , props: (route) => ({ camp_no: route.query.camp_no }) }
  
  ,{ path : '/adbrix', component : adbrix, name : 'adbrix'}
  ,{ path : '/adbrixre', component : adbrixre, name : 'adbrixre'}
  ,{ path : '/appsflyer', component : appsflyer, name : 'appsflyer'}
  ,{ path : '/adjust', component : adjust, name : 'adjust'}
  ,{ path : '/tune', component : tune, name : 'tune'}
  
  ,{ path : '/postbackguide', component : postbackguide, name : 'postbackguide'}
  ,{ path : '/serverguide', component : serverguide, name : 'serverguide'}  
  /*
  ,{ path : '/postbackguide', component : httpVueLoader('/templates/guide/postbackguide.vue'), name : 'postbackguide'}
  ,{ path : '/serverguide', component : httpVueLoader('/templates/guide/serverguide.vue'), name : 'serverguide'}
  ,{ path : '/sample3', component: httpVueLoader('/templates/sample3.vue'), name: 'sample3' } 
  ,{ path : '/gpc/:packageName?/:startDate?/:endDate?', component: httpVueLoader('/gpc/main.vue'), name: 'gpc' }
  ,{ path : '/view/menu', component : admin_menu_main, name : 'admin_menu_main'}
  ,{ path : '/view/menu/addform', component : admin_menu_addform, name : 'admin_menu_addform' }
  ,{ path : '/view/menu/editform', component : admin_menu_editform, name : 'admin_menu_editform' }
  ,{ path : '/view/game', component : admin_game_main, name : 'admin_game_main' }
  ,{ path : '/view/game/addform', component : admin_game_addform, name : 'admin_game_addform' }
  ,{ path : '/view/game/editform', component : admin_game_editform, name : 'admin_game_editform' }
  ,{ path : '/view/playstore/review', component : playstore_review_main, name : 'playstore_review_main' }
  ,{ path : '/view/playstore/admin', component : playstore_admin_main, name : 'playstore_admin_main' }
  ,{ path : '/view/playstore/stat', component : playstore_stat_main, name : 'playstore_stat_main' }
  ,{ path : '/view/playstore/reply', component : playstore_reply_main, name : 'playstore_reply_main' }
  ,{ path : '/view/newplaystore/admin', component : new_playstore_admin_main, name : 'new_playstore_admin_main' }
  ,{ path : '/view/newplaystore/reply', component : new_playstore_reply_main, name : 'new_playstore_reply_main' }
  ,{ path : '/view/newplaystore/review', component : new_playstore_review_main, name : 'new_playstore_review_main' }
  ,{ path : '/view/member', component : admin_member_main, name : 'admin_member_main' }
  ,{ path : '/view/member/editform', component : admin_member_editform, name : 'admin_member_editform' }
  ,{ path : '/view/setting/template', component : setting_template_main, name : 'setting_template_main' }
  ,{ path : '/view/setting/template_new', component : setting_template_main_new, name : 'setting_template_main_new' }
  ,{ path : '/view/setting/template/addform', component : setting_template_addform, name : 'setting_template_addform' }
  ,{ path : '/view/setting/template/editform', component : setting_template_editform, name : 'setting_template_editform' }
  ,{ path : '/view/setting/alarm', component : setting_alarm_main, name : 'setting_alarm_main' }
  ,{ path : '/view/setting/alarm/addform', component : setting_alarm_addform, name : 'setting_alarm_addform' }
  ,{ path : '/view/setting/alarm/editform', component : setting_alarm_editform, name : 'setting_alarm_editform' }
  ,{ path : '/view/setting/lang', component : setting_lang_main, name : 'setting_lang_main' }
  ,{ path : '/view/setting/file', component : setting_file_main, name : 'setting_file_main' }
  ,{ path : '/view/setting/session', component : setting_session_main, name : 'setting_session_main' }
  ,{ path : '/view/setting/session/addform', component : setting_session_addform, name : 'setting_session_addform' }
  ,{ path : '/view/setting/session/editform', component : setting_session_editform, name : 'setting_session_editform' }
  ,{ path : '/view/setting/account/addform', component : setting_account_addform, name : 'setting_account_addform' }
  ,{ path : '/view/setting/account/editform', component : setting_account_editform, name : 'setting_account_editform' }
  ,{ path : '/view/setting/alert', component : setting_alert_main, name : 'setting_alert_main' }
  ,{ path : '/view/setting/alert/log', component : setting_alert_log_main, name : 'setting_alert_log_main' }
  ,{ path : '/view/setting/alert/addform', component : setting_alert_addform, name : 'setting_alert_addform' }
  ,{ path : '/view/setting/alert/editform', component : setting_alert_editform, name : 'setting_alert_editform' }
  ,{ path : '/view/company', component : admin_company_main, name : 'admin_company_main' }
  ,{ path : '/view/company/addform', component : admin_company_addform, name : 'admin_company_addform' }
  ,{ path : '/view/company/editform', component : admin_company_editform, name : 'admin_company_editform' }
  ,{ path : '/modal/review/process', component : modal_review_process, name : 'modal_review_process' }
  ,{ path : '/view/dashboard/main', component : dashboard_form_main, name : 'dashboard_form_main' }
  ,{ path : '/view/dashboard/editform', component : dashboard_form_editform, name : 'dashboard_form_editform' }
  ,{ path : '/view/community/operation', component : community_operation_main, name : 'community_operation_main', props: (route) => ({ seq: route.query.seq }) }
  ,{ path : '/view/community/search', component : community_search_main, name : 'community_search_main' }
  ,{ path : '/view/community/restrict', component : community_restrict_main, name : 'community_restrict_main' }
  ,{ path : '/view/current', component : current_form_main, name : 'current_form_main' }
  ,{ path : '/view/report', component : report_form_main, name : 'report_form_main' }
  ,{ path : '/view/log', component : admin_log_main, name : 'admin_log_main' }
  ,{ path : '/view/statics/operation', component : statics_operation_chart, name : 'statics_operation_chart' }
  ,{ path : '/view/statics/review/main', component : statics_review_main, name : 'statics_review_main' }
  */
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
    gameLists : [],
    gameListsAll : [],
    userLists : [],
    menulist: null,
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
	    isAuth(auth){
	        if(this.$store.state.userInfo.master) return true
	        
	        for(var i=0; i<this.$store.state.userInfo.auth.length ;i++){
	          var data = this.$store.state.userInfo.auth[i]
	          if(data['code'] == auth)
	            return true
	        }
	        return false
	    },
	    isGame(gameid){
	        if(typeof(gameid) != 'number'){
	          if(isNaN(gameid))
	            return false
	          gameid = Number(gameid)
	        }
	        
	        if(this.$store.state.userInfo.master)
	          return true
	        for(var i=0; this.$store.state.gameLists.length; i++){
	          if(this.$store.state.gameLists[i]['gameid'] == gameid)
	            return true
	        }
	        
	        return false
	    },
		getMyMenuList(){
	    	var self = this
	      	axios.get(
	      	    '/api/menu/mylist'
	      	  ).then(function(response){
	      	    self.$store.state.menulist = response.data;
	      	  }).catch(err => {console.log(err);alert('메뉴 리스트를 가져오지 못했습니다.');})
	    }
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
    userListsAll(){
      var self = this
      axios.get('/api/member/getlistall').then(res => {
        self.$store.state.userLists = res.data
      }).catch(err => {})
    },
    sessionInfo(){
      var self = this
      axios.get('/api/session').then(res => {
        self.$store.state.sessionInfo = res.data;
        self.$store.state.loading = true})
    },
    LockDelete(){
      var self = this
      
      if(self.$route.query.reviewid!=null){
	      axios.post('/api/multilock/delete', {reviewid : self.$route.query.reviewid}).then( res => {
	      }).catch(err => alert('에러'))
      }
    },
    getGameLists : function(){
      var self = this
      axios.get('/api/game/mygetlist').then(res => {
        self.$store.state.gameLists = res.data;
        self.userInfo()
        }).catch(err => { alert('게임권한 정보를 불러오지 못했습니다.')})
      
    },
    getGameListsAll() {
      var self = this
      axios.get('/api/game/getlistall').then(res => {
        
        self.$store.gameListsAll = res.data
        self.getGameLists()
        self.userListsAll()
      }).catch(err =>{alert('게임조회 실패')})
    },
    
  }
}).$mount('#main')

</script>