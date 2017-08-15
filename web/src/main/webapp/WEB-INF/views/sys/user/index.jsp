<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../../common/taglib.jsp" %>

<head>
    <title>用户管理</title>
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
            >用户管理
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
                    <td>账号：</td>
                    <td><input type="text" id="txtUsername" class="form-control input-small"
                               placeholder=""
                               value="${sysUserSearchVO.username }"></td>
                    <td>姓名：</td>
                    <td><input type="text" id="txtRealname" class="form-control input-middle"
                               placeholder=""
                               value="${sysUserSearchVO.realname }"></td>
                    <td>状态：</td>
                    <td><form:select path="sysUserSearchVO.status" class="form-control"
                                     id="cmbStatus">
                        <form:option value="" label="--全部--"/>
                        <form:option value="1">正常</form:option>
                        <form:option value="2">已锁定</form:option>
                    </form:select></td>
                    <td>角色：</td>
                    <td><form:select path="sysUserSearchVO.roleId" class="form-control"
                                     id="cmbRoleId">
                        <form:option value="" label="--全部--"/>
                        <form:options items="${listRole}" itemValue="value" itemLabel="content"/>
                    </form:select></td>
                    <td>
                        <button class="btn btn-primary" id="btnSearch">
                            <i class="ace-icon fa fa-search"></i> 查询
                        </button>
                        <c:if test="${critc:isP('SysUserAdd')}">
                            <button type="button" class="btn btn-success" id="btnAdd">
                                <i class="ace-icon fa fa-plus bigger-110"></i>新增
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
        <table id="simple-table" class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th width=40>#</th>
                <th width=120>账号</th>
                <th width="120">姓名</th>
                <th width="120">角色</th>
                <th width="120">创建人</th>
                <th width="140">创建时间</th>
                <th width="80">状态</th>
                <th width="80">登录记录</th>
                <th width="160">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list }" var="sysUser" varStatus="st">
                <tr>
                    <td>${st.index+1 }</td>
                    <td>${sysUser.username }</td>
                    <td>${sysUser.realname }</td>
                    <td>${sysUser.roleName }</td>
                    <td>${sysUser.createdBy }</td>
                    <td><fmt:formatDate value="${sysUser.createdAt }"
                                        pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>${critc:getUserStatus(sysUser.status)}</td>
                    <td>
                        <a href="javascript:viewLoginHis('${sysUser.id}','${sysUser.username}')">查看 </a>
                    </td>
                    <td><c:if test="${critc:isP('SysUserUpdate')}">
                        <a href="toUpdate.htm?id=${sysUser.id }&backUrl=${backUrl}"> 修改 </a>
                    </c:if>
                        <c:if test="${critc:isP('SysUserDelete')&&sysUser.isDelete==1}">
                        <a href="javascript:delUser(${sysUser.id });"> 删除 </a>
                    </c:if>
                        <c:if test="${critc:isP('SysUserLock')&&sysUser.status==1}">
                        <a href="javascript:lock(${sysUser.id });">锁定 </a>
                    </c:if>
                        <c:if test="${critc:isP('SysUserUnlock')&&sysUser.status==2}">
                        <a href="javascript:unlock(${sysUser.id });">解锁 </a>
                    </c:if>
                        <c:if test="${critc:isP('SysUserResetPass')}">
                        <a href="javascript:resetPass(${sysUser.id });">重置密码 </a>
                    </c:if></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="row">
    <div class="col-xs-12">${ pageNavigate.pageModel}</div>
</div>

<div class="modal fade" id="dialog-viewLogin" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document" style="width:1000px;height:500px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">登录历史</h4>
            </div>
            <div class="modal-body">
                <table id="loginHis" class="display" cellspacing="0" width="800">
                    <thead>
                    <tr>
                        <th width=40>#</th>
                        <th width=140>登录时间</th>
                        <th width="120">登录IP</th>
                        <th>终端</th>
                        <th>浏览器类型</th>
                        <th>浏览器版本</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>
