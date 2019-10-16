package zoopeter.module.services;

import java.sql.SQLException;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class AdbrixService {

	@Autowired
	AdbrixRepository g_adbrixRepository;
	
	public Adbrix getAdbrix( int seq ) {
		if( seq != 0 )
		{
			Adbrix adbrix = null;
			try {
				adbrix = g_adbrixRepository.getAdbrix( seq );
				return adbrix;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public int setAdbrix( Adbrix adbrix ) {
		int seq = 0;
		try {
			seq = g_adbrixRepository.setAdbrix( adbrix );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countAdbrix( Adbrix adbrix ) {
		int count = 0;
		try {
			count = g_adbrixRepository.countAdbrix( adbrix );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	public List<Adbrix> getAdbrixList( Adbrix adbrix ) {
			List<Adbrix> tmpAdbrixList = null;
			try {
				tmpAdbrixList = g_adbrixRepository.getAdbrixList( adbrix );
				return tmpAdbrixList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateAdbrix( Adbrix adbrix ) {
		try {
			g_adbrixRepository.updateAdbrix( adbrix );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteAdbrix( int seq ) {
		try {
			g_adbrixRepository.deleteAdbrix( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	public List<Adbrix> getAdbrixListForDashboard( Adbrix adbrix ) {
		List<Adbrix> tmpAdbrixList = null;
		try {
			tmpAdbrixList = g_adbrixRepository.getAdbrixListForDashboard( adbrix );
			return tmpAdbrixList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}	
}
