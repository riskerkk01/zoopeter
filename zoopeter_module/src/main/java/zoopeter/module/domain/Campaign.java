package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Campaign extends Basedomain {
	
	private static final long serialVersionUID = 10001L;
	
	private int campaignid;
	private String name;
	private String code;
	private String startdate;
	private String enddate;
	private String rtime;
	private String mtime;
	private String note;
	private String trackercode;
	private String trackername;
	private String publisherids;
	private String launchingurl;
	private int state;
	private String appname;
	private int clickcnt;
	private int installcnt;
	private int revenue;
	
}
