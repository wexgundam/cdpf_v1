<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../../common/taglib.jsp" %>
<head>
    <title>操作日志</title>
</head>
<body>
<div class="page-bar">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home"></i> <a href="${dynamicServer}/index.htm">首页</a>
        </li>
        <li>
            >系统管理
        </li>
        <li>
            >日志管理
        </li>
    </ul>
</div>
<div class="portlet box blue">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-cogs"></i>操作面板
        </div>
        <div class="tools">
            <a href="javascript:;" class="collapse"> </a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="table-responsive">
            <table class="searchTable">
                <tr>
                    <td>用户：</td>
                    <td>
                        ${critc:createCombo('sysUser',sysLogSearchVO.userId,2,'userId','userId','form-control input-small' )}
                        <%--${critc:createCombo2('{1:管理员,2:普通用户}',sysLogSearchVO.userId,2,'userId','userId','form-control input-small' )}--%>
                    </td>
                    <td>起止日期：</td>
                    <td><input type="text" id="startDate" class="form-control input-small"
                               placeholder="" value="${sysLogSearchVO.startDate }">
                    </td>
                    <td>至</td>
                    <td><input type="text" id="endDate" class="form-control input-small"
                               placeholder="" value="${sysLogSearchVO.endDate }"></td>
                    <td>
                        <button class="btn btn-primary" id="btnSearch">
                            <i class="ace-icon fa fa-search"></i> 查询
                        </button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <table id="simple-table" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th width=40>#</th>
                <th width="100">用户姓名</th>
                <th width="160">操作时间</th>
                <th width="120">模块名称</th>
                <th width="120">操作名称</th>
                <th>操作url</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${list }" var="sysLog" varStatus="st">
                <tr>
                    <td>${st.index+1 }</td>
                    <td>${sysLog.realname }</td>
                    <td><fmt:formatDate value="${sysLog.operaDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>${sysLog.moduleName }</td>
                    <td>${sysLog.operaName }</td>
                    <td>${sysLog.operaUrl }</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- /.span -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-xs-12">${ pageNavigate.pageModel}</div>
</div>

</body>
<critc-script>
    <script type="text/javascript">
        $(function () {
            $("#btnSearch").bind('click', searchUser);

            $('#startDate').datetimepicker({
                lang: 'ch',
                timepicker: false,
                format: 'Y-m-d'
            });
            $('#endDate').datetimepicker({
                lang: 'ch',
                timepicker: false,
                format: 'Y-m-d'
            });
        })

        // 查询方法
        var searchUser = function () {
            var url = "index.htm?";
            if ($("#userId").val() != '')
                url += "userId=" + $("#userId").val();
            if ($("#startDate").val() != '')
                url += "&startDate=" + $("#startDate").val();
            if ($("#endDate").val() != '')
                url += "&endDate=" + $("#endDate").val();
            window.location = encodeURI(url);
        }
    </script>
</critc-script>