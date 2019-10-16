package zoopeter.module.domain;

import lombok.*;

@Data
@EqualsAndHashCode(callSuper=false)
public class Sitecode extends Basedomain {
	private static final long serialVersionUID = 10006L;
	
	private int seq;
	private String category;
	private String code;
	private String value;
	private int sorder;
}
