<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/member.css" />
<script>
$(function(){
	
	$(".profile-nav").click(function(){
		$(".sub1").css("display", "block");
		$(".mypage-profile1").css("display", "block");
		$(".edit-info1").css("display", "none");
		$(".edit-info2").css("display", "none");
		$(".profile-nav").css("color", "rgb(255, 138, 61)");
		$(".setting-nav").css("color", "#000");
		$(".sub2").css("display", "none");
	});
	$(".setting-nav").click(function(){
		$(".sub1").css("display", "none");
		$(".mypage-profile1").css("display", "none");
		$(".mypage-profile2").css("display", "none");
		$(".mypage-profile3").css("display", "none");
		$(".edit-info2").css("display", "none");
		$(".sub2").css("display", "block");
		$(".edit-info1").css("display", "block");
		$(".setting-nav").css("color", "rgb(255, 138, 61)");
		$(".profile-nav").css("color", "#000");
	});
	
		$(".click1").click(function() {
			$(".mypage-profile1").css("display", "block");
			$(".mypage-profile2").css("display", "none");
			$(".mypage-profile3").css("display", "none");
		});
		$(".click2").click(function() {
			$(".mypage-profile2").css("display", "block");
			$(".mypage-profile1").css("display", "none");
			$(".mypage-profile3").css("display", "none");
		});
		$(".click3").click(function() {
			$(".mypage-profile3").css("display", "block");
			$(".mypage-profile2").css("display", "none");
			$(".mypage-profile1").css("display", "none");
		});
		$(".click4").click(function() {
			$(".edit-info1").css("display", "block");
			$(".edit-info2").css("display", "none");
		});
		$(".click5").click(function() {
			$(".edit-info2").css("display", "block");
			$(".edit-info1").css("display", "none");
		});
});
$(function(){
	$("#passwordUpdateFrm").submit(function(){
		
	var $newPwd = $("#newPassword");
	var $newPwdChk = $("#newPasswordCheck");
	
	if($newPwd.val() != $newPwdChk.val()){
		alert("입력한 비밀번호가 일치하지 않습니다.");
		$newPwd.select();
		return false;
	}
	return true;	
	});
});
//탈퇴
function deleteMember(){
	if(!confirm("정말 탈퇴하시겠습니까?")) return;
	$("[name=deleteMemberFrm]").submit();
}
$("#file").on('change',function(){
	  var fileName = $("#file").val();
	  $(".upload-name").val(fileName);
	});
//페이지내 이벤트

