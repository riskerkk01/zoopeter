<route> 
<template id="postbackguide">
<div>
	<!-- Page Heading -->
	<div class="page-header">
		<h1 class="page-title">
			포스트백 가이드 
		</h1>
	</div>
	<p>
zoopeter 가이드 : <a href="https://docs.google.com/document/d/1lHnO4V8J0t_CBomdz_DnOVA6T1owhFy_1upbZd6Aetk/edit?ts=5c64ceea" target="_blank">구글독스</a><br>
요구 지표 : <a href="https://docs.google.com/spreadsheets/d/1fSpPDV9hl-tdbhe6ZT0-CgXesNdHOzIUGt9xqVJ3R68/edit#gid=272657281" target="_blank">구글독스</a><br>
<br>

AppsFlyer : <a href="https://support.appsflyer.com/hc/en-us/articles/207273946-Available-Macros-on-AppsFlyer-s-Postbacks" target="_blank">https://support.appsflyer.com/hc/en-us/articles/207273946-Available-Macros-on-AppsFlyer-s-Postbacks</a>
	<pre>
	매체 변수 : publisher_id
	Intall Postback URL :  http://log.zoopeter.com/postback/appsflyer/postback.php?pid=(pid)&amp;clickid=(clickid)&amp;idfa=(idfa)&amp;advertiserid=(advertiserId)&amp;android_id=(android-id)&amp;app_id=(app-id)&amp;wifi=(wifi)&amp;install_unix_ts=(install-unix-ts)&amp;click_ts=(click-ts)&amp;campaign=(campaign)&amp;publisher_id=(publisher_id)&amp;country_code=(country_code)&amp;city=(city)&amp;device_brand=(device_brand)&amp;carrier=(carrier)&amp;ip=(ip)&amp;device_model=(device-model)&amp;language=(language)&amp;appsflyer_device_id=(appsflyer-device-id)&amp;sdk_version=(sdk-version)&amp;app_version_name=(app-version-name)&amp;user_agent=(user-agent)&amp;vendorid=(vendorid)&amp;os_version=(os-version)&amp;app_name=(app-name)&amp;match_type=(match-type)&amp;gp_referer_click_ts=(gp_referer_click_ts)&amp;gp_referer_install_ts=(gp_referer_install_ts)

	In-app Event URL :  http://log.zoopeter.com/postback/appsflyer/inappevent.php?pid=(pid)&amp;clickid=(clickid)&amp;idfa=(idfa)&amp;advertiserid=(advertiserId)&amp;android_id=(android-id)&amp;app_id=(app-id)&amp;wifi=(wifi)&amp;install_unix_ts=(install-unix-ts)&amp;click_ts=(click-ts)&amp;campaign=(campaign)&amp;publisher_id=(publisher_id)&amp;country_code=(country_code)&amp;city=(city)&amp;device_brand=(device_brand)&amp;carrier=(carrier)&amp;ip=(ip)&amp;device_model=(device-model)&amp;language=(language)&amp;appsflyer_device_id=(appsflyer-device-id)&amp;sdk_version=(sdk-version)&amp;app_version_name=(app-version-name)&amp;user_agent=(user-agent)&amp;vendorid=(vendorid)&amp;os_version=(os-version)&amp;app_name=(app-name)&amp;match_type=(match-type)&amp;gp_referer_click_ts=(gp_referer_click_ts)&amp;gp_referer_install_ts=(gp_referer_install_ts)&amp;event_name=(event-name)&amp;maped_iae=(mapped-iae)&amp;monetary=(monetary)&amp;orig_monetary=(orig-monetary)&amp;currency=(currency)&amp;timestamp=(timestamp)&amp;event_value=(event-value)&event=(event)&json=(encode)

	Launching URL : https://app.appsflyer.com/com.appsflyer.adNetworkTest?c={campain}&amp;af_siteid={af_siteid}&amp;af_sub_siteid={af_sub_siteid}&amp;af_ad_type={af_ad_type}&amp;pid=zoopeter_int&amp;af_click_lookback=7d&amp;advertishing_id={adversting_id}&amp;clickid={clickid}&amp;is_incentivized={is_incentivized}&amp;is_s2s={is_s2s}
	</pre>
