<#include "/layout/begin.ftl">

		<#assign pagetitle="사이트코드  관리">
		<#assign pagelink="sitecode">
		<#assign subtitle="">
		<#if SITECODECOUNT??><#assign subtitle="( 총 : "+SITECODECOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">

			<div class="alert alert-primary">
				<form action="" method="get" name="sform">
					<input type="hidden" name="page" value="1">
				<div class="row">
					<div class="col-2">
						<select name="category" class="form-control xform-control-sm" onChange="document.sform.submit()"> 
							<option value="">카테고리 선택</option>
							<option value="trackersite"  <#if SSITECODE.category??><#if SSITECODE.category = "trackersite">selected</#if></#if> >trackersite</option>
							<option value="gamecode" <#if SSITECODE.category??><#if SSITECODE.category = "gamecode">selected</#if></#if> >gamecode</option>
						</select>
					</div>
					<div class="col-7">
						<div class="input-group">
							<div class="input-group-btn" >
								<select name="searchtype" class="form-control xform-control-sm" style="width:140px:"> 
									<option value="code"  <#if SSITECODE.searchtype = "code">selected</#if>>CODE</option>
									<option value="value" <#if SSITECODE.searchtype = "value">selected</#if> >VALUE</option>
								</select>
							</div>
							<input type="text" class="form-control xform-control-sm"  placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SSITECODE.searchkeyword??>${SSITECODE.searchkeyword}</#if>">
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
							<col width="150px" />
							<col width="150px" /> 
							<col xwidth="80px" />
							<col width="80px" /> 
							<col width="80px" /> 
						</cols>
			    		<tr class="info">
			    			<th class="text-center">SEQ</th>
			    			<th class="text-center">카테고리</th>
			    			<th class="text-center">코드명</th>
			    			<th class="text-center">값</th>
			    			<th class="text-center">순서</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if SITECODELIST?has_content>
							<#list SITECODELIST as SITECODE>
								<tr>
									<td class="text-center"><a href="update/${SITECODE.seq}">${SITECODE.seq}</a></td>
									<td class="text-center">
										${SITECODE.category}
									</td>
									<td class="text-center">
										${SITECODE.code}
									</td>
									<td class="">
										${SITECODE.value}
									</td>
									<td class="">
										${SITECODE.sorder}
									</td>
									<td class="text-center">
										<a href="update/${SITECODE.seq}" class="btn btn-warning btn-sm">수정</a>
									</td>									
	
								</tr>
							</#list>
						<#else>
						<tr style="height:100px;">
							<td colspan="10" class="text-center" style="margin-top:20px;padding-top:20px;">등록된 정보가 없습니다</td>
						</tr>
						</#if>
			  		</table>
				</div>
				<div class="card-footer text-center">
					<form name="pageform" method="get">
					<input type="hidden" name="pageno" value="${paging.pageNumber}">
					<input type="hidden" name="searchtype" value="${SSITECODE.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SSITECODE.searchkeyword}">
					</form>
					<#include "/layout/paging.ftl">
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">