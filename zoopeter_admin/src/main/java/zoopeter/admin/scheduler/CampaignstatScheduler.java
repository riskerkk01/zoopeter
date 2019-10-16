package zoopeter.admin.scheduler;

import java.text.DateFormat;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import zoopeter.module.domain.*;
import zoopeter.module.services.*;

@Component
public class CampaignstatScheduler {
	
	@Autowired private CampaignService g_campaignService;
	@Autowired private ClicklogService g_clicklogService;
	
	@Autowired private AdbrixService g_adbrixService;
	@Autowired private AdbrixreService g_adbrixreService;
	@Autowired private AppsflyerService g_appsflyerService;
	
	//@Autowired private PostService postService;
	//@Autowired private UserService userService;
	
	//@Scheduled( cron="0 0 * * *" )
	//@Scheduled( fixedRate=10000 )
	@Scheduled( fixedDelay=600000 ) // 10min
	public void cronCampaignstat() {
		
		Calendar c1 = new GregorianCalendar();
		c1.add(Calendar.DATE, -7); // 어제
		SimpleDateFormat tformat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 포맷 
		String enddate = tformat.format(c1.getTime()); // String으로 저장
		
		Campaign campaign = new Campaign();

		
		List<Campaign> campaignList = g_campaignService.getCampaignList(campaign);
		
		if( campaignList == null ) return;
		
		for( int i=0; i<campaignList.size(); i++ ) {
			Campaign tmpCampaign = campaignList.get(i);   
			
			String tEnddate = tmpCampaign.getEnddate();
			if( tEnddate.compareTo(enddate) < 0 ) continue;
			
			Clicklog clicklog = new Clicklog();
			clicklog.setCamp_no( Integer.toString( tmpCampaign.getCampaignid() ) );
			int clickCnt = g_clicklogService.countClicklog( clicklog );
			int installCnt = 0;
			int revenue = 0;
			
			String trackercode = tmpCampaign.getTrackercode();
			if( "adbrix".equals( trackercode ) == true ) {
				Adbrix adbrix = new Adbrix();
				adbrix.setCb_param4( Integer.toString( tmpCampaign.getCampaignid() ) );
				adbrix.setEvent_type_code( "1" );
				int cnt = g_adbrixService.countAdbrix( adbrix );
				installCnt = cnt;
				
				adbrix.setEvent_type_code( "4" );
				List<Adbrix> adbrixList = g_adbrixService.getAdbrixList(adbrix);
				int tmpRevenue = 0;
				for( int ii=0; ii<adbrixList.size(); ii++ ) {
					tmpRevenue += Integer.parseInt( adbrixList.get(ii).getSales() );
				}
				
				revenue = tmpRevenue;
			}
			if( "adbrixre".equals( trackercode ) == true ) {
				Adbrixre adbrixre = new Adbrixre();
				adbrixre.setCb_param4( Integer.toString( tmpCampaign.getCampaignid() ) );
				adbrixre.setEvent_type_code( "1" );
				int cnt = g_adbrixreService.countAdbrixre( adbrixre );
				installCnt = cnt;
				
				adbrixre.setEvent_type_code( "4" );
				List<Adbrixre> adbrixreList = g_adbrixreService.getAdbrixreList(adbrixre);
				int tmpRevenue = 0;
				for( int ii=0; ii<adbrixreList.size(); ii++ ) { 
					String sales = adbrixreList.get(ii).getSales();
					int t = 0;
					if( "".equals( sales ) == false ) {
						try {
							t = Integer.parseInt( sales );
						} catch ( NumberFormatException e ) {
							t = 0;
						}
					}
					tmpRevenue += t;
				}
				
				revenue = tmpRevenue;
			}			
			if( "appsflyer".equals( trackercode ) == true ) { 
				Appsflyer appsflyer = new Appsflyer();
				appsflyer.setCampaign( tmpCampaign.getCode() );
				appsflyer.setEvent_name( "af_app_install" );
				int cnt = g_appsflyerService.countAppsflyer( appsflyer );
				installCnt = cnt;
			}			
			
			tmpCampaign.setClickcnt( clickCnt );
			tmpCampaign.setInstallcnt( installCnt );
			tmpCampaign.setRevenue( revenue );
			
			g_campaignService.updateCampaignCount( tmpCampaign );
			
			System.out.println( "campaign name : " + tmpCampaign.getName() + " tracker : " + trackercode + "  clickCnt : " + clickCnt + " installCnt : " + installCnt + "  revenue : " + revenue  );
		}
		
	}
}
