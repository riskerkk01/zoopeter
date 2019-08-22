package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class AppsflyerService {

	@Autowired
	AppsflyerRepository g_appsflyerRepository;
	
	public Appsflyer getAppsflyer( int seq ) {
		if( seq != 0 )
		{
			Appsflyer appsflyer = null;
			try {
				appsflyer = g_appsflyerRepository.getAppsflyer( seq );
				return appsflyer;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public int setAppsflyer( Appsflyer appsflyer ) {
		int seq = 0;
		try {
			seq = g_appsflyerRepository.setAppsflyer( appsflyer );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countAppsflyer( Appsflyer appsflyer ) {
		int count = 0;
		try {
			count = g_appsflyerRepository.countAppsflyer( appsflyer );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	public List<Appsflyer> getAppsflyerList( Appsflyer appsflyer ) {
			List<Appsflyer> tmpAppsflyerList = null;
			try {
				tmpAppsflyerList = g_appsflyerRepository.getAppsflyerList( appsflyer );
				return tmpAppsflyerList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateAppsflyer( Appsflyer appsflyer ) {
		try {
			g_appsflyerRepository.updateAppsflyer( appsflyer );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteAppsflyer( int seq ) {
		try {
			g_appsflyerRepository.deleteAppsflyer( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}	
	public List<Appsflyer> getAppsflyerListForDashboard( Appsflyer appsflyer ) {
		List<Appsflyer> tmpAppsflyerList = null;
		try {
			tmpAppsflyerList = g_appsflyerRepository.getAppsflyerListForDashboard( appsflyer );
			return tmpAppsflyerList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
