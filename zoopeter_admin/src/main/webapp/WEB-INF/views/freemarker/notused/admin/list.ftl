<#include "/layout/begin.ftl">

		<#assign pagetitle="관리자  관리">
		<#assign pagelink="admin">
		<#assign subtitle="">
		<#if ADMINCOUNT??><#assign subtitle="( 총 : "+ADMINCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">

			<div class="alert alert-primary">
				<form action="" method="get" name="sform">
					<input type="hidden" name="page" value="1">
				<div class="row">
					
					<div class="col-9">
							<div class="input-group">
								<div class="input-group-btn" >
									<select name="searchtype" class="form-control xform-control-sm" style="width:140px:"> 
										<option value="id" <#if SADMIN.searchtype = "id">selected</#if> >아이디</option>
										<option value="name"  <#if SADMIN.searchtype = "name">selected</#if>>이름</option>
									</select>
								</div>
								<input type="text" class="form-control xform-control-sm"  placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SADMIN.searchkeyword??>${SADMIN.searchkeyword}</#if>">
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
					<table class="table card-table table-vcenter text-nowrap ">
						<cols>
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col xwidth="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="80px" />
							<col width="90px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">adminID</th>
			    			<th class="text-center">타입</th>
			    			<th class="text-center">매체</th>
			    			<th class="text-center">아이디</th>
			    			<th class="text-center">이름</th>
			    			<th class="text-center">등록일</th>
			    			<th class="text-center">수정일</th>
			    			<th class="text-center">상태</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if ADMINLIST?has_content>
							<#list ADMINLIST as ADMIN>
								<tr>
									<td class="text-center"><a href="update/${ADMIN.adminid}">${ADMIN.adminid}</a></td>
									<td class="text-center">
										<#if ADMIN.type == 1>관리자<#else>매체</#if>
									</td>
									<td class="text-center">
										<#if PUBLISHERLIST?has_content>
											<#list PUBLISHERLIST as PUBLISHER>
												<#if PUBLISHER.publisherid == ADMIN.publisherid>${PUBLISHER.name}</#if>
											</#list>
										</#if>
									</td>
									<td class="text-center">${ADMIN.id}</td>
									<td class="">${ADMIN.name}</td>
									<td class="text-center">${ADMIN.rtime?substring(0,10)}</td>
									<td class="text-center">${ADMIN.mtime?substring(0,10)}</td>
									<td class="text-center"><#if ADMIN.state == 1>사용정지<#else>사용중</#if></td>
									<td class="text-center">
										<a href="update/${ADMIN.adminid}" class="btn btn-warning btn-sm">수정</a>
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
					<input type="hidden" name="searchtype" value="${SADMIN.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SADMIN.searchkeyword}">
					</form>

					<#include "/layout/paging.ftl">
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">