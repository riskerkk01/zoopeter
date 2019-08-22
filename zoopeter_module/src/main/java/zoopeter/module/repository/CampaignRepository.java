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
public class CampaignRepository {

	@Autowired
	private SqlSession sql;

	// private static final Logger logger =
	// LoggerFactory.getLogger(CampaignRepository.class);

	public Campaign getCampaign(int campaignid) throws SQLException {
		Campaign campaign = (Campaign) sql.selectOne("zoopeter.database.getCampaign", campaignid);
		return campaign;
	}
	public Campaign getCampaignByCode(String code) throws SQLException {
		Campaign campaign = (Campaign) sql.selectOne("zoopeter.database.getCampaignByCode", code);
		return campaign;
	}
	public int setCampaign(Campaign campaign) throws SQLException {
		int campaignid = sql.insert("zoopeter.database.setCampaign", campaign);
		return campaignid;
	}

	public List<Campaign> getCampaignList(Campaign campaign) throws SQLException {
		List<Campaign> campaignList = sql.selectList("zoopeter.database.getCampaignList", campaign);
		return campaignList;
	}

	public int countCampaign(Campaign campaign) throws SQLException {
		int count = sql.selectOne("zoopeter.database.countCampaign", campaign);
		return count;
	}

	public void updateCampaign(Campaign campaign) throws SQLException {
		sql.update("zoopeter.database.updateCampaign", campaign);
	}
	public void updateCampaignCount(Campaign campaign) throws SQLException {
		sql.update("zoopeter.database.updateCampaignCount", campaign);
	}	
	public void deleteCampaign(int campaignid) throws SQLException {
		sql.update("zoopeter.database.deleteCampaign", campaignid);
	}
}