<br>
Branck(Tunes) : <a href="https://docs.branch.io/pages/deep-linked-ads/branch-universal-ads-mobile-tracking/#edit-postbacks" target="_blank">https://docs.branch.io/pages/deep-linked-ads/branch-universal-ads-mobile-tracking/#edit-postbacks</a>
	<pre>
	매체 변수 : channel
	Postback URL : http://log.zoopeter.com/postback/tune/postback.php?%24aaid={aaid}&%24idfa={idfa}&~agency={agency}&~secondary_publisher={secondary_publisher}
					&~campaign={campaign}&~campaign_id={campaign_id}&~channel={channel}&~ad_set_name={ad_set_name}&~ad_set_id={ad_set_id}&~ad_name={ad_name}
					&~ad_id={ad_id}&click_id={click_id}&event_name={event_name}&event_timestamp={event_timestamp}&is_attributed={is_attributed}
					&bundle_id={bundle_id}&app_name={app_name}&app_version={app_version}&language={language}&os={os}&os_version={os_version}
					&client_ip={client_ip}&country={country}&device_id={device_id}&user_agent={user_agent}&goal_id={goal_id}

	In-app Event URL : http://log.zoopeter.com/postback/tune/inappevent.php?%24aaid={aaid}&%24idfa={idfa}&~agency={agency}&~secondary_publisher={secondary_publisher}
					&~campaign={campaign}&~campaign_id={campaign_id}&~channel={channel}&~ad_set_name={ad_set_name}&~ad_set_id={ad_set_id}&~ad_name={ad_name}
					&~ad_id={ad_id}&click_id={click_id}&event_name={event_name}&event_timestamp={event_timestamp}&is_attributed={is_attributed}
					&bundle_id={bundle_id}&app_name={app_name}&app_version={app_version}&language={language}&os={os}&os_version={os_version}
					&client_ip={client_ip}&country={country}&device_id={device_id}&user_agent={user_agent}&goal_id={goal_id}

	Launching URL : https://branchster.app.link/uU57IgnlpS?%243p=a_zoopeter_media&%24aaid={aaid}&%24idfa={idfa}&~ad_set_id={ad_set_id}
					&~ad_set_name={ad_set_name}&~agency={agency}&~campaign={campaign}&~campaign_id={campaign_id}
					&~channel={channel}&~click_id={click_id}&~creative_name={ad_name}&~secondary_publisher={secondary_publisher}
	</pre>
<br>
	

AdBrix : 
	담당자 : Integrations &lt;integration@adjust.com><br>
	<a href="http://adbrixpartners.cs-works.io/hc/ko/8_12/Content/Article/adbrix-postback-guide-2018?share=true" target="_blank">http://adbrixpartners.cs-works.io/hc/ko/8_12/Content/Article/adbrix-postback-guide-2018?share=true</a>
	<pre>
	매체 변수 : cb_param2
	Install Postback URL : http://log.zoopeter.com/postback/adbrix/postback.php?appkey={appkey}&amp;package_name={package_name}&amp;gaid={gaid}&amp;ifa={ifa}&amp;ifv={ifv}&amp;model={model}&amp;network={network}&amp;os_ver={os_ver}&amp;sdk_version={sdk_version}&amp;platform={platform}&amp;country={country}&amp;language={language}&amp;width={width}&amp;height={height}&amp;carrier={carrier}&amp;first_install_time={first_install_time}&amp;event_type_code={event_type_code}&amp;conversion_ip={conversion_ip}&amp;event_time={event_time}&amp;session_id={session_id}&amp;cb_param1={cb_param1}&amp;cb_param2={cb_param2}&amp;cb_param3={cb_param3}&amp;cb_param4={cb_param4}&amp;cb_param5={cb_param5}

	In-app Event Postback URL : http://log.zoopeter.com/postback/adbrix/inappevent.php?appkey={appkey}&amp;package_name={package_name}&amp;gaid={gaid}&amp;ifa={ifa}&amp;ifv={ifv}&amp;model={model}&amp;network={network}&amp;os_ver={os_ver}&amp;sdk_version={sdk_version}&amp;platform={platform}&amp;country={country}&amp;language={language}&amp;width={width}&amp;height={height}&amp;carrier={carrier}&amp;first_install_time={first_install_time}&amp;event_type_code={event_type_code}&amp;conversion_ip={conversion_ip}&amp;event_time={event_time}&amp;session_id={session_id}&amp;cb_param1={last_cb_param1}&amp;cb_param2={last_cb_param2}&amp;cb_param3={last_cb_param3}&amp;cb_param4={last_cb_param4}&amp;cb_param5={last_cb_param5}&amp;activity_group={activity_group}&amp;activity={activity}&amp;activity_param={activity_param}&amp;order_id={order_id}&amp;product_id={product_id}&amp;product_name={product_name}&amp;price={price}&amp;quantity={quantity}&amp;sales={sales}&amp;category={category}&amp;currency={currency}&amp;event_detail={event_detail}

	Launching URL : https://ref.ad-brix.com/v1/referrallink?ak=128828124&amp;ck=9502284&amp;cb_param1={click_id}&amp;cb_param2={매체코드}
	</pre>
<br>

