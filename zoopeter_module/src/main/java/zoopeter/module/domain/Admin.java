package zoopeter.module.domain;


import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Admin extends Basedomain {
	
	private static final long serialVersionUID = 10000L;
	
	private int adminid;
	private int type;
	private int state;
	private String rtime;
	private String mtime;
	private String id;
	private String passwd;
	private String name;
	private String description;
	private int publisherid;
	
	private String publishername;
	private String passwdsha256;
	
}
