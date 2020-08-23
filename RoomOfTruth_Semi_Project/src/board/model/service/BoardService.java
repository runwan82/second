package board.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import board.model.dao.BoardDAO;
import board.model.vo.BoardComment;
import board.model.vo.BoardForList;
import board.model.vo.Room;
import board.model.vo.RoomBoard;
import board.model.vo.RoomImage;
import member.model.vo.Member;

public class BoardService {
	private BoardDAO boardDAO = new BoardDAO();


	public int insertBoard(RoomBoard newRoomBoard) {
		Connection conn = getConnection();
		int result = new BoardDAO().insertBoard(conn, newRoomBoard);
		//트랜잭션 처리
		if(result>0) {
			int boardNo = new BoardDAO().selectLastBoardSeq(conn);
			//controller에서도 board객체의 참조주소를 통해 접근할 수 있다.
			newRoomBoard.setBoard_num(boardNo);
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}

	public int insertRoom(Room newRoom) {
		Connection conn = getConnection();
		int result = new BoardDAO().insertRoom(conn, newRoom);
		//트랜잭션 처리
		if(result>0) {
			int roomNo = new BoardDAO().selectLastRoomSeq(conn);
			//controller에서도 board객체의 참조주소를 통해 접근할 수 있다.
			newRoom.setRoom_num(roomNo);
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}

	public int insertBoardImg(RoomImage newRoomImg) {
		Connection conn = getConnection();
		int result = new BoardDAO().insertRoomImg(conn, newRoomImg);
		//트랜잭션 처리
		if(result>0) {
			int imgNo = new BoardDAO().selectLastRoomImgSeq(conn);
			//controller에서도 board객체의 참조주소를 통해 접근할 수 있다.
			newRoomImg.setImg_num(imgNo);
			commit(conn);
		}
		else 
			rollback(conn);
		close(conn);
		return result;
	}

	public List<RoomBoard> selectBoardList(int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<RoomBoard> list= boardDAO.selectBoardList(conn, cPage, numPerPage);
		close(conn);
		return list;
	}

	public int selectBoardCount() {
		Connection conn = getConnection();
		int totalContents = boardDAO.selectBoardCount(conn);
		close(conn);
		return totalContents;
	}

	public int updateOk(RoomBoard rb) {
		Connection conn = getConnection();
		int result = new BoardDAO().updateOk(conn, rb);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public RoomBoard selectRoomBoardOne(int board_num, boolean hasRead) {
		Connection conn = getConnection();
		int result = 0;
		//조회수 증가
		if(!hasRead)
			result = boardDAO.increaseBoardReadCount(conn, board_num);
		
		RoomBoard board = boardDAO.selectRoomBoardOne(conn, board_num);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return board;
	}

	public Room selectRoomOne(int board_num) {
		Connection conn = getConnection();
		int result = 0;
		Room room = boardDAO.selectRoomOne(conn, board_num);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return room;
	}

	public List<RoomImage> selectRoomImgList(int board_num) {
		Connection conn = getConnection();
		List<RoomImage> list= boardDAO.selectRoomImgList(conn, board_num);
		close(conn);
		return list;
	}

	public int selectTotalContents(String room_val, String tax_val, int price, int fee) {
		Connection conn = getConnection();
		int totalContents = boardDAO.selectTotalContents(conn, room_val, tax_val, price, fee);
		close(conn);
		return totalContents;
	}

	public List<RoomBoard> searchBoardList(String room_val, String tax_val, int price, int fee, int cPage,
			int numPerPage) {
		Connection conn = getConnection();
		List<RoomBoard> list = boardDAO.searchBoardList(conn, room_val, tax_val, price, fee, cPage, numPerPage);
		close(conn);
		return list;
	}

	public List<RoomBoard> searchBoardList(String location, int cPage, int numPerPage) {
		Connection conn = getConnection();
		List<RoomBoard> list = boardDAO.searchBoardList(conn, location, cPage, numPerPage);
		close(conn);
		return list;
	}

	public int selectTotalContents(String location) {
		Connection conn = getConnection();
		int totalContents = boardDAO.selectTotalContents(conn, location);
		close(conn);
		return totalContents;
	}



	
	
	/*
	 * public int selectBoardCount() {
		Connection conn = getConnection();
		int totalContents = boardDAO.selectBoardCount(conn);
		close(conn);
		return totalContents;
	}

	public Board selectOne(int boardNo) {
		Connection conn = getConnection();
		Board board = boardDAO.selectOne(conn, boardNo);
		close(conn);
		return board;
	}

	public Board selectOne(int boardNo, boolean hasRead) {
		Connection conn = getConnection();
		int result = 0;
		//조회수 증가
		if(!hasRead)
			result = boardDAO.increaseBoardReadCount(conn, boardNo);
		
		Board board = boardDAO.selectOne(conn, boardNo);
		
		if(result > 0) commit(conn);
		else rollback(conn);
		
		close(conn);
		return board;
	}

	public int deleteBoard(int board_no) {
		Connection conn = getConnection();
		int result = new BoardDAO().deleteBoard(conn, board_no);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		
		return result;
	}

	public int updateBoard(Board board) {
		Connection conn = getConnection();
		int result = boardDAO.updateBoard(conn, board);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public int insertBoardComment(BoardComment bc) {
		Connection conn = getConnection();
		int result = boardDAO.insertBoardComment(conn, bc);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}

	public List<BoardComment> selectCommentList(int boardNo) {
		Connection conn = getConnection();
		List<BoardComment> commentList
			= boardDAO.selectCommentList(conn, boardNo);
		close(conn);
		return commentList;
	}

	public int deleteBoardComment(int boardCommentNo) {
		Connection conn = getConnection();
		int result = boardDAO.deleteBoardComment(conn, boardCommentNo);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		
		return result;
	}

*/
}
