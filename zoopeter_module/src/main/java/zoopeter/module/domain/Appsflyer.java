package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Appsflyer extends Basedomain {
	
	private static final long serialVersionUID = 10024L;
	
	private int seq;
	private String regtime;
	private String pid;
	private String clickid;
	private String idfa;
	private String advertiserid;
	private String android_id;
	private String app_id;
	private String wifi;
	private String install_unix_ts;
	private String click_ts;
	private String campaign;
	private String publisher_id;
	private String publisher_sub_id;
	private String country_code;
	private String city;
	private String device_brand;
	private String carrier;
	private String ip;
	private String device_model;
	private String language;
	private String appsflyer_device_id;
	private String sdk_version;
	private String app_version_name;
	private String user_agent;
	private String vendorid;
	private String os_version;
	private String app_name;
	private String match_type;
	private String gp_referer_click_ts;
	private String gp_referer_install_ts;
	private String event_name;
	private String mapped_iae;
	private String monetary;
	private String orig_monetary;
	private String currency;
	private String timestamp;
	private String event_value;
	private String event;
	private String json;
	private int af_quantity;
	private int af_revenue;
	private String af_currency;
	private String af_content_id;
	private String af_content_type;
	

}
