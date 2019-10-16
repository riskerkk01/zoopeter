					<nav aria-label="Page navigation example" class="text-center">
						<ul class="pagination pagination-sm justify-content-center">
						  <#if paging.minPageNumber != 0 && paging.maxPageNumber != 0> <#if
						  paging.prevPageNumber != 0>
						  <li class="page-item"><a class="page-link" href="javascript:goPage(${paging.prevPageNumber})" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li> </#if>
						  <#list paging.minPageNumber..paging.maxPageNumber as i> <#if i = paging.pageNumber>
						  <li class="page-item active"><#else>
						  <li class="page-item"></#if><a class="page-link" href="javascript:goPage(${i})">${i}</a></li> </#list> <#if
						  paging.nextPageNumber != 0>
						  <li class="page-item"><a class="page-link" href="javascript:goPage(${paging.nextPageNumber})" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li> </#if>
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