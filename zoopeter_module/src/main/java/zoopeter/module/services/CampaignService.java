package zoopeter.module.services;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import zoopeter.module.domain.*;
import zoopeter.module.repository.*;

@Service
public class CampaignService {

	@Autowired
	CampaignRepository g_campaignRepository;
	
	public Campaign getCampaign( int campaignid ) {
		if( campaignid != 0 )
		{
			Campaign campaign = null;
			try {
				campaign = g_campaignRepository.getCampaign( campaignid );
				return campaign;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}
	public Campaign getCampaignByCode( String code ) {
		if( "".equals(code) != true )
		{
			Campaign campaign = null;
			try {
				campaign = g_campaignRepository.getCampaignByCode( code );
				return campaign;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return null;
	}	
	public int setCampaign( Campaign campaign ) {
		int campaignid = 0;
		try {
			campaignid = g_campaignRepository.setCampaign( campaign );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return campaignid;
	}
	
	public int countCampaign( Campaign campaign ) {
		int count = 0;
		try {
			count = g_campaignRepository.countCampaign( campaign );
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
}
	public List<Campaign> getCampaignList( Campaign campaign ) {
			List<Campaign> tmpCampaignList = null;
			try {
				tmpCampaignList = g_campaignRepository.getCampaignList( campaign );
				return tmpCampaignList;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	public void updateCampaign( Campaign campaign ) {
		try {
			g_campaignRepository.updateCampaign( campaign );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	public void updateCampaignCount( Campaign campaign ) {
		try {
			g_campaignRepository.updateCampaignCount( campaign );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}	
	public void deleteCampaign( int campaignid ) {
		try {
			g_campaignRepository.deleteCampaign( campaignid );
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}			
}
