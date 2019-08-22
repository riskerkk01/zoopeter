<#include "/layout/begin.ftl">

		<#assign pagetitle="단말기 관리">
		<#assign pagelink="deviceinfo">
		<#assign subtitle="">
		<#if DEVICEINFOCOUNT??><#assign subtitle="( 총 : "+DEVICEINFOCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">
		
			<div class="well">
				<div class="row">
					<div class="col-xs-9">
						<form action="" method="get" name="sform">
							<div class="input-group">
								<div class="input-group-btn" style="width:140px;">
									<select name="searchtype" class="form-control" style="width:140px:">
										<option value="device_nm" <#if SDEVICEINFO.searchtype = "device_nm">selected</#if> >단말기명</option>
										<option value="device_id"  <#if SDEVICEINFO.searchtype = "device_id">selected</#if>>DEVICEID</option>
										<option value="device_type"  <#if SDEVICEINFO.searchtype = "device_type">selected</#if>>유형</option>
										<option value="device_vendor"  <#if SDEVICEINFO.searchtype = "device_vendor">selected</#if>>제조사</option>
										<option value="os_type"  <#if SDEVICEINFO.searchtype = "os_type">selected</#if>>OS유형</option>
										<option value="os_ver"  <#if SDEVICEINFO.searchtype = "os_ver">selected</#if>>OS버젼</option>
									</select>
								</div>
								<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SDEVICEINFO.searchkeyword??>${SDEVICEINFO.searchkeyword}</#if>">
								<span class="input-group-btn">
									<input type="submit" class="btn btn-primary" value="검색">
								</span>
							</div><!-- /input-group -->
						</form>
					</div>
					<div class="col-xs-3">
						<div class="text-right">
							<a href="create" class="btn btn-success">등록하기</a>
						</div>
					</div>
				</div>
			</div>

			<div class="panel panel-widget" id="p01" >
				<!--
	            <div class="panel-heading">
	                <i class="fa fa-edit"></i><span class="panel-title">내가 보고한 일일 업무 보고</span>
					<div class="pull-right">
						<a href="dailyreport.php?cmd=addform" class="btn btn-danger ">일일 업무 보고 작성하기</a>
					</div>
	            </div>
	           	-->
	            <div class="panel-body" align="center">
		    
					<table class="table  table-bordered table-striped">
						<cols>
							<col width="100px" />
							<col width="130px" />
							<col width="130px" />
							<col width="130px" />
							<col width="130px" />
							<col xwidth="100px" />
							<col width="100px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">DEVICE_ID</th>
			    			<th class="text-center">단말기유형</th>
			    			<th class="text-center">OS유형</th>
			    			<th class="text-center">OS버젼</th>
			    			<th class="text-center">제조사</th>
			    			<th>단말기명</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if DEVICEINFOLIST?has_content>
							<#list DEVICEINFOLIST as DEVICEINFO>
								<tr>
									<td class="text-center">${DEVICEINFO.device_id}</td>
									<td class="text-center">${DEVICEINFO.device_type}</td>
									<td class="text-center">${DEVICEINFO.os_type}</td>
									<td class="text-center">${DEVICEINFO.os_ver}</td>
									<td class="text-center">${DEVICEINFO.device_vendor}</td>
									<td>${DEVICEINFO.device_nm}</td>	
									<td class="text-center">
										<a href="update/${DEVICEINFO.device_id}" class="btn btn-warning btn-xs">수정 / 삭제</a>
									</td>
								</tr>
							</#list>
						<#else>
						<tr style="height:100px;">
							<td colspan="7" class="text-center" style="margin-top:40px;padding-top:40px;">단말기 정보가 없습니다</td>
						</tr>
						</#if>
			  		</table>
			
			  		<nav class="text-center">
					  <ul class="pagination">
						  <#if paging.minPageNumber != 0 && paging.maxPageNumber != 0> <#if
						  paging.prevPageNumber != 0>
						  <li><a href="javascript:goPage(${paging.prevPageNumber})" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li> </#if>
						  <#list paging.minPageNumber..paging.maxPageNumber as i> <#if i = paging.pageNumber>
						  <li class="active"><#else>
						  <li></#if><a href="javascript:goPage(${i})">${i}</a></li> </#list> <#if
						  paging.nextPageNumber != 0>
						  <li><a href="javascript:goPage(${paging.nextPageNumber})" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li> </#if>
						  </#if>
					  </ul>
					</nav>
					<script language="javascript">
					function goPage(pageno)
					{
						document.pageform.pageno.value= pageno;
						document.pageform.submit();
					}
					</script>
					<form name="pageform" method="get">
					<input type="hidden" name="pageno" value="${paging.pageNumber}">
					<input type="hidden" name="searchtype" value="${SDEVICEINFO.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SDEVICEINFO.searchkeyword}">
					</form>
				</div>
			</div>
		
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">