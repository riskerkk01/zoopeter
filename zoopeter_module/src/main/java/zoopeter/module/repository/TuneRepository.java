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
public class TuneRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(TuneRepository.class);

	public Tune getTune(int seq) throws SQLException {
		Tune tune = (Tune) sql.selectOne("zoopeter.database.getTune", seq);
		return tune;
	}

	public int setTune(Tune tune) throws SQLException {
		int seq = sql.insert("zoopeter.database.setTune", tune);
		return seq;
	}

	public List<Tune> getTuneList(Tune tune) throws SQLException {
		List<Tune> tuneList = sql.selectList("zoopeter.database.getTuneList", tune);
		return tuneList;
	}

	public int countTune(Tune tune) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countTune", tune);
		return count;
	}

	public void updateTune(Tune tune) throws SQLException {
		sql.update("zoopeter.database.updateTune", tune);
	}

	public void deleteTune(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteTune", seq);
	}
}
