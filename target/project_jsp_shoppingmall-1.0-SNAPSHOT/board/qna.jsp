<%@ page import="com.ezen.mall.web.common.page.Pagination" %>
<%@ page import="com.ezen.board.service.BoardService" %>
<%@ page import="com.ezen.board.service.BoardServiceImpl" %>
<%@ page import="com.ezen.board.dto.Article" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ezen.mall.web.common.page.PageParams" %>
<%--
    일상 게시판
 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("utf-8");
    int boardNum = 20;
    if (request.getParameter("boardNum") != null) {
        boardNum = Integer.parseInt(request.getParameter("boardNum"));
    }
    int requestPage = 1;
    if (request.getParameter("page") != null) {
        requestPage = Integer.parseInt(request.getParameter("page"));
    }
    int rowCount = 10;
    if (request.getParameter("count") != null) {
        rowCount = Integer.parseInt(request.getParameter("count"));
    }

    int pageSize = 10;

    String userId = (String) session.getAttribute("userId");
    if (userId != null) {
        response.sendRedirect("board.jsp");
    } else {
    }

    String searchType = request.getParameter("searchType");
    String searchValue = request.getParameter("searchText");

    BoardService boardService = new BoardServiceImpl();
    List<Article> list = boardService.articleList(rowCount, boardNum, requestPage, searchType, searchValue);
    request.setAttribute("list", list);

    int tableRowCount = boardService.getArticleCount(boardNum, searchType, searchValue);
    PageParams params = new PageParams(rowCount, pageSize, requestPage, tableRowCount);
    Pagination pagination = new Pagination(params);
    request.setAttribute("pagination", pagination);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HAN ZO</title>

    <link rel="stylesheet" href="/css/board.css">
    <link rel="stylesheet" href="/css/style.css">
    <script src="https://kit.fontawesome.com/89ab2ce88f.js" crossorigin="anonymous"></script>
</head>
<body>
<div id="wrapper">
    <!-- header start -->
    <jsp:include page="/module/header.jsp"/>
    <!-- header end -->
    <!-- nav start -->
    <jsp:include page="/module/nav.jsp"/>
    <!-- nav start -->
    <section class="notice">
        <div class="page-title">
            <div class="container">
                <h1>상품 Q&A 게시판</h1>
                <div class="list">
                    <div class="list-left">
                        <h3>고객 문의</h3>
                        <div class="list-left-desc">
                            고객님의 소중한 의견을 빠르고<br>
                            정확하게 해결하기 위해 최선을 다하겠습니다.
                        </div>
                    </div>
                    <div class="list-right">
                        <h3>1999-1999</h3>
                        <div class="list-right-desc">
                            상담시간 AM 9:00 ~ PM 5:30<br>
                            점심시간 PM 12:00 ~ PM 1:00<br>
                            (토/일/공휴일 휴무)
                        </div>
                    </div>
                </div>
            </div>
            <div id="board-search">
                <div class="container">
                    <div class="search-window">
                        <div class="search-wrap">
                            <form class="form-search" action="board.jsp" method="post">
                                <select class="search-type" name="searchType">
                                    <option name="searchType" value="">-검색-</option>
                                    <option name="searchType" value="t">제목</option>
                                    <option name="searchType" value="w">작성자</option>
                                </select>
                                <input type="text" placeholder="검색어를 입력해주세요." class="search-text" name="searchText">
                                <input type="text" name="count" value="<%=rowCount%>" style="opacity: 0;width: 0px;">
                                <input type="text" name="page" value="<%=requestPage%>" style="opacity: 0;width: 0px;">
                                <input type="text" name="boardNum" value="<%=boardNum%>" style="opacity: 0;width: 0px;">
                                <button class="btn btn-dark search-btn">검색</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="board-list">
                <div class="container">
                    <table class="board-table">
                        <thead>
                        <tr>
                            <th scope="col" class="th-num">번호</th>
                            <th scope="col" class="th-title">제목</th>
                            <th scope="col" class="th-writer">작성자</th>
                            <th scope="col" class="th-date">등록일</th>
                            <th scope="col" class="th-hitcount">조회수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="article" items="${list}" varStatus="loop">
                            <tr>
                                <td>${pagination.params.rowCount - ( (pagination.params.requestPage-1)* pagination.params.elementSize)-loop.index}</td>
                                <td>
                                    <a href="read.jsp?boardNum=${article.boardNum}&articleNum=${article.articleNum}">${article.articleTitle}(${article.countReply})</a>
                                </td>
                                <td>${article.userId}</td>
                                <td>${article.articleDate}</td>
                                <td>${article.hitcount}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div id="board-write">
                        <div class="container">
                            <div class="search-window">
                                <div class="search-wrap">
                                    <button type="button" class="btn btn-dark"><i class="fa-solid fa-pencil"></i>
                                        <a href="qnaWrite.jsp?boardNum=<%=boardNum%>"> 글쓰기</a></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="page">
                        <ul class="pagination modal">
                            <c:if test="${pagination.showFirst}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=1&searchType=${param.searchType}&searchText=${param.searchText}">처음</a>
                                </li>
                            </c:if>
                            <c:if test="${pagination.showPrevious}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${pagination.previousStartPage}&searchType=${param.searchType}&searchText=${param.searchText}">이전</a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                                <c:url var="list" value="board.jsp">
                                    <c:param name="page" value="${i}"/>
                                    <c:param name="searchType" value="${param.searchType}"/>
                                    <c:param name="searchText" value="${param.searchText}"/>
                                </c:url>
                                <li class="page-item <c:if test="${i == pagination.params.requestPage}">active</c:if>">
                                    <a class="page-link" href="${list}">${i}</a></li>
                            </c:forEach>
                            <c:if test="${pagination.showNext}">
                                <li class="page-item"><a class="page-link"
                                                         href="?page=${pagination.nextStartPage}&searchType=${param.searchType}&searchText=${param.searchText}">다음</a>
                                </li>
                            </c:if>
                            <c:if test="${pagination.showLast}">
                                <li class="page-item"><a class="page-link"
                                                         href="?page=${pagination.totalPages}&searchType=${param.searchType}&searchText=${param.searchText}">끝</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<%-- footer start --%>
<jsp:include page="/module/footer.jsp"/>
<%-- footer end --%>
</body>
</html>