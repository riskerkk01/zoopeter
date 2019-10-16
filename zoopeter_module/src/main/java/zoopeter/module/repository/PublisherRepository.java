package zoopeter.module.repository;

import org.apache.ibatis.session.SqlSession;


//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import zoopeter.module.domain.*;

import java.sql.SQLException;
import java.util.List;

@Repository
public class PublisherRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(PublisherRepository.class);

	public Publisher getPublisher(int publisherid) throws SQLException {
		Publisher publisher = (Publisher) sql.selectOne("zoopeter.database.getPublisher", publisherid);
		return publisher;
	}
	public Publisher getPublisherByCode(String code) throws SQLException {
		Publisher publisher = (Publisher) sql.selectOne("zoopeter.database.getPublisherByCode", code);
		return publisher;
	}
	public int setPublisher(Publisher publisher) throws SQLException {
		int publisherid = sql.insert("zoopeter.database.setPublisher", publisher);
		return publisherid;
	}

	public List<Publisher> getPublisherList(Publisher publisher) throws SQLException {
		List<Publisher> publisherList = sql.selectList("zoopeter.database.getPublisherList", publisher);
		return publisherList;
	}

	public int countPublisher(Publisher publisher) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countPublisher", publisher);
		return count;
	}

	public void updatePublisher(Publisher publisher) throws SQLException {
		sql.update("zoopeter.database.updatePublisher", publisher);
	}
	
	public void deletePublisher(int publisherid) throws SQLException {
		sql.update("zoopeter.database.deletePublisher", publisherid);
	}
}
