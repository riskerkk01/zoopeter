package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class ContactusService {

	@Autowired
	ContactusRepository g_contactusRepository;
	
	public Contactus getContactus( int seq ) {
		if( seq != 0 )
		{
			Contactus contactus = null;
			try {
				contactus = g_contactusRepository.getContactus( seq );
				return contactus;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Contactus getContactusByCode( String code ) {
		if( "".equals(code) != true )
		{
			Contactus contactus = null;
			try {
				contactus = g_contactusRepository.getContactusByCode( code );
				return contactus;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}	
	public int setContactus( Contactus contactus ) {
		int seq = 0;
		try {
			seq = g_contactusRepository.setContactus( contactus );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seq;
	}
	
	public int countContactus( Contactus contactus ) {
		int count = 0;
		try {
			count = g_contactusRepository.countContactus( contactus );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Contactus> getContactusList( Contactus contactus ) {
			List<Contactus> tmpContactusList = null;
			try {
				tmpContactusList = g_contactusRepository.getContactusList( contactus );
				return tmpContactusList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateContactus( Contactus contactus ) {
		try {
			g_contactusRepository.updateContactus( contactus );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deleteContactus( int seq ) {
		try {
			g_contactusRepository.deleteContactus( seq );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
