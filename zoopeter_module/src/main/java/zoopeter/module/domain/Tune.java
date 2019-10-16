package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Tune extends Basedomain {
	
	private static final long serialVersionUID = 10026L;
	
	private int seq;
	private String regtime;
	private String aaid;
	private String idfa;
	private String agency;
	private String secondary_publisher;
	private String campaign;
	private String campaign_id;
	private String channel;
	private String ad_set_name;
	private String ad_set_id;
	private String ad_name;
	private String ad_id;
	private String click_id;
	private String event_name;
	private String event_timestamp;
	private String is_attributed;
	private String bundle_id;
	private String app_name;
	private String app_version;
	private String language;
	private String os;
	private String os_version;
	private String client_ip;
	private String country;
	private String device_id;
	private String goal_id;
	private String user_agent;
}
