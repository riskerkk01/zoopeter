<#include "/layout/begin.ftl">

		<#assign pagetitle="WEBVIEW">
		<#assign pagelink="GAME">
		<#assign subtitle="">

		<#include "/layout/pagehead.ftl">

			<#if GAME??>
				<div class="panel panel-default">
					<div class="panel-heading">게임 기본정보</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label for="gametitle" class="col-xs-2 control-label">게임명</label>
									<div class="col-xs-8">
										${GAME.gametitle}
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="gametitle" class="col-xs-2 control-label">공지사항</label>
									<div class="col-xs-8">
										<a href="<@spring.url '/webview/' />${GAME.gameurl}/" class="btn btn-default">HOME</a> 
										<a href="<@spring.url '/webview/' />${GAME.gameurl}/notice" class="btn btn-primary">공지사항</a>
										<a href="<@spring.url '/webview/' />${GAME.gameurl}/event" class="btn btn-info">이벤트</a>
									</div>
								</div> 
							</div>							
							<div class="col-xs-12">
								<div class="form-group">
									<label for="" class="col-xs-2 control-label">IconImage</label>
									<div class="col-xs-8">
										<#if GAME.iconurl != ''>
										<img id="thumb_image" src="${GAME.iconurl}" class="thumbnail" xwidth="60px">
										</#if>

									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="" class="col-xs-2 control-label">ImgUrl</label>
									<div class="col-xs-8">
										<#if GAME.imgurl != ''>
										<img id="thumb_image" src="${GAME.imgurl}" class="thumbnail" xwidth="60px">
										</#if>													
										
									</div>
								</div>
								
							</div>
							
							
	
						</div>

					</div>
				</div>
		
				<div style='margin-top:10px' class="row">
					<div class="col-xs-12 text-center">
						<a href="<@spring.url '/game/' />" class="btn btn-default">목록</a>
						
					</div>
				</div>
					
				
				
			<script type='text/javascript'>
			$(function () {
			});
			</script>
		<#else>
			<div class="alert alert-danger" role="alert">  	
		 		게임 정보가 없습니다.		
			</div>	
			<div class="text-center">
				<a href="<@spring.url '/game/' />" class="btn btn-default">목록으로</a>
			</div>
		</#if>
      
        <#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">