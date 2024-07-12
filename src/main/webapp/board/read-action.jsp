<%@ page import="com.ezen.member.dto.Member" %>
<%@ page import="com.ezen.board.dto.ArticleComment" %>
<%@ page import="com.ezen.board.dao.JdbcArticleDao" %>
<%@ page import="com.ezen.board.dao.ArticleDao" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    request.setCharacterEncoding("utf-8");
    Member user = (Member) session.getAttribute("loginMember");
    String userid = user.getId();
    ArticleDao dao = new JdbcArticleDao();


    int articleNum = Integer.parseInt(request.getParameter("articleNum"));
    String replyInput = request.getParameter("reply-input");
    int boardNum = Integer.parseInt(request.getParameter("boardNum"));
    ArticleComment ac = new ArticleComment();
    ac.setUserId(userid);
    ac.setArticleNum(articleNum);
    ac.setCommentContent(replyInput);
    dao.createReply(ac);

    response.sendRedirect("/board/read.jsp?boardNum=" + boardNum + "&articleNum=" + articleNum);


%>