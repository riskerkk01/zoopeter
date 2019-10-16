package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Contactus extends Basedomain {
	private static final long serialVersionUID = 10004L;
	
	private int seq;
	private String rtime;
	private String name;
	private String subject;
	private String email;
	private String message;
}