AdBrix Remaster : 
	담당자 : Integrations &lt;integration@adjust.com><br>
	<a href="http://adbrixpartners.cs-works.io/hc/ko/8_12/Content/Article/adbrix-postback-guide-2018?share=true" target="_blank">http://adbrixpartners.cs-works.io/hc/ko/8_12/Content/Article/adbrix-postback-guide-2018?share=true</a>
	<pre>
	매체 변수 : cb_2
	Install Postback URL : http://log.zoopeter.com/postback/adbrixre/postback.php?appkey={appkey}&amp;package_name={package_name}&amp;gaid={gaid}&amp;ifa={ifa}&amp;ifv={ifv}&amp;model={model}&amp;network={network}&amp;os_ver={os_ver}&amp;sdk_version={sdk_version}&amp;platform={platform}&amp;country={country}&amp;language={language}&amp;width={width}&amp;height={height}&amp;carrier={carrier}&amp;first_install_time={first_install_time}&amp;event_type_code={event_type_code}&amp;conversion_ip={conversion_ip}&amp;event_time={event_time}&amp;session_id={session_id}&amp;cb_1={cb_1}&amp;cb_2={cb_2}&amp;cb_3={cb_3}&amp;cb_4={cb_4}&amp;cb_5={cb_5}

	In-app Event Postback URL : http://log.zoopeter.com/postback/adbrixre/inappevent.php?appkey={appkey}&amp;package_name={package_name}&amp;gaid={gaid}&amp;ifa={ifa}&amp;ifv={ifv}&amp;model={model}&amp;network={network}&amp;os_ver={os_ver}&amp;sdk_version={sdk_version}&amp;platform={platform}&amp;country={country}&amp;language={language}&amp;width={width}&amp;height={height}&amp;carrier={carrier}&amp;first_install_time={first_install_time}&amp;event_type_code={event_type_code}&amp;conversion_ip={conversion_ip}&amp;event_time={event_time}&amp;session_id={session_id}&amp;cb_1={last_cb_1}&amp;cb_2={last_cb_2}&amp;cb_3={last_cb_3}&amp;cb_4={last_cb_4}&amp;cb_5={last_cb_5}&amp;activity_group={activity_group}&amp;activity={activity}&amp;activity_param={activity_param}&amp;order_id={order_id}&amp;product_id={product_id}&amp;product_name={product_name}&amp;price={price}&amp;quantity={quantity}&amp;sales={sales}&amp;category={category}&amp;currency={currency}&amp;event_detail={event_detail}

	Launching URL : https://fnbFMvaGgkGVcajnoIeUTw.adtouch.adbrix.io/api/v1/click/T2yaK9KHmEmQrk72ViEv7A?&amp;cb_1={cb_1}&amp;cb_2={cb_2}&amp;cb_3={cb_3}&amp;cb_4={cb_4}&amp;cb_5={cb_5}&amp;m_adid={m_adid}&amp;m_publisher={m_publisher}&amp;m_sub_publisher={m_sub_publisher}
	Launching URL test : https://fnbFMvaGgkGVcajnoIeUTw.adtouch.adbrix.io/api/v1/click/T2yaK9KHmEmQrk72ViEv7A?&amp;cb_1=testclickid&amp;cb_2=test&amp;cb_3=&amp;cb_4=16&amp;cb_5=test&amp;m_adid=adid&amp;m_publisher=test&amp;m_sub_publisher=
	</pre>
<br>

Adjust : <a href="https://partners.adjust.com/placeholders/" target="_blank">https://partners.adjust.com/placeholders/</a>
	<pre>
	매체 변수 : network_name  
	Install Postback URL : http://log.zoopeter.com/postback/adjust/postback.php?adid={adid}&amp;app_id={app_id}&amp;app_name={app_name}&amp;idfa={idfa}&amp;click_id={click_id}&amp;app_version={app_version}&amp;campaign_name={campaign_name}&amp;install_at={install_at}&amp;click_time={click_time}&amp;country={country}&amp;region={region}&amp;sdk_version={sdk_version}&amp;os_version={os_version}&amp;os_name={os_name}&amp;event={event}&amp;event_name={event_name}&amp;ip_address={ip_address}&amp;network_name={network_name}

	In-app Event URL : http://log.zoopeter.com/postback/adjust/inappevent.php?adid={adid}&amp;app_id={app_id}&amp;app_name={app_name}&amp;idfa={idfa}&amp;click_id={click_id}&amp;app_version={app_version}&amp;campaign_name={campaign_name}&amp;install_at={install_at}&amp;click_time={click_time}&amp;country={country}&amp;region={region}&amp;sdk_version={sdk_version}&amp;os_version={os_version}&amp;os_name={os_name}&amp;event={event}&amp;event_name={event_name}&amp;ip_address={ip_address}&amp;network_name={network_name}&amp;revenue={revenue}&amp;currency={currency}&amp;revenue_float={revenue_float} 

	Launching URL : https://app.adjust.com/abc123?idfa={idfa}&amp;campaign={campaign}
						&amp;install_callback=http://log.zoopeter.com/postback/adjust/postback.php?adid={adid}&app_id={app_id}&app_name={app_name}&idfa={idfa}&click_id={click_id}&app_version={app_version}&campaign_name={campaign_name}&install_at={install_at}&click_time={click_time}&country={country}&region={region}&sdk_version={sdk_version}&os_version={os_version}&os_name={os_name}&event={event}&event_name={event_name}
	</pre>
</p>
</div>
</template> 
<script type="text/javascript">
var postbackguide = Vue.component('postbackguide', {
	template : '#postbackguide',
	data : function() { return {
		xxx: '1'
		}
	},
	created : function() {
		console.log("postbackguide created");
	},
	mounted : function() {
		//console.log( $store.state.sessionInfo );
		console.log('postbackguide');
	},
	updated: function() {
	},
	method : {
	}
});
</script>
</route>