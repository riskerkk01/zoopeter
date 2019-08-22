package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Clicklog extends Basedomain {
	
	private static final long serialVersionUID = 10009L;
	
	private long seq;
	private String camp_id;
	private String camp_no;
	private String click_id;
	private String pub_id;
	private String sub_pub_id;
	private String sub_param1;
	private String sub_param2;
	private String sub_param3;
	private String sub_param4;

	private String idfa;
	private String adid;
	private String rtime;
	private String ip;
}
