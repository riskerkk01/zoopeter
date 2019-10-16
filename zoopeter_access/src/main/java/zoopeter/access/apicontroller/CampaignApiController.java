package zoopeter.access.apicontroller;

import java.util.ArrayList;

//import java.util.Iterator;
import java.util.List;

import java.io.UnsupportedEncodingException;
//import java.text.DateFormat;
//import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.ConfigurableWebApplicationContext;

import zoopeter.module.domain.*;
import zoopeter.module.services.*;


@RestController
@RequestMapping("/api/campaign")
public class CampaignApiController {
	
	private static final Logger logger = LoggerFactory.getLogger(CampaignApiController.class);
	
	@Autowired 	ConfigurableWebApplicationContext subContext;
	@Autowired	private CampaignService campaignService;
	@Autowired	private PublisherService publisherService;
	@Autowired	private ClicklogstatService clicklogstatService;
	
	@Autowired	private AdbrixService adbrixService;
	@Autowired	private AdbrixreService adbrixreService;
	@Autowired	private AppsflyerService appsflyerService;
	
	@RequestMapping(value = { "/listdetail" }, method=RequestMethod.POST) 
	public ResultPageDomain<Campaign> listdetail(
			@RequestBody Campaign scampaign,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		List<Campaign> campaignList = new ArrayList<Campaign>();
		
		Admin admin = (Admin) session.getAttribute( "SESSION_USERAUTH");
		if( admin == null ) {
			return new ResultPageDomain<Campaign>( 0, 1, 0, campaignList);
		}
		
		int publisherid = admin.getPublisherid();
		if( publisherid == 0 ) {
			return new ResultPageDomain<Campaign>( 0, 1, 0, campaignList);
		}
		
		Publisher publisher = publisherService.getPublisher( publisherid );
		String publisher_code = publisher.getCode();
		if( "".equals( publisher_code ) == true ) {
			return new ResultPageDomain<Campaign>( 0, 1, 0, campaignList);
		}
		logger.info( "page:" + scampaign.getPage() );
		//logger.info( "campaignid:" + scampaign.getSeq() );
		//logger.info( "searchkeyword:" + scampaign.getSearchkeyword() );
		
		// get ALL
		scampaign.setStart( 0 );
		scampaign.setCount( 0 );
		List<Campaign> tcampaignList = new ArrayList<Campaign>();
		
		tcampaignList = campaignService.getCampaignList( scampaign );
		for( int i=0; i<tcampaignList.size(); i++ ) {
			Campaign t = tcampaignList.get(i);
			String pub = t.getPublisherids();
			if( pub == null ) continue;
			if( "".equals( pub ) == true ) continue; 
			
			String[] publishers = pub.split(",");
			for( int ii=0; ii<publishers.length; ii++ ) {
				if( publisher_code.equals( publishers[ii] ) == true ) {
					
					int clickcnt = GetClickcnt( t.getCampaignid(), publisher_code );
					t.setClickcnt( clickcnt );
					
					String trackercode = t.getTrackercode();
					List<Adbrix> adbrixList = null;
					List<Adbrixre> adbrixreList = null;
					List<Appsflyer> appsflyerList = null;
					
					int installcnt = 0;
					int revenue = 0;
					
					if( "adbrix".equals( trackercode ) == true ) {
						Adbrix adbrix = new Adbrix();
						adbrix.setCb_param4( Integer.toString( t.getCampaignid() ));
						adbrix.setCb_param2( publisher_code );
						adbrixList = adbrixService.getAdbrixListForDashboard(adbrix);
						for( int iii=0; iii<adbrixList.size(); iii++ ) {
							Adbrix tmp = adbrixList.get(iii);
							if( "1".equals( tmp.getEvent_type_code() ) == true ) {
								installcnt += tmp.getCount();
							}
							if( "4".equals( tmp.getEvent_type_code() ) == true ) {
								if( "".equals( tmp.getSales() ) == false ) {
									revenue += Integer.parseInt( tmp.getSales() );
								}
							}
						}
					}
					if( "adbrixre".equals( trackercode ) == true ) {
						Adbrixre adbrixre = new Adbrixre();
						adbrixre.setCb_param2( publisher_code );
						adbrixre.setCb_param4(Integer.toString( t.getCampaignid() ));
						adbrixreList = adbrixreService.getAdbrixreListForDashboard(adbrixre);
						for( int iii=0; iii<adbrixreList.size(); iii++ ) {
							Adbrixre tmp = adbrixreList.get(iii);
							if( "1".equals( tmp.getEvent_type_code() ) == true ) {
								installcnt += tmp.getCount();
							}
							if( "4".equals( tmp.getEvent_type_code() ) == true ) {
								if( "".equals( tmp.getSales() ) == false ) {
									revenue += Integer.parseInt( tmp.getSales() );
								}
							}
						}
					}

					if( "appsflyer".equals( trackercode ) == true ) {
						Appsflyer appsflyer = new Appsflyer();
						appsflyer.setCampaign( t.getCode() );
						appsflyer.setPublisher_id( publisher_code );
						appsflyerList = appsflyerService.getAppsflyerListForDashboard(appsflyer);
						for( int iii=0; iii<appsflyerList.size(); iii++ ) {
							Appsflyer tmp = appsflyerList.get(iii);
							if( "af_app_install".equals( tmp.getEvent_name() ) == true ) {
								installcnt += tmp.getCount();
							}
						}
					}
					
					t.setInstallcnt( installcnt );
					t.setRevenue( revenue );
					campaignList.add( t );
				}
			}
		}
		
		int campaignCount = campaignList.size();
		scampaign.setSize( campaignCount );
		
		return new ResultPageDomain<Campaign>( scampaign.getPage(), scampaign.getSize(), campaignCount, campaignList);
	}
	
