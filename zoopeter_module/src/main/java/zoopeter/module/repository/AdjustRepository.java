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
public class AdjustRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(AdjustRepository.class);

	public Adjust getAdjust(int seq) throws SQLException {
		Adjust adjust = (Adjust) sql.selectOne("zoopeter.database.getAdjust", seq);
		return adjust;
	}

	public int setAdjust(Adjust adjust) throws SQLException {
		int seq = sql.insert("zoopeter.database.setAdjust", adjust);
		return seq;
	}

	public List<Adjust> getAdjustList(Adjust adjust) throws SQLException {
		List<Adjust> adjustList = sql.selectList("zoopeter.database.getAdjustList", adjust);
		return adjustList;
	}

	public int countAdjust(Adjust adjust) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countAdjust", adjust);
		return count;
	}

	public void updateAdjust(Adjust adjust) throws SQLException {
		sql.update("zoopeter.database.updateAdjust", adjust);
	}

	public void deleteAdjust(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteAdjust", seq);
	}
}
