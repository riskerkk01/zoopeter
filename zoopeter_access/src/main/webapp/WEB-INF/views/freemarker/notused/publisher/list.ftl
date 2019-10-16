<#include "/layout/begin.ftl">

		<#assign pagetitle="매체  관리">
		<#assign pagelink="publisher">
		<#assign subtitle="">
		<#if PUBLISHERCOUNT??><#assign subtitle="( 총 : "+PUBLISHERCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">

			<div class="alert alert-primary">
				<form action="" method="get" name="sform">
					<input type="hidden" name="page" value="1">
				<div class="row">
					
					<div class="col-9">
							<div class="input-group">
								<div class="input-group-btn" >
									<select name="searchtype" class="form-control xform-control-sm" style="width:140px:"> 
										<option value="name"  <#if SPUBLISHER.searchtype = "name">selected</#if>>매체명</option>
										<option value="code" <#if SPUBLISHER.searchtype = "code">selected</#if> >CODE</option>
									</select>
								</div>
								<input type="text" class="form-control xform-control-sm"  placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SPUBLISHER.searchkeyword??>${SPUBLISHER.searchkeyword}</#if>">
								<span class="input-group-btn">
									<input type="submit" class="btn btn-primary xbtn-sm" value="검색">
								</span>
							</div><!-- /input-group -->

					</div>
					<div class="col-3 text-right">
						<a href="create" class="btn btn-success xbtn-sm">등록하기</a>
					</div>
				</div>
				</form>
			</div>
		
			<div class="card">
	           	<div style="" class="table-responsive">
					<table class="table card-table table-vcenter xtext-nowrap ">
						<cols>
							<col width="80px" />
							<col width="100px" />
							<col width="120px" />
							<col width="100px" />
							<col xwidth="80px" />
							<col width="80px" /> 
						</cols>
			    		<tr class="info">
			    			<th class="text-center">ID</th>
			    			<th class="text-center">매체명</th>
			    			<th class="text-center">코드</th>
			    			<th class="text-center">등록/수정일</th>
			    			<th class="text-center">정보</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if PUBLISHERLIST?has_content>
							<#list PUBLISHERLIST as PUBLISHER>
								<tr>
									<td class="text-center"><a href="update/${PUBLISHER.publisherid}">${PUBLISHER.publisherid}</a></td>
									<td class="text-center">
										${PUBLISHER.name}
									</td>
									<td class="text-center">
										${PUBLISHER.code}
									</td>
									<td class="text-center">${PUBLISHER.rtime?substring(0,10)}<br>${PUBLISHER.mtime?substring(0,10)}</td>
									<td class="">
										postback : ${PUBLISHER.postback_url}<br>
										event : ${PUBLISHER.event_url}<br>
									</td>
									<td class="text-center">
										<a href="update/${PUBLISHER.publisherid}" class="btn btn-warning btn-sm">수정</a>
									</td>									
	
								</tr>
							</#list>
						<#else>
						<tr style="height:100px;">
							<td colspan="10" class="text-center" style="margin-top:30px;padding-top:40px;">등록된 정보가 없습니다</td>
						</tr>
						</#if>
			  		</table>
				</div>
				<div class="card-footer text-center">
					<form name="pageform" method="get">
					<input type="hidden" name="pageno" value="${paging.pageNumber}">
					<input type="hidden" name="searchtype" value="${SPUBLISHER.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SPUBLISHER.searchkeyword}">
					</form>
					<#include "/layout/paging.ftl">
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">