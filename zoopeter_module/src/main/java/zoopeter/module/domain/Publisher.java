package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Publisher extends Basedomain {
	private static final long serialVersionUID = 10005L;
	
	private int publisherid;
	private String name;
	private String code;
	private String note;
	private String rtime;
	private String mtime;
	private String postback_url;
	private String event_url;
}
