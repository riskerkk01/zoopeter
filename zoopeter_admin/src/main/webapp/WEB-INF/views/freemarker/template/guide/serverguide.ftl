<route>
<template id="serverguide">
<div>
	<!-- Page Heading -->
	<div class="page-header">
		<h1 class="page-title">
			서버 설치 가이드 
		</h1>
	</div>
	<pre>
	일단 APM이란 무엇인가?? APM 이란 웹서버를 구성할 때 흔히 쓰이는 Apache, PHP, Mysql 의 앞글자를 따서 불리워지는 이름이다. 
	요즘엔 여기에 Linux 환경까지 더해져서 LAMP라고 부르기도 한다. 각각에 대한 자세한 내용은 관련 검색을 하면 쉽게 알 수 있을 것이다.
	
	 역시 우분투답게 APM 서버 또한 터미널에서 명령어 몇 번 치니 쉽게 설치를 할 수 있었다.
	
	1. Apache 설치
	
	$ sudo apt-get install apache2
	2. Mysql 인증을 위한 모듈 설치
	
	$ sudo apt-get install libapache2-mod-auth-mysql
	
	3. Mysql 설치
	
	$ sudo apt-get install mysql-server mysql-client
	
	 아래와 같은 화면이 나오면 mysql root 유저에 대한 password를 지정해 준다.
	
	
	  
	
	4. PHP 설치
	
	$ sudo apt-get install php-common php libapache2-mod-php php-curl
	
	5. PHP와 Mysql을 연동하기 위한 모듈 설치
	
	$ sudo apt-get install php-mysql
	
	6. Apache를 재시작한다.
	
	$ sudo /etc/init.d/apache2 restart
	
	7. Mysql이 정상적으로 작동하는지 확인하기 위해 터미널에 아래와 같은 명령어를 실행한다.
	
	$ sudo netstat -tap | grep mysql
	
	    만약 아래와 비슷하게 나온다면 정상 작동하고 있는 것이다.
	
	tcp    0    0    localhost.:mysql    *:*    LISTEN    -
	
	   위와 같이 나오지 않는다면 다음 명령어를 실행하여 Mysql을 재시작한다.
	
	$ sudo /etc/init.d/mysql restart
	
	8. 이제 PHP를 확인하기 위해 에디터로 phpintfo.php라는 파일 하나를 만든다.
	
	$ sudo gedit /var/www/phpinfo.php
	
	    아래 문구를 삽입하고 저장한다.
	
	    print_r(phpinfo());
	9. 이제 웹브라우저를 열고 주소창에 위 파일을 실행시켜 본다.
	
	http://호스트주소/phpinfo.php
	
	호스트주소는 ifconfig 명령어로 알 수 있다.
	</pre>

</div>
</template> 
<script type="text/javascript">
var serverguide = Vue.component('serverguide', {
	template : '#serverguide',
	data : function() { return {
		xxx: '1'
		}
	},
	created : function() {
		console.log("serverguide created");
	},
	mounted : function() {
		//console.log( $store.state.sessionInfo );
		console.log('serverguide');
	},
	updated: function() {
	},
	method : {
	}
});
</script>
</route>