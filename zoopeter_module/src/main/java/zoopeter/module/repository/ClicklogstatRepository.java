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
public class ClicklogstatRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(ClicklogstatRepository.class);

	public Clicklogstat getClicklogstat(int seq) throws SQLException {
		Clicklogstat clicklogstat = (Clicklogstat) sql.selectOne("zoopeter.database.getClicklogstat", seq);
		return clicklogstat;
	}
	public int setClicklogstat(Clicklogstat clicklogstat) throws SQLException {
		int seq = sql.insert("zoopeter.database.setClicklogstat", clicklogstat);
		return seq;
	}

	public List<Clicklogstat> getClicklogstatList(Clicklogstat clicklogstat) throws SQLException {
		List<Clicklogstat> clicklogstatList = sql.selectList("zoopeter.database.getClicklogstatList", clicklogstat);
		return clicklogstatList;
	}

	public int countClicklogstat(Clicklogstat clicklogstat) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countClicklogstat", clicklogstat);
		return count;
	}

	public void updateClicklogstat(Clicklogstat clicklogstat) throws SQLException {
		sql.update("zoopeter.database.updateClicklogstat", clicklogstat);
	}
	
	public void deleteClicklogstat(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteClicklogstat", seq);
	}
	
	public List<Clicklogstat> getClicklogstatData(Clicklogstat clicklogstat) throws SQLException {
		List<Clicklogstat> clicklogstatList = sql.selectList("zoopeter.database.getClicklogstatData", clicklogstat);
		return clicklogstatList;
	}	
}
