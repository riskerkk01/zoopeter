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
public class AppsflyerRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(AppsflyerRepository.class);

	public Appsflyer getAppsflyer(int seq) throws SQLException {
		Appsflyer appsflyer = (Appsflyer) sql.selectOne("zoopeter.database.getAppsflyer", seq);
		return appsflyer;
	}

	public int setAppsflyer(Appsflyer appsflyer) throws SQLException {
		int seq = sql.insert("zoopeter.database.setAppsflyer", appsflyer);
		return seq;
	}

	public List<Appsflyer> getAppsflyerList(Appsflyer appsflyer) throws SQLException {
		List<Appsflyer> appsflyerList = sql.selectList("zoopeter.database.getAppsflyerList", appsflyer);
		return appsflyerList;
	}

	public int countAppsflyer(Appsflyer appsflyer) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countAppsflyer", appsflyer);
		return count;
	}

	public void updateAppsflyer(Appsflyer appsflyer) throws SQLException {
		sql.update("zoopeter.database.updateAppsflyer", appsflyer);
	}

	public void deleteAppsflyer(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteAppsflyer", seq);
	}
	public List<Appsflyer> getAppsflyerListForDashboard(Appsflyer appsflyer) throws SQLException {
		List<Appsflyer> appsflyerList = sql.selectList("zoopeter.database.getAppsflyerListForDashboard", appsflyer);
		return appsflyerList;
	}	
}
