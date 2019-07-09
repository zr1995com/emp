<%--
  Created by IntelliJ IDEA.
  User: zr
  Date: 2019/6/15
  Time: 8:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div style="width:600px; margin:0px auto;">
    <div style="text-align:center">
        <h3>添加员工信息</h3>
    </div>
    <div style="text-align:left">
        <form action="${pageContext.request.contextPath}/add" method="post" id="form1" enctype="multipart/form-data">
            <table width="600" border="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td>员工姓名</td>
                    <td>
                        <input type="text" name="empname" id="empname" /></td>
                </tr>
                <tr>
                    <td>性别</td>
                    <td><input type="radio" name="sex" id="sex1" value="男" />
                        男
                        <input type="radio" name="sex" id="sex" value="女" />
                        女
                    </td>
                </tr>
                <tr>
                    <td>出生日期</td>
                    <td><input type="date" name="birthday" id="birthday" /></td>
                </tr>
                <tr>
                    <td>工资</td>
                    <td>
                        <input type="text" name="sal" id="sal" />
                    </td>
                </tr>
                <tr>
                    <td>部门</td>
                    <td>
                        <select name="deptno" id="deptno">
                            <option value="-1">-请选择-</option>
                            <c:if test="${requestScope.list!=null}">
                                <c:forEach items="${requestScope.list}" var="dept">
                                    <option value="${dept.deptno}">${dept.deptname}</option>
                                </c:forEach>
                            </c:if>
                        </select></td>
                </tr>
                <tr>
                    <td>照片</td>
                    <td>
                        <input type="file" id="picfile" name="picfile" />
                        <input type="hidden" id="picpath" name="picpath" />
                        <img width="30%" height="30%">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" valign="middle"><input type="submit" name="btnAdd" id="btnAdd" value="添加员工" />
                        &nbsp;<input type="reset" name="btnReturn" id="btnReturn" value="返回" /></td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
<script type="application/javascript" src="../js/jquery-1.8.0.min.js"></script>
<script type="application/javascript" src="../js/jquery.form.js"></script>
<script type="application/javascript">
    $(function () {
        $("#picfile").change(function () {
            $("#form1").ajaxSubmit({
                url:'/upload',
                type:'post',
                success:function (data) {
                    $("img").attr("src","/images/"+data);
                    $("#picpath").val(data);
                }
            });
        });
    });
</script>
</html>

