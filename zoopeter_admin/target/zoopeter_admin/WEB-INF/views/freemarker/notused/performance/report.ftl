<#include "/layout/begin.ftl">

	<#assign pagetitle="성능 테스트 결과 리포트">
	<#assign pagelink="performance">
	<#assign subtitle="">
	<#include "/layout/pagehead.ftl">

	<#macro convert_sec sec><#compress>
		<#assign xx1=sec/60>
		<#assign xx2=sec%60>
		${xx1?string("00")}:${xx2?string("00")}
	</#compress></#macro>
			
	<#if PERFORMANCE??>
				
		<script language="javascript">
		$(function () {
			setTimeout( InitViewType, 2000 );
		});
		function InitViewType()
		{
			var viewtype = "${VIEWTYPE}";
			ChangeTab( viewtype );
		}
		</script>
		<script src="<@spring.url '/resources/scripts/jQuery.print.js' />"></script>
		<form id="excelform" name="excelform" method="post" xxtarget="downframe" action="<@spring.url '/performance/exceldownload' />">
		<input type="hidden" name="savefilename" value="${PERFORMANCE.performance_id}_${PERFORMANCE.performance_memo}_result.xls">
		<input type="hidden" name="str" value="">
		</form>
		<iframe name="downframe" id="downframe" style="width:0px;height:0px;border:0px;"></iframe>
		<div class="xadmin-form">
			<div class="panel">
				<div class="panel-body xbg-light">
					<div class="row">

						<div class="col-xs-6">
							<form name="searchform" method="get">
							<input type="hidden" name="viewtype" value="${VIEWTYPE}">
							<div class="media">
								<div class="media-left">
									<#if APPINFO.app_image != ''>
											<img src="<@spring.url '/downloader/' />${APPINFO.app_image}" class="thumbnail" width="60px" style="margin-bottom:0px;">
									</#if>
								</div>
								<div class="media-body">
									<h3 class="media-heading" style="padding-top:5px;"> 
									${APPINFO.app_nm} - ${APPINFO.app_os} - ${APPINFO.app_ver}
									<small># ${PERFORMANCE.performance_memo}</small>
									</h3>
									<p style="padding-top:5px;">
									${PERFORMANCE.performance_device_name}
									- ${PERFORMANCE.performance_device_version}
									- ${PERFORMANCE.performance_date?substring(0,19)}
									</p>
								</div>
							</div>
							 
							<div class="panel">
								<div class="panel-body xbg-light">
									<div class="row">
										<div class="col-xs-2" style="padding-top:10px;">
											MARK s:${MARK_START} e:${MARK_END}
										</div>
										<div class="col-xs-4">
									
											<select name="mark_start" class="form-control">
											<OPTION value="">선택하세요</OPTION>
											<#if MARKLIST?has_content>
												<#list MARKLIST as MARK> 
													<option value="${MARK.performance_mark}" <#if MARK.performance_mark == MARK_START>selected</#if> > ${MARK.performance_mark} - ${MARK.performance_memo}</option>  
												</#list>
											</#if>
											</select>
										</div>
										<div class="col-xs-4">
											<select name="mark_end" class="form-control">
											<OPTION value="">선택하세요</OPTION>
											<#if MARKLIST?has_content>
												<#list MARKLIST as MARK> 
													<option value="${MARK.performance_mark}" <#if MARK.performance_mark == MARK_END>selected</#if> > ${MARK.performance_mark} - ${MARK.performance_memo}</option>  
												</#list>
											</#if>
											</select>								
										</div>
										<div class="col-xs-2">	
											<a href="javascript:;" onClick="document.searchform.submit();" class="btn btn-info btn-block">조회</a>
										</div>
									</div>
								</div>
							</div>
							</form>
							
							<div class="panel">
								<div class="panel-body pn">	
									<table class="table table-striped table-condensed">
										<tr>
											<th width="20%" class="primary text-center">CPU</th>
											<td width="30%">
												<p> Avg : ${AVG_CPU?string("00")} % </p> 
												<p> Max : ${MAX_CPU?string("00")} % </p>
											</td> 
											<th width="20%" class="primary text-center">Temp</th>
											<td width="30%">
												<p> Avg : ${AVG_TEMP?string("00")} C </p>
												<p> Max : ${MAX_TEMP?string("00")} C </p>
											</td>
										</tr>
										<tr>
											<th width="20%" class="primary text-center">RAM</th>
											<td width="30%"> 
												<p> Avg : ${AVG_MEM?string("00")} % </p>
												<p> Max : ${MAX_MEM?string("00")} % </p>
											</td> 
											<th width="20%" class="primary text-center">FPS</th>
											<td width="30%">
												<p> Avg : ${AVG_FPS?string("00")}  </p> 
												<p> Max : ${MAX_FPS?string("00")}  </p>
											</td>
										</tr> 
										<tr>
											<th width="20%" class="primary text-center">Packet</th>
											<td width="30%">
												<p> Avg : ${AVG_PACKET?string("00")} </p>
												<p> Max : ${MAX_PACKET?string("00")} </p>
											</td> 
											<th width="20%" class="primary text-center">Battery</th>
											<td width="30%">
												<p> Avg : ${AVG_BATTERY?string("00")} % </p>
												<p> Max : ${MAX_BATTERY?string("00")} % </p>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
			
						<div class="col-xs-6">
							<div id="screenshot_layer">
							
							</div>
						</div>
					</div>						
				</div>
			</div>
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
						document.searchform.viewtype.value=tabname;
						
					}
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
						$('#chartview').print();
					}					
					</script>
					
					<div class="tab-content pn br-n">
						<div class="tab-pane active" id="chartview">
							<div id="chartview_sub" class="text-right" style="display:<#if VIEWTYPE != "tableview">block<#else>none</#if>;margin-bottom:20px;">
								<a href="javascript:void(0)" onClick="myPrintChart()" class="btn btn-danger btn-sm">Print</a>
							</div>	
							<div id="mainchart_mark" style="height:80px;">Mark Loading ...</div>
							<div id="mainchart_cpu" style="height:200px;">CPU Loading ...</div>
							<div id="mainchart_mem" style="height:200px;">Memory Loading ...</div>
							<div id="mainchart_packet" style="height:200px;">Packet Loading ...</div>
							<div id="mainchart_temp" style="height:200px;">Temperature Loading ...</div>
							<div id="mainchart_fps" style="height:200px;">FPS Loading ...</div>
							<div id="mainchart_battery" style="height:200px;">Battery Loading ...</div>
						</div>
						<div class="tab-pane" id="tableview">
							<@compress single_line=true>
							<div id="tableview_sub" class="text-right" style="padding-bottom:10px;display:<#if VIEWTYPE == "tableview">block<#else>none</#if>;">
								<a href="javascript:ExcelDown()" class="btn btn-primary btn-sm">Excel</a>
								<a href="javascript:myPrintTable()" class="btn btn-danger btn-sm">Print</a>
							</div>
							<div style="xxoverflow-x:auto;" id="tablebody"> 
							
								<table class="table table-bordered table-striped table-condensed" xstyle="table-layout:fixed;">
									<tr class="info">
										<th class="text-center" width="70px">Time</th>
										<th class="text-center" width="70px">Flag</th>
										<th class="text-center" xwidth="60px">Memo</th>
										<th class="text-center" width="70px">CPU</th>
										<th class="text-center" width="70px">MEM</th>
										<th class="text-center" width="70px">Packet</th>
										<th class="text-center" width="70px">Temp</th>
										<th class="text-center" width="70px">FPS</th>
										<th class="text-center" width="70px">Battery</th>
										<th class="text-center" width="70px">보기</th>
									</tr>
	
									<#if PERFORMANCERESULTLIST?has_content> <#list PERFORMANCERESULTLIST as PR>
									<tr>
										<td class="text-center"><@convert_sec PR.performance_time /></td>
										<td class="text-center"><#if PR.performance_mark != 0>${PR.performance_mark}</#if></td>
										<td class="text-left">${PR.performance_memo}</td>
										<td class="text-right">${PR.performance_cpu}%</td>
										<td class="text-right">${PR.performance_mem}%</td>
										<td class="text-right">${PR.performance_packet}</td>
										<td class="text-right">${PR.performance_temp}C</td>
										<td class="text-right">${PR.performance_fps}</td>
										<td class="text-right">${PR.performance_battery}%</td>
										<td class="text-center">
											<a href="javascript:LoadScreenshotResultid('${PR.performance_result_id}')" class="btn btn-info btn-xs">보기</a>
										</td>
									</tr>
									</#list> </#if>
								</table>
							</div>
							</@compress>
						</div>
																	
					</div>
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
			
			

			
			<script language="javascript">
			//https://report.tipigs.com/html/load/main_service_chart.php?gameids=455744,404753,404754,404751,404755,404752,33092,393533,393535,393536,16713,510,22695,365509,32,835,94,31,30,479,829,35,139,392625,385752,16323,623,154,144,656,783,781,299,364,370,667,160,779,199,156,227,387,778,655,784,158,308,159,676,218,787,777,16263,724,782,153,780,453,427,161,785,788,786,16,843,12,142,14,842,10,5194,34507,34508,834,34505,34506,6581,450779,374224,365469,19,383976,4535,4536,310,350,1672,301,2219,423,87,4538,157,389025,4531,414238,448387,62,373930,57,40517,86,59,56,137,60,347955,417746,49,400777,389121,4534,359552,398672,417896,147,394166,1681,22,397457,278932,31728,404757,404756,1421,2914,1679,414248,428531,414236,414247,414243,414241,414251,414246,456961,414240,414239,414250,414237,414242,416532,414249,414245,414244,404758,428528,404033,54238&alpha2=&sdate=2017-09-01&edate=2017-09-14
			jQuery(document).ready(function() {
			    var highColors = [ bgPrimary, bgDanger, bgSuccess, bgWarning ];
			    var seriesData = [
			            { yAxis:0, name: 'TEMP', data: ${STR_JSON_TEMP}  },
			            //{ yAxis:1, type:"spline", name: 'PACKET', data: ${STR_JSON_PACKET} },
			            //{ yAxis:1, type:"spline", name: 'BATTERY', data: ${STR_JSON_BATTERY} },
			            //{ yAxis:1, type:"spline", name: 'FPS', data: ${STR_JSON_FPS} },
			            //{ yAxis:1, type:"spline", name: 'MEM', data: ${STR_JSON_MEM} },
			            //{ yAxis:1, type:"spline", name: 'CPU', data: ${STR_JSON_CPU} }
			        ];
			    
			    var ecomChart_mark = $('#mainchart_mark');
			    if (ecomChart_mark.length) {
			      ecomChart_mark.highcharts({
			        credits: false,
			        colors: [bgDanger],
			        chart: { backgroundColor: 'transparent', className: '', type: 'column', zoomType: 'x', panning: true, panKey: 'shift', marginTop: 10, marginRight: 20, },
			        title: { text: null },
			        xAxis: { gridLineColor: '#EEE', lineColor: '#EEE', tickColor: '#EEE',  categories: ${STR_JSON_CATE}, labels: { rotation: 0 } },
			        yAxis: [{ min: 0, max:1, gridLineColor: '#EEE', title: { text: "Mark", }, reversed: false, } ],
			        plotOptions: { 
			        	spline: { lineWidth: 3, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: { cursor : 'pointer', point: { events: { click: function(e) { LoadScreenshot( this.x ); } }, }
			        	},
			        },
			        tooltip: { enabled: false, shared: false },
			        legend: { enabled: false, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: [ { yAxis:0, name: 'MARK', data: ${STR_JSON_MARK}  } ]
			      });
			    } 
			    var ecomChart_cpu = $('#mainchart_cpu');
			    if (ecomChart_cpu.length) {
			      ecomChart_cpu.highcharts({
			        credits: false,
			        colors: [bgPrimary],
			        chart: { backgroundColor: 'transparent', className: '', type: 'column', zoomType: 'x', panning: true, panKey: 'shift', marginTop: 50, marginRight: 20, },
			        title: { text: 'CPU' },
			        xAxis: { gridLineColor: '#EEE', lineColor: '#EEE', tickColor: '#EEE',  categories: ${STR_JSON_CATE}, labels: { rotation: 0 } },
			        yAxis: [{ min: 0, gridLineColor: '#EEE', title: { text: "CPU", }, reversed: false, } ],
			        plotOptions: { 
			        	spline: { lineWidth: 2, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: { cursor : 'pointer', point: { events: { click: function(e) { LoadScreenshot( this.x ); } }, }
			        	},
			        },
			        tooltip: { shared: true },
			        legend: { enabled: true, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: [ { yAxis:0, type:"spline", name: 'CPU', data: ${STR_JSON_CPU}  } ]
			      });
			    }
			    var ecomChart_mem = $('#mainchart_mem');
			    if (ecomChart_mem.length) {
			      ecomChart_mem.highcharts({
			        credits: false,
			        colors: [bgSuccess],
			        chart: { backgroundColor: 'transparent', className: '', type: 'column', zoomType: 'x', panning: true, panKey: 'shift', marginTop: 50, marginRight: 20, },
			        title: { text: 'Memory' },
			        xAxis: { gridLineColor: '#EEE', lineColor: '#EEE', tickColor: '#EEE',  categories: ${STR_JSON_CATE}, labels: { rotation: 0 } },
			        yAxis: [{ min: 0, gridLineColor: '#EEE', title: { text: "RAM", }, reversed: false, } ],
			        plotOptions: { 
			        	spline: { lineWidth: 2, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: { cursor : 'pointer', point: { events: { click: function(e) { LoadScreenshot( this.x ); } }, }
			        	},
			        },
			        tooltip: { shared: true },
			        legend: { enabled: true, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: [ { yAxis:0, type:"spline", name: 'RAM', data: ${STR_JSON_MEM}  } ]
			      });
			    }
			     var ecomChart_packet = $('#mainchart_packet');
			    if (ecomChart_packet.length) {
			      ecomChart_packet.highcharts({
			        credits: false,
			        colors: [bgInfo],
			        chart: { backgroundColor: 'transparent', className: '', type: 'column', zoomType: 'x', panning: true, panKey: 'shift', marginTop: 50, marginRight: 20, },
			        title: { text: 'Packet' },
			        xAxis: { gridLineColor: '#EEE', lineColor: '#EEE', tickColor: '#EEE',  categories: ${STR_JSON_CATE}, labels: { rotation: 0 } },
			        yAxis: [{ min: 0, gridLineColor: '#EEE', title: { text: "PACKET", }, reversed: false, } ],
			        plotOptions: { 
			        	spline: { lineWidth: 3, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: { cursor : 'pointer', point: { events: { click: function(e) { LoadScreenshot( this.x ); } }, }
			        	},
			        },
			        tooltip: { shared: true },
			        legend: { enabled: true, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: [ { yAxis:0, type:"spline", name: 'PACKET', data: ${STR_JSON_PACKET}  } ]
			      });
			    }    
			    var ecomChart_temp = $('#mainchart_temp');
			    if (ecomChart_temp.length) {
			      ecomChart_temp.highcharts({
			        credits: false,
			        colors: [bgDanger],
			        chart: { backgroundColor: 'transparent', className: '', type: 'column', zoomType: 'x', panning: true, panKey: 'shift', marginTop: 50, marginRight: 20, },
			        title: { text: 'Temperature' },
			        xAxis: { gridLineColor: '#EEE', lineColor: '#EEE', tickColor: '#EEE',  categories: ${STR_JSON_CATE}, labels: { rotation: 0 } },
			        yAxis: [{ min: 0, gridLineColor: '#EEE', title: { text: "온도", }, reversed: false, } ],
			        plotOptions: { 
			        	spline: { lineWidth: 3, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: { cursor : 'pointer', point: { events: { click: function(e) { LoadScreenshot( this.x ); } }, }
			        	},
			        },
			        tooltip: { shared: true },
			        legend: { enabled: true, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: [ { yAxis:0, type:"spline", name: 'TEMP', data: ${STR_JSON_TEMP}  } ]
			      });
			    }
			    var ecomChart_fps = $('#mainchart_fps');
			    if (ecomChart_fps.length) {
			      ecomChart_fps.highcharts({
			        credits: false,
			        colors: [bgWarning],
			        chart: { backgroundColor: 'transparent', className: '', type: 'column', zoomType: 'x', panning: true, panKey: 'shift', marginTop: 50, marginRight: 20, },
			        title: { text: 'FPS' },
			        xAxis: { gridLineColor: '#EEE', lineColor: '#EEE', tickColor: '#EEE',  categories: ${STR_JSON_CATE}, labels: { rotation: 0 } },
			        yAxis: [{ min: 0, gridLineColor: '#EEE', title: { text: "FPS", }, reversed: false, } ],
			        plotOptions: { 
			        	spline: { lineWidth: 3, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: { cursor : 'pointer', point: { events: { click: function(e) { LoadScreenshot( this.x ); } }, }
			        	},
			        },
			        tooltip: { shared: true },
			        legend: { enabled: true, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: [ { yAxis:0, type:"spline", name: 'FPS', data: ${STR_JSON_FPS}  } ]
			      });
			    }
			    var ecomChart_battery = $('#mainchart_battery');
			    if (ecomChart_battery.length) {
			      ecomChart_battery.highcharts({
			        credits: false, 
			        colors: [bgAlert],
			        chart: { backgroundColor: 'transparent', className: '', type: 'column', zoomType: 'x', panning: true, panKey: 'shift', marginTop: 50, marginRight: 20, },
			        title: { text: 'Battery' },
			        xAxis: { gridLineColor: '#EEE', lineColor: '#EEE', tickColor: '#EEE',  categories: ${STR_JSON_CATE}, labels: { rotation: 0 } },
			        yAxis: [{ min: 0, gridLineColor: '#EEE', title: { text: "BATTERY", }, reversed: false, } ],
			        plotOptions: { 
			        	spline: { lineWidth: 3, }, area: { stacking: 'normal', fillOpacity: 0.2 },
			        	series: { cursor : 'pointer', point: { events: { click: function(e) { LoadScreenshot( this.x ); } }, }
			        	},
			        },
			        tooltip: { shared: true },
			        legend: { enabled: true, floating: false, align: 'right', verticalAlign: 'top', x: -15 },
			        series: [ { yAxis:0, type:"spline", name: 'BATTERY', data: ${STR_JSON_BATTERY}  } ]
			      });
			    }
			});
			var g_cate = ${STR_JSON_ICATE};
			var g_result_id = ${STR_JSON_RESULT_ID};
			function LoadScreenshot(t_time)
			{
				var performance_result_id = g_result_id[t_time];
				var performance_id='${PERFORMANCE.performance_id}';
				$('#screenshot_layer').load( "<@spring.url '/performance/load' />/"+performance_id+"/"+performance_result_id );
			}
			function LoadScreenshotResultid(performance_result_id)
			{
				var performance_id='${PERFORMANCE.performance_id}';
				$('#screenshot_layer').load( "<@spring.url '/performance/load' />/"+performance_id+"/"+performance_result_id );
			}			
			</script>
		</div>	
    
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