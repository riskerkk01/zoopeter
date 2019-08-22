package zoopeter.module.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import zoopeter.module.domain.*;

import java.sql.SQLException;
import java.util.List;

@Repository
public class AdbrixRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(AdbrixRepository.class);

	public Adbrix getAdbrix(int seq) throws SQLException {
		Adbrix adbrix = (Adbrix) sql.selectOne("zoopeter.database.getAdbrix", seq);
		return adbrix;
	}

	public int setAdbrix(Adbrix adbrix) throws SQLException {
		int seq = sql.insert("zoopeter.database.setAdbrix", adbrix);
		return seq;
	}

	public List<Adbrix> getAdbrixList(Adbrix adbrix) throws SQLException {
		List<Adbrix> adbrixList = sql.selectList("zoopeter.database.getAdbrixList", adbrix);
		return adbrixList;
	}

	public int countAdbrix(Adbrix adbrix) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countAdbrix", adbrix);
		return count;
	}

	public void updateAdbrix(Adbrix adbrix) throws SQLException {
		sql.update("zoopeter.database.updateAdbrix", adbrix);
	}

	public void deleteAdbrix(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteAdbrix", seq);
	}
	
	public List<Adbrix> getAdbrixListForDashboard(Adbrix adbrix) throws SQLException {
		List<Adbrix> adbrixList = sql.selectList("zoopeter.database.getAdbrixListForDashboard", adbrix);
		return adbrixList;
	}
	
}
