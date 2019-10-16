package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Clickidmap extends Basedomain {
	
	private static final long serialVersionUID = 10018L;
	
	private int seq;
	private String clickid;
	private String publishercode;
	private String click_id;
	private String rtime;
	
}
