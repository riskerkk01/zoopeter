package zoopeter.admin.apicontroller;

import java.util.ArrayList;

import java.util.Calendar;
import java.util.Collections;
//import java.util.Iterator;
import java.util.List;

import java.io.UnsupportedEncodingException;
//import java.text.DateFormat;
//import java.util.Date;
import java.text.SimpleDateFormat;

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
@RequestMapping("/api/dashboard")
public class DashboardApiController {

	private static final Logger logger = LoggerFactory.getLogger(DashboardApiController.class);

	@Autowired
	ConfigurableWebApplicationContext subContext;
	@Autowired
	private ClicklogService clicklogService;
	@Autowired
	private ClicklogstatService clicklogstatService;
	@Autowired
	private CampaignService campaignService;
	@Autowired
	private AdbrixService adbrixService;
	@Autowired
	private AdbrixreService adbrixreService;
	@Autowired
	private AppsflyerService appsflyerService;
	
	@RequestMapping(value = "/test", method = RequestMethod.POST)
	public @ResponseBody String test(@RequestBody Clicklog sclicklog) {
		return "test";
	}

	@RequestMapping(value = { "/list" }, method = RequestMethod.POST)
	public ResultPageDomain<Dashboard> list(@RequestBody Dashboard sdashboard, HttpSession session, Model model)
			throws UnsupportedEncodingException {

		// logger.info( "seq:" + sclicklog.getSeq() );
		// logger.info( "searchkeyword:" + sclicklog.getSearchkeyword() );
		List<Dashboard> dashboardList = new ArrayList<Dashboard>();
		
		int camp_no = sdashboard.getCamp_no();
		if( camp_no == 0 ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		String startdate = sdashboard.getStartdate();
		String enddate = sdashboard.getEnddate();
		//System.out.println(startdate);
		//System.out.println(enddate);
		
		Campaign qCampaign = campaignService.getCampaign( sdashboard.getCamp_no() );
		if( qCampaign == null ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		
		String publisherids = qCampaign.getPublisherids();
		if( "".equals( publisherids) == true || publisherids == null ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		
		String[] publishers = publisherids.split(",");
		if( publishers.length == 0 ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		
		String trackercode = qCampaign.getTrackercode();
		if( "".equals( trackercode) == true || trackercode == null ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		
		Clicklogstat clicklogstat = new Clicklogstat();
		clicklogstat.setCamp_no( camp_no );
		clicklogstat.setStartdate( startdate );
		clicklogstat.setEnddate( enddate );
		List<Clicklogstat> clicklogList = clicklogstatService.getClicklogstatList(clicklogstat);
	
		
		List<Adbrix> adbrixList = null;
		List<Adbrixre> adbrixreList = null;
		List<Appsflyer> appsflyerList = null;
		
		if( "adbrix".equals( trackercode ) == true ) {
			Adbrix adbrix = new Adbrix();
			adbrix.setCb_param4(Integer.toString( camp_no ));
			adbrix.setStartdate( startdate );
			adbrix.setEnddate( enddate + " 23:59:59" );
			adbrixList = adbrixService.getAdbrixListForDashboard(adbrix);
		}
		if( "adbrixre".equals( trackercode ) == true ) {
			Adbrixre adbrixre = new Adbrixre();
			adbrixre.setCb_param4(Integer.toString( camp_no ));
			adbrixre.setStartdate( startdate );
			adbrixre.setEnddate( enddate + " 23:59:59" );
			adbrixreList = adbrixreService.getAdbrixreListForDashboard(adbrixre);
		}

		if( "appsflyer".equals( trackercode ) == true ) {
			Appsflyer appsflyer = new Appsflyer();
			appsflyer.setCampaign( qCampaign.getCode() );
			appsflyer.setStartdate( startdate );
			appsflyer.setEnddate( enddate + " 23:59:59" );
			appsflyerList = appsflyerService.getAppsflyerListForDashboard(appsflyer);
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calS = Calendar.getInstance();
		Calendar calE = Calendar.getInstance();

		calS.set(Integer.parseInt(startdate.substring(0, 4)), Integer.parseInt(startdate.substring(5, 7)) - 1,
				Integer.parseInt(startdate.substring(8, 10)));
		calE.set(Integer.parseInt(enddate.substring(0, 4)), Integer.parseInt(enddate.substring(5, 7)) - 1,
				Integer.parseInt(enddate.substring(8, 10)));

		boolean addflag = false;
		
		while (calS.getTimeInMillis() <= calE.getTimeInMillis()) {
			String checkDate = dateFormat.format(calS.getTime());
			calS.add(Calendar.DATE, 1); 
			System.out.println("checkDate : " + checkDate + " clicklogstate : " + clicklogList.size() );
			
			List<Dashboard> tmp_dashboardList = new ArrayList<Dashboard>();
			for( int i=0; i<publishers.length; i++ ) {
				String pub_id = publishers[i];
				Dashboard iDashboard = new Dashboard();
				iDashboard.setRegtime( checkDate );
				iDashboard.setCamp_no(sdashboard.getCamp_no());
				iDashboard.setPub_id( pub_id );
				
				iDashboard.setSub_pub_id("");
				
				int installcnt = 0;
				int clickcnt = 0;
				int revenue = 0;
				double cvr = 0;
				for( int ii=0; ii<clicklogList.size(); ii++ ) {
					Clicklogstat tmp = clicklogList.get(ii);
					if( checkDate.equals( tmp.getRtime() ) == false ) continue; 
					if( pub_id.equals( tmp.getPub_id() ) == false ) continue;
					clickcnt += tmp.getCnt();
				}
				
				if( "adbrix".equals( trackercode ) == true ) {
					for (int ii = 0; ii < adbrixList.size(); ii++) {
						Adbrix tmp = adbrixList.get(ii);
						if( checkDate.equals( tmp.getRegtime() ) == false ) continue; 
						
						if( pub_id.equals( tmp.getCb_param2() ) == true ) {
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
				}
				if( "adbrixre".equals( trackercode ) == true ) {
					for (int ii = 0; ii < adbrixreList.size(); ii++) {
						Adbrixre tmp = adbrixreList.get(ii);
						if( checkDate.equals( tmp.getRegtime() ) == false ) continue; 
						
						if( pub_id.equals( tmp.getCb_param2() ) == true ) {
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
				}
				if( "appsflyer".equals( trackercode ) == true ) {
					for (int ii = 0; ii < appsflyerList.size(); ii++) {
						Appsflyer tmp = appsflyerList.get(ii);
						if( checkDate.equals( tmp.getRegtime() ) == false ) continue; 
						
						if( pub_id.equals( tmp.getPublisher_id() ) == true ) {
							if( "af_app_install".equals( tmp.getEvent_name() ) == true ) {
								installcnt += tmp.getCount();
							}
						}
					}
				}				
				
				if( clickcnt > 0 ) {
					cvr = (double) (Math.round( ( installcnt * 100.0 / clickcnt ) * 100) / 100.0);
				}
				iDashboard.setInstallcnt( installcnt );
				iDashboard.setClickcnt( clickcnt );
				iDashboard.setRevenue( revenue );
				iDashboard.setCvr( cvr );
				
				//System.out.println( "install : " + installcnt + "  clickcnt : " + clickcnt + " cvr : " + cvr );
				/*
				if( iDashboard.getInstallcnt() ==0 && iDashboard.getClickcnt() == 0 && iDashboard.getRevenue() == 0 && addflag == false ) {
					continue;
				}
				addflag = true;
				*/
				
				tmp_dashboardList.add( iDashboard );
			}
			
			if( addflag == false ) {
				boolean tflag = false;
				for( int t=0; t<tmp_dashboardList.size(); t++ ) {
					Dashboard k = tmp_dashboardList.get(t);
					if( k.getInstallcnt() > 0 || k.getClickcnt() > 0 || k.getRevenue() > 0 ) {
						tflag = true;
						break;
					}
				}
				if( tflag == false ) continue;
			}
			
			addflag = true;
			for( int t=0; t<tmp_dashboardList.size(); t++ ) {
				dashboardList.add( tmp_dashboardList.get(t) );
			}
			
		}
		
		// clicklogList = clicklogService.getClicklogList( sclicklog );
		// int clicklogCount = clicklogService.countClicklog( sclicklog );

		return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
	}

	@RequestMapping(value = { "/listdetail" }, method = RequestMethod.POST)
	public ResultPageDomain<Dashboard> listdetail(@RequestBody Dashboard sdashboard, HttpSession session, Model model)
			throws UnsupportedEncodingException {

		// logger.info( "seq:" + sclicklog.getSeq() );
		// logger.info( "searchkeyword:" + sclicklog.getSearchkeyword() );
		
		List<Dashboard> dashboardList = new ArrayList<Dashboard>();
		
		int camp_no = sdashboard.getCamp_no();
		if( camp_no == 0 ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		String regtime = sdashboard.getRegtime();
		String pub_id = sdashboard.getPub_id();
		
		Campaign qCampaign = campaignService.getCampaign( sdashboard.getCamp_no() );
		if( qCampaign == null ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		
		String trackercode = qCampaign.getTrackercode();
		if( "".equals( trackercode) == true || trackercode == null ) {
			return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
		}
		
		Clicklogstat clicklogstat = new Clicklogstat();
		clicklogstat.setCamp_no( camp_no );
		clicklogstat.setPub_id( pub_id );
		clicklogstat.setRtime( regtime );
		System.out.println( "start clicklogstatlist");
		List<Clicklogstat> clicklogList = clicklogstatService.getClicklogstatList(clicklogstat);
		System.out.println( "end clicklogstatlist");
		
		List<Adbrix> adbrixList = null;
		List<Adbrixre> adbrixreList = null;
		List<Appsflyer> appsflyerList = null;
		
		if( "adbrix".equals( trackercode ) == true ) {
			Adbrix adbrix = new Adbrix();
			adbrix.setCb_param4(Integer.toString( camp_no ));
			adbrix.setRegtime( regtime );
			adbrix.setCb_param2( pub_id );
			adbrixList = adbrixService.getAdbrixListForDashboard(adbrix);
		}
		if( "adbrixre".equals( trackercode ) == true ) {
			Adbrixre adbrixre = new Adbrixre();
			adbrixre.setCb_param4(Integer.toString( camp_no ));
			adbrixre.setRegtime( regtime );
			adbrixre.setCb_param2( pub_id );
			adbrixreList = adbrixreService.getAdbrixreListForDashboard(adbrixre);
		}

		if( "appsflyer".equals( trackercode ) == true ) {
			Appsflyer appsflyer = new Appsflyer();
			appsflyer.setCampaign( qCampaign.getCode() );
			appsflyer.setPublisher_id( pub_id );
			appsflyer.setRegtime( regtime );
			appsflyerList = appsflyerService.getAppsflyerListForDashboard(appsflyer);
		}
		System.out.println( "end fordashboard");
		
		for( int ii=0; ii<clicklogList.size(); ii++ ) {
			Clicklogstat tmp = clicklogList.get(ii);
			
			Dashboard iDashboard = new Dashboard();
			iDashboard.setRegtime( regtime );
			iDashboard.setCamp_no( sdashboard.getCamp_no() );
			iDashboard.setPub_id( pub_id );
			iDashboard.setSub_pub_id( tmp.getSub_pub_id() );
			iDashboard.setClickcnt( tmp.getCnt() );
			
			dashboardList.add( iDashboard );
		}
		
		if( "adbrix".equals( trackercode ) == true ) {
			for (int ii = 0; ii < adbrixList.size(); ii++) {
				Adbrix tmp = adbrixList.get(ii);
				if( regtime.equals( tmp.getRegtime() ) == false ) continue;
				String sub_pub_id = tmp.getCb_param3();
				if( sub_pub_id == null ) sub_pub_id = "";
				
				boolean flag = false;
				for( int t=0; t<dashboardList.size(); t++ ) {
					Dashboard kk = dashboardList.get(t);
					if( sub_pub_id.equals( kk.getSub_pub_id() ) == true ) {
						if( "1".equals( tmp.getEvent_type_code() ) == true ) {
							dashboardList.get(t).setInstallcnt( tmp.getCount() );
						}
						if( "4".equals( tmp.getEvent_type_code() ) == true ) {
							if( "".equals( tmp.getSales() ) == false ) {
								dashboardList.get(t).setRevenue( Integer.parseInt( tmp.getSales() ) );
							}
						}
						flag = true;
						break;
					} 
				}
				if( flag == false ) {
					Dashboard iDashboard = new Dashboard();
					iDashboard.setRegtime( regtime );
					iDashboard.setCamp_no( sdashboard.getCamp_no() );
					iDashboard.setPub_id( pub_id );
					iDashboard.setSub_pub_id( tmp.getCb_param3() );
					iDashboard.setClickcnt( 0 );
					if( "1".equals( tmp.getEvent_type_code() ) == true ) {
						iDashboard.setInstallcnt( tmp.getCount() );
					}
					if( "4".equals( tmp.getEvent_type_code() ) == true ) {
						if( "".equals( tmp.getSales() ) == false ) {
							iDashboard.setRevenue( Integer.parseInt( tmp.getSales() ) );
						}
					}
					
					dashboardList.add( iDashboard );
					
				}
			}
		}
		if( "adbrixre".equals( trackercode ) == true ) {
			for (int ii = 0; ii < adbrixreList.size(); ii++) {
				Adbrixre tmp = adbrixreList.get(ii);
				if( regtime.equals( tmp.getRegtime() ) == false ) continue;
				String sub_pub_id = tmp.getCb_param3();
				if( sub_pub_id == null ) sub_pub_id = "";
				
				boolean flag = false;
				for( int t=0; t<dashboardList.size(); t++ ) {
					if( sub_pub_id.equals( dashboardList.get(t).getSub_pub_id() ) == true ) {
						if( "1".equals( tmp.getEvent_type_code() ) == true ) {
							dashboardList.get(t).setInstallcnt( tmp.getCount() );
						}
						if( "4".equals( tmp.getEvent_type_code() ) == true ) {
							if( "".equals( tmp.getSales() ) == false ) {
								dashboardList.get(t).setRevenue( Integer.parseInt( tmp.getSales() ) );
							}
						}
						flag = true;
						break;
					} 
				}
				
				if( flag == false) {
					Dashboard iDashboard = new Dashboard();
					iDashboard.setRegtime( regtime );
					iDashboard.setCamp_no( sdashboard.getCamp_no() );
					iDashboard.setPub_id( pub_id );
					iDashboard.setSub_pub_id( tmp.getCb_param3() );
					iDashboard.setClickcnt( 0 );
					if( "1".equals( tmp.getEvent_type_code() ) == true ) {
						iDashboard.setInstallcnt( tmp.getCount() );
					}
					if( "4".equals( tmp.getEvent_type_code() ) == true ) {
						if( "".equals( tmp.getSales() ) == false ) {
							iDashboard.setRevenue( Integer.parseInt( tmp.getSales() ) );
						}
					}
					
					dashboardList.add( iDashboard );
				}
			}
		}	
	
		if( "appsflyer".equals( trackercode ) == true ) {
			for (int ii = 0; ii < appsflyerList.size(); ii++) {
				Appsflyer tmp = appsflyerList.get(ii);
				if( regtime.equals( tmp.getRegtime() ) == false ) continue;
				String sub_pub_id = tmp.getPublisher_sub_id();
				if( sub_pub_id == null ) sub_pub_id = "";
				
				boolean flag = false;
				for( int t=0; t<dashboardList.size(); t++ ) {
					if( sub_pub_id.equals( dashboardList.get(t).getSub_pub_id() ) == true ) {
						if( "af_app_install".equals( tmp.getEvent_name() ) == true ) {
							dashboardList.get(t).setInstallcnt( tmp.getCount() );
						}
					} 
					flag = true;
					break;
				}
				if( flag == false ) {
					Dashboard iDashboard = new Dashboard();
					iDashboard.setRegtime( regtime );
					iDashboard.setCamp_no( sdashboard.getCamp_no() );
					iDashboard.setPub_id( pub_id );
					iDashboard.setSub_pub_id( tmp.getPublisher_sub_id() );
					iDashboard.setClickcnt( 0 );
					if( "af_app_install".equals( tmp.getEvent_name() ) == true ) {
						iDashboard.setInstallcnt( tmp.getCount() );
					}
					dashboardList.add( iDashboard );
				}
			}
		}			

		for( int t=0; t<dashboardList.size(); t++ ) {
			Dashboard k = dashboardList.get(t);
			if( k.getClickcnt() > 0 ) {
				double cvr = (float) (Math.round( ( k.getInstallcnt() * 100.0 / k.getClickcnt() ) * 100 ) / 100.0);
				k.setCvr( cvr );
			}
		}
		

		return new ResultPageDomain<Dashboard>(0, 10, dashboardList.size(), dashboardList);
	}
}
