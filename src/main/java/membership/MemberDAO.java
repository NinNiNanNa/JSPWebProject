package membership;

import common.JDBConnect;
import jakarta.servlet.ServletContext;

public class MemberDAO extends JDBConnect {

	// 회원정보를 입력하기 위한 메소드 정의
	public int memberJoin(MemberDTO dto) {
		int result = 0;
		
		try {
			String query = "INSERT INTO members "
						 + " VALUES "
						 + " (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			
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
		boolean retValue = true;
		
		try {
			String query = "SELECT COUNT(*) FROM members WHERE id=?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			rs.next();
			
			int result = rs.getInt(1);
			if(result==1) 
				retValue = false;
		}
		catch(Exception e) {
			System.out.println("중복아이디 확인 중 예외발생");
			e.printStackTrace();
		}
		
		return retValue;
	}
	
	// 회원 로그인을 위한 메서드 정의
	public MemberDTO memberLogin(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		
		try {
			String query = "SELECT id, pass, name, email FROM members WHERE id=? AND pass=?";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			rs = psmt.executeQuery();
			
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
	
	// 아이디/비번 찾기를 위한 메서드 정의
	public MemberDTO memberFindIdPW(String uid, String uname, String uemail) {
		MemberDTO dto = new MemberDTO();
		String query = null;
		
		try {
			if(uid != null) {
				query = "SELECT * FROM members WHERE id=? AND name=? AND email=?";
			}
			else {
				query = "SELECT * FROM members WHERE name=? AND email=?";
			}
			
			psmt = con.prepareStatement(query);
			
			if(uid != null) {
				psmt.setString(1, uid);
				psmt.setString(2, uname);
				psmt.setString(3, uemail);
			}
			else {
				psmt.setString(1, uname);
				psmt.setString(2, uemail);
			}
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setTel(rs.getString(4));
				dto.setMobile(rs.getString(5));
				dto.setEmail(rs.getString(6));
				dto.setOpen_email(rs.getString(7));
				dto.setZipcode(rs.getString(8));
				dto.setAddr1(rs.getString(9));
				dto.setAddr2(rs.getString(10));
			}
		}
		catch(Exception e) {
			System.out.println("아이디,비번찾기 중 예외발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 회원정보 불러오기 위한 메서드 정의(회원정보수정에 필요)
	public MemberDTO memberInfo(String uid) {
		MemberDTO dto = new MemberDTO();
		
		try {
			String query = "SELECT * FROM members WHERE id=?";
			
			psmt = con.prepareStatement(query);

			psmt.setString(1, uid);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setTel(rs.getString(4));
				dto.setMobile(rs.getString(5));
				dto.setEmail(rs.getString(6));
				dto.setOpen_email(rs.getString(7));
				dto.setZipcode(rs.getString(8));
				dto.setAddr1(rs.getString(9));
				dto.setAddr2(rs.getString(10));
			}
		}
		catch(Exception e) {
			System.out.println("회원정보 불러오는 중 예외발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 회원정보 수정을 위한 메서드 정의
	public int memberModify(MemberDTO dto) {
		int result = 0;
		
		try {
			String query = " UPDATE members SET "
					+ " pass=?, name=?, tel=?, mobile=?, email=?, open_email=?, zipcode=?, addr1=?, addr2=? "
					+ " WHERE id=? ";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getTel());
			psmt.setString(4, dto.getMobile());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getOpen_email());
			psmt.setString(7, dto.getZipcode());
			psmt.setString(8, dto.getAddr1());
			psmt.setString(9, dto.getAddr2());
			
			psmt.setString(10, dto.getId());
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("회원정보수정 중 예외발생");
			e.printStackTrace();
		}
		
		return result;
	}

}