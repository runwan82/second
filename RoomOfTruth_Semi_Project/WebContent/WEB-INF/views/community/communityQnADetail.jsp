<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="nav-bar">
		<a href="<%= request.getContextPath() %>/community/communityView" class="community-nav" >방 정보 공유&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a href="#" class="community-nav">질문과 답변</a>
	</div>


	<div class="qnaDetail">
		<h3>질문과 답변 </h3>
		
		<h1 class="questions-item__title text-heading-5 bold text-black">이불색상을 골라주세여 ㅠㅠ</h1>
		<p class="qnaContent" id="qnaDetailCon">커튼은 아이보리 색 입니다 이에 어울리는 이불색으로 뭐가 좋을까요?커튼은 아이보리 색 입니다 이에 어울리는 이불색으로 뭐가 좋을까요?커튼은 아이보리 색 입니다 이에 어울리는 이불색으로 뭐가 좋을까요?커튼은 아이보리 색 입니다 이에 어울리는 이불색으로 뭐가 좋을까요?커튼은 아이보리 색 입니다 이에 어울리는 이불색으로 뭐가 좋을까요?</p>
	
		<footer class="questions-item__footer">
            <span class="questions-item__footer__author">
                
                <span class="questions-item__footer__author__content text-caption-1">붕붕카파</span>
            </span>
            <span class="questions-item__footer__meta text-caption-1">
              <time datetime="2019-01-28T23:57:51+09:00" class="questions-item__footer__date text-gray">
                2020.01.28
              </time>
              <span class="questions-item__footer__comments text-gray">
               	 댓글
                <span class="questions-item__footer__comments__content active">
                  102
                </span>
              </span>
              <span class="questions-item__footer__views text-gray">
              	  조회
                <span class="questions-item__footer__views__content">1933</span>
              </span>
              <span class="questions-item__footer__views text-gray" onclick="reportBtn();">
              	  신고 
              </span>
            </span>
            
          </footer>
	
	</div>
	
	<!-- 작성자 -->
	<div id="qnaDetailProfile">
		<span class="qnaWriterView">
			<img src="../images/naver.png" alt="" />
			<span class="pnaWriter">반지하의 제왕</span>
		</span>
		<p>궁금한 것들 물어보세요!</p>
		<a class="questions-filter__actions__new-question btn btn-priority btn-sm" href="#">질문하러 가기</a>
	</div>
	
	
	<!-- 신고하기 추가 -->
	 <div id="reportBack"></div> 
	 <div id="reportWrap">
            <div class="report-wrap">
                <div class="button-wrap">
                    <p>신고사유를 선택해주세요</p>
                </div>
                <input type="button" id="closeBtn" value="x" onclick="reportCloseBtn();">
                
                <form action="<%= request.getContextPath() %>/member/login" id="login" method="post" class="report-group">
	                <input type="radio" name="chk_info" value="offTopic"checked="checked"/>주제와 맞지 않음 <br />
					<input type="radio" name="chk_info" value="inaccuracy" />정보가 부정확함<br />
					<input type="radio" name="chk_info" value="dvertising"/>지나친 광고성 게시글<br />
	                <input type="radio" name="chk_info" value="overlap"/>도배 및 중복 게시물<br />
					<input type="radio" name="chk_info" value="copyright" />저작권 침해가 우려됨<br />
					<input type="radio" name="chk_info" value="abuse"/>욕설/비방이 심함<br />
					<input type="radio" name="chk_info" value="obscene" />외설적인 게시물<br />
					<input type="radio" name="chk_info" value="privacy"/>개인정보노출<br />
                    <input type="submit" class="submit" id="reportSubmit" value="신고하기" />
                </form>
                
            </div>
        </div> 
	
	
	
	
	
	<!-- 댓글 -->
	<div id="qnaRepleWrap">
		<p>댓글 0</p>
		<div id="qnaReple">
			<input type="text" placeholder="댓글을 입력해주세요"/>
			<p>등록</p>
		</div>
	</div>
	
	

	
	
<script>
function filterBtn(){
	$(".filter-select__list").css('visibility', 'visible');
}
function reportBtn() {
	reportWrap.style.display = "block";
    reportBack.style.display = "block";
}
function reportCloseBtn() {
	reportWrap.style.display = "none";
    reportBack.style.display = "none";
}

</script>	

</body>
</html>