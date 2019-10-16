package zoopeter.module.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class ResultPageDomain <T> implements Serializable{
	List<T> content;
	boolean first = false;
	boolean last = false;
	long number = 0;
	long numberOfElements;
	long size;
	long totalElements;
	long totalPages;
	
	public ResultPageDomain(int page, int size, long totalElements, List<T> content){
		this.totalElements = totalElements;
		this.content = content;
		this.size = size;
		this.numberOfElements = size;
		this.number = page;
		
		if(this.number == 0){
			this.first = true;
		}
		
		if(this.totalElements % this.size > 0){
			this.totalPages = (this.totalElements / this.size) + 1;
		}else{
			this.totalPages = (this.totalElements / this.size);
		}
		
		if((this.number+1) == this.totalPages) this.last = true;
	}
}
