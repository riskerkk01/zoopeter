package zoopeter.module.services;

import java.sql.SQLException;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class AdjustService {

	@Autowired
	AdjustRepository g_adjustRepository;
	
	public Adjust getAdjust( int seq ) {
		if( seq != 0 )
		{
			Adjust adjust = null;
			try {
				adjust = g_adjustRepository.getAdjust( seq );
				return adjust;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public int setAdjust( Adjust adjust ) {
		int seq = 0;
		try {
			seq = g_adjustRepository.setAdjust( adjust );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countAdjust( Adjust adjust ) {
		int count = 0;
		try {
			count = g_adjustRepository.countAdjust( adjust );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Adjust> getAdjustList( Adjust adjust ) {
			List<Adjust> tmpAdjustList = null;
			try {
				tmpAdjustList = g_adjustRepository.getAdjustList( adjust );
				return tmpAdjustList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateAdjust( Adjust adjust ) {
		try {
			g_adjustRepository.updateAdjust( adjust );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteAdjust( int seq ) {
		try {
			g_adjustRepository.deleteAdjust( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
