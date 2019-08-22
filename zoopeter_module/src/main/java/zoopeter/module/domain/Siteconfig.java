package zoopeter.module.domain;

import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Siteconfig extends Basedomain {
	private static final long serialVersionUID = 10007L;
	
	private int seq;
	private String name;
	private String value;
}
