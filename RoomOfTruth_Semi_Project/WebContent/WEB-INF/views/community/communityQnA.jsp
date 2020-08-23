<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="nav-bar">
		<a href="<%= request.getContextPath() %>/community/communityView" class="community-nav" >방 정보 공유&nbsp;&nbsp;&nbsp;&nbsp;</a>
		<a href="#" class="community-nav">질문과 답변</a>
	</div>

	<!-- content -->
	
	<div class="commu-info-container">
		<section id="features">
					<div class="container">
						<div class="row aln-center">
							<div class="col-4 col-6-medium col-12-small">

								<!-- Feature -->
									<div class="questions-filter__content container">
						          <div class="questions-filter__filters">
						            <div class="filter-select" id="questions-filter-sort" data-modal-id="questions-filter-sort-modal">
						              <dl class="filter-select__header" role="button" onclick="filterBtn()">
						                <dt class="filter-select__header__name">
						                  정렬 ▼<span class="icon icon-pointer-angle-down-dark-sm"></span>
						                </dt>
						                <dd class="filter-select__header__value">최신순</dd>
						              </dl>
						              <ul class="filter-select__list">
						                  <li class="filter-select__list__entry ">
						                    <a href="/questions?order=popular&amp;page=1">인기순</a>
						                  </li>
						                  <li class="filter-select__list__entry active">
						                    <a href="/questions?order=recent&amp;page=1">최신순</a>
						                  </li>
						                  <li class="filter-select__list__entry ">
						                    <a href="/questions?order=recent_comments&amp;page=1">최근 답변순</a>
						                  </li>
						              </ul>
						            </div>
						          </div>
						          <div class="questions-filter__actions">
						              <a class="set-reply btn btn-normal btn-sm" href="#">
						                답변을 기다리는 질문</a>            
						                <a class="questions-filter__actions__new-question btn btn-priority btn-sm" href="#">질문하기</a>
						          </div>
						        </div>
							</div>
							
							<div  id="info-questionList" >
								<!-- 질문 목록1 -->
									
									<article class="questions-item" onclick="location.href='<%= request.getContextPath() %>/community/communityQnADetail'" >
						            <div class="questions-item__image" >
						              <div class="image-wrap square">
						                <img src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-cards-snapshots-1548687459_vMyG4GyO.jpeg/320/320">
						              </div>
						            </div>
						          <h1 class="questions-item__title text-heading-5 bold text-black">이불색상을 골라주세여 ㅠㅠ</h1>
						          <p class="questions-item__content" id="text-caption-1">커튼은 아이보리 색 입니다 이에 어울리는 이불색으로 뭐가 좋을까요?</p>
						          <footer class="questions-item__footer">
						            <span class="questions-item__footer__author">
						                <span class="questions-item__footer__author__image">
						                    <img src="../images/naver.png">
						                </span>
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
						            </span>
						            
						          </footer>
						        </article>

							</div>
							
							
							<div  id="info-questionList">
								<!-- 질문 목록2 -->
									
									<article class="questions-item">
						            <div class="questions-item__image">
						              <div class="image-wrap square">
						                <img src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-cards-snapshots-1548687459_vMyG4GyO.jpeg/320/320">
						              </div>
						            </div>
						          <h1 class="questions-item__title text-heading-5 bold text-black">이불색상을 골라주세여 ㅠㅠ</h1>
						          <p class="questions-item__content" id="text-caption-1">오늘의 집 질문과 답변 통해서 꾸며본 자취방이에요!! 많이 도와주셔서 모두들 감사합니다!! 새해 복 많이 받으세요</p>
						          <footer class="questions-item__footer">
						            <span class="questions-item__footer__author">
						                <span class="questions-item__footer__author__image">
						                    <img src="../images/naver.png">
						                </span>
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
						            </span>
						            
						          </footer>
						        </article>

							</div>
							
							
							<div  id="info-questionList">
								<!-- 질문 목록3 -->
									
									<article class="questions-item">
						            <div class="questions-item__image">
						              <div class="image-wrap square">
						                <img src="https://image.ohou.se/image/central_crop/bucketplace-v2-development/uploads-cards-snapshots-1548687459_vMyG4GyO.jpeg/320/320">
						              </div>
						            </div>
						          <h1 class="questions-item__title text-heading-5 bold text-black">이불색상을 골라주세여 ㅠㅠ</h1>
						          <p class="questions-item__content" id="text-caption-1">커튼은 아이보리 색 입니다 이에 어울리는 이불색으로 뭐가 좋을까요?</p>
						          <footer class="questions-item__footer">
						            <span class="questions-item__footer__author">
						                <span class="questions-item__footer__author__image">
						                    <img src="../images/naver.png">
						                </span>
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
						            </span>
						            
						          </footer>
						        </article>

							</div>
							
							
						</div>
					</div>
				</section>
		
		
	</div>
<script>
function filterBtn(){
	$(".filter-select__list").css('visibility', 'visible');
}


</script>	

</body>
</html>