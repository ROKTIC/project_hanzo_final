<%@ page import="com.ezen.board.service.BoardService" %>
<%@ page import="com.ezen.board.service.BoardServiceImpl" %>
<%@ page import="com.ezen.member.dto.Member" %>
<%request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" class="com.ezen.board.dto.Article" scope="request"/>
<jsp:setProperty name="article" property="*"/>

<%
    request.setCharacterEncoding("utf-8");
    Member id = (Member) session.getAttribute("loginMember");
    String userId = id.getId();
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    String title = request.getParameter("write-title");
    String content = request.getParameter("article_content");
    int hitCount = Integer.parseInt(request.getParameter("hitCount"));

    article.setBoardNum(boardNum);
    article.setHitcount(hitCount);
    article.setArticleTitle(title);
    article.setUserId(userId);
    article.setArticleContent(content);

    BoardService boardService = new BoardServiceImpl();
    boardService.writeArticle(article);

    response.sendRedirect("/board/board.jsp");
%>