package board.model.dao;

import static common.JDBCTemplate.close;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import board.model.exception.BoardException;
import board.model.vo.BoardComment;
import board.model.vo.BoardForList;
import board.model.vo.Room;
import board.model.vo.RoomBoard;
import board.model.vo.RoomImage;
import member.model.vo.Member;

public class BoardDAO {

	private Properties prop = new Properties();
	
	public BoardDAO() {
		try {
			//클래스객체 위치찾기 : 절대경로를 반환한다. 
			// "/" : 루트디렉토리를 절대경로로 URL객체로 반환한다.
			// "./" : 현재디렉토리를 절대경로로 URL객체로 반환한다.
			String fileName 
				= BoardDAO.class
						  .getResource("/sql/board/board-query.properties")
						  .getPath();
			prop.load(new FileReader(fileName));
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}

	//보드 넘버
	public int selectLastBoardSeq(Connection conn) {
		int boardNo = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectLastBoardSeq");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				boardNo = rset.getInt("board_num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		//System.out.println("boardNo@dao = " + boardNo);
		return boardNo;
	}

	//보드 등록
	public int insertBoard(Connection conn, RoomBoard newRoomBoard) {
		PreparedStatement pstmt = null;
		String query = prop.getProperty("insertBoard");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, newRoomBoard.getBr_cp_id());
			pstmt.setString(2, newRoomBoard.getBoard_title());
			pstmt.setString(3, newRoomBoard.getContent());
			pstmt.setString(4, newRoomBoard.getOriginalName());
			pstmt.setString(5, newRoomBoard.getRenameName());
			pstmt.setString(6, newRoomBoard.getOk());
			
			result = pstmt.executeUpdate();
			
			//System.out.println("result@dao="+result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int selectLastRoomSeq(Connection conn) {
		int roomNo = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectLastRoomSeq");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				roomNo = rset.getInt("room_num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		//System.out.println("roomNo@dao = " + roomNo);
		return roomNo;
	}
	
	//방 테이블
	public int insertRoom(Connection conn, Room newRoom) {
		PreparedStatement pstmt = null;
		String query = prop.getProperty("insertRoom");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, newRoom.getRoom_val());
			pstmt.setString(2, newRoom.getTax_val());
			pstmt.setInt(3, newRoom.getPrice());
			pstmt.setString(4, newRoom.getLocation());
			pstmt.setInt(5, newRoom.getSize());
			pstmt.setString(6, newRoom.getFloor());
			pstmt.setDate(7, newRoom.getMovedate());
			pstmt.setInt(8, newRoom.getFee());
			
			result = pstmt.executeUpdate();
			
			//System.out.println("Room@dao="+result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	//이미지테이블
	public int selectLastRoomImgSeq(Connection conn) {
		int imgNo = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectLastRoomImgSeq");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				imgNo = rset.getInt("img_num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		//System.out.println("imgNo@dao = " + imgNo);
		return imgNo;
	}

	public int insertRoomImg(Connection conn, RoomImage newRoomImg) {
		PreparedStatement pstmt = null;
		String query = prop.getProperty("insertRoomImg");
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, newRoomImg.getOriginalName());
			pstmt.setString(2, newRoomImg.getRenameName());

			result = pstmt.executeUpdate();
			
			//System.out.println("RoomImg@dao="+result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public List<RoomBoard> selectBoardList(Connection conn, int cPage, int numPerPage) {
		List<RoomBoard> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectBoardList");
		
		try{
			//미완성쿼리문을 가지고 객체생성. 
			pstmt = conn.prepareStatement(query);
			
			//시작 rownum과 마지막 rownum 구하는 공식
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			
			//쿼리문실행
			//완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				RoomBoard b = new RoomBoard();
				//컬럼명은 대소문자 구분이 없다.
				b.setBoard_num(rset.getInt("board_num"));
				b.setBr_cp_id(rset.getString("br_cp_id"));
				b.setBoard_title(rset.getString("board_title"));
				b.setContent(rset.getString("content"));
				b.setEnrolldate(rset.getDate("enrolldate"));
				b.setViewCount(rset.getInt("viewcount"));
				b.setOriginalName(rset.getString("originalname"));
				b.setRenameName(rset.getString("renamename"));
				b.setOk(rset.getString("ok"));
				/*
				b.setRoom_num(rset.getInt("room_num"));
				b.setBoard_num(rset.getInt("board_num"));
				b.setEnrolldate(rset.getDate("enrolldate"));
				b.setRoom_val(rset.getString("room_val"));
				b.setTax_val(rset.getString("tax_val"));
				b.setPrice(rset.getInt("price"));
				b.setLocation(rset.getString("location"));
				b.setSize(rset.getInt("size"));
				b.setFloor(rset.getString("floor"));
				b.setMovedate(rset.getDate("movedate"));
				b.setFee(rset.getInt("fee"));
				b.setFileName(rset.getString("filename"));
				*/
				list.add(b);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		//System.out.println("@@@@@dao"+list);
		return list;
	}

	public int selectBoardCount(Connection conn) {
		PreparedStatement pstmt = null;
		int totalContents = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectBoardCount");
		
		try{
			//미완성쿼리문을 가지고 객체생성. 
			pstmt = conn.prepareStatement(query);
			
			//쿼리문실행
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				totalContents = rset.getInt("cnt");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return totalContents;
	}

	public int updateOk(Connection conn, RoomBoard rb) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateOk");
		//update broker set black = ? where br_cp_id = ?
		
		try {
			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, updateMember.getPassword());
			pstmt.setString(1, rb.getOk());
			pstmt.setInt(2, rb.getBoard_num());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		//System.out.println("result@dao="+result);
		
		return result;
	}

	public int increaseBoardReadCount(Connection conn, int board_num) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseBoardReadCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new BoardException("조회수 증가 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public RoomBoard selectRoomBoardOne(Connection conn, int board_num) {
		RoomBoard b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectRoomBoardOne");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new RoomBoard();
				b.setBoard_num(rset.getInt("board_num"));
				b.setBr_cp_id(rset.getString("br_cp_id"));
				b.setBoard_title(rset.getString("board_title"));
				b.setContent(rset.getString("content"));
				b.setEnrolldate(rset.getDate("enrolldate"));
				b.setViewCount(rset.getInt("viewcount"));
				b.setOriginalName(rset.getString("originalname"));
				b.setRenameName(rset.getString("renamename"));
				b.setOk(rset.getString("ok"));
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		//System.out.println("board@dao = " + b);
		
		return b;
	}

