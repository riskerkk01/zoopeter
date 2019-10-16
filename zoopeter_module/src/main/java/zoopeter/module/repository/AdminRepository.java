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
public class AdminRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(AdminRepository.class);

	public Admin getAdmin(int adminid) throws SQLException {
		Admin admin = (Admin) sql.selectOne("zoopeter.database.getAdmin", adminid);
		return admin;
	}
	public Admin getAdminById(String id) throws SQLException {
		Admin admin = (Admin) sql.selectOne("zoopeter.database.getAdminById", id);
		return admin;
	}
	public int setAdmin(Admin admin) throws SQLException {
		int adminid = sql.insert("zoopeter.database.setAdmin", admin);
		return adminid;
	}

	public List<Admin> getAdminList(Admin admin) throws SQLException {
		List<Admin> adminList = sql.selectList("zoopeter.database.getAdminList", admin);
		return adminList;
	}

	public int countAdmin(Admin admin) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countAdmin", admin);
		return count;
	}

	public void updateAdmin(Admin admin) throws SQLException {
		sql.update("zoopeter.database.updateAdmin", admin);
	}
	
	public void updatePasswd(Admin admin) throws SQLException {
		sql.update("zoopeter.database.updatePasswd", admin);
	}

	
	public void deleteAdmin(int adminid) throws SQLException {
		sql.update("zoopeter.database.deleteAdmin", adminid);
	}
}
