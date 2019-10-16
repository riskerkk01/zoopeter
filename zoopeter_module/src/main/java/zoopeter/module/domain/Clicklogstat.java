package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Clicklogstat extends Basedomain {
	
	private static final long serialVersionUID = 10008L;
	
	private int seq;
	private int camp_no;
	private String pub_id;
	private String sub_pub_id;
	private String rtime;
	private int cnt;

}
