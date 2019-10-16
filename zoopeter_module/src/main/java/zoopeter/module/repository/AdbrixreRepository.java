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
public class AdbrixreRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(AdbrixreRepository.class);

	public Adbrixre getAdbrixre(int seq) throws SQLException {
		Adbrixre adbrixre = (Adbrixre) sql.selectOne("zoopeter.database.getAdbrixre", seq);
		return adbrixre;
	}

	public int setAdbrixre(Adbrixre adbrixre) throws SQLException {
		int seq = sql.insert("zoopeter.database.setAdbrixre", adbrixre);
		return seq;
	}

	public List<Adbrixre> getAdbrixreList(Adbrixre adbrixre) throws SQLException {
		List<Adbrixre> adbrixreList = sql.selectList("zoopeter.database.getAdbrixreList", adbrixre);
		return adbrixreList;
	}

	public int countAdbrixre(Adbrixre adbrixre) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countAdbrixre", adbrixre);
		return count;
	}

	public void updateAdbrixre(Adbrixre adbrixre) throws SQLException {
		sql.update("zoopeter.database.updateAdbrixre", adbrixre);
	}

	public void deleteAdbrixre(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteAdbrixre", seq);
	}
	public List<Adbrixre> getAdbrixreListForDashboard(Adbrixre adbrixre) throws SQLException {
		List<Adbrixre> adbrixreList = sql.selectList("zoopeter.database.getAdbrixreListForDashboard", adbrixre);
		return adbrixreList;
	}	
}
