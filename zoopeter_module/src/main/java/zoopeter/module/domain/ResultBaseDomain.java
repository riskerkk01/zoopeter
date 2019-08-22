package zoopeter.module.domain;

import java.io.Serializable;
import lombok.Data;

@Data
public class ResultBaseDomain implements Serializable{
	String result;
	String note;
}
