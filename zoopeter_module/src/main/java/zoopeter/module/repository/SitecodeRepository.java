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
public class SitecodeRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(SitecodeRepository.class);

	public Sitecode getSitecode(int seq) throws SQLException {
		Sitecode sitecode = (Sitecode) sql.selectOne("zoopeter.database.getSitecode", seq);
		return sitecode;
	}
	public Sitecode getSitecodeByCode(String code) throws SQLException {
		Sitecode sitecode = (Sitecode) sql.selectOne("zoopeter.database.getSitecodeByCode", code);
		return sitecode;
	}
	public int setSitecode(Sitecode sitecode) throws SQLException {
		int seq = sql.insert("zoopeter.database.setSitecode", sitecode);
		return seq;
	}

	public List<Sitecode> getSitecodeList(Sitecode sitecode) throws SQLException {
		List<Sitecode> sitecodeList = sql.selectList("zoopeter.database.getSitecodeList", sitecode);
		return sitecodeList;
	}

	public int countSitecode(Sitecode sitecode) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countSitecode", sitecode);
		return count;
	}

	public void updateSitecode(Sitecode sitecode) throws SQLException {
		sql.update("zoopeter.database.updateSitecode", sitecode);
	}
	
	public void deleteSitecode(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteSitecode", seq);
	}
}
