package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Adjust extends Basedomain {
	
	private static final long serialVersionUID = 10023L;
	
	private int seq;
	private String regtime;
	private String adid;
	private String app_id;
	private String app_name;
	private String idfa;
	private String click_id;
	private String app_version;
	private String campaign_name;
	private String install_at;
	private String click_time;
	private String country;
	private String region;
	private String sdk_version;
	private String os_version;
	private String os_name;
	private String event;
	private String event_name;
	private String ip_address;
	private String network_name;
	private String revenue;
	private String currency;
	private String revenue_float;

}
