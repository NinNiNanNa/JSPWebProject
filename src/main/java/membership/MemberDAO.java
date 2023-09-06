package membership;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class MemberDAO extends JDBConnect {

	// 회원정보를 입력하기 위한 메소드 정의
	public int insertMember(MemberDTO dto) {
		int result = 0;
		
		try {
			String query = "INSERT INTO members "
						 + " VALUES "
						 + " (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
			// 쿼리문 실행을 위한 prepared객체 생성
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getOpen_email());
			psmt.setString(8, dto.getZipcode());
			psmt.setString(9, dto.getAddr1());
			psmt.setString(10, dto.getAddr2());
			
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원가입 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 아이디 중복확인을 위한 메서드 정의
	public boolean idOverlap(String id) {
		// 초기값은 true로 설정. 중복된 아이디가 없는 경우.
		boolean retValue = true;
		
		try {
			// 중복된 아이디가 있는지 확인하기 위한 쿼리문
			String query = "SELECT COUNT(*) FROM members WHERE id=?";
			// prepared객체 생성 및 인파라미터 설정
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			// select계열의 쿼리문이므로 반환타입은 ResultSet
			rs = psmt.executeQuery();
			/*
			count()함수를 사용하므로 결과는 무조건 0 혹은 1
			따라서 if()문을 사용할 필요없이 next()를 호출한다.
			*/
			rs.next();
			int result = rs.getInt(1);
			// 중복된 아이디가 있어 1이 반환되면 false를 반환한다.
			if(result==1) 
				retValue = false;
		}
		catch(Exception e) {
			System.out.println("중복아이디 확인 중 예외발생");
			e.printStackTrace();
		}
		// 중복된 아이디가 없다면 0이므로 true를 반환한다.
		return retValue;
		
	}
	
	// 입력한 아이디, 패스워드를 통해 회원테이블을 select한 후 존재하는 회원인 경우 DTO객체에 레코드를 담아 반환
	public MemberDTO memberLogin(String uid, String upass) {
		
		// 회원인증을 위한 쿼리문을 실행한 후 회원정보를 저장하기 위해 생성
		MemberDTO dto = new MemberDTO();
		
		try {
			String query = "SELECT * FROM members WHERE id=? AND pass=?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			
			rs = psmt.executeQuery();
			
			// 반환된 ResultSet객체에 정보가 있는지 확인
			if(rs.next()) {
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setEmail(rs.getString(4));
			}
		}
		catch(Exception e) {
			System.out.println("회원로그인 중 예외발생");
			e.printStackTrace();
		}
		
		return dto;
		
	}
	
	// 아이디 찾기
	public String getMemberId(String uname, String uemail) {
		String id = null;
		String query = " SELECT id FROM member WHERE name=? AND email=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uname);
			psmt.setString(2, uemail);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				id = rs.getString("id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return id;
	}
	
	// 비밀번호 찾기
	public String getMemberPw(String uid, String uname, String uemail) {
		String pw = null;
		String query = " SELECT pass FROM member WHERE id=? AND name=? AND email=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, uname);
			psmt.setString(3, uemail);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				pw = rs.getString("pass");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return pw;
	}
	
	// 회원정보 수정
	public int memberEdit(MemberDTO dto) {
		int result = 0;
		String query = " UPDATE member "
				+ " SET pass=?, tel=?, mobile=?, email=?, mailing=?, zipcode=?, addr1=?, addr2=? "
				+ " WHERE name=? AND id=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getTel());
			psmt.setString(3, dto.getMobile());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getOpen_email());
			psmt.setString(6, dto.getZipcode());
			psmt.setString(7, dto.getAddr1());
			psmt.setString(8, dto.getAddr2());
			psmt.setString(9, dto.getName());
			psmt.setString(10, dto.getId());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원정보 수정 중 예외 발생");
			e.printStackTrace();
		}
		
		return result;
	}

}