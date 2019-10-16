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
public class ClicklogstatScheduler {
	
	@Autowired private ClicklogstatService g_clicklogstatService;
	//@Autowired private PostService postService;
	//@Autowired private UserService userService;
	
	//@Scheduled( cron="0 0 * * *" )
	//@Scheduled( fixedRate=10000 )
	@Scheduled( fixedDelay=300000 ) // 5min
	public void cronClicklogstat() {
		
		Calendar c1 = new GregorianCalendar();
		c1.add(Calendar.DATE, -1); // 어제
		SimpleDateFormat tformat = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 포맷 
		String startdate = tformat.format(c1.getTime()); // String으로 저장
		c1.add(Calendar.DATE, 2); // 내일
		String enddate = tformat.format(c1.getTime()); // String으로 저장

		Clicklogstat clicklogstat = new Clicklogstat();
		clicklogstat.setStartdate( startdate );
		clicklogstat.setEnddate( enddate );
		
		List<Clicklogstat> logList = null;
		logList = g_clicklogstatService.getClicklogstatData( clicklogstat );
		if( logList != null ) {
			for( int i=0; i<logList.size(); i++ ) {
				Clicklogstat tmp = logList.get(i);
				List<Clicklogstat> t = null;
				tmp.setStart(0);
				tmp.setCount(1000);
				t = g_clicklogstatService.getClicklogstatList( tmp );
				System.out.println( "scheduler " + t.size() + ":::"+tmp.getPub_id() + ":"+tmp.getSub_pub_id()+":"+tmp.getRtime() + ":"+tmp.getCnt() );
				
				if( t == null || 0 == t.size() ) {
					System.out.println( "insert :::: " );
					g_clicklogstatService.setClicklogstat(tmp);
				} else {
					System.out.println( "update :::: t size : " + t.size() );
					tmp.setSeq( t.get(0).getSeq() );
					g_clicklogstatService.updateClicklogstat(tmp);
				}
			  
			}
		}
	}
}
