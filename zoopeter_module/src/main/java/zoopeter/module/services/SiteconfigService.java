package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class SiteconfigService {

	@Autowired
	SiteconfigRepository g_siteconfigRepository;
	
	public Siteconfig getSiteconfig( int seq ) {
		if( seq != 0 )
		{
			Siteconfig siteconfig = null;
			try {
				siteconfig = g_siteconfigRepository.getSiteconfig( seq );
				return siteconfig;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Siteconfig getSiteconfigByName( String name ) {
		if( "".equals(name) != true )
		{
			Siteconfig siteconfig = null;
			try {
				siteconfig = g_siteconfigRepository.getSiteconfigByName( name );
				return siteconfig;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}	
	public int setSiteconfig( Siteconfig siteconfig ) {
		int seq = 0;
		try {
			seq = g_siteconfigRepository.setSiteconfig( siteconfig );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countSiteconfig( Siteconfig siteconfig ) {
		int count = 0;
		try {
			count = g_siteconfigRepository.countSiteconfig( siteconfig );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Siteconfig> getSiteconfigList( Siteconfig siteconfig ) {
			List<Siteconfig> tmpSiteconfigList = null;
			try {
				tmpSiteconfigList = g_siteconfigRepository.getSiteconfigList( siteconfig );
				return tmpSiteconfigList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateSiteconfig( Siteconfig siteconfig ) {
		try {
			g_siteconfigRepository.updateSiteconfig( siteconfig );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteSiteconfig( int seq ) {
		try {
			g_siteconfigRepository.deleteSiteconfig( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
