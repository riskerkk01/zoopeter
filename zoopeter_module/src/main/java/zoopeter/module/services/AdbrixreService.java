package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class AdbrixreService {

	@Autowired
	AdbrixreRepository g_adbrixreRepository;
	
	public Adbrixre getAdbrixre( int seq ) {
		if( seq != 0 )
		{
			Adbrixre adbrixre = null;
			try {
				adbrixre = g_adbrixreRepository.getAdbrixre( seq );
				return adbrixre;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public int setAdbrixre( Adbrixre adbrixre ) {
		int seq = 0;
		try {
			seq = g_adbrixreRepository.setAdbrixre( adbrixre );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countAdbrixre( Adbrixre adbrixre ) {
		int count = 0;
		try {
			count = g_adbrixreRepository.countAdbrixre( adbrixre );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Adbrixre> getAdbrixreList( Adbrixre adbrixre ) {
			List<Adbrixre> tmpAdbrixreList = null;
			try {
				tmpAdbrixreList = g_adbrixreRepository.getAdbrixreList( adbrixre );
				return tmpAdbrixreList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateAdbrixre( Adbrixre adbrixre ) {
		try {
			g_adbrixreRepository.updateAdbrixre( adbrixre );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteAdbrixre( int seq ) {
		try {
			g_adbrixreRepository.deleteAdbrixre( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}	
	public List<Adbrixre> getAdbrixreListForDashboard( Adbrixre adbrixre ) {
		List<Adbrixre> tmpAdbrixreList = null;
		try {
			tmpAdbrixreList = g_adbrixreRepository.getAdbrixreListForDashboard( adbrixre );
			return tmpAdbrixreList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}	
}
