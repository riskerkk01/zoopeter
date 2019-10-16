package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class ClicklogService {

	@Autowired
	ClicklogRepository g_clicklogRepository;
	
	public Clicklog getClicklog( int seq ) {
		if( seq != 0 )
		{
			Clicklog clicklog = null;
			try {
				clicklog = g_clicklogRepository.getClicklog( seq );
				return clicklog;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public int setClicklog( Clicklog clicklog ) {
		int seq = 0;
		try {
			seq = g_clicklogRepository.setClicklog( clicklog );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countClicklog( Clicklog clicklog ) {
		int count = 0;
		try {
			count = g_clicklogRepository.countClicklog( clicklog );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Clicklog> getClicklogList( Clicklog clicklog ) {
			List<Clicklog> tmpClicklogList = null;
			try {
				tmpClicklogList = g_clicklogRepository.getClicklogList( clicklog );
				return tmpClicklogList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateClicklog( Clicklog clicklog ) {
		try {
			g_clicklogRepository.updateClicklog( clicklog );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteClicklog( int seq ) {
		try {
			g_clicklogRepository.deleteClicklog( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}		

	
}
