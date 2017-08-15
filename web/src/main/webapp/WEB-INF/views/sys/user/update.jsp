<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../../common/taglib.jsp" %>
<head>
    <title>用户管理</title>
</head>

<body class="no-skin">

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
<h1 class="page-title"> 用户管理
    <small>>>新增用户</small>
</h1>


<div class="row">
    <div class="col-md-12">
        <form id="userForm" name="userForm" class="form-horizontal" action="update.htm" method="post">
            <input type="hidden" name="id" value="${sysUser.id }">
            <input type="hidden" name="backUrl" value="${backUrl }">
            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">账号：</label>
                    <div class="col-md-9">
                        <input id="username" name="username" type="text" readonly="readonly"
                               class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysUser.username}"> <label
                            id="usernameTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">姓名：</label>
                    <div class="col-md-9">
                        <input id="realname" type="text" name="realname" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysUser.realname}"><label
                            id="realnameTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">手机：</label>
                    <div class="col-md-9">
                        <input id="mobile" type="text" name="mobile" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysUser.mobile}"><label id="mobileTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">Email：</label>
                    <div class="col-md-9">
                        <input id="email" type="text" name="email" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysUser.email}"><label id="emailTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">角色：</label>
                    <div class="col-md-9 ">
                        <form:select path="sysUser.roleId" name="roleId" class="form-control input-inline  input-xlarge"
                                     id="roleId">
                            <option value="">请选择角色</option>
                            <form:options items="${listRole }" itemValue="value" itemLabel="content"/>
                        </form:select>
                        <label id="roleIdTip"></label>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <div class="row">
                    <div class="col-md-offset-3 col-md-9">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"/></i> 保存</button>
                        <button type="button" class="btn default" onclick="history.back(-1)"><i
                                class="fa fa-undo"/></i>  取消
                        </button>
                    </div>
                </div>
            </div>

        </form>

    </div>
</div>
</body>

<critc-script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#userForm").validate({
                //debug : true,
                errorElement: "label",
                errorClass: "valiError",
                errorPlacement: function (error, element) {
                    error.appendTo($("#" + element.attr('id') + "Tip"));
                },
                rules: {
                    realname: {
                        required: true,
                        maxlength: 20
                    },
                    mobile: {
                        mobile: true,
                        required: true,
                        maxlength: 11
                    },
                    roleId: {
                        required: true
                    },
                    email: {
                        maxlength: 30
                    }
                },
                messages: {
                    username: {
                        remote: "账号已存在！"
                    }
                },
                submitHandler: function (form) {
                    form.submit();
                }
            });
        });
    </script>
</critc-script>