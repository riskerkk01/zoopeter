<#import "/spring.ftl" as spring>

<#macro convert_sec sec><#compress>
	<#assign xx1=sec/60>
	<#assign xx2=sec%60>
	${xx1?string("00")}:${xx2?string("00")}
</#compress></#macro>
	
<script language="javascript">
function CheckSize(obj)
{
	var w = obj.width;
	var h = obj.height;
	$('#datalayer1').hide();
	$('#datalayer2').hide();
	if( w > h ) {
		$('#screenshotlayer').removeClass('col-xs-6');
		$('#screenshotlayer').addClass('col-xs-12');
		$('#datalayer2').show();
	} else {
		$('#datalayer1').show();
	}
}
</script>
<div class="row">
	<div id="screenshotlayer" class="col-xs-6">
		<#if PERFORMANCERESULT??>
			<#if PERFORMANCERESULT.performance_screenshot??>
			<img width="100%" src="<@spring.url '/downloader/' />${PERFORMANCERESULT.performance_screenshot}" class="thumbnail" onLoad="CheckSize(this)">
			</#if>
		</#if>
	</div>
	<div id="datalayer1" class="col-xs-6" style="display:none;">
		<div class="panel">
			<div class="panel-body pn">
				<table class="table table-striped table-condensed">
					<tr>
						<th width="40%" class="primary text-center">TIME</th>
						<td >
							<@convert_sec PERFORMANCERESULT.performance_time />			
						</td>
					</tr>				
				
					<tr>
						<th  class="primary text-center">MARK</th>
						<td >
							${PERFORMANCERESULT.performance_mark}					
						</td>
					</tr>				
					<tr>
						<th  class="primary text-center">MEMO</th>
						<td >
							${PERFORMANCERESULT.performance_memo}					
						</td>
					</tr>
					<tr>
						<th class="primary text-center">CPU</th>
						<td >
							${PERFORMANCERESULT.performance_cpu} % 
						</td>
					</tr>
					<tr>
						<th  class="primary text-center">Temp</th>
						<td >
							${PERFORMANCERESULT.performance_temp} C						
						</td>
					</tr>
					<tr>
						<th  class="primary text-center">RAM</th>
						<td > 
							${PERFORMANCERESULT.performance_mem} %
						</td>
					</tr>
					<tr>
						<th class="primary text-center">FPS</th>
						<td >
							${PERFORMANCERESULT.performance_fps}
						</td>
					</tr> 
					<tr>
						<th class="primary text-center">Packet</th>
						<td >
							${PERFORMANCERESULT.performance_packet}
						</td>
					</tr>
					<tr>
						<th  class="primary text-center">Battery</th>
						<td >
							${PERFORMANCERESULT.performance_battery} %
						</td>
					</tr>
				</table>

			</div>
		</div>
	</div>
	<div id="datalayer2" class="col-xs-12" style="display:none;">
		<div class="panel">
			<div class="panel-body pn">
				<table class="table table-striped table-condensed">
					<tr>
						<th width="20%" class="primary text-center">TIME</th>
						<td width="30%">
							${PERFORMANCERESULT.performance_time}				
						</td>
						<th width="20%" class="primary text-center">MARK</th>
						<td width="30%">
							${PERFORMANCERESULT.performance_mark}					
						</td>
					</tr>				
					<tr>
						<th  class="primary text-center">MEMO</th>
						<td colspan="3">
							${PERFORMANCERESULT.performance_memo}					
						</td>
					</tr>
					<tr>
						<th class="primary text-center">CPU</th>
						<td >
							${PERFORMANCERESULT.performance_cpu} % 
						</td>

						<th  class="primary text-center">Temp</th>
						<td >
							${PERFORMANCERESULT.performance_temp} C						
						</td>
					</tr>
					<tr>
						<th  class="primary text-center">RAM</th>
						<td > 
							${PERFORMANCERESULT.performance_mem} %
						</td>

						<th class="primary text-center">FPS</th>
						<td >
							${PERFORMANCERESULT.performance_fps}
						</td>
					</tr> 
					<tr>
						<th class="primary text-center">Packet</th>
						<td >
							${PERFORMANCERESULT.performance_packet}
						</td>

						<th  class="primary text-center">Battery</th>
						<td >
							${PERFORMANCERESULT.performance_battery} %
						</td>
					</tr>
				</table>

			</div>
		</div>
	</div>	
</div>

