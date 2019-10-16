package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class SitecodeService {

	@Autowired
	SitecodeRepository g_sitecodeRepository;
	
	public Sitecode getSitecode( int seq ) {
		if( seq != 0 )
		{
			Sitecode sitecode = null;
			try {
				sitecode = g_sitecodeRepository.getSitecode( seq );
				return sitecode;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Sitecode getSitecodeByCode( String code ) {
		if( "".equals(code) != true )
		{
			Sitecode sitecode = null;
			try {
				sitecode = g_sitecodeRepository.getSitecodeByCode( code );
				return sitecode;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}	
	public int setSitecode( Sitecode sitecode ) {
		int seq = 0;
		try {
			seq = g_sitecodeRepository.setSitecode( sitecode );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countSitecode( Sitecode sitecode ) {
		int count = 0;
		try {
			count = g_sitecodeRepository.countSitecode( sitecode );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Sitecode> getSitecodeList( Sitecode sitecode ) {
			List<Sitecode> tmpSitecodeList = null;
			try {
				tmpSitecodeList = g_sitecodeRepository.getSitecodeList( sitecode );
				return tmpSitecodeList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateSitecode( Sitecode sitecode ) {
		try {
			g_sitecodeRepository.updateSitecode( sitecode );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteSitecode( int seq ) {
		try {
			g_sitecodeRepository.deleteSitecode( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
