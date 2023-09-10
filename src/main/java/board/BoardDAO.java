package board;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.JDBConnect;

public class BoardDAO extends JDBConnect {
	
	// 게시물의 갯수를 카운트하기 위한 메서드 정의
	public int selectCount(Map<String, Object> map) {
		// 게시물의 갯수를 담을 변수 생성
		int totalCount = 0;
		
		// 해당 게시판의 게시물 갯수 쿼리문 준비
		String query = "SELECT COUNT(*) FROM board WHERE boardtype='"+ map.get("boardType") +"'";
		// 검색어가 있는 경우
		if(map.get("keyString") != null) {
			query += " AND "+ map.get("keyField") + " "
				   + " LIKE '%"+ map.get("keyString") +"%'";
		}

		//System.out.println("게시물 카운트 쿼리문: " + query);
		
		try {
			// 인파라미터가 없는 정적쿼리문 - statement객체 생성
			stmt = con.createStatement(); 
            //쿼리문 실행 후 결과는 ResultSet으로 반환
			rs = stmt.executeQuery(query);
            //커서를 첫번째 행으로 이동하여 레코드 읽기
			rs.next();
            //첫번째 컬럼(count함수)의 값을 가져와서 변수에 저장
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 카운트 중 예외발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// 목록에 출력할 게시물을 얻어오기 위한 메서드 정의
	public List<BoardDTO> selectListPage(Map<String, Object> map){
		// board 테이블을 대상으로하므로 타입매개변수 확인 필요
		List<BoardDTO> board = new Vector<BoardDTO>();
		
		// 페이징 처리를 위한 서브쿼리문
		String query = "SELECT * FROM "
					 + "    (SELECT bo.*, ROWNUM rNum FROM "
					 + "        (SELECT * FROM board WHERE boardtype='"+ map.get("boardType") +"'";
		// 검색어가 있는 경우
		if(map.get("keyString") != null) {
			query += " AND "+ map.get("keyField") +" "
				   + " LIKE '%"+ map.get("keyString") +"%' ";
		}
		// 게시물의 구간을 결정하기 위해 between 사용
		query += "            ORDER BY idx DESC) bo) "
			   + " WHERE rNum BETWEEN ? AND ?";

		//System.out.println("게시물 리스트 쿼리문: " + query);
		
		try {
			// 인파라미터가 있는 동적쿼리문 - prepared객체 생성
			psmt = con.prepareStatement(query);
			// 인파라미터 설정
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			// 쿼리문 실행 및 ResultSet반환
			rs = psmt.executeQuery();
			// 2개 이상의 레코드가 반환될 수 있으므로 while문을 사용
			while (rs.next()) {
				// 하나의 레코드를 저장할 수 있는 DTO객체 생성
				BoardDTO dto = new BoardDTO();
				
				// setter를 이용해 각 컬럼의 값을 멤버변수에 저장
				dto.setIdx(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setVisitcount(rs.getShort(9));
				
				// List에 DTO 추가
				board.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외발생");
			e.printStackTrace();
		}
		
		return board;
	}
	
	// 게시물 입력하기 위한 메서드 정의
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		String query = "INSERT INTO board (idx, id, title, content, visitcount, boardtype, ofile, sfile) "
					 + "    VALUES (seq_board_num.nextval, ?, ?, ?, 0, ?, ?, ?)";

		//System.out.println("게시물 입력 쿼리문: " + query);
		
		try {
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getBoardType());
			psmt.setString(5, dto.getOfile());
			psmt.setString(6, dto.getSfile());
			
			result = psmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("게시물 입력 중 예외발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시글 상세보기를 위한 메서드 정의
	public BoardDTO selectView(String idx) {
		BoardDTO dto = new BoardDTO();
		
		String query = "SELECT B.*, M.name "
					 + "    FROM members M INNER JOIN board B "
					 + "    ON M.id=B.id WHERE idx=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setId(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4).replace("\r\n", "<br/>"));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setVisitcount(rs.getInt(9));
				dto.setBoardType(rs.getString(10));
				dto.setName(rs.getString(11));
			}
		} catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 게시물 조회수 증가하기 위한 메서드 정의
	public void updateVisitCount(String idx) {
		String query = "UPDATE board SET visitcount=visitcount+1 WHERE idx=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
			
		} catch (Exception e) {
			System.out.println("게시물 조회수 증가 중 예외발생");
			e.printStackTrace();
		}
	}
	
	// 게시물 수정하기 위한 메서드 정의
	public int updatePost(BoardDTO dto) {
		int result = 0;
		
		String query = "UPDATE board SET "
					 + "    title=?, content=?, ofile=?, sfile=? WHERE idx=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			psmt.setString(5, dto.getIdx());
			
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 수정 중 예외발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 게시물 삭제하기 위한 메서드 정의
		public int deletePost(BoardDTO dto) {
			int result = 0;
			
			try {
				// 인파라미터가 있는 delete쿼리문 작성
				String query = "DELETE FROM board WHERE idx=?";
				
				psmt = con.prepareStatement(query);
				psmt.setString(1, dto.getIdx());
				
				result = psmt.executeUpdate();
			}
			catch (Exception e) {
				System.out.println("게시물 삭제 중 예외 발생");
				e.printStackTrace();
			}
			
			return result;
		}
	
	
}
