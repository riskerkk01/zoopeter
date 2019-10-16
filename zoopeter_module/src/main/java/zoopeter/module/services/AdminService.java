package zoopeter.module.services;

import java.sql.SQLException;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class AdminService {

	@Autowired
	AdminRepository g_AdminRepository;
	
	public Admin getAdmin( int adminid ) {
		if( adminid != 0 )
		{
			Admin admin = null;
			try {
				admin = g_AdminRepository.getAdmin( adminid );
				return admin;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Admin getAdminById( String id ) {
		if( "".equals(id) != true )
		{
			Admin admin = null;
			try {
				admin = g_AdminRepository.getAdminById( id );
				return admin;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}	
	public int setAdmin( Admin admin ) {
		int adminid = 0;
		try {
			adminid = g_AdminRepository.setAdmin( admin );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return adminid;
	}
	
	public int countAdmin( Admin admin ) {
		int count = 0;
		try {
			count = g_AdminRepository.countAdmin( admin );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Admin> getAdminList( Admin admin ) {
			List<Admin> tmpAdminList = null;
			try {
				tmpAdminList = g_AdminRepository.getAdminList( admin );
				return tmpAdminList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateAdmin( Admin admin ) {
		try {
			g_AdminRepository.updateAdmin( admin );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	public void updatePasswd( Admin admin ) {
		try {
			g_AdminRepository.updatePasswd( admin );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}		
	public void deleteAdmin( int adminid ) {
		try {
			g_AdminRepository.deleteAdmin( adminid );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
