package zoopeter.log.controller;

//import org.apache.log4j.Logger;
import org.slf4j.Logger;


import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import zoopeter.module.domain.*;
import zoopeter.module.services.*;

import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class ClickController {
	protected Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired private AdminService adminService;
	@Autowired private CampaignService campaignService;
	@Autowired private ClicklogService clicklogService;
	
	@RequestMapping("/click")
	public String click( HttpSession session, Model model, 
			HttpServletResponse response, HttpServletRequest request,
			@RequestParam(value="camp_id", defaultValue="" ) String p_camp_id,
			@RequestParam(value="click_id", defaultValue="" ) String p_click_id,
			@RequestParam(value="pub_id", defaultValue="" ) String p_pub_id,
			@RequestParam(value="sub_pub_id", defaultValue="" ) String p_sub_pub_id,
			@RequestParam(value="sub_param1", defaultValue="" ) String p_sub_param1,
			@RequestParam(value="sub_param2", defaultValue="" ) String p_sub_param2,
			@RequestParam(value="sub_param3", defaultValue="" ) String p_sub_param3,
			@RequestParam(value="sub_param4", defaultValue="" ) String p_sub_param4,
			@RequestParam(value="IDFA", defaultValue="" ) String p_idfa,
			@RequestParam(value="ADID", defaultValue="" ) String p_adid,
			@RequestParam(value="pubsa_", defaultValue="" ) String p_pubsa
			) {
		
		if( "".equals( p_pubsa ) == false && "".equals( p_sub_pub_id ) == true ) {
			p_sub_pub_id = p_pubsa;
		}

		if( "{camp_id}".equals( p_camp_id ) == true ) p_camp_id = "";
		if( "{click_id}".equals( p_click_id ) == true ) p_click_id = "";
		if( "{pub_id}".equals( p_pub_id ) == true ) p_pub_id = "";
		if( "{sub_pub_id}".equals( p_sub_pub_id ) == true ) p_sub_pub_id = "";
		if( "{sub_param1}".equals( p_sub_param1 ) == true ) p_sub_param1 = "";
		if( "{sub_param2}".equals( p_sub_param2 ) == true ) p_sub_param2 = "";
		if( "{sub_param3}".equals( p_sub_param3 ) == true ) p_sub_param3 = "";
		if( "{sub_param4}".equals( p_sub_param4 ) == true ) p_sub_param4 = "";
		if( "{IDFA}".equals( p_idfa ) == true ) p_idfa = "";
		if( "{ADID}".equals( p_adid ) == true ) p_adid = "";
		
		if( "".equals( p_camp_id ) == true ) {
			model.addAttribute("error_message", "Require camp_id" );
			return "click_guide";
		}

		if( "".equals( p_pub_id ) == true ) {
			model.addAttribute("error_message", "Require pub_id" );
			return "click_guide";
		}

		if( "".equals( p_click_id ) == true ) {
			model.addAttribute("error_message", "Require click_id or replace {click_id}" );
			return "click_guide";
		}
		
		Campaign campaign = campaignService.getCampaignByCode( p_camp_id );
		if( campaign == null ) {
			model.addAttribute("error_message", "Invalid camp_id : " + p_camp_id );
			return "click_guide";
		}

		String launchingurl = campaign.getLaunchingurl();
		String trackercode = campaign.getTrackercode();
		if( "".equals( launchingurl ) == true ) {
			model.addAttribute("error_message", "Not set launching URL" );
			return "click_guide";
		}
		
		if( "".equals( trackercode ) == true ) {
			model.addAttribute("error_message", "Not set tracker" );
			return "click_guide";
		}
		String startdate = campaign.getStartdate();
		String enddate = campaign.getEnddate();
		Calendar calS = Calendar.getInstance();
		Calendar calE = Calendar.getInstance();

		calS.set(Integer.parseInt(startdate.substring(0, 4)), Integer.parseInt(startdate.substring(5, 7)) - 1,
				Integer.parseInt(startdate.substring(8, 10)));
		calE.set(Integer.parseInt(enddate.substring(0, 4)), Integer.parseInt(enddate.substring(5, 7)) - 1,
				Integer.parseInt(enddate.substring(8, 10)));
		
		Calendar now = Calendar.getInstance( );
		if( calS.getTimeInMillis() > now.getTimeInMillis() ) {
			model.addAttribute("error_message", "The campaign is not service." );
			return "click_guide";
		}
		if( calE.getTimeInMillis() < now.getTimeInMillis() ) {
			model.addAttribute("error_message", "The campaign is expired" );
			return "click_guide";
		}
		
		String publisherids = campaign.getPublisherids();
		if( "".equals( publisherids) == true || publisherids == null ) {
			model.addAttribute("error_message", "The publisher '"+p_pub_id+"' is not allowed campaign" );
			return "click_guide";
		}
		
		String[] publishers = publisherids.split(",");
		if( publishers.length == 0 ) {
			model.addAttribute("error_message", "The publisher '"+p_pub_id+"' is not allowed campaign" );
			return "click_guide";
		}
		
		boolean check = false;
		for( int i=0; i<publishers.length; i++ ) {
			String pub_id = publishers[i];
			if( pub_id.equals( p_pub_id ) == true ) check = true;
		}
		if( check == false ) {
			model.addAttribute("error_message", "The publisher '"+p_pub_id+"' is not allowed campaign" );
			return "click_guide";
		}
		
		Clicklog clicklog = new Clicklog();
		clicklog.setCamp_id( p_camp_id );
		clicklog.setCamp_no( Integer.toString( campaign.getCampaignid() ) );
		clicklog.setClick_id( p_click_id );
		clicklog.setPub_id( p_pub_id );
		clicklog.setSub_pub_id( p_sub_pub_id );
		clicklog.setSub_param1( p_sub_param1 );
		clicklog.setSub_param2( p_sub_param2 );
		clicklog.setSub_param3( p_sub_param3 );
		clicklog.setSub_param4( p_sub_param4 );
		clicklog.setIdfa( p_idfa );
		clicklog.setAdid( p_adid );
		
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getHeader("Proxy-Client-IP");
        if (ip == null) ip = request.getRemoteAddr();
        clicklog.setIp( ip );
        
        int new_seq = clicklogService.setClicklog( clicklog );
		if( new_seq == 0 ) {
			model.addAttribute("error_message", "Intenal Error" );
			return "click_guide";
		}
		
		String device_id = "";
		if( "".equals( p_idfa ) == false ) device_id = p_idfa;
		if( "".equals( p_adid ) == false ) device_id = p_adid;		
		
		if( "adbrix".equals( trackercode ) == true ) {
			String sub_referal = "";
			if( "".equals( p_sub_pub_id ) == false ) sub_referal = p_pub_id + "@" + p_sub_pub_id;
			
			launchingurl = launchingurl.replace( "{cb_param1}", p_click_id );
			launchingurl = launchingurl.replace( "{cb_param2}", p_pub_id );
			launchingurl = launchingurl.replace( "{cb_param3}", p_sub_pub_id );
			launchingurl = launchingurl.replace( "{cb_param4}", Integer.toString(campaign.getCampaignid() ) );
			launchingurl = launchingurl.replace( "{cb_param5}", p_camp_id );
			launchingurl = launchingurl.replace( "{device_id}", device_id );
			launchingurl = launchingurl.replace( "{sub_referral}", sub_referal );
			//System.out.println( "1 trackercode : " + trackercode + " , launching url : " + launchingurl );
			
			if( launchingurl.contains( "cb_param1" ) == false ) {
				String tmp = "";
				tmp += "&cb_param1="+p_click_id;
				tmp += "&cb_param2="+p_pub_id;
				tmp += "&cb_param3="+p_sub_pub_id;
				tmp += "&cb_param4="+Integer.toString(campaign.getCampaignid() );
				tmp += "&cb_param5="+p_camp_id;
				tmp += "&agreement_key="+device_id;
				tmp += "&sub_referral="+sub_referal;
				launchingurl += tmp;
			}
		}
		if( "adbrixre".equals( trackercode ) == true ) {
			launchingurl = launchingurl.replace( "{cb_1}", p_click_id );
			launchingurl = launchingurl.replace( "{cb_2}", p_pub_id );
			launchingurl = launchingurl.replace( "{cb_3}", p_sub_pub_id );
			launchingurl = launchingurl.replace( "{cb_4}", Integer.toString(campaign.getCampaignid() ) );
			launchingurl = launchingurl.replace( "{cb_5}", p_camp_id );
			launchingurl = launchingurl.replace( "{m_adid}", device_id );
			launchingurl = launchingurl.replace( "{m_publisher}", p_pub_id );
			launchingurl = launchingurl.replace( "{m_sub_publisher}", p_sub_pub_id );

			//System.out.println( "1 trackercode : " + trackercode + " , launching url : " + launchingurl );
			
			if( launchingurl.contains( "cb_1" ) == false ) {
				String tmp = "";
				tmp += "&cb_1="+p_click_id;
				tmp += "&cb_2="+p_pub_id;
				tmp += "&cb_3="+p_sub_pub_id;
				tmp += "&cb_4="+Integer.toString(campaign.getCampaignid() );
				tmp += "&cb_5="+p_camp_id;
				tmp += "&m_adid="+device_id;
				tmp += "&m_publisher="+p_pub_id;
				tmp += "&m_sub_publisher="+p_sub_pub_id;
				if( launchingurl.contains( "?" ) == false ) {
					launchingurl = launchingurl + "?x=x";
				}
				launchingurl += tmp;
			}
		}
		if( "appsflyer".equals( trackercode ) == true ) {
			launchingurl = launchingurl.replace( "{clickid}", p_click_id );
			launchingurl = launchingurl.replace( "{campaign}", p_camp_id );
			launchingurl = launchingurl.replace( "{af_siteid}", p_pub_id );
			launchingurl = launchingurl.replace( "{af_sub_siteid}", p_sub_pub_id );
			launchingurl = launchingurl.replace( "{adversting_id}", device_id );
			launchingurl = launchingurl.replace( "{af_ad_type}", "banner" );
			launchingurl = launchingurl.replace( "{is_incentivized}", "false" );
			launchingurl = launchingurl.replace( "{is_s2s}", "" );
			launchingurl = launchingurl.replace( "{idfa}", p_idfa );
			//System.out.println( "1 trackercode : " + trackercode + " , launching url : " + launchingurl );
		}
		if( "branch".equals( trackercode ) == true ) {
			launchingurl = launchingurl.replace( "{click_id}", p_click_id );
			launchingurl = launchingurl.replace( "{aaid}", p_adid );
			launchingurl = launchingurl.replace( "{idfa}", p_idfa );
			launchingurl = launchingurl.replace( "{channel}", p_pub_id );
			launchingurl = launchingurl.replace( "{secondary_publisher}", p_sub_pub_id );
			launchingurl = launchingurl.replace( "{campaign_id}", p_camp_id );
			launchingurl = launchingurl.replace( "{campaign}", Integer.toString(campaign.getCampaignid() ) );
			//System.out.println( "1 trackercode : " + trackercode + " , launching url : " + launchingurl );
		}		
		System.out.println( "l trackercode : " + trackercode + " , launching url : " + launchingurl );
		
		/*
			Date date = new Date();		
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG);		
			String formattedDate = dateFormat.format(date);		
			String str = formattedDate;		
			model.addAttribute("serverTime", str);		
		*/
		
		return "redirect:" + launchingurl;
	}
}
