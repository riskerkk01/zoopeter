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
@RequestMapping("/adbrix")
public class PostbackAdbrixController {
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private PublisherService publisherService;
	@Autowired private AdbrixService adbrixService;
	@Autowired private ClicklogService clicklogService;
	
	@RequestMapping(value = { "/postback" }, method=RequestMethod.GET)
	public String postback( HttpSession session, Model model, 
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value="appkey", defaultValue="" ) String appkey,
			@RequestParam(value="package_name", defaultValue="" ) String package_name,
			@RequestParam(value="gaid", defaultValue="" ) String gaid,
			@RequestParam(value="ifa", defaultValue="" ) String ifa,
			@RequestParam(value="ifv", defaultValue="" ) String ifv,
			@RequestParam(value="model", defaultValue="" ) String p_model,
			@RequestParam(value="network", defaultValue="" ) String network,
			@RequestParam(value="os_ver", defaultValue="" ) String os_ver,
			@RequestParam(value="sdk_version", defaultValue="" ) String sdk_version,
			@RequestParam(value="platform", defaultValue="" ) String platform,
			@RequestParam(value="country", defaultValue="" ) String country,
			@RequestParam(value="language", defaultValue="" ) String language,
			@RequestParam(value="width", defaultValue="" ) String width,
			@RequestParam(value="height", defaultValue="" ) String height,
			@RequestParam(value="carrier", defaultValue="" ) String carrier,
			@RequestParam(value="first_install_time", defaultValue="" ) String first_install_time,
			@RequestParam(value="event_type_code", defaultValue="" ) String event_type_code,
			@RequestParam(value="conversion_ip", defaultValue="" ) String conversion_ip,
			@RequestParam(value="event_time", defaultValue="" ) String event_time,
			@RequestParam(value="session_id", defaultValue="" ) String session_id,
			@RequestParam(value="cb_param1", defaultValue="" ) String cb_param1,
			@RequestParam(value="cb_param2", defaultValue="" ) String cb_param2,
			@RequestParam(value="cb_param3", defaultValue="" ) String cb_param3,
			@RequestParam(value="cb_param4", defaultValue="" ) String cb_param4,
			@RequestParam(value="cb_param5", defaultValue="" ) String cb_param5,
			@RequestParam(value="activity_group", defaultValue="" ) String activity_group,
			@RequestParam(value="activity", defaultValue="" ) String activity,
			@RequestParam(value="activity_param", defaultValue="" ) String activity_param,
			@RequestParam(value="order_id", defaultValue="" ) String order_id,
			@RequestParam(value="product_id", defaultValue="" ) String product_id,
			@RequestParam(value="product_name", defaultValue="" ) String product_name,
			@RequestParam(value="price", defaultValue="" ) String price,
			@RequestParam(value="quantity", defaultValue="" ) String quantity,
			@RequestParam(value="sales", defaultValue="" ) String sales,
			@RequestParam(value="category", defaultValue="" ) String category,
			@RequestParam(value="currency", defaultValue="" ) String currency,
			@RequestParam(value="event_detail", defaultValue="" ) String event_detail,
			@RequestParam(value="last_cb_param1", defaultValue="" ) String last_cb_param1,
			@RequestParam(value="last_cb_param2", defaultValue="" ) String last_cb_param2,
			@RequestParam(value="last_cb_param3", defaultValue="" ) String last_cb_param3,
			@RequestParam(value="last_cb_param4", defaultValue="" ) String last_cb_param4,
			@RequestParam(value="last_cb_param5", defaultValue="" ) String last_cb_param5
			) {
		
		if( "".equals( appkey ) == true || "{appkey}".equals( appkey ) == true ) {
			model.addAttribute("error_message", "Invalid parameter : appkey" );
			return "postback_error";
		}

		if( "".equals( cb_param1 ) == true ) cb_param1 = last_cb_param1;
		if( "".equals( cb_param2 ) == true ) cb_param1 = last_cb_param2;
		if( "".equals( cb_param3 ) == true ) cb_param1 = last_cb_param3;
		if( "".equals( cb_param4 ) == true ) cb_param1 = last_cb_param4;
		if( "".equals( cb_param5 ) == true ) cb_param1 = last_cb_param5;
		
		// gaid != "" 이고 cb_param1, cb_param2, cb_param3 == "" 이면  이전 데이타가지고 처리.
		if( "".equals( gaid ) == false && "".equals( cb_param1 ) == true && "".equals( cb_param2 ) == true && "".equals( cb_param3 ) == true ) {
			Adbrix adbrix = new Adbrix();
			adbrix.setGaid( gaid );
			adbrix.setStart(0);
			adbrix.setCount(1);
			List<Adbrix> adbrixList = adbrixService.getAdbrixList( adbrix );
			if( adbrixList.size() > 0 ) {
				Adbrix tadbrix = adbrixList.get(0);
				cb_param1 = tadbrix.getCb_param1();
				cb_param2 = tadbrix.getCb_param2();
				cb_param3 = tadbrix.getCb_param3();
				cb_param4 = tadbrix.getCb_param4();
				cb_param5 = tadbrix.getCb_param5();
			}
		}
		
		Adbrix iadbrix = new Adbrix();
		iadbrix.setAppkey( appkey );
		iadbrix.setPackage_name( package_name );
		iadbrix.setGaid( gaid );
		iadbrix.setIfa( ifa );
		iadbrix.setIfv( ifv );
		iadbrix.setModel( p_model );
		iadbrix.setNetwork( network );
		iadbrix.setOs_ver( os_ver );
		iadbrix.setSdk_version( sdk_version );
		iadbrix.setPlatform( platform );
		iadbrix.setCountry( country );
		iadbrix.setLanguage( language );
		iadbrix.setWidth( width );
		iadbrix.setHeight( height );
		iadbrix.setCarrier( carrier );
		iadbrix.setFirst_install_time( first_install_time );
		iadbrix.setEvent_type_code( event_type_code );
		iadbrix.setConversion_ip( conversion_ip );
		iadbrix.setEvent_time( event_time );
		iadbrix.setSession_id( session_id );
		iadbrix.setCb_param1( cb_param1 );
		iadbrix.setCb_param2( cb_param2 );
		iadbrix.setCb_param3( cb_param3 );
		iadbrix.setCb_param4( cb_param4 );
		iadbrix.setCb_param5( cb_param5 );
		iadbrix.setActivity_group( activity_group );
		iadbrix.setActivity( activity );
		iadbrix.setActivity_param( activity_param );
		iadbrix.setOrder_id( order_id );
		iadbrix.setProduct_id( product_id );
		iadbrix.setProduct_name( product_name );
		iadbrix.setPrice( price );
		iadbrix.setQuantity( quantity );
		iadbrix.setSales( sales );
		iadbrix.setCategory( category );
		iadbrix.setCurrency( currency );
		iadbrix.setEvent_detail( event_detail );

		String click_id = cb_param1;
		String pub_id = cb_param2;
		Publisher publisher = publisherService.getPublisherByCode( pub_id );
		if( publisher == null ) {
			model.addAttribute("error_message", "Invalid publisher : " + pub_id );
			return "postback_error";
		}
		
		int newseq = adbrixService.setAdbrix( iadbrix );
		if( newseq == 0 ) {
			model.addAttribute("error_message", "Internal Error : Insert Error" );
			return "postback_error";
		}
		
		Clicklog sclicklog = new Clicklog();
		//sclicklog.setClick_id( click_id );
		sclicklog.setPub_id( pub_id );
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
		
		String postback_url = publisher.getPostback_url();
		if( "".equals( postback_url ) != true ) {
			postback_url = postback_url.replace( "{click_id}", click_id );
			postback_url = postback_url.replace( "{sub_pub_id}", cb_param3 );
			postback_url = postback_url.replace( "{sub_param1}", clicklog.getSub_param1() );
			postback_url = postback_url.replace( "{sub_param2}", clicklog.getSub_param2() );
			postback_url = postback_url.replace( "{sub_param3}", clicklog.getSub_param3() );
			postback_url = postback_url.replace( "{sub_param4}", clicklog.getSub_param4() );
			
			postback_url = postback_url.replace( "{click_time}", event_time );
			postback_url = postback_url.replace( "{install_time}", first_install_time );
			postback_url = postback_url.replace( "{ADID}", gaid );
			postback_url = postback_url.replace( "{IDFA}", ifa );
			postback_url = postback_url.replace( "{ip}", conversion_ip );
			postback_url = postback_url.replace( "{platform}", platform );
			postback_url = postback_url.replace( "{os_ver}", os_ver );
			postback_url = postback_url.replace( "{carrier}", carrier );
			postback_url = postback_url.replace( "{model}", p_model );
			postback_url = postback_url.replace( "{country}", country );
			postback_url = postback_url.replace( "{language}", language );
			postback_url = postback_url.replace( "{app_id}", package_name );
			postback_url = postback_url.replace( "{event_type}", event_type_code );
			postback_url = postback_url.replace( "{event_purchase}", sales );
			requestUrl( postback_url );
		}

		return "postback_adbrix";
	}

	@RequestMapping(value = { "/inappevent" }, method=RequestMethod.GET)
	public String inapevent( HttpSession session, Model model, 
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value="appkey", defaultValue="" ) String appkey,
			@RequestParam(value="package_name", defaultValue="" ) String package_name,
			@RequestParam(value="gaid", defaultValue="" ) String gaid,
			@RequestParam(value="ifa", defaultValue="" ) String ifa,
			@RequestParam(value="ifv", defaultValue="" ) String ifv,
			@RequestParam(value="model", defaultValue="" ) String p_model,
			@RequestParam(value="network", defaultValue="" ) String network,
			@RequestParam(value="os_ver", defaultValue="" ) String os_ver,
			@RequestParam(value="sdk_version", defaultValue="" ) String sdk_version,
			@RequestParam(value="platform", defaultValue="" ) String platform,
			@RequestParam(value="country", defaultValue="" ) String country,
			@RequestParam(value="language", defaultValue="" ) String language,
			@RequestParam(value="width", defaultValue="" ) String width,
			@RequestParam(value="height", defaultValue="" ) String height,
			@RequestParam(value="carrier", defaultValue="" ) String carrier,
			@RequestParam(value="first_install_time", defaultValue="" ) String first_install_time,
			@RequestParam(value="event_type_code", defaultValue="" ) String event_type_code,
			@RequestParam(value="conversion_ip", defaultValue="" ) String conversion_ip,
			@RequestParam(value="event_time", defaultValue="" ) String event_time,
			@RequestParam(value="session_id", defaultValue="" ) String session_id,
			@RequestParam(value="cb_param1", defaultValue="" ) String cb_param1,
			@RequestParam(value="cb_param2", defaultValue="" ) String cb_param2,
			@RequestParam(value="cb_param3", defaultValue="" ) String cb_param3,
			@RequestParam(value="cb_param4", defaultValue="" ) String cb_param4,
			@RequestParam(value="cb_param5", defaultValue="" ) String cb_param5,
			@RequestParam(value="activity_group", defaultValue="" ) String activity_group,
			@RequestParam(value="activity", defaultValue="" ) String activity,
			@RequestParam(value="activity_param", defaultValue="" ) String activity_param,
			@RequestParam(value="order_id", defaultValue="" ) String order_id,
			@RequestParam(value="product_id", defaultValue="" ) String product_id,
			@RequestParam(value="product_name", defaultValue="" ) String product_name,
			@RequestParam(value="price", defaultValue="" ) String price,
			@RequestParam(value="quantity", defaultValue="" ) String quantity,
			@RequestParam(value="sales", defaultValue="" ) String sales,
			@RequestParam(value="category", defaultValue="" ) String category,
			@RequestParam(value="currency", defaultValue="" ) String currency,
			@RequestParam(value="event_detail", defaultValue="" ) String event_detail,
			@RequestParam(value="last_cb_param1", defaultValue="" ) String last_cb_param1,
			@RequestParam(value="last_cb_param2", defaultValue="" ) String last_cb_param2,
			@RequestParam(value="last_cb_param3", defaultValue="" ) String last_cb_param3,
			@RequestParam(value="last_cb_param4", defaultValue="" ) String last_cb_param4,
			@RequestParam(value="last_cb_param5", defaultValue="" ) String last_cb_param5
			) {
		
		if( "".equals( appkey ) == true || "{appkey}".equals( appkey ) == true ) {
			model.addAttribute("error_message", "Invalid parameter : appkey" );
			return "postback_error";
		}

		if( "".equals( cb_param1 ) == true ) cb_param1 = last_cb_param1;
		if( "".equals( cb_param2 ) == true ) cb_param1 = last_cb_param2;
		if( "".equals( cb_param3 ) == true ) cb_param1 = last_cb_param3;
		if( "".equals( cb_param4 ) == true ) cb_param1 = last_cb_param4;
		if( "".equals( cb_param5 ) == true ) cb_param1 = last_cb_param5;
		
		// gaid != "" 이고 cb_param1, cb_param2, cb_param3 == "" 이면  이전 데이타가지고 처리.
		if( "".equals( gaid ) == false && "".equals( cb_param1 ) == true && "".equals( cb_param2 ) == true && "".equals( cb_param3 ) == true ) {
			Adbrix adbrix = new Adbrix();
			adbrix.setGaid( gaid );
			adbrix.setStart(0);
			adbrix.setCount(1);
			List<Adbrix> adbrixList = adbrixService.getAdbrixList( adbrix );
			if( adbrixList.size() > 0 ) {
				Adbrix tadbrix = adbrixList.get(0);
				cb_param1 = tadbrix.getCb_param1();
				cb_param2 = tadbrix.getCb_param2();
				cb_param3 = tadbrix.getCb_param3();
				cb_param4 = tadbrix.getCb_param4();
				cb_param5 = tadbrix.getCb_param5();
			}
		}
		
		Adbrix iadbrix = new Adbrix();
		iadbrix.setAppkey( appkey );
		iadbrix.setPackage_name( package_name );
		iadbrix.setGaid( gaid );
		iadbrix.setIfa( ifa );
		iadbrix.setIfv( ifv );
		iadbrix.setModel( p_model );
		iadbrix.setNetwork( network );
		iadbrix.setOs_ver( os_ver );
		iadbrix.setSdk_version( sdk_version );
		iadbrix.setPlatform( platform );
		iadbrix.setCountry( country );
		iadbrix.setLanguage( language );
		iadbrix.setWidth( width );
		iadbrix.setHeight( height );
		iadbrix.setCarrier( carrier );
		iadbrix.setFirst_install_time( first_install_time );
		iadbrix.setEvent_type_code( event_type_code );
		iadbrix.setConversion_ip( conversion_ip );
		iadbrix.setEvent_time( event_time );
		iadbrix.setSession_id( session_id );
		iadbrix.setCb_param1( cb_param1 );
		iadbrix.setCb_param2( cb_param2 );
		iadbrix.setCb_param3( cb_param3 );
		iadbrix.setCb_param4( cb_param4 );
		iadbrix.setCb_param5( cb_param5 );
		iadbrix.setActivity_group( activity_group );
		iadbrix.setActivity( activity );
		iadbrix.setActivity_param( activity_param );
		iadbrix.setOrder_id( order_id );
		iadbrix.setProduct_id( product_id );
		iadbrix.setProduct_name( product_name );
		iadbrix.setPrice( price );
		iadbrix.setQuantity( quantity );
		iadbrix.setSales( sales );
		iadbrix.setCategory( category );
		iadbrix.setCurrency( currency );
		iadbrix.setEvent_detail( event_detail );

		String click_id = cb_param1;
		String pub_id = cb_param2;
		Publisher publisher = publisherService.getPublisherByCode( pub_id );
		if( publisher == null ) {
			model.addAttribute("error_message", "Invalid publisher : " + pub_id );
			return "postback_error";
		}
		
		int newseq = adbrixService.setAdbrix( iadbrix );
		if( newseq == 0 ) {
			model.addAttribute("error_message", "Internal Error : Insert Error" );
			return "postback_error";
		}
		
		Clicklog sclicklog = new Clicklog();
		//sclicklog.setClick_id( click_id );
		sclicklog.setSearchtype( "click_id" );
		sclicklog.setSearchkeyword( click_id );
		sclicklog.setPub_id( pub_id );
		sclicklog.setStart(0);
		sclicklog.setCount(1);
		List<Clicklog> clicklogList = clicklogService.getClicklogList( sclicklog );
		if( clicklogList.size() == 0 ) {
			model.addAttribute("error_message", "Invalid click_id : " + click_id );
			return "postback_error";
		}
		
		Clicklog clicklog = clicklogList.get(0);
		
		String postback_url = publisher.getEvent_url();
		if( "".equals( postback_url ) != true && "".equals(activity ) != true ) {
			postback_url = postback_url.replace( "{click_id}", click_id );
			postback_url = postback_url.replace( "{sub_pub_id}", cb_param3 );
			postback_url = postback_url.replace( "{sub_param1}", clicklog.getSub_param1() );
			postback_url = postback_url.replace( "{sub_param2}", clicklog.getSub_param2() );
			postback_url = postback_url.replace( "{sub_param3}", clicklog.getSub_param3() );
			postback_url = postback_url.replace( "{sub_param4}", clicklog.getSub_param4() );
			
			postback_url = postback_url.replace( "{click_time}", event_time );
			postback_url = postback_url.replace( "{install_time}", first_install_time );
			postback_url = postback_url.replace( "{ADID}", gaid );
			postback_url = postback_url.replace( "{IDFA}", ifa );
			postback_url = postback_url.replace( "{ip}", conversion_ip );
			postback_url = postback_url.replace( "{platform}", platform );
			postback_url = postback_url.replace( "{os_ver}", os_ver );
			postback_url = postback_url.replace( "{carrier}", carrier );
			postback_url = postback_url.replace( "{model}", p_model );
			postback_url = postback_url.replace( "{country}", country );
			postback_url = postback_url.replace( "{language}", language );
			postback_url = postback_url.replace( "{app_id}", package_name );
			
			postback_url = postback_url.replace( "{event_type}", event_type_code );
			postback_url = postback_url.replace( "{event_purchase}", sales );
			postback_url = postback_url.replace( "{event_name}", activity );
			postback_url = postback_url.replace( "{event_value}", activity_param );
			postback_url = postback_url.replace( "{event_time}", event_time );
			postback_url = postback_url.replace( "{event_stamp}", event_time );
			
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
