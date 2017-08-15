<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../../common/taglib.jsp" %>
<html lang="en">
<head>
    <title>修改密码</title>
</head>

<body>
<div class="page-bar">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home"></i> <a href="${dynamicServer}/index.htm">首页</a>
        </li>
        <li>
            >修改密码
        </li>
    </ul>
</div>
<h1 class="page-title"> 修改密码
</h1>


<div class="row">
    <div class="col-md-12">
        <form id="userForm" name="userForm" class="form-horizontal" action="saveUpdatePass.htm" method="post">
            <input type="hidden" name="backUrl" value="${backUrl }">
            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">原密码：</label>
                    <div class="col-md-9">
                        <input id="oldPass" name="oldPass" type="password" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value=""> <label
                            id="oldPassTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">新密码：</label>
                    <div class="col-md-9">
                        <input id="newPass" type="password" name="newPass" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value=""><label
                            id="newPassTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">确认新密码：</label>
                    <div class="col-md-9">
                        <input id="renewPass" type="password" name="renewPass"
                               class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value=""><label
                            id="renewPassTip"></label>
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
        $(function () {
            var validate = $("#userForm").validate({
                errorElement: "label",
                errorClass: "valiError",
                errorPlacement: function (error, element) {
                    error.appendTo($("#" + element.attr('id') + "Tip"));
                },
                rules: {
                    oldPass: {
                        required: true,
                        minlength: 6,
                        maxlength: 20
                    },
                    newPass: {
                        required: true,
                        minlength: 6,
                        maxlength: 20
                    },
                    renewPass: {
                        required: true,
                        minlength: 6,
                        maxlength: 20,
                        equalTo: "#newPass"
                    },
                },
                messages: {
                    renewPass: {
                        equalTo: "确认新密码与新密码输入不一致"
                    }
                },
                submitHandler: function (form) {
                    form.submit();
                }
            });
        });
    </script>
</critc-script>
</html>
