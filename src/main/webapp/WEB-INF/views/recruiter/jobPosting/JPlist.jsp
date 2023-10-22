<!DOCTYPE html>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="ko" xmlns:c="http://java.sun.com/jsp/jstl/core" xmlns:fmt="http://java.sun.com/jsp/jstl/fmt">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recruiter/jobposting/JPlist.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/base.css">
    <title>채용 공고 목록</title>
</head>

<body>
<%@ include file="../../layout/layoutNav.jsp" %>
<div  id="top" data-wow-duration="1s" data-wow-delay="0.5s">
    <div class="header-text" data-wow-duration="1s" data-wow-delay="1s">
    </div>
</div>
<%@ include file="../../layout/layoutSideRecruiter.jsp" %>
<main>
    <!--<article class="article-content">-->
    <article>
        <!-- 검색 활용 -->
        <!--<section>
            <ul class="webtong_tab_type03">
            <li class="dropdown">
                <a href="#" class="dropbtn">지역</a>
                <span class="dropdown-content">
                    <c:forEach items="${upperLoc}" var="upLoc">
                        <div class="checkbox-wrapper" onclick="toggleCheckbox(this)">
                            <input type="checkbox" name="upperLoc" id="${upLoc.detail_code_num}"
                                   value="${upLoc.detail_code_num}">
                            <span class="loc-detail-name">${upLoc.detail_name}</span>
                        </div>
                    </c:forEach>
                </span>
                <span class="dropdown-low-content">
                    <c:forEach items="${lowerLoc}" var="loLoc">
                        <div class="" onclick="toggleCheckbox(this)">
                            <input type="checkbox" name="lowerLoc" id="${loLoc.detail_code_num}"
                                   value="${loLoc.detail_code_num}">
                            <span class="loc-detail-name">${loLoc.detail_name}</span>
                        </div>
                    </c:forEach>
                </span>
            </li>
            <li><a href="/#">개인회원</a></li>
            <li class="searchContainer">
                <div class="searchWrapper">
                    <input type="text" id="searchInput" placeholder="검색어 입력">
                </div>
            </li>
        </ul>
        </section>-->
        <section>
            <div class="recruitment">
                <h4><!--채용 공고 정보--></h4>
            </div>
            <%--<c:forEach var="JPlist" items="${JPlist}"></c:forEach>--%>
            <div class="jobPostingList-container">
                <div class="info-container">
                    <c:forEach var="jobPosting" items="${jobPostingList}">
                        <div class="info-container-items">
                            <input type="hidden" id="posting_swork" name="posting_swork" ${jobPosting.posting_swork}>
                            <input type="hidden" id="posting_ework" name="posting_ework" ${jobPosting.posting_ework}>
                            <input type="hidden" id="posting_no" name="posting_no" ${jobPosting.posting_no}>
                            <a href="${cPath}/recruiter/JPdetail/${jobPosting.posting_no}" target="_blank">
                                <div class="info-items service-item first-service">
                                    <h3 class="posting_title">${jobPosting.posting_title}</h3>
                                    <div>
                                        <%--<span>${JPlist.company_address_detail}</span>--%>
                                        <span class="company_address">${fn:substring(jobPosting.company_address_detail, 0, 6)}</span>
                                        <span class="posting_career">${jobPosting.posting_career}</span>
                                        <span class="posting_academy">${jobPosting.posting_academy}</span>
                                        <span class="posting_labor">${jobPosting.posting_labor}</span>
                                        <span class="posting_salary">${jobPosting.posting_salary}</span>
                                        <span>
                                        <strong class="company_name"><a>${jobPosting.company_name}</a></strong>
                                    </span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <!--<a class="page-link" href="${pageContext.request.contextPath}/recruiter/JPlist?page=1">처음</a>-->
                        <a class="page-link" href="${pageContext.request.contextPath}/recruiter/JPlist?page=${currentPage - 1}">이전</a>
                    </c:if>

                    <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                        <c:choose>
                            <c:when test="${pageNum == currentPage}">
                                <span class="current page-link">${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                                <a class="page-link" href="${pageContext.request.contextPath}/recruiter/JPlist?page=${pageNum}">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a class="page-link" href="${pageContext.request.contextPath}/recruiter/JPlist?page=${currentPage + 1}">다음</a>
                        <!--<a class="page-link" href="${pageContext.request.contextPath}/recruiter/JPlist?page=${totalPages}">마지막</a>-->
                    </c:if>
                </div>
            </div>
        </section>
    </article>
</main>
<%@include file="../../layout/layoutFooter.jsp" %>
<!-- Scripts -->
<script src="/css/template/vendor/jquery/jquery.min.js"></script>
<script src="/css/template/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/css/template/assets/js/owl-carousel.js"></script>
<script src="/css/template/assets/js/animation.js"></script>
<script src="/css/template/assets/js/imagesloaded.js"></script>
<script src="/css/template/assets/js/popup.js"></script>
<script src="/css/template/assets/js/custom.js"></script>
<script src="/css/template/assets/js/side.js"></script>
<script>
    var dropdown = document.querySelector('.dropdown');

    dropdown.addEventListener('click', function () {
        this.classList.toggle('active');

        var dropdownContent = this.querySelector('.dropdown-content');

        if (this.classList.contains('active')) {
            dropdownContent.style.display = 'block';

            // 드롭다운 내부의 스크롤을 마우스로 조작 가능하도록 설정합니다.
            dropdownContent.style.overflowY = 'auto';

            // 이벤트 전파를 막아 클릭 시 드롭다운이 닫히지 않도록 합니다.
            dropdownContent.addEventListener('click', function (event) {
                event.stopPropagation();
            });
        } else {
            dropdownContent.style.display = 'none';
        }
    });
    window.addEventListener('click', function (event) {
        if (!event.target.matches('.dropbtn')) {
            var dropdowns = document.querySelectorAll('.dropdown');

            for (var i = 0; i < dropdowns.length; i++) {
                var openDropdown = dropdowns[i];

                if (openDropdown.classList.contains('active')) {
                    openDropdown.classList.remove('active');
                    openDropdown.querySelector('.dropdown-content').style.display = 'none';
                }
            }
        }
    });
</script>
<script>
    function toggleCheckbox(element) {
        var checkbox = element.querySelector('input[type="checkbox"]');
        checkbox.checked = !checkbox.checked;

        var locDetailName = element.querySelector('.loc-detail-name');
        locDetailName.classList.toggle('selected');
    }
</script>
<script>
    $(document).ready(function () {
        $('#searchInput').on('focus', function () {
            $('.input_placeholder').hide();
        });

        $('#searchInput').on('blur', function () {
            if ($(this).val().length == 0)
                $('.input_placeholder').show();
        });

        $('.input_placeholder').click(function () {
            $('#searchInput').focus();
        });
    });
</script>
<script>
    $(document).on('click', 'input[name="upperLoc"]', function () {
        let upperLoc = $(this).val();
        let isChecked = $(this).is(':checked');

        if (isChecked) { // 체크박스가 선택된 경우만 AJAX 요청
            $.ajax({
                url: '/recruiter/getJPLowerLoc', // 실제 서버 URL로 변경 필요
                type: 'GET',
                data: {upperLoc: upperLoc},
                dataType: 'json',
                success: function (response) {
                    let lowerLocContainer = $(".dropdown-low-content");
                    lowerLocContainer.empty(); // 기존 하위 지역 목록을 제거

                    $.each(response, function (index, loLoc) {
                        let lowerLocHtml = `
                        <div class="" onclick="toggleCheckbox(this)">
                            <input type="checkbox" name="lowerLoc" id="${loLoc.detail_code_num}" value="${loLoc.detail_code_num}">
                            <span class="loc-detail-name">${loLoc.detail_name}</span>
                        </div>
                    `;

                        lowerLocContainer.append(lowerLocHtml);
                    });
                }
            });
        } else {
            // 체크박스가 해제된 경우 하위 지역 목록 제거
            $(".dropdown-low-content").empty();
        }
    });
</script>
</body>
</html>
