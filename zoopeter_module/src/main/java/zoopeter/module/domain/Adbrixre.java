package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Adbrixre extends Basedomain {
	
	private static final long serialVersionUID = 10022L;
	
	private int seq;
	private String regtime;
	private String appkey;
	private String package_name;
	private String gaid;
	private String ifa;
	private String ifv;
	private String model;
	private String network;
	private String os_ver;
	private String sdk_version;
	private String platform;
	private String country;
	private String language;
	private String width;
	private String height;
	private String carrier;
	private String first_install_time;
	private String event_type_code;
	private String conversion_ip;
	private String event_time;
	private String session_id;
	private String cb_param1;
	private String cb_param2;
	private String cb_param3;
	private String cb_param4;
	private String cb_param5;
	private String activity_group;
	private String activity;
	private String activity_param;
	private String order_id;
	private String product_id;
	private String product_name;
	private String price;
	private String quantity;
	private String sales;
	private String category;
	private String currency;
	private String event_detail;
}