</script>
	<div class="mypage-nav-bar">
		<section class="mypage-nav">
			<ul >
				<li class="profile-nav">프로필</li>
				<li class="setting-nav" >설정</li>
			</ul>
		</section>
		<section class="setting-sub">
			<div class="sub1">
				<ul >
					<li class="click1">모두보기</li>
					<li class="click2">질문과 답변</li>
					<li class="click3"><a href="#" class="mypage-like">좋아요</a></li>
				</ul>
			</div>
			<div class="sub2">
				<ul >
					<li class="click4">회원정보수정</li>
					<li class="click5" >비밀번호 변경</li>
				</ul>	
			
			</div>
			
		</section>
	</div>
	<div class="mypage-profile1">
		<section class="mypage-allView">
			<form method="post" action="<%=request.getContextPath() %>/member/memberProfile" enctype="multipart/form-data">
			<table>
				<tr>
					<th></th>
					<td>
						<img id="profileImg" src="<%= request.getContextPath() %>/upload/member/<%= memberLoggedIn.getProfile() %>" alt="profile">
						
					</td>
				</tr>
				<tr>
					<th></th>
					<td >	
						<input type="text" name = "memberId" class="mypage-id" value="<%= memberLoggedIn.getMemberId() %>" readonly />
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<div class="filebox"> 
							<label for="file" >사진 업로드</label> 
							<input type="file" id="file" name="profile"> 
								<!-- <input class="upload-name" value="파일선택">  -->
						</div>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>	
						<input type="submit" value="변경" />
					</td>
				</tr>
			</table>
			</form>	
		</section>
	</div>
	<div class="mypage-profile2">
		<section class="mypage-allView">
			<form method="post" action="<%=request.getContextPath() %>/member/memberProfile" enctype="multipart/form-data">
			<table>
				<tr>
					<th></th>
					<td>
						<img id="profileImg" src="<%= request.getContextPath() %>/upload/member/<%= memberLoggedIn.getProfile() %>" onerror="this.src='<%= request.getContextPath() %>/upload/member/user.png'" alt="profile">
						
					</td>
				</tr>
				<tr>
					<th></th>
					<td >	
						<input type="text" name = "memberId" class="mypage-id" value="<%= memberLoggedIn.getMemberId() %>" readonly />
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<div class="filebox"> 
							<label for="file" >사진 업로드</label> 
							<input type="file" id="file" name="profile"> 
								<!-- <input class="upload-name" value="파일선택">  -->
						</div>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>	
						<input type="submit" value="변경" />
					</td>
				</tr>
			</table>
			</form>	
		</section>
	</div>
	<div class="mypage-profile3">
		<section class="mypage-allView">
			<form method="post" action="<%=request.getContextPath() %>/member/memberProfile" enctype="multipart/form-data">
			<table>
				<tr>
					<th></th>
					<td>
						<img id="profileImg" src="<%= request.getContextPath() %>/upload/member/<%= memberLoggedIn.getProfile() %>" alt="profile">
						
					</td>
				</tr>
				<tr>
					<th></th>
					<td >	
						<input type="text" name = "memberId" class="mypage-id" value="<%= memberLoggedIn.getMemberId() %>" readonly />
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<div class="filebox"> 
							<label for="file" >사진 업로드</label> 
							<input type="file" id="file" name="profile"> 
								<!-- <input class="upload-name" value="파일선택">  -->
						</div>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>	
						<input type="submit" value="변경" />
					</td>
				</tr>
			</table>
			</form>	
		</section>
	</div>
	
	
	<div class="edit-info1">
		<section class="edit-infoPage">
			<input type="button" id=deleteMem value="탈퇴하기" onclick="deleteMember();">
			<p>회원정보 수정</p>
			<form action="<%=request.getContextPath() %>/member/deleteMember" name="deleteMemberFrm" method="POST">
				<input type="hidden" name="memberId" value="<%=memberLoggedIn.getMemberId() %>" />
			</form>
			<form name="memberUpdateFrm" 
				  action="<%= request.getContextPath() %>/member/memberUpdate" method="post">
				<table>
					<tr>
						<th>아이디</th>
						<td>
							<input type="text" name="memberId" id="memberId_" 
								   value="<%= memberLoggedIn.getMemberId() %>" readonly required>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>	
							<input type="email"  name="email" id="email"
								   value="<%= memberLoggedIn.getEmail() %>"><br>
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>	
							<input type="tel"  id="userPhone" name="phone"
								   value="<%= memberLoggedIn.getPhone() %>"><br>
						</td>
					</tr>
				</table>
				<div class="editBtn">
					<input type="submit" value="회원정보수정" >
					<input type="reset" value="초기화">
				
				</div>
			</form>
		</section>
	</div>
	
	<div class="edit-info2" >
		<section class="edit-passwordPage">
			<p>비밀번호 변경</p>
			
			<form name="passwordUpdateFrm" id="passwordUpdateFrm"
				  action="<%= request.getContextPath() %>/member/updatePassword" method="post">
				  <input type="hidden" name="memberId" value="<%= memberLoggedIn.getMemberId() %>" />
				<table>
					<tr>
						<th>현재 비밀번호</th>
						<td>
							<input type="password" name="password" id="password" required>
						</td>
					</tr>
					<tr>
						<th>변경 비밀번호</th>
						<td>	
							<input type="password" name="newPassword" id="newPassword"><br>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>	
							<input type="password" id="newPasswordCheck" required><br>
						</td>
					</tr>
				</table>
				<div class="editBtn">
					<input type="submit" value="비밀번호 변경"  >
					<input type="reset" value="초기화">
				
				</div>
			</form>
		</section>
	</div>











</body>
</html>