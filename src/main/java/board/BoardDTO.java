package board;

public class BoardDTO {
	
	// 멤버변수
	private String idx;				// 일련번호
	private String id;				// 작성자 아이디
	private String title;			// 제목
	private String content;			// 내용
	private java.sql.Date postdate;	// 작성일 - Date형
	private String ofile;			// 원본 파일명
	private String sfile;			// 서버에 저장된 파일명
	private int downcount;			// 다운로드 카운트 - int형
	private int visitcount;			// 게시물 조회수 - int형
	private String boardType;		// 게시판 종류
	
	// members테이블과의 join을 통해 회원 이름을 출력하기위해 멤버변수 추가
	private String name;			// 작성자 이름
		
	
	// getter,setter 정의
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
	public int getDowncount() {
		return downcount;
	}
	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}
	public int getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(int visitcount) {
		this.visitcount = visitcount;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	
}