<critc-script>
    <script type="text/javascript">
        var selUserId = 0;//定义选择的userId
        $(function () {
            $("#btnSearch").bind('click', searchUser);
            $("#btnAdd").bind('click', addUser);
        })

        // 查询方法
        var searchUser = function () {
            var url = "index.htm?";
            if ($("#txtUsername").val() != '')
                url += "username=" + $("#txtUsername").val();
            if ($("#txtRealname").val() != '')
                url += "&realname=" + $("#txtRealname").val();
            if ($("#cmbStatus").val() != '')
                url += "&status=" + $("#cmbStatus").val();
            if ($("#cmbRoleId").val() != '')
                url += "&role_id=" + $("#cmbRoleId").val();
            window.location = encodeURI(url);
        }
        // 删除
        var delUser = function (id) {
            bootbox.confirm("你确定要删除该用户吗？", function (result) {
                if (result) {
                    window.location = "delete.htm?id=" + id + "&backUrl=${backUrl}";
                }
            })
        }
        // 锁定
        var lock = function (id) {
            bootbox.confirm("你确定要锁定该用户吗？", function (result) {
                if (result) {
                    window.location = "saveLock.htm?id=" + id + "&backUrl=${backUrl}";
                }
            })
        }
        // 解锁
        var unlock = function (id) {
            bootbox.confirm("你确定要解锁该用户吗？", function (result) {
                if (result) {
                    window.location = "saveUnlock.htm?id=" + id + "&backUrl=${backUrl}";
                }
            })
        }
        // 重置密码
        var resetPass = function (id) {
            bootbox.confirm("你确定要给该用户重置密码吗？", function (result) {
                if (result) {
                    window.location = "saveResetPass.htm?id=" + id + "&backUrl=${backUrl}";
                }
            })
        }

        //新增
        var addUser = function (id) {
            window.location = 'toAdd.htm?backUrl=${backUrl }';
        }

        var viewLoginHis = function (id, title) {
            selUserId = id;
            $('#dialog-viewLogin').modal('show')
            $('#loginHis').DataTable().ajax.reload();


        }

        $(function () {
            //提示信息
            var lang = {
                //"sProcessing": "处理中...",
                "sLengthMenu": "每页 _MENU_ 项",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "当前显示第 _START_ 至 _END_ 项，共 _TOTAL_ 项。",
                "sInfoEmpty": "当前显示第 0 至 0 项，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix": "",
                "sSearch": "搜索:",
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上页",
                    "sNext": "下页",
                    "sLast": "末页",
                    "sJump": "跳转"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            };

            //初始化表格
            var table = $("#loginHis").dataTable({
                scrollY: '50vh',
                scrollCollapse: true,
                language: lang,  //提示信息
                autoWidth: false,  //禁用自动调整列宽
                stripeClasses: ["odd", "even"],  //为奇偶行加上样式，兼容不支持CSS伪类的场合
                processing: true,  //隐藏加载提示,自行处理
                serverSide: true,  //启用服务器端分页
                searching: false,  //禁用原生搜索
                orderMulti: false,  //启用多列排序
                ordering: false,
                bLengthChange: false,   //去掉每页显示多少条数据方法
                pageLength: 20,//每页多少条记录
                order: [],  //取消默认排序查询,否则复选框一列会出现小箭头
                renderer: "bootstrap",  //渲染样式：Bootstrap和jquery-ui
                pagingType: "bootstrap_full_number",  //分页样式：simple,simple_numbers,full,full_numbers
                ajax: function (data, callback, settings) {
                    //封装请求参数
                    var param = {};
                    param.pageSize = 20;//页面显示记录条数，在页面显示每页显示多少项的时候
                    param.start = data.start;//开始的记录序号
                    param.pageIndex = (data.start / data.length) + 1;//当前页码
                    param.userId = selUserId;
                    $.ajax({
                        type: "GET",
                        url: "searchUserLogin.htm",
                        cache: false,  //禁用缓存
                        data: param,  //传入组装的参数
                        dataType: "json",
                        success: function (result) {
                            //setTimeout仅为测试延迟效果
                            setTimeout(function () {
                                //封装返回数据
                                var returnData = {};
                                returnData.draw = data.draw;//这里直接自行返回了draw计数器,应该由后台返回
                                returnData.recordsTotal = result.total;//返回数据全部记录
                                returnData.recordsFiltered = result.total;//后台不实现过滤功能，每次查询均视作全部结果
                                returnData.data = result.data;//返回的数据列表
                                //调用DataTables提供的callback方法，代表数据已封装完成并传回DataTables进行渲染
                                //此时的数据需确保正确无误，异常判断应在执行此回调前自行处理完毕
                                callback(returnData);
                            }, 200);
                        }
                    });
                },
                //列表表头字段
                columns: [
                    {
                        "data": "index", "render": function (data, type, row, meta) {
                        var startIndex = meta.settings._iDisplayStart;
                        return startIndex + meta.row + 1;
                    }
                    },
                    {"data": "loginDate"},
                    {"data": "loginIp"},
                    {"data": "terminal"},
                    {"data": "explorerType"},
                    {"data": "explorerVersion"}
                ]
            }).api();
            //此处需调用api()方法,否则返回的是JQuery对象而不是DataTables的API对象
        });

    </script>
</critc-script>