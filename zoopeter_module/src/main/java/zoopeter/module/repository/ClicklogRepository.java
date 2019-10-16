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
public class ClicklogRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(ClicklogRepository.class);

	public Clicklog getClicklog(int seq) throws SQLException {
		Clicklog clicklog = (Clicklog) sql.selectOne("zoopeter.database.getClicklog", seq);
		return clicklog;
	}
	public int setClicklog(Clicklog clicklog) throws SQLException {
		int seq = sql.insert("zoopeter.database.setClicklog", clicklog);
		return seq;
	}

	public List<Clicklog> getClicklogList(Clicklog clicklog) throws SQLException {
		List<Clicklog> clicklogList = sql.selectList("zoopeter.database.getClicklogList", clicklog);
		return clicklogList;
	}

	public int countClicklog(Clicklog clicklog) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countClicklog", clicklog);
		return count;
	}

	public void updateClicklog(Clicklog clicklog) throws SQLException {
		sql.update("zoopeter.database.updateClicklog", clicklog);
	}
	
	public void deleteClicklog(int seq) throws SQLException {
		sql.update("zoopeter.database.deleteClicklog", seq);
	}
	
}
