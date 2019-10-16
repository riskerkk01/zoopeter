package zoopeter.log.controller;

//import org.apache.log4j.Logger;
import org.slf4j.Logger;


import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import okhttp3.FormBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import zoopeter.module.domain.*;
import zoopeter.module.services.*;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/appsflyer")
public class PostbackAppsflyerController {
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private PublisherService publisherService;
	@Autowired private AppsflyerService appsflyerService;
	@Autowired private ClicklogService clicklogService;
	
	@RequestMapping(value = { "/postback" }, method=RequestMethod.GET)
	public String postback( HttpSession session, Model model, 
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value="clickid", defaultValue="" ) String clickid,
			@RequestParam(value="pid", defaultValue="" ) String pid,
			@RequestParam(value="idfa", defaultValue="" ) String idfa,
			@RequestParam(value="advertiserid", defaultValue="" ) String advertiserid,
			@RequestParam(value="android_id", defaultValue="" ) String android_id,
			@RequestParam(value="app_id", defaultValue="" ) String app_id,
			@RequestParam(value="wifi", defaultValue="" ) String wifi,
			@RequestParam(value="install_unix_ts", defaultValue="" ) String install_unix_ts,
			@RequestParam(value="click_ts", defaultValue="" ) String click_ts,
			@RequestParam(value="campaign", defaultValue="" ) String campaign,
			@RequestParam(value="publisher_id", defaultValue="" ) String publisher_id,
			@RequestParam(value="country_code", defaultValue="" ) String country_code,
			@RequestParam(value="city", defaultValue="" ) String city,
			@RequestParam(value="device_brand", defaultValue="" ) String device_brand,
			@RequestParam(value="carrier", defaultValue="" ) String carrier,
			@RequestParam(value="ip", defaultValue="" ) String ip,
			@RequestParam(value="device_model", defaultValue="" ) String device_model,
			@RequestParam(value="language", defaultValue="" ) String language,
			@RequestParam(value="appsflyer_device_id", defaultValue="" ) String appsflyer_device_id,
			@RequestParam(value="sdk_version", defaultValue="" ) String sdk_version,
			@RequestParam(value="app_version_name", defaultValue="" ) String app_version_name,
			@RequestParam(value="user_agent", defaultValue="" ) String user_agent,
			@RequestParam(value="vendorid", defaultValue="" ) String vendorid,
			@RequestParam(value="os_version", defaultValue="" ) String os_version,
			@RequestParam(value="app_name", defaultValue="" ) String app_name,
			@RequestParam(value="match_type", defaultValue="" ) String match_type,
			@RequestParam(value="gp_referer_click_ts", defaultValue="" ) String gp_referer_click_ts,
			@RequestParam(value="gp_referer_install_ts", defaultValue="" ) String gp_referer_install_ts,
			@RequestParam(value="event_name", defaultValue="" ) String event_name,
			@RequestParam(value="mapped_iae", defaultValue="" ) String mapped_iae,
			@RequestParam(value="monetary", defaultValue="" ) String monetary,
			@RequestParam(value="orig_monetary", defaultValue="" ) String orig_monetary,
			@RequestParam(value="currency", defaultValue="" ) String currency,
			@RequestParam(value="timestamp", defaultValue="" ) String timestamp,
			@RequestParam(value="event_value", defaultValue="" ) String event_value,
			@RequestParam(value="event", defaultValue="" ) String event,
			@RequestParam(value="json", defaultValue="" ) String json
			) {
		
		if( "".equals( pid ) == true || "{pid}".equals( pid ) == true || "(pid)".equals( pid ) == true ) {
			model.addAttribute("error_message", "Invalid parameter : pid" );
			return "postback_error";
		}

		if( "".equals( clickid ) == true || "{clickid}".equals( clickid ) == true || "(clickid)".equals( clickid ) == true ) {
			model.addAttribute("error_message", "Invalid parameter : clickid" );
			return "postback_error";
		}
		
		String click_id = clickid;
		
		int af_quantity = 0;
		int af_revenue = 0;
		String af_currency = "";
		String af_content_id = "";
		String af_content_type = "";

		Clicklog sclicklog = new Clicklog();
		//sclicklog.setClick_id( clickid );
		sclicklog.setSearchtype( "click_id" );
		sclicklog.setSearchkeyword( click_id );
		sclicklog.setStart(0);
		sclicklog.setCount(1);
		List<Clicklog> clicklogList = clicklogService.getClicklogList( sclicklog );
		if( clicklogList.size() == 0 ) {
			model.addAttribute("error_message", "Invalid click_id : " + click_id );
			return "postback_error";
		}
		
		Clicklog clicklog = clicklogList.get(0);
		String sub_pub_id = clicklog.getSub_pub_id();
		
		Appsflyer iappsflyer = new Appsflyer();
		iappsflyer.setPid( pid );
		iappsflyer.setClickid( click_id );
		iappsflyer.setIdfa( idfa );
		iappsflyer.setAdvertiserid( advertiserid );
		iappsflyer.setAndroid_id( android_id );
		iappsflyer.setApp_id( app_id );
		iappsflyer.setWifi( wifi );
		iappsflyer.setInstall_unix_ts( install_unix_ts );
		iappsflyer.setClick_ts( click_ts );
		iappsflyer.setCampaign( campaign );
		iappsflyer.setPublisher_id( publisher_id );
		iappsflyer.setPublisher_sub_id( sub_pub_id );
		iappsflyer.setCountry_code( country_code );
		iappsflyer.setCity( city );
		iappsflyer.setDevice_brand( device_brand );
		iappsflyer.setCarrier( carrier );
		iappsflyer.setIp( ip );
		iappsflyer.setDevice_model( device_model );
		iappsflyer.setLanguage( language );
		iappsflyer.setAppsflyer_device_id( appsflyer_device_id );
		iappsflyer.setSdk_version( sdk_version );
		iappsflyer.setApp_version_name( app_version_name );
		iappsflyer.setUser_agent( user_agent );
		iappsflyer.setVendorid( vendorid );
		iappsflyer.setOs_version( os_version );
		iappsflyer.setApp_name( app_name );
		iappsflyer.setMatch_type( match_type );
		iappsflyer.setGp_referer_click_ts( gp_referer_click_ts );
		iappsflyer.setGp_referer_install_ts( gp_referer_install_ts );
		iappsflyer.setEvent_name( event_name );
		iappsflyer.setMapped_iae( mapped_iae );
		iappsflyer.setMonetary( monetary );
		iappsflyer.setOrig_monetary( orig_monetary );
		iappsflyer.setCurrency( currency );
		iappsflyer.setTimestamp( timestamp );
		iappsflyer.setEvent_value( event_value );
		iappsflyer.setEvent( event );
		iappsflyer.setJson( json );
		iappsflyer.setAf_quantity( af_quantity );
		iappsflyer.setAf_revenue( af_revenue );
		iappsflyer.setAf_currency( af_currency );
		iappsflyer.setAf_content_id( af_content_id );
		iappsflyer.setAf_content_type( af_content_type );

		Publisher publisher = publisherService.getPublisherByCode( publisher_id );
		if( publisher == null ) {
			model.addAttribute("error_message", "Invalid publisher : " + publisher_id );
			return "postback_error";
		}
		
		int newseq = appsflyerService.setAppsflyer( iappsflyer );
		if( newseq == 0 ) {
			model.addAttribute("error_message", "Internal Error : Insert Error" );
			return "postback_error";
		}
		
		String postback_url = publisher.getPostback_url();
		if( "".equals( postback_url ) != true ) {
			postback_url = postback_url.replace( "{click_id}", click_id );
			postback_url = postback_url.replace( "{sub_pub_id}", sub_pub_id );
			postback_url = postback_url.replace( "{sub_param1}", clicklog.getSub_param1() );
			postback_url = postback_url.replace( "{sub_param2}", clicklog.getSub_param2() );
			postback_url = postback_url.replace( "{sub_param3}", clicklog.getSub_param3() );
			postback_url = postback_url.replace( "{sub_param4}", clicklog.getSub_param4() );
			
			postback_url = postback_url.replace( "{click_time}", click_ts );
			postback_url = postback_url.replace( "{install_time}", install_unix_ts );
			postback_url = postback_url.replace( "{ADID}", advertiserid );
			postback_url = postback_url.replace( "{IDFA}", idfa );
			postback_url = postback_url.replace( "{ip}", ip );
			postback_url = postback_url.replace( "{platform}", vendorid );
			postback_url = postback_url.replace( "{os_ver}", os_version );
			postback_url = postback_url.replace( "{carrier}", carrier );
			postback_url = postback_url.replace( "{model}", device_model );
			postback_url = postback_url.replace( "{country}", country_code );
			postback_url = postback_url.replace( "{language}", language );
			postback_url = postback_url.replace( "{app_id}", app_id );
			postback_url = postback_url.replace( "{event_type}", event_name );
			postback_url = postback_url.replace( "{event_purchase}", Integer.toString(af_revenue) );
			requestUrl( postback_url );
		}

		return "postback_adbrix";
	}

	@RequestMapping(value = { "/inappevent" }, method=RequestMethod.GET)
	public String inappevent( HttpSession session, Model model, 
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value="clickid", defaultValue="" ) String clickid,
			@RequestParam(value="pid", defaultValue="" ) String pid,
			@RequestParam(value="idfa", defaultValue="" ) String idfa,
			@RequestParam(value="advertiserid", defaultValue="" ) String advertiserid,
			@RequestParam(value="android_id", defaultValue="" ) String android_id,
			@RequestParam(value="app_id", defaultValue="" ) String app_id,
			@RequestParam(value="wifi", defaultValue="" ) String wifi,
			@RequestParam(value="install_unix_ts", defaultValue="" ) String install_unix_ts,
			@RequestParam(value="click_ts", defaultValue="" ) String click_ts,
			@RequestParam(value="campaign", defaultValue="" ) String campaign,
			@RequestParam(value="publisher_id", defaultValue="" ) String publisher_id,
			@RequestParam(value="country_code", defaultValue="" ) String country_code,
			@RequestParam(value="city", defaultValue="" ) String city,
			@RequestParam(value="device_brand", defaultValue="" ) String device_brand,
			@RequestParam(value="carrier", defaultValue="" ) String carrier,
			@RequestParam(value="ip", defaultValue="" ) String ip,
			@RequestParam(value="device_model", defaultValue="" ) String device_model,
			@RequestParam(value="language", defaultValue="" ) String language,
			@RequestParam(value="appsflyer_device_id", defaultValue="" ) String appsflyer_device_id,
			@RequestParam(value="sdk_version", defaultValue="" ) String sdk_version,
			@RequestParam(value="app_version_name", defaultValue="" ) String app_version_name,
			@RequestParam(value="user_agent", defaultValue="" ) String user_agent,
			@RequestParam(value="vendorid", defaultValue="" ) String vendorid,
			@RequestParam(value="os_version", defaultValue="" ) String os_version,
			@RequestParam(value="app_name", defaultValue="" ) String app_name,
			@RequestParam(value="match_type", defaultValue="" ) String match_type,
			@RequestParam(value="gp_referer_click_ts", defaultValue="" ) String gp_referer_click_ts,
			@RequestParam(value="gp_referer_install_ts", defaultValue="" ) String gp_referer_install_ts,
			@RequestParam(value="event_name", defaultValue="" ) String event_name,
			@RequestParam(value="mapped_iae", defaultValue="" ) String mapped_iae,
			@RequestParam(value="monetary", defaultValue="" ) String monetary,
			@RequestParam(value="orig_monetary", defaultValue="" ) String orig_monetary,
			@RequestParam(value="currency", defaultValue="" ) String currency,
			@RequestParam(value="timestamp", defaultValue="" ) String timestamp,
			@RequestParam(value="event_value", defaultValue="" ) String event_value,
			@RequestParam(value="event", defaultValue="" ) String event,
			@RequestParam(value="json", defaultValue="" ) String json
			) {
		
		if( "".equals( pid ) == true || "{pid}".equals( pid ) == true || "(pid)".equals( pid ) == true ) {
			model.addAttribute("error_message", "Invalid parameter : pid" );
			return "postback_error";
		}

		if( "".equals( clickid ) == true || "{clickid}".equals( clickid ) == true || "(clickid)".equals( clickid ) == true ) {
			model.addAttribute("error_message", "Invalid parameter : clickid" );
			return "postback_error";
		}
		
		String click_id = clickid;
		
		int af_quantity = 0;
		int af_revenue = 0;
		String af_currency = "";
		String af_content_id = "";
		String af_content_type = "";

		Clicklog sclicklog = new Clicklog();
		//sclicklog.setClick_id( clickid );
		sclicklog.setSearchtype( "click_id" );
		sclicklog.setSearchkeyword( click_id );
		sclicklog.setStart(0);
		sclicklog.setCount(1);
		List<Clicklog> clicklogList = clicklogService.getClicklogList( sclicklog );
		if( clicklogList.size() == 0 ) {
			model.addAttribute("error_message", "Invalid click_id : " + click_id );
			return "postback_error";
		}
		
		Clicklog clicklog = clicklogList.get(0);
		String sub_pub_id = clicklog.getSub_pub_id();
		
		Appsflyer iappsflyer = new Appsflyer();
		iappsflyer.setPid( pid );
		iappsflyer.setClickid( click_id );
		iappsflyer.setIdfa( idfa );
		iappsflyer.setAdvertiserid( advertiserid );
		iappsflyer.setAndroid_id( android_id );
		iappsflyer.setApp_id( app_id );
		iappsflyer.setWifi( wifi );
		iappsflyer.setInstall_unix_ts( install_unix_ts );
		iappsflyer.setClick_ts( click_ts );
		iappsflyer.setCampaign( campaign );
		iappsflyer.setPublisher_id( publisher_id );
		iappsflyer.setPublisher_sub_id( sub_pub_id );
		iappsflyer.setCountry_code( country_code );
		iappsflyer.setCity( city );
		iappsflyer.setDevice_brand( device_brand );
		iappsflyer.setCarrier( carrier );
		iappsflyer.setIp( ip );
		iappsflyer.setDevice_model( device_model );
		iappsflyer.setLanguage( language );
		iappsflyer.setAppsflyer_device_id( appsflyer_device_id );
		iappsflyer.setSdk_version( sdk_version );
		iappsflyer.setApp_version_name( app_version_name );
		iappsflyer.setUser_agent( user_agent );
		iappsflyer.setVendorid( vendorid );
		iappsflyer.setOs_version( os_version );
		iappsflyer.setApp_name( app_name );
		iappsflyer.setMatch_type( match_type );
		iappsflyer.setGp_referer_click_ts( gp_referer_click_ts );
		iappsflyer.setGp_referer_install_ts( gp_referer_install_ts );
		iappsflyer.setEvent_name( event_name );
		iappsflyer.setMapped_iae( mapped_iae );
		iappsflyer.setMonetary( monetary );
		iappsflyer.setOrig_monetary( orig_monetary );
		iappsflyer.setCurrency( currency );
		iappsflyer.setTimestamp( timestamp );
		iappsflyer.setEvent_value( event_value );
		iappsflyer.setEvent( event );
		iappsflyer.setJson( json );
		iappsflyer.setAf_quantity( af_quantity );
		iappsflyer.setAf_revenue( af_revenue );
		iappsflyer.setAf_currency( af_currency );
		iappsflyer.setAf_content_id( af_content_id );
		iappsflyer.setAf_content_type( af_content_type );

		Publisher publisher = publisherService.getPublisherByCode( publisher_id );
		if( publisher == null ) {
			model.addAttribute("error_message", "Invalid publisher : " + publisher_id );
			return "postback_error";
		}
		
		int newseq = appsflyerService.setAppsflyer( iappsflyer );
		if( newseq == 0 ) {
			model.addAttribute("error_message", "Internal Error : Insert Error" );
			return "postback_error";
		}
		

		
		String postback_url = publisher.getEvent_url();
		if( "".equals( postback_url ) != true ) {
			postback_url = postback_url.replace( "{click_id}", click_id );
			postback_url = postback_url.replace( "{sub_pub_id}", sub_pub_id );
			postback_url = postback_url.replace( "{sub_param1}", clicklog.getSub_param1() );
			postback_url = postback_url.replace( "{sub_param2}", clicklog.getSub_param2() );
			postback_url = postback_url.replace( "{sub_param3}", clicklog.getSub_param3() );
			postback_url = postback_url.replace( "{sub_param4}", clicklog.getSub_param4() );
			
			postback_url = postback_url.replace( "{click_time}", click_ts );
			postback_url = postback_url.replace( "{install_time}", install_unix_ts );
			postback_url = postback_url.replace( "{ADID}", advertiserid );
			postback_url = postback_url.replace( "{IDFA}", idfa );
			postback_url = postback_url.replace( "{ip}", ip );
			postback_url = postback_url.replace( "{platform}", vendorid );
			postback_url = postback_url.replace( "{os_ver}", os_version );
			postback_url = postback_url.replace( "{carrier}", carrier );
			postback_url = postback_url.replace( "{model}", device_model );
			postback_url = postback_url.replace( "{country}", country_code );
			postback_url = postback_url.replace( "{language}", language );
			postback_url = postback_url.replace( "{app_id}", app_id );
			postback_url = postback_url.replace( "{event_type}", event_name );
			postback_url = postback_url.replace( "{event_purchase}", Integer.toString(af_revenue) );
			
			postback_url = postback_url.replace( "{event_type}", event_name );
			postback_url = postback_url.replace( "{event_purchase}", Integer.toString( af_revenue ) );
			postback_url = postback_url.replace( "{event_name}", event_name );
			postback_url = postback_url.replace( "{event_value}", event_value );
			postback_url = postback_url.replace( "{event_time}", timestamp );
			postback_url = postback_url.replace( "{event_stamp}", timestamp );
			
			requestUrl( postback_url );
		}

		return "postback_adbrix";
	}	
	
	private void requestUrl( String url ) {
		OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder()
                .url( url )
                .build();
        try {
			Response response = client.newCall(request).execute();
			response.close();
			//String bodystr = response.body().string();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
