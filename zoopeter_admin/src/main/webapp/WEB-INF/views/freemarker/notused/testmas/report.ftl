<#include "/layout/begin.ftl">

	<#assign pagetitle="테스트 결과 리포트">
	<#assign pagelink="testmas">
	<#assign subtitle="">
	<#include "/layout/pagehead.ftl">
		
	<#if TESTMAS??>
		
		<script src="<@spring.url '/resources/scripts/jQuery.print.js' />"></script>
		<div class="xadmin-form">
			<div class="panel">
				<div class="panel-heading">
					<ul class="nav panel-tabs-border panel-tabs panel-tabs-left">
						<li class="<#if VIEWTYPE != "tableview">active</#if>" id="tab_chartview">
							<a  href="javascript:ChangeTab('chartview')" >Chart</a>
						</li>
						<li class="<#if VIEWTYPE == "tableview">active</#if>" id="tab_tableview">
							<a  href="javascript:ChangeTab('tableview')">Table</a>
						</li>
					</ul>
					
					<ul class="nav nav-pills pull-right">

					</ul>
				</div>
				<div class="panel-body bg-light">
					<script language="javascript">
					function ExcelDown()
					{
						var str = "";
						str += "<meta charset='utf-8'>";
						str += $('#tablebody').html();
						document.excelform.str.value = str;
						document.excelform.submit();
					}
					function myPrintTable()
					{
						$('#tablebody').print();
					}
					function myPrintChart()
					{
						$('#mainchart').print();
					}					
					</script>
					
					<form id="reportform" name="reportform" action="" method="post" class="form-horizontal" role="form">
					<input type="hidden" name="viewtype" id="viewtype" value="${VIEWTYPE}">
					
					<div class="tab-content pn br-n">
						<div class="tab-pane <#if VIEWTYPE != "tableview">active</#if>" id="chartview">
							<div id="chartview_sub" class="text-right" style="display:<#if VIEWTYPE != "tableview">block<#else>none</#if>;">
								<a href="javascript:void(0)" onClick="myPrintChart()" class="btn btn-danger btn-sm">Print</a>
							</div>	
							<div id="mainchart" style="height:300px;">로딩중</div>
						</div>
						<div class="tab-pane <#if VIEWTYPE == "tableview">active</#if>" id="tableview">
							<@compress single_line=true>
							<div id="tableview_sub" class="text-right" style="padding-bottom:10px;display:<#if VIEWTYPE == "tableview">block<#else>none</#if>;">
								<a href="javascript:ExcelDown()" class="btn btn-primary btn-sm">Excel</a>
								<a href="javascript:myPrintTable()" class="btn btn-danger btn-sm">Print</a>
							</div>
							<div style="overflow-x:auto;" id="tablebody">
							<table class="table table-bordered table-striped table-condensed" style="table-layout:fixed;">
								<tr class="info">
									<th rowspan="2" class="text-center" width="60px">시퀀스</th>
									<th rowspan="2" class="text-center" width="150px">테스트 케이스</th>
									<#list 1..MAX_MEA_SEQ as MEA_SEQ>
									<th colspan="3" class="text-center" width="150px">
										${MEA_SEQ} 회
									</th>
									</#list>
								</tr>
								<tr class="info">
									<#list 1..MAX_MEA_SEQ as MEA_SEQ>
									<th class="text-center" width="50px"> 발열 </th>
									<th class="text-center" width="50px"> RAM </th>
									<th class="text-center" width="50px"> CPU </th>
									</#list>
								</tr>
								
							<#if TESTCASELIST?has_content> <#list TESTCASELIST as TESTCASE>
								<tr>
									<td class="text-center">${TESTCASE.test_case_seq}</td>
									<td class="text-left">${TESTCASE.test_case_nm}</td>
									<#list 1..MAX_MEA_SEQ as MEA_SEQ>
									<td class="text-right">
										<#if TESTRESULTDATALIST?has_content> <#list TESTRESULTDATALIST as RESULT> 
											<#if TESTCASE.test_case_id == RESULT.test_case_id && RESULT.mea_seq == MEA_SEQ && RESULT.test_mea == "TMP"> 
												<#if RESULT.test_result_data == MAX_TMP>
												<span style='color:black;font-weight:bold;background-color:red;'>${RESULT.test_result_data}</span>
												<#else>
												${RESULT.test_result_data}
												</#if>
											</#if>	
										</#list> </#if>
									</td>
									<td class="text-right">
										<#if TESTRESULTDATALIST?has_content> <#list TESTRESULTDATALIST as RESULT>											
											<#if TESTCASE.test_case_id == RESULT.test_case_id && RESULT.mea_seq == MEA_SEQ && RESULT.test_mea == "RAM"> 
												<#if RESULT.test_result_data == MAX_RAM>
												<span style='color:black;font-weight:bold;background-color:red;'>${RESULT.test_result_data}%</span>
												<#else>
												${RESULT.test_result_data}%
												</#if>	
											</#if>
										</#list> </#if>
									</td>
									
									<td class="text-right">
										<#if TESTRESULTDATALIST?has_content> <#list TESTRESULTDATALIST as RESULT>
											<#if TESTCASE.test_case_id == RESULT.test_case_id && RESULT.mea_seq == MEA_SEQ && RESULT.test_mea == "CPU"> 
												<#if RESULT.test_result_data == MAX_CPU>
												<span style='color:black;font-weight:bold;background-color:red;'>${RESULT.test_result_data}%</span>
												<#else>
												${RESULT.test_result_data}%
												</#if>
											</#if>
										</#list> </#if>
									</td>
									</#list>
								</tr>
							</#list> </#if>
							</table>
							</div>
							</@compress>
						</div>
						
						<br>
						<@compress single_line=true>
						<#if VENDORLIST?has_content>
							<#list VENDORLIST as VENDOR>
								<hr class="short alt" style="margin:3px;">		
								<div class="form-group" style="margin-bottom:0px;">
									<label for="test_nm" class="col-xs-2 control-label">${VENDOR.device_vendor}</label>
									<div class="col-xs-10">
										<#if DEVICEINFOLIST?has_content>
											<#list DEVICEINFOLIST as DEVICEINFO>
												<#if DEVICEINFO.device_vendor = VENDOR.device_vendor>
				                          			<div class="col-xs-2 checkbox-custom mt10 mb5" style="float:left;margin-right:20px;">
														<input id="deviceinfo_${DEVICEINFO.device_id}" type="checkbox" name="deviceinfos" value="${DEVICEINFO.device_id}" class="devicecheckbox"
															<#if CHECKED_DEVICE_INFO?has_content>
																<#list CHECKED_DEVICE_INFO as CHECKED_DEVICE_ID>
																	<#if CHECKED_DEVICE_ID == DEVICEINFO.device_id>
																		checked
																	</#if>
																</#list>
															</#if>													 
														onChange="Refresh();">
														<label for="deviceinfo_${DEVICEINFO.device_id}"  style="padding-top:2px;">${DEVICEINFO.device_nm}</label>
													</div>
												</#if>
											</#list>
										</#if>
									</div>
								</div>
								
									
							</#list>
						</#if>
						
						</@compress>											
					</div>
				</div>
				<div class="row text-center" >
					<br>
					<a href="javascript:Refresh();" class="btn btn-info">조회하기</a>
					<br>
					<br>
				</div>
			</div>
			<!-- 챠트 클릭시 상세 내용 모달 팝업 -->
	        <div class="modal fade" id="chart_detail_view" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		        <div class="modal-dialog modal-lg">
		            <div class="modal-content">
		              <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		                <h4 class="modal-title" id="myModalLabel">상세정보</h4>
		              </div>
		              <div class="modal-body" id="chart_detail_body">
		              		로딩중
		              </div>
		              <div class="modal-footer">
		                <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">닫기</button>
		              </div>
		            </div>
		        </div>
	        </div>
			
			</form>
		
			<script language="javascript">
			function Refresh()
			{	
				var devicecheckbox = $('.devicecheckbox:checkbox:checked').map( function() { return this.value; } ).get().join(',');
				if( devicecheckbox == '' )
				{
					alert('단말을 선택하여 주세요');
					return ;
				}
				document.reportform.submit();
			}
			function ChangeTab( tabname )
			{
				$('#chartview').hide();
				$('#tableview').hide();
				
				$('#'+tabname).show();
				
				$('#tab_chartview').removeClass('active');
				$('#tab_tableview').removeClass('active');
				
				$('#tab_'+tabname).addClass('active');
				$('#viewtype').val(tabname);
				
				$('#chartview_sub').hide();
				$('#tableview_sub').hide();
				$('#'+tabname+'_sub').show();
				
			}
			$(function () {
			});
			</script>
			
			<script language="javascript">
			//https://report.tipigs.com/html/load/main_service_chart.php?gameids=455744,404753,404754,404751,404755,404752,33092,393533,393535,393536,16713,510,22695,365509,32,835,94,31,30,479,829,35,139,392625,385752,16323,623,154,144,656,783,781,299,364,370,667,160,779,199,156,227,387,778,655,784,158,308,159,676,218,787,777,16263,724,782,153,780,453,427,161,785,788,786,16,843,12,142,14,842,10,5194,34507,34508,834,34505,34506,6581,450779,374224,365469,19,383976,4535,4536,310,350,1672,301,2219,423,87,4538,157,389025,4531,414238,448387,62,373930,57,40517,86,59,56,137,60,347955,417746,49,400777,389121,4534,359552,398672,417896,147,394166,1681,22,397457,278932,31728,404757,404756,1421,2914,1679,414248,428531,414236,414247,414243,414241,414251,414246,456961,414240,414239,414250,414237,414242,416532,414249,414245,414244,404758,428528,404033,54238&alpha2=&sdate=2017-09-01&edate=2017-09-14
			jQuery(document).ready(function() {
			    var highColors = [ bgPrimary, bgDanger, bgSuccess, bgWarning ];
			    var seriesData = [
			            { yAxis:0, name: '발열', data: ${STR_JSON_TMP}  },
			            { yAxis:1, type:"spline", name: 'RAM', data: ${STR_JSON_RAM} },
			            { yAxis:1, type:"spline", name: 'CPU', data: ${STR_JSON_CPU} }
			        ];
			    var ecomChart = $('#mainchart');
			    if (ecomChart.length) {
			      ecomChart.highcharts({
			        credits: false,
			        colors: highColors,
			        chart: {
			          backgroundColor: 'transparent',
			          className: '',
			        //  type: 'line',
			          type: 'column',
			          zoomType: 'x',
			          panning: true,
			          panKey: 'shift',
			          marginTop: 70,
			          marginRight: 70,
			        },
			        title: {
			          text: null
			        },
			        xAxis: {
			          gridLineColor: '#EEE',
			          lineColor: '#EEE',
			          tickColor: '#EEE',
			          categories: ${STR_JSON_CATE},
			            labels: {
			            rotation: -45
			            }
			        },
			        yAxis: [{ min: 0, gridLineColor: '#EEE', title: { text: "온도", }, reversed: false, }, 
			        	{min: 0, gridLineColor: '#EEE', title: { text: "percent(%)", }, reversed:false, opposite:true},
			        	],
			        plotOptions: { 
			        	spline: { lineWidth: 3, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: {
			        		cursor : 'pointer',
			        		point: {
			        			events: {
			        				click: function(e) {
			        					$('#chart_detail_view').modal('show');
			        					var test_id = ${TESTMAS.test_id};
			        					var test_case_id = this.x+1;
			        					$('#chart_detail_body').load( "<@spring.url '/testmas/load' />/"+test_id+"/"+test_case_id );
			        				}
			        			},
			        		}
			        	},
			        },
			        ///plotOptions: { column: { states: { hover: { color: '000000' } } }, spline: { lineWidth: 3, }, area: { stacking: 'normal', fillOpacity: 0.2 } },
			        tooltip: { shared: true },
			        legend: { enabled: true, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: seriesData
			      });
			    }
			});
			</script>
		<form id="excelform" name="excelform" method="post" xxtarget="downframe" action="<@spring.url '/testmas/exceldownload' />">
		<input type="hidden" name="savefilename" value="${TESTMAS.test_id}_${TESTMAS.test_nm}_result.xls">
		<input type="hidden" name="str" value="">
		</form>
		<iframe name="downframe" id="downframe" style="width:0px;height:0px;border:0px;"></iframe>			
    
	<#else>
			<div class="alert alert-danger" role="alert">  	
		  		테스트 결과 레포트 정보가 없습니다.		
		 	</div>	
			<div class="text-center">
				<a href="<@spring.url '/testmas/' />" class="btn btn-default">목록으로</a>
			</div>
	</#if>
			
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">