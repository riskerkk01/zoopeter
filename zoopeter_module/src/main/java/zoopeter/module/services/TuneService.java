package zoopeter.module.services;

import java.sql.SQLException;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class TuneService {

	@Autowired
	TuneRepository g_tuneRepository;
	
	public Tune getTune( int seq ) {
		if( seq != 0 )
		{
			Tune tune = null;
			try {
				tune = g_tuneRepository.getTune( seq );
				return tune;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public int setTune( Tune tune ) {
		int seq = 0;
		try {
			seq = g_tuneRepository.setTune( tune );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countTune( Tune tune ) {
		int count = 0;
		try {
			count = g_tuneRepository.countTune( tune );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Tune> getTuneList( Tune tune ) {
			List<Tune> tmpTuneList = null;
			try {
				tmpTuneList = g_tuneRepository.getTuneList( tune );
				return tmpTuneList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateTune( Tune tune ) {
		try {
			g_tuneRepository.updateTune( tune );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteTune( int seq ) {
		try {
			g_tuneRepository.deleteTune( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