	private int GetClickcnt( int camp_no, String pub_id ) {
		int clickcnt = 0;
		
		Clicklogstat clicklogstat = new Clicklogstat();
		clicklogstat.setCamp_no( camp_no );
		clicklogstat.setPub_id( pub_id );
		
		List<Clicklogstat> clicklogList = clicklogstatService.getClicklogstatList(clicklogstat);
		for( int i=0; i<clicklogList.size(); i++ ) {
			clickcnt += clicklogList.get(i).getCnt();
		}
		
		return clickcnt;
	}
	@RequestMapping(value = { "/list" }, method=RequestMethod.POST) 
	public ResultPageDomain<Campaign> list(
			@RequestBody Campaign scampaign,
			HttpSession session, Model model
			) throws UnsupportedEncodingException {
		
		List<Campaign> campaignList = new ArrayList<Campaign>();
		
		Admin admin = (Admin) session.getAttribute( "SESSION_USERAUTH");
		if( admin == null ) {
			return new ResultPageDomain<Campaign>( 0, 1, 0, campaignList);
		}
		
		int publisherid = admin.getPublisherid();
		if( publisherid == 0 ) {
			return new ResultPageDomain<Campaign>( 0, 1, 0, campaignList);
		}
		
		Publisher publisher = publisherService.getPublisher( publisherid );
		String publisher_code = publisher.getCode();
		if( "".equals( publisher_code ) == true ) {
			return new ResultPageDomain<Campaign>( 0, 1, 0, campaignList);
		}
		logger.info( "page:" + scampaign.getPage() );
		//logger.info( "campaignid:" + scampaign.getSeq() );
		//logger.info( "searchkeyword:" + scampaign.getSearchkeyword() );
		
		// get ALL
		scampaign.setStart( 0 );
		scampaign.setCount( 0 );
		List<Campaign> tcampaignList = new ArrayList<Campaign>();
		
		tcampaignList = campaignService.getCampaignList( scampaign );
		for( int i=0; i<tcampaignList.size(); i++ ) {
			Campaign t = tcampaignList.get(i);
			String pub = t.getPublisherids();
			if( pub == null ) continue;
			if( "".equals( pub ) == true ) continue; 
			
			String[] publishers = pub.split(",");
			for( int ii=0; ii<publishers.length; ii++ ) {
				if( publisher_code.equals( publishers[ii] ) == true ) {
					campaignList.add( t );
				}
			}
		}
		
		int campaignCount = campaignList.size();
		scampaign.setSize( campaignCount );
		
		return new ResultPageDomain<Campaign>( scampaign.getPage(), scampaign.getSize(), campaignCount, campaignList);
	}	
	
	
	@RequestMapping(value = "/{campaignid}", method=RequestMethod.GET ) 
	public Campaign getinfo(@PathVariable int campaignid, Model model, 
			HttpServletResponse response, HttpServletRequest request ) {

		Campaign tmp = campaignService.getCampaign( campaignid );
		if( tmp == null ) {
			tmp = new Campaign();
			return tmp;
		}
		return tmp;
	}
}
