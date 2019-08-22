<#import "/spring.ftl" as spring>
<div class="row">
	<div class="col-xs-5">
	<#if TESTRESULT??>
		<#if TESTRESULT.scrshot_file_path??>
		<img width="300px" src="<@spring.url '/download/resultfile' />?path=${TESTRESULT.scrshot_file_path?url('utf-8')}&name=${TESTRESULT.scrshot_file_nm?url('utf-8')}" class="thumbnail">
		${TESTRESULT.scrshot_file_path}
		</#if>
	</#if>
	</div>
	<div class="col-xs-7">
		<div class="panel">
			<div class="panel-heading">
				<#if TESTCASE??>
					TestCase : ${TESTCASE.test_case_id}. ${TESTCASE.test_case_nm}
				</#if>
			</div>
			<div class="panel-body">
				<table class="table">
					<tr>
						<td>
						측정횟수 : ${TESTMAS.test_cnt}회
						</td>
					</tr>
				<#if TESTRESULTDATALIST?has_content>
					<#list TESTRESULTDATALIST as RESULT>
						<#if RESULT.test_mea == "CPU">
					<tr>
						<td>						
							CPU : ${RESULT.test_result_data} %
						</td>
					</tr>							
						</#if>
						<#if RESULT.test_mea == "RAM">
					<tr>
						<td>						
							RAM : ${RESULT.test_result_data} %
						</td>
					</tr>							
						</#if>
						<#if RESULT.test_mea == "TMP">
					<tr>
						<td>						
							발열량 : ${RESULT.test_result_data} C
						</td>
					</tr>							
						</#if>
						
					</#list>				
				</#if>

			</div>
		</div>
	</div>
</div>

