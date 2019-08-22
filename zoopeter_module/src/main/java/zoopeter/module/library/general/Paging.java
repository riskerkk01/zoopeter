package zoopeter.module.library.general;

import org.apache.commons.lang.builder.ToStringBuilder;

import org.apache.commons.lang.builder.ToStringStyle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Paging {
    private static final Logger logger = LoggerFactory.getLogger(Paging.class);

    private int pageNumber;    //페이지번호
    private int pageSize;        //페이지크기
    private long totalCount;    //전체 행의 갯수
    private long totalPage;    //전체 페이지 수

    private static final int pageCount = 10;            //네비게이션에 보여줄 페이지 수
    private long minPageNumber;    //시작 페이지 번호
    private long maxPageNumber;    //끝 페이지 번호
    private long prevPageNumber;    //이전 페이지 번호
    private long nextPageNumber;    //다음 페이지 번호
    private long firstPageNumber;    //첫목록
    private long lastPageNumber;    //끝목록

    public Paging(int pageNumber, int pageSize, long totalCount) {
        this.pageNumber = pageNumber;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.totalPage = (long)Math.ceil((double)totalCount/(double)pageSize);

        double minPageNo;
        if(this.pageNumber % Paging.pageCount == 0){
            minPageNo = Math.floor((double)this.pageNumber / Paging.pageCount) * Paging.pageCount - (Paging.pageCount-1);
        }else{
            minPageNo = Math.floor((double)this.pageNumber / Paging.pageCount) * Paging.pageCount + 1;
        }

        double pageCnt = Math.ceil((double)this.totalCount/(double)this.pageSize) - minPageNo;

        if(pageCnt > Paging.pageCount){
            pageCnt = Paging.pageCount - 1;
        }
        double maxPageNo = minPageNo + pageCnt;

        this.minPageNumber = (long) minPageNo;
        this.maxPageNumber = (long) maxPageNo;
        if(this.pageNumber <= Paging.pageCount){
            this.prevPageNumber = 0;
            this.firstPageNumber = 0;
        } else{
            this.prevPageNumber = this.minPageNumber - this.pageSize;
            this.firstPageNumber = 1;
        }

        if(this.minPageNumber + Paging.pageCount >= this.totalPage)
        {
            this.nextPageNumber = 0;
            this.lastPageNumber = 0;
        }else{
            this.nextPageNumber = this.maxPageNumber + 1;
            this.lastPageNumber = totalPage;
        }
        //logger.debug("member: {}", toString());
    }

    public String toString(){
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }

    /**
     * @return the pageNumber
     */
    public int getPageNumber() {
        return pageNumber;
    }
    /**
     * @param pageNumber the pageNumber to set
     */
    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }
    /**
     * @return the pageSize
     */
    public int getPageSize() {
        return pageSize;
    }
    /**
     * @param pageSize the pageSize to set
     */
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
    /**
     * @return the totalCount
     */
    public long getTotalCount() {
        return totalCount;
    }
    /**
     * @param totalCount the totalCount to set
     */
    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }
    /**
     * @return the totalPage
     */
    public long getTotalPage() {
        return totalPage;
    }

    /**
     * @return the pageCount
     */
    public int getPageCount() {
        return pageCount;
    }
    /**
     * @return the minPageNumber
     */
    public long getMinPageNumber() {
        return minPageNumber;
    }
    /**
     * @param minPageNumber the minPageNumber to set
     */
    public void setMinPageNumber(long minPageNumber) {
        this.minPageNumber = minPageNumber;
    }
    /**
     * @return the maxPageNumber
     */
    public long getMaxPageNumber() {
        return maxPageNumber;
    }
    /**
     * @param maxPageNumber the maxPageNumber to set
     */
    public void setMaxPageNumber(long maxPageNumber) {
        this.maxPageNumber = maxPageNumber;
    }
    /**
     * @return the prevPageNumber
     */
    public long getPrevPageNumber() {
        return prevPageNumber;
    }
    /**
     * @param prevPageNumber the prevPageNumber to set
     */
    public void setPrevPageNumber(long prevPageNumber) {
        this.prevPageNumber = prevPageNumber;
    }
    /**
     * @return the nextPageNumber
     */
    public long getNextPageNumber() {
        return nextPageNumber;
    }
    /**
     * @param nextPageNumber the nextPageNumber to set
     */
    public void setNextPageNumber(long nextPageNumber) {
        this.nextPageNumber = nextPageNumber;
    }
    /**
     * @return the firstPageNumber
     */
    public long getFirstPageNumber() {
        return firstPageNumber;
    }
    /**
     * @param firstPageNumber the firstPageNumber to set
     */
    public void setFirstPageNumber(long firstPageNumber) {
        this.firstPageNumber = firstPageNumber;
    }
    /**
     * @return the lastPageNumber
     */
    public long getLastPageNumber() {
        return lastPageNumber;
    }
    /**
     * @param lastPageNumber the lastPageNumber to set
     */
    public void setLastPageNumber(long lastPageNumber) {
        this.lastPageNumber = lastPageNumber;
    }
    /**
     * @return the logger
     */
    public static Logger getLogger() {
        return logger;
    }
    /**
     * @param totalPage the totalPage to set
     */
    public void setTotalPage(long totalPage) {
        this.totalPage = totalPage;
    }
}
