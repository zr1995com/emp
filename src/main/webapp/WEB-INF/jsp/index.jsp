<%--
  Created by IntelliJ IDEA.
  User: zr
  Date: 2019/6/14
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
/'
<head>
    <title>Title</title>
</head>
<body onload="chanclo()" >
<div style="width:980px; margin:0px auto; text-align:center">
    <div style="text-align:center">
        <h3>员工信息信息列表</h3>
    </div>
    <div style="text-align:center">
        <form action="${pageContext.request.contextPath}/index" method="post" id="form1">
            员工名称：

            <input type="text" name="empname" id="empname" value="${requestScope.empParam.empname}"/>
            部门:
            <select name="deptno" id="deptno">
                <option value="-1">--请选择--</option>
                <c:if test="${requestScope.list!=null}">
                    <c:forEach items="${requestScope.list}" var="dept">
                        <option value="${dept.deptno}"
                                <c:if test="${requestScope.empParam.deptno==dept.deptno}">selected="selected"</c:if>
                        >${dept.deptname}</option>
                    </c:forEach>
                </c:if>
            </select>&nbsp;&nbsp;
            工资：
            <input name="min_sal" type="text" id="min_sal" size="10" value="${empParam.min_sal}"/>
            到
            <input name="max_sal" type="text" id="max_sal" size="10" value="${empParam.max_sal}"/>
            <input type="hidden" id="pageIndex" name="pageIndex" value="1">
            &nbsp;&nbsp;&nbsp;<input type="submit" name="btnQuery" id="btnQuery" value="查询" />
        </form>
    </div>

    <div style="width:950px; padding-right:30px; line-height:40px; height:40px; text-align:right">
        <a href="javascript:do_delete_list()">多项删除</a>
        <a href="${pageContext.request.contextPath}/add">添加员工</a>
    </div>

    <form action="${pageContext.request.contextPath}/deletelist" method="get" id="form2" >
    <table width="980" border="1" cellspacing="0" cellpadding="0"  >
        <tr>
            <td>全选
                <input type="checkbox" name="ckbAll" id="ckbAll" /></td>
            <td>员工编号</td>
            <td>姓名</td>
            <td>性别</td>
            <td>生日</td>
            <td>部门名称</td>
            <td>详细</td>
            <td>删除</td>
            <td>修改</td>
        </tr>
        <c:if test="${requestScope.page.list!=null}">
            <c:forEach items="${requestScope.page.list}" var="emp">
                <tr>
                    <td><input type="checkbox" name="ckb" id="ckb" value="${emp.empno}"/></td>
                    <td>${emp.empno}</td>
                    <td>${emp.empname}</td>
                    <td>${emp.sex}</td>
                    <td>
                        <fmt:formatDate value="${emp.birthday}" pattern="yyyy-MM-dd"></fmt:formatDate>
                    </td>
                    <td>${emp.dept.deptname}</td>
                    <td><a href="${pageContext.request.contextPath}/get/${emp.empno}">详细</a></td>
                    <td><a href="javascript:do_delete(${emp.empno})">删除</a></td>
                    <td><a href="${pageContext.request.contextPath}/update/${emp.empno}">修改</a></td>
                </tr>
            </c:forEach>
        </c:if>
        <tr>
            <td colspan="9" align="center" valign="middle">
                <a href="javascript:do_page(1)">首页</a>
                <a href="javascript:do_page(${requestScope.page.pageNum-1})">上一页</a>
                <c:forEach items="${requestScope.page.navigatepageNums}" var="a">
                    <a href="javascript:do_page(${a})">${a}</a>
                </c:forEach>
                <a href="javascript:do_page(${requestScope.page.pageNum+1})">下一页</a>
                <a href="javascript:do_page(${requestScope.page.pages})">尾页</a>
                ${requestScope.page.pageNum}/${requestScope.page.pages}页
            </td>
        </tr>
    </table>
    </form>
</div>
</body>
<script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.0.min.js"></script>
<script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="application/javascript">
    function do_page(pn) {
        $("#pageIndex").val(pn);
        $("#form1").submit();
    }
    function do_delete(empno) {
        if (confirm("确认删除吗?")){
            location.href="${pageContext.request.contextPath}/delete/"+empno;
        }
    }
    $(function () {
       $("#ckbAll").click(function () {
          $(":checkbox[name='ckb']").prop("checked",this.checked)
       });

    });
    function do_delete_list() {
        if (confirm("确认删除吗")){
            $("#form2").submit();
        }
    }
    function chanclo() {
//获取标签
        var arr = document.getElementsByTagName("tr");
//for循环实现换色
        for (var i = 1; i< arr.length ; i++) {
//如果行数为偶数，背景颜色变为X色
            if (i % 2 == 0) {
                arr[i].style.backgroundColor = "ComflowerBlue";
            }
//如果行数为奇数，背景颜色变为Y色
            else {
                arr[i].style.backgroundColor = "LightSlateGray";
            }
        }
    }
</script>
</html>