	public Room selectRoomOne(Connection conn, int board_num) {
		Room r = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectRoomOne");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				r = new Room();
				r.setRoom_num(rset.getInt("room_num"));
				r.setBoard_num(rset.getInt("board_num"));
				r.setEnrolldate(rset.getDate("enrolldate"));
				r.setRoom_val(rset.getString("room_val"));
				r.setTax_val(rset.getString("tax_val"));
				r.setPrice(rset.getInt("price"));
				r.setLocation(rset.getString("location"));
				r.setSize(rset.getInt("size"));
				r.setFloor(rset.getString("floor"));
				r.setMovedate(rset.getDate("movedate"));
				r.setFee(rset.getInt("fee"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		//System.out.println("board@dao = " + r);
		
		return r;
	}


	public List<RoomImage> selectRoomImgList(Connection conn, int board_num) {
		List<RoomImage> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectRoomImgList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			rset = pstmt.executeQuery();
			
			list = new ArrayList<>();
			while(rset.next()) {
				int imgNum = rset.getInt("img_num");
				int boardNum = rset.getInt("board_num");
				String oName = rset.getString("originalname");
				String rName = rset.getString("renamename");
				
				RoomImage ri = new RoomImage(imgNum, boardNum, oName, rName);
				
				list.add(ri);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		System.out.println("List@dao = " + list);
		
		return list;
	}

	public int selectTotalContents(Connection conn, String room_val, String tax_val, int price, int fee) {
		int totalContents = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectFinderTotalContents");
		
		/*
		 * String columnName = ""; switch(searchType) { case "memberId": columnName =
		 * "member_id"; break; case "memberName": columnName = "member_name"; break;
		 * case "gender": columnName = "gender"; break; }
		 */
//		sql = sql.replace("#", columnName);
		System.out.println("sql@dao = " + sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,room_val );
			pstmt.setString(2, tax_val );
			pstmt.setInt(3, price);
			pstmt.setInt(4,fee );
			
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContents = rset.getInt("total_contents");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		System.out.println("totalContents@dao = " + totalContents);
		return totalContents;
	}

	public List<RoomBoard> searchBoardList(Connection conn, String room_val, String tax_val, int price, int fee,
			int cPage, int numPerPage) {
		List<RoomBoard> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchBoardPaging");
//		select * from member where # like ?
//		select * from member where member_name like ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  room_val );
			pstmt.setString(2,  tax_val );
			pstmt.setInt(3,  price );
			pstmt.setInt(4, fee );
			pstmt.setInt(5, (cPage - 1) * numPerPage + 1);
			pstmt.setInt(6, cPage * numPerPage);
			
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			while(rset.next()) {
				RoomBoard rb = new RoomBoard();
				rb.setBoard_num(rset.getInt("board_num"));
				rb.setBr_cp_id(rset.getString("br_cp_id"));
				rb.setBoard_title(rset.getString("board_title"));
				rb.setContent(rset.getString("content"));
				rb.setEnrolldate(rset.getDate("enrolldate"));
				rb.setViewCount(rset.getInt("viewcount"));
				rb.setOriginalName(rset.getString("originalname"));
				rb.setRenameName(rset.getString("renamename"));
				rb.setOk(rset.getString("ok"));
				list.add(rb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		System.out.println("list@dao = " + list);
		
		return list;
	}

	public List<RoomBoard> searchBoardList(Connection conn, String location, int cPage, int numPerPage) {
		List<RoomBoard> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchLocationBoardPaging");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,  "%"+location+"%");
			pstmt.setInt(2, (cPage - 1) * numPerPage + 1);
			pstmt.setInt(3, cPage * numPerPage);
			
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			while(rset.next()) {
				RoomBoard rb = new RoomBoard();
				rb.setBoard_num(rset.getInt("board_num"));
				rb.setBr_cp_id(rset.getString("br_cp_id"));
				rb.setBoard_title(rset.getString("board_title"));
				rb.setContent(rset.getString("content"));
				rb.setEnrolldate(rset.getDate("enrolldate"));
				rb.setViewCount(rset.getInt("viewcount"));
				rb.setOriginalName(rset.getString("originalname"));
				rb.setRenameName(rset.getString("renamename"));
				rb.setOk(rset.getString("ok"));
				list.add(rb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		System.out.println("list@@@dao = " + list);
		
		return list;
	}

	public int selectTotalContents(Connection conn, String location) {
		int totalContents = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectFinderLocationTotalContents");
		
		System.out.println("sql@dao = " + sql);
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,"%"+location+"%");
			
			rset = pstmt.executeQuery();
			if(rset.next())
				totalContents = rset.getInt("total_contents");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		System.out.println("totalContents@@@dao = " + totalContents);
		return totalContents;
	}



	
	/*
	public int selectBoardCount(Connection conn) {
		PreparedStatement pstmt = null;
		int totalContents = 0;
		ResultSet rset = null;
		String query = prop.getProperty("selectBoardCount");
		
		try{
			//미완성쿼리문을 가지고 객체생성. 
			pstmt = conn.prepareStatement(query);
			
			//쿼리문실행
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				totalContents = rset.getInt("cnt");
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return totalContents;
	}

	public List<Board> selectBoardList(Connection conn, int cPage, int numPerPage) {
		List<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = prop.getProperty("selectBoardList");
		
		try{
			//미완성쿼리문을 가지고 객체생성. 
			pstmt = conn.prepareStatement(query);
			
			//시작 rownum과 마지막 rownum 구하는 공식
			pstmt.setInt(1, (cPage-1)*numPerPage+1);
			pstmt.setInt(2, cPage*numPerPage);
			
			//쿼리문실행
			//완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				BoardForList b = new BoardForList();
				//컬럼명은 대소문자 구분이 없다.
				b.setBoardNo(rset.getInt("board_no"));
				b.setBoardTitle(rset.getString("board_title"));
				b.setBoardWriter(rset.getString("board_writer"));
				b.setBoardContent(rset.getString("board_content"));
				b.setBoardOriginalFileName(rset.getString("board_original_filename"));
				b.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				b.setBoardDate(rset.getDate("board_date"));
				b.setBoardReadCount(rset.getInt("board_readcount"));
				b.setCommentCnt(rset.getInt("comment_cnt"));
				
				list.add(b);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public Board selectOne(Connection conn, int boardNo) {
		Board board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectOne");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				board = new Board();
				board.setBoardNo(rset.getInt("board_no"));
				board.setBoardTitle(rset.getString("board_title"));
				board.setBoardWriter(rset.getString("board_writer"));
				board.setBoardContent(rset.getString("board_content"));
				board.setBoardOriginalFileName(rset.getString("board_original_filename"));
				board.setBoardRenamedFileName(rset.getString("board_renamed_filename"));
				board.setBoardDate(rset.getDate("board_date"));
				board.setBoardReadCount(rset.getInt("board_readcount"));
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		System.out.println("board@dao = " + board);
		
		return board;
	}

	public int increaseBoardReadCount(Connection conn, int boardNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("increaseBoardReadCounttttt");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			//사용자 예외객체 던지기**
			throw new BoardException("조회수 증가 오류!", e);
		} finally {
			close(pstmt);
		}
		
		return result;
	}	
	
	 public int deleteBoard(Connection conn, int board_no) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = prop.getProperty("deleteBoard"); 
		
		try {
			//미완성쿼리문을 가지고 객체생성.
			pstmt = conn.prepareStatement(query);
			//쿼리문미완성
			pstmt.setInt(1, board_no);
			
			//쿼리문실행 : 완성된 쿼리를 가지고 있는 pstmt실행(파라미터 없음)
			//DML은 executeUpdate()
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		
		return result;
	}

	public int updateBoard(Connection conn, Board board) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getBoardTitle());
			pstmt.setString(2, board.getBoardContent());
			pstmt.setString(3, board.getBoardOriginalFileName());
			pstmt.setString(4, board.getBoardRenamedFileName());
			pstmt.setInt(5, board.getBoardNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		System.out.println("result@dao = " + result);
		
		return result;
	}

	public int insertBoardComment(Connection conn, BoardComment bc) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertBoardComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bc.getBoardCommentLevel());
			pstmt.setString(2, bc.getBoardCommentWriter());
			pstmt.setString(3, bc.getBoardCommentContent());
			pstmt.setInt(4, bc.getBoardRef());
			
			//board_comment_ref에 null을 추가할때,
			//setInt(null)을 지원하지 않으므로, setString(null)
//			pstmt.setInt(5, bc.getBoardCommentRef());//0
			String boardCommentRef
				= bc.getBoardCommentRef() == 0 
					? null
						: String.valueOf(bc.getBoardCommentRef());
			pstmt.setString(5,boardCommentRef);
			
			//실행
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("result@dao = " + result);
		
		return result;
	}

	public List<BoardComment> selectCommentList(Connection conn, int boardNo) {
		List<BoardComment> commentList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCommentList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			commentList = new ArrayList<>();
			while(rset.next()) {
				int boardCommentNo = rset.getInt("board_comment_no");
				int boardCommentLevel = rset.getInt("board_comment_level");
				String boardCommentWriter = rset.getString("board_comment_writer");
				String boardCommentContent = rset.getString("board_comment_content");
				int boardRef = rset.getInt("board_ref");
				int boardCommentRef = rset.getInt("board_comment_ref");//null값은 0으로 치환
				Date boardCommentDate = rset.getDate("board_comment_date");
						
				BoardComment bc = new BoardComment(boardCommentNo, boardCommentLevel, boardCommentWriter, boardCommentContent, boardRef, boardCommentRef, boardCommentDate);
				
				commentList.add(bc);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		System.out.println("commentList@dao = " + commentList);
		
		return commentList;
	}

	public int deleteBoardComment(Connection conn, int boardCommentNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteBoardComment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardCommentNo);
			result = pstmt.executeUpdate();  //dml
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		System.out.println("result@dao = "+result);
		return result;
	}
	
*/
}
