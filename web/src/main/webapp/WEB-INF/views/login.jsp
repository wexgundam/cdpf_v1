<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>${webTitle}</title>
    <%@ include file="common/styles.jspf" %>
    <link rel="stylesheet" href="${staticServer}/assets/common/css/login.min.css?versionNo=${versionNo}"/>
</head>
<body class="login">
<!-- BEGIN LOGO -->
<div class="logo">
</div>
<!-- END LOGO -->
<!-- BEGIN LOGIN -->
<div class="content">
    <!-- BEGIN LOGIN FORM -->
    <form class="login-form" id="loginForm" action="" method="post">
        <h3 class="form-title">${webTitle}-登录</h3>
        <div class="alert alert-danger display-hide" id="loginAlert">
            <button class="close" data-close="alert"></button>
            <i class="fa-lg fa fa-warning"></i> <span id="lblMessage"> 账号或密码输入错误！ </span>
        </div>
        <div class="form-group">
            <label class="control-label visible-ie8 visible-ie9">账号</label>
            <div class="input-icon">
                <i class="fa fa-user"></i>
                <input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="账号"
                       name="username" id="username"/></div>
        </div>
        <div class="form-group">
            <label class="control-label visible-ie8 visible-ie9">密码</label>
            <div class="input-icon">
                <i class="fa fa-lock"></i>
                <input class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="密码"
                       name="password" id="password"/></div>
        </div>
        <div class="form-actions">
            <label class="rememberme mt-checkbox mt-checkbox-outline">
                <input type="checkbox" name="remember" value="1" id="chk"/> 记住我
                <span></span>
            </label>
            <button type="submit" class="btn blue pull-right"> 登录</button>
        </div>
        <div class="forget-password">
            <p> 版权所有@
                <a href="javascript:;" id="forget-password">  </a>  </p>
        </div>
    </form>
    <!-- END LOGIN FORM -->
</div>
</body>
<%@ include file="common/scripts.jspf" %>
<script type="text/javascript">
    $(function () {
        $('#username').bind('keypress',function(event){
            if(event.keyCode == 13)
            {
                $("#loginForm").submit();
            }
        });
        $('#password').bind('keypress',function(event){
            if(event.keyCode == 13)
            {
                $("#loginForm").submit();
            }
        });


        $("#loginForm").validate({
            errorElement: "label",
            errorClass: "valiError",
            errorPlacement: function (error, element) {
            },
            rules: {
                username: {
                    required: true
                },
                password: {
                    required: true
                }
            },
            messages: {
                username: {
                    required: ""
                },
                password: {
                    required: ""
                }
            },
            submitHandler: function (form) {
                checkLogin();
            }
        });

        var cookie_chk = Cookies.get('critc_chk');
        if (cookie_chk != '' && cookie_chk != null && cookie_chk == '1') {
            $('#chk').prop("checked", true);
            $('#username').val(Cookies.get('critc_username'));
        }
    });

    function checkLogin() {
        if ($('#chk').is(':checked')) {
            Cookies.set('critc_chk', '1', {expires: 10, path: '/'});
            Cookies.set('critc_username', $('#username').val(), {expires: 10, path: '/'});
        } else {
            Cookies.set('critc_chk', '0', {expires: 10, path: '/'});
        }

        var username = $("#username").val();
        var password = $("#password").val();
        $.ajax({
            type: "post",
            url: "${dynamicServer}/checkLogin.htm",
            data: {
                username: username,
                password: password
            },
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    $("#loginAlert").hide();
                    window.location.href = "${dynamicServer}/index.htm";
                } else {
                    $("#lblMessage").html(data.msgText);
                    $("#loginAlert").show();
                }
            },
            error: function (data) {
                $("#lblMessage").html('登录失败');
                $("#loginAlert").show();
            }
        });
    }

</script>
</html>