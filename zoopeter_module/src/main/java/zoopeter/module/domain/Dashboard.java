package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Dashboard extends Basedomain {
	
	private static final long serialVersionUID = 10030L;
	
	private int camp_no;
	private String pub_id;
	private String sub_pub_id;
	private String regtime;
	
	private int installcnt;
	private int clickcnt;
	private int revenue;
	private double cvr;
	

}
