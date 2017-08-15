<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>个人信息</title>
</head>
<critc-css>
    <link rel="stylesheet" href="${staticServer}/assets/cropper3.0/cropper.min.css"/>
    <link rel="stylesheet" href="${staticServer}/assets/cropper3.0/main.css"/>
    <link href="${staticServer}/assets/metronic4.7/pages/css/profile.min.css" rel="stylesheet" type="text/css"/>

</critc-css>
<body>
<div class="page-bar">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home"></i> <a href="${dynamicServer}/index.htm">首页</a>
        </li>
        <li>
            >个人信息
        </li>
    </ul>
</div>
<h1 class="page-title"> 个人信息
    <small>>>设置</small>
</h1>
<div class="row">
    <div class="col-md-12">
        <!-- 左边头像-->
        <div class="profile-sidebar">
            <!-- PORTLET MAIN -->
            <div class="portlet light profile-sidebar-portlet  bg-inverse">
                <!-- SIDEBAR USERPIC -->
                <div class="profile-userpic">
                    <img id="imgAvatar" src="${imageServer}${sysUser.avatar}" class="img-responsive" alt="">
                </div>
                <!-- END SIDEBAR USERPIC -->
                <!-- SIDEBAR USER TITLE -->
                <div class="profile-usertitle">
                    <div class="profile-usertitle-name"><i class="fa fa-credit-card"></i> ${sysUser.realname}</div>
                    <div class="profile-usertitle-job"><i class="fa fa-phone-square"></i> ${sysUser.mobile}</div>
                </div>
                <!-- END SIDEBAR USER TITLE -->
                <!-- SIDEBAR BUTTONS -->
                <div class="profile-userbuttons">
                    <button type="button" class="btn btn-circle blue btn-sm" id="btnEditAvatar">编辑头像</button>
                    <button type="button" class="btn btn-circle red btn-sm">Message</button>
                </div>
                <br/>
                <br/>
                <!-- END SIDEBAR BUTTONS -->
            </div>
        </div>

        <!--右边内容-->
        <div class="profile-content">
            <div class="row">
                <div class="col-md-12">

                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption font-yellow-crusta">
                                <i class="icon-share font-yellow-crusta"></i>
                                <span class="caption-subject bold uppercase"> 基本信息</span>
                                <span class="caption-helper">修改</span>
                            </div>
                            <div class="actions">
                                <a class="btn btn-circle btn-icon-only btn-default fullscreen" href="javascript:;"> </a>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="scroller" style="height:360px" data-always-visible="1" data-rail-visible="1"
                                 data-handle-color="green">
                                <form id="userForm" name="userForm" class="form-horizontal" action="updateInfo.htm"
                                      method="post">
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
                                                <input id="realname" type="text" name="realname"
                                                       class="form-control input-inline  input-xlarge"
                                                       placeholder=""
                                                       value="${sysUser.realname}"><label
                                                    id="realnameTip"></label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">手机：</label>
                                            <div class="col-md-9">
                                                <input id="mobile" type="text" name="mobile"
                                                       class="form-control input-inline  input-xlarge"
                                                       placeholder=""
                                                       value="${sysUser.mobile}"><label id="mobileTip"></label>
                                            </div>
                                        </div>
                                        <%--<div class="form-group">
                                            <label class="col-md-3 control-label">Email：</label>
                                            <div class="col-md-9">
                                                <input id="email" type="text" name="email"
                                                       class="form-control input-inline  input-xlarge"
                                                       placeholder=""
                                                       value="${sysUser.email}"><label id="emailTip"></label>
                                            </div>
                                        </div>--%>
                                    </div>
                                    <div class="form-actions">
                                        <div class="row">
                                            <div class="col-md-offset-3 col-md-9">
                                                <button type="submit" class="btn btn-primary"><i
                                                        class="fa fa-save"/></i> 保存
                                                </button>
                                                <button type="button" class="btn default" onclick="history.back(-1)"><i
                                                        class="fa fa-undo"/></i>  取消
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="container" id="crop-avatar">
    <!-- Cropping modal -->
    <div class="modal fade" id="avatar-modal" aria-hidden="false" aria-labelledby="avatar-modal-label" role="dialog"
         tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form class="avatar-form" action="${dynamicServer}/sys/info/uploadAvatar.htm" enctype="multipart/form-data"
                      method="post"
                      accept="image/*">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" id="avatar-modal-label">修改头像</h4>
                    </div>
                    <div class="modal-body">
                        <div class="avatar-body">
                            <!-- Upload image and data -->
                            <div class="avatar-upload">
                                <input type="hidden" class="avatar-src" name="avatar_src">
                                <input type="hidden" class="avatar-data" name="avatar_data">
                                <label for="avatarInput" class="btn btn-primary">选择图片</label>
                                <input type="file" class="avatar-input" id="avatarInput" name="avatar_file"
                                       style="display: none;" accept="image/*">
                            </div>

                            <!-- Crop and preview -->
                            <div class="row">
                                <div class="col-md-9">
                                    <div class="avatar-wrapper"></div>
                                </div>
                                <div class="col-md-3">
                                    <div class="avatar-preview preview-lg"></div>
                                    <div class="avatar-preview preview-md"></div>
                                    <div class="avatar-preview preview-sm"></div>
                                </div>
                            </div>

                            <div class="row avatar-btns">
                                <div class="col-md-9" style="display: none">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="-90" title="Rotate -90 degrees">Rotate Left
                                        </button>
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="-15">-15deg
                                        </button>
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="-30">-30deg
                                        </button>
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="-45">-45deg
                                        </button>
                                    </div>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="90" title="Rotate 90 degrees">Rotate Right
                                        </button>
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="15">15deg
                                        </button>
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="30">30deg
                                        </button>
                                        <button type="button" class="btn btn-primary" data-method="rotate"
                                                data-option="45">45deg
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-primary avatar-save"><i class="fa fa-save"/></i> 保存
                                    </button>
                                    <button type="button" class="btn btn-default" onclick="$('#avatar-modal').modal('hide');"><i
                                            class="fa fa-undo"/></i> 取消
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div><!-- /.modal -->
    <!-- Loading state -->
    <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
</div>
</body>


<critc-script>
    <script src="${staticServer}/assets/cropper3.0/cropper.min.js"></script>
    <script src="${staticServer}/assets/cropper3.0/main.js"></script>
    <script>
        $(function () {
            $("#btnEditAvatar").bind('click', showAvatar);

            $("#userForm").validate({
                debug: true,
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
                    email: {
                        maxlength: 30
                    }
                },
                messages: {},
                submitHandler: function (form) {
                    form.submit();
                }
            });
        })

        function showAvatar() {
            $('#avatar-modal').modal('show');
        }
    </script>
</critc-script>

</html>