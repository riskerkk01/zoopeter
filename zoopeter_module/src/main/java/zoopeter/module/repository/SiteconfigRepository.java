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
public class SiteconfigRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(SiteconfigRepository.class);

	public Siteconfig getSiteconfig(int seq) throws SQLException {
		Siteconfig siteconfig = (Siteconfig) sql.selectOne("zoopeter.database.getSiteconfig", seq);
		return siteconfig;
	}
	public Siteconfig getSiteconfigByName(String name) throws SQLException {
		Siteconfig siteconfig = (Siteconfig) sql.selectOne("zoopeter.database.getSiteconfigByName", name);
		return siteconfig;
	}
	public int setSiteconfig(Siteconfig siteconfig) throws SQLException {
		int seq = sql.insert("zoopeter.database.setSiteconfig", siteconfig);
		return seq;
	}

	public List<Siteconfig> getSiteconfigList(Siteconfig siteconfig) throws SQLException {
		List<Siteconfig> siteconfigList = sql.selectList("zoopeter.database.getSiteconfigList", siteconfig);
		return siteconfigList;
	}

	public int countSiteconfig(Siteconfig siteconfig) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countSiteconfig", siteconfig);
		return count;
	}

	public void updateSiteconfig(Siteconfig siteconfig) throws SQLException {
		sql.update("zoopeter.database.updateSiteconfig", siteconfig);
	}
	
	public void deleteSiteconfig(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteSiteconfig", seq);
	}
}
