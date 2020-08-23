package broker.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import broker.model.service.BrokerService;
import broker.model.vo.Broker;
import common.util.Utils;

/**
 * Servlet implementation class MemberEnrollServlet
 */
@WebServlet("/broker/enroll")
public class BrokerEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BrokerEnrollServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//memberEnroll.jsp view단 forwarding 처리
		
		RequestDispatcher reqDispatcher = request.getRequestDispatcher("/WEB-INF/views/broker/brokerEnroll.jsp");
		reqDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//사용자 회원가입정보를 db에 insert
		//1. 인코딩
		request.setCharacterEncoding("utf-8");
		
		//2. 사용자입력값 처리
		String br_cp_id = request.getParameter("br_cp_id");
		String email = request.getParameter("email");
		String password = Utils.getEncryptedPassword(request.getParameter("password"));
		String br_cp_name = request.getParameter("br_cp_name");
		String br_name = request.getParameter("br_name");
		String phone = request.getParameter("phone");
		String joindate = request.getParameter("joindate");
		String insurance = request.getParameter("insurance");
		
		//날짜타입으로 변경
		Date joindate_ = null;
		if(joindate != null && !"".equals(joindate))
			joindate_ = Date.valueOf(joindate);
		
		//Member객체로 만들기
		Broker newBroker = new Broker(br_cp_id, email, password, br_cp_name, br_name, phone, joindate_, insurance, 0, null, 0, null, null);
		System.out.println("newBroker="+newBroker);
		
		//3. 업무로직: db에 insert (DML -> int =>1,0)
		int result = new BrokerService().insertBroker(newBroker);
		System.out.println("result@brokerEnrollServlet="+result);
		
		//4. 사용자 응답처리 : msg.jsp
		String msg = result > 0 ? "회원 가입 성공!" : "회원 가입 실패!";
		String loc = "/";  
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	
		
		
	}

}
