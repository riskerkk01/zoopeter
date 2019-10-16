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
public class ContactusRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(ContactusRepository.class);

	public Contactus getContactus(int seq) throws SQLException {
		Contactus contactus = (Contactus) sql.selectOne("zoopeter.database.getContactus", seq);
		return contactus;
	}
	public Contactus getContactusByCode(String code) throws SQLException {
		Contactus contactus = (Contactus) sql.selectOne("zoopeter.database.getContactusByCode", code);
		return contactus;
	}
	public int setContactus(Contactus contactus) throws SQLException {
		int seq = sql.insert("zoopeter.database.setContactus", contactus);
		return seq;
	}

	public List<Contactus> getContactusList(Contactus contactus) throws SQLException {
		List<Contactus> contactusList = sql.selectList("zoopeter.database.getContactusList", contactus);
		return contactusList;
	}

	public int countContactus(Contactus contactus) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countContactus", contactus);
		return count;
	}

	public void updateContactus(Contactus contactus) throws SQLException {
		sql.update("zoopeter.database.updateContactus", contactus);
	}
	
	public void deleteContactus(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteContactus", seq);
	}
}
