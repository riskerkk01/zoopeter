package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class ClicklogstatService {

	@Autowired
	ClicklogstatRepository g_clicklogstatRepository;
	
	public Clicklogstat getClicklogstat( int seq ) {
		if( seq != 0 )
		{
			Clicklogstat clicklogstat = null;
			try {
				clicklogstat = g_clicklogstatRepository.getClicklogstat( seq );
				return clicklogstat;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public int setClicklogstat( Clicklogstat clicklogstat ) {
		int seq = 0;
		try {
			seq = g_clicklogstatRepository.setClicklogstat( clicklogstat );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countClicklogstat( Clicklogstat clicklogstat ) {
		int count = 0;
		try {
			count = g_clicklogstatRepository.countClicklogstat( clicklogstat );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Clicklogstat> getClicklogstatList( Clicklogstat clicklogstat ) {
			List<Clicklogstat> tmpClicklogstatList = null;
			try {
				tmpClicklogstatList = g_clicklogstatRepository.getClicklogstatList( clicklogstat );
				return tmpClicklogstatList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateClicklogstat( Clicklogstat clicklogstat ) {
		try {
			g_clicklogstatRepository.updateClicklogstat( clicklogstat );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteClicklogstat( int seq ) {
		try {
			g_clicklogstatRepository.deleteClicklogstat( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}		
	public List<Clicklogstat> getClicklogstatData( Clicklogstat clicklogstat ) {
		List<Clicklogstat> tmpClicklogstatList = null;
		try {
			tmpClicklogstatList = g_clicklogstatRepository.getClicklogstatData( clicklogstat );
			return tmpClicklogstatList;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
}
	
}
