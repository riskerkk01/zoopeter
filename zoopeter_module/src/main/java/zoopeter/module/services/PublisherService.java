package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class PublisherService {

	@Autowired
	PublisherRepository g_publisherRepository;
	
	public Publisher getPublisher( int publisherid ) {
		if( publisherid != 0 )
		{
			Publisher publisher = null;
			try {
				publisher = g_publisherRepository.getPublisher( publisherid );
				return publisher;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Publisher getPublisherByCode( String code ) {
		if( "".equals(code) != true )
		{
			Publisher publisher = null;
			try {
				publisher = g_publisherRepository.getPublisherByCode( code );
				return publisher;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}	
	public int setPublisher( Publisher publisher ) {
		int publisherid = 0;
		try {
			publisherid = g_publisherRepository.setPublisher( publisher );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return publisherid;
	}
	
	public int countPublisher( Publisher publisher ) {
		int count = 0;
		try {
			count = g_publisherRepository.countPublisher( publisher );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Publisher> getPublisherList( Publisher publisher ) {
			List<Publisher> tmpPublisherList = null;
			try {
				tmpPublisherList = g_publisherRepository.getPublisherList( publisher );
				return tmpPublisherList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updatePublisher( Publisher publisher ) {
		try {
			g_publisherRepository.updatePublisher( publisher );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	
	public void deletePublisher( int publisherid ) {
		try {
			g_publisherRepository.deletePublisher( publisherid );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
