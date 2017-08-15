<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../../common/taglib.jsp" %>

<head>
    <title>角色管理</title>
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
            >角色管理
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
                    <td>
                        <button class="btn btn-primary" id="btnSearch">
                            <i class="fa fa-search"></i> 刷新
                        </button>
                        <c:if test="${critc:isP('SysRoleAdd')}">
                            <button type="button" class="btn btn-success" id="btnAdd">
                                <i class=" fa fa-plus bigger-110"></i> 新增
                            </button>
                        </c:if>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>


<div class="row">
    <div class="col-md-12">
        <table id="treeTable" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th width=60>序号</th>
                <th width=150>角色名称</th>
                <th>描述</th>
                <th width=100>创建人</th>
                <th width=160>创建时间</th>
                <th width="140">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list }" var="sysRole" varStatus="st">
                <tr>
                    <td>${st.index+1 }</td>
                    <td>
                        ${sysRole.name }
                    </td>
                    <td>${sysRole.description }</td>
                    <td>${sysRole.createdBy }</td>
                    <th width=120><fmt:formatDate value="${sysRole.createdAt}" pattern="yyyy-MM-dd HH:mm"/></th>
                    <td><c:if test="${critc:isP('SysRoleUpdate')}">
                        <a href="toUpdate.htm?id=${sysRole.id }&backUrl=${backUrl}"> 修改 </a>
                    </c:if> <c:if test="${sysRole.isDelete eq 1 && critc:isP('SysRoleDelete')}">
                        <a href="javascript:delRole(${sysRole.id });"> 删除 </a>
                    </c:if></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-md-12">${ pageNavigate.pageModel}</div>
</div>

</body>
<critc-script>
    <script type="text/javascript">
        $(function () {
            $("#btnSearch").bind('click', searchRole);
            $("#btnAdd").bind('click', addRole);
        })

        // 查询方法
        var searchRole = function () {
            var url = "index.htm?";
            window.location = encodeURI(url);
        }
        // 删除
        var delRole = function (id) {
            bootbox.confirm("你确定要删除该角色吗？", function (result) {
                if (result) {
                    window.location = "delete.htm?id=" + id + "&backUrl=${backUrl}";
                }
            })
        }
        //新增
        var addRole = function (id) {
            window.location = 'toAdd.htm?backUrl=${backUrl }';
        }

    </script>
</critc-script>