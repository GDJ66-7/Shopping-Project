package vo;

public class ReviewImg {
	private int historyNo;
	private String reviewOriFilename;
	private String reviewSaveFilename;
	private String reviewFiletype;
	private String createdate;
	private String updatedate;
	
	public int getHistoryNo() {
		return historyNo;
	}
	public void setHistoryNo(int historyNo) {
		this.historyNo = historyNo;
	}
	public String getReviewOriFilename() {
		return reviewOriFilename;
	}
	public void setReviewOriFilename(String reviewOriFilename) {
		this.reviewOriFilename = reviewOriFilename;
	}
	public String getReviewSaveFilename() {
		return reviewSaveFilename;
	}
	public void setReviewSaveFilename(String reviewSaveFilename) {
		this.reviewSaveFilename = reviewSaveFilename;
	}
	public String getReviewFiletype() {
		return reviewFiletype;
	}
	public void setReviewFiletype(String reviewFiletype) {
		this.reviewFiletype = reviewFiletype;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}
