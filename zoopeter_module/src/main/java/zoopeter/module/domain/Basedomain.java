package zoopeter.module.domain;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

//import lombok.Data;
//import lombok.EqualsAndHashCode;

//@Data
//@EqualsAndHashCode(callSuper=false)
public class Basedomain implements Serializable {
	
	//private static final long serialVersionUID = 10002L;
	
	// for query
	//@JsonIgnore
	@JsonProperty( access = JsonProperty.Access.WRITE_ONLY)
	private int page=0;
	
	//@JsonIgnore
	@JsonProperty( access = JsonProperty.Access.WRITE_ONLY)
	private int size=10;
	
	@JsonIgnore
	private int start=0;
	
	@JsonIgnore
	private int count=0;
	
	//for search
	//@JsonIgnore
	@JsonProperty( access = JsonProperty.Access.WRITE_ONLY)
	private String searchtype="";
	
	//@JsonIgnore
	@JsonProperty( access = JsonProperty.Access.WRITE_ONLY)
	private String searchkeyword="";
	
	//@JsonIgnore
	@JsonProperty( access = JsonProperty.Access.WRITE_ONLY)
	private String startdate="";

	//@JsonIgnore
	@JsonProperty( access = JsonProperty.Access.WRITE_ONLY)
	private String enddate="";

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getSearchtype() {
		return searchtype;
	}

	public void setSearchtype(String searchtype) {
		this.searchtype = searchtype;
	}

	public String getSearchkeyword() {
		return searchkeyword;
	}

	public void setSearchkeyword(String searchkeyword) {
		this.searchkeyword = searchkeyword;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
	
	
}
