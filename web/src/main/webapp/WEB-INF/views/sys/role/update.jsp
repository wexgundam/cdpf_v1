<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ include file="../../common/taglib.jsp" %>

<head>
    <title>角色管理</title>
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
            >角色管理
        </li>
    </ul>
</div>
<h1 class="page-title"> 角色管理
    <small>>>新增角色</small>
</h1>


<div class="row">
    <div class="col-md-10">
        <form role="form" id="roleForm" name="roleForm" class="form-horizontal"
              action="update.htm" method="post">
            <input type="hidden" name="backUrl" value="${backUrl }"> <input type="hidden" name="id"
                                                                            value="${sysRole.id }"> <input
                type="hidden" id="moduleArr" name="moduleArr" value=""> <input type="hidden" name="functionArr"
                                                                               id="functionArr" value="">
            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-2 control-label">角色名称：</label>
                    <div class="col-md-10">
                        <input id="name" name="name" type="text" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysRole.name}"> <label id="nameTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">角色说明：</label>
                    <div class="col-md-10">
                        <input id="description" name="description" type="text"
                               class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysRole.description}"> <label id="descriptionTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">排序：</label>
                    <div class="col-md-10">
                        <input id="displayOrder" name="displayOrder" type="text"
                               class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysRole.displayOrder}"> <label id="displayOrderTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-2 control-label">权限设置：</label>
                    <div class="col-md-10">
                        <c:forEach items="${listModule }" var="sysModule" varStatus="st">
                            <c:if test="${sysModule.parentId eq 1 }">
                                <div class="portlet light bordered">
                                    <div class="portlet-title">
                                        <div class="caption font-red-intense">
                                    <span class="caption-subject bold uppercase">
                                        <label class="mt-checkbox mt-checkbox-outline">
                                            <input name="module" type="checkbox" id="mod_${sysModule.id }" value="${sysModule.id }" class="father">
                                            <i class="icon-share font-red-intense"></i> ${sysModule.name }<span></span>
                                        </label>
                                    </span>
                                        </div>
                                    </div>
                                    <div class="portlet-body" style="height: auto;">
                                        <c:forEach items="${listModule }" var="secModule" varStatus="st">
                                            <c:if test="${sysModule.id eq secModule.parentId }">
                                                <span class="caption-subject bold ">
                                                <label class="mt-checkbox mt-checkbox-outline font-yellow-crusta">
                                                    <input name="module" id="mod_${secModule.id }" type="checkbox" value="${secModule.id }" class="child"/>
                                                    <i class="icon-share font-yellow-crusta"></i> ${secModule.name }<span></span>
                                                </label>
                                                </span>

                                                <c:forEach items="${listFunction }" var="sysFunction" varStatus="st">
                                                    <c:if test="${sysFunction.parentId eq secModule.id }">
                                                        <span class="caption-subject bold ">
                                                        <label class="mt-checkbox mt-checkbox-outline font-blue">
                                                            <input name="function" id="function_${sysFunction.id }" type="checkbox" value="${sysFunction.id }" class="child"/>
                                                            <i class="icon-note font-blue"></i> ${sysFunction.name } <span></span>
                                                        </label>
                                                        </span>
                                                    </c:if>
                                                </c:forEach>
                                                <br/>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
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
            $(".child").click(function () {
                $(this).parent().parent().parent().parent().find(".father").prop("checked", true);
            })
            $(".father").click(function () {
                if (this.checked) {
                    $(this).parent().parent().parent().parent().parent().find(".child").prop("checked", true);
                } else {
                    $(this).parent().parent().parent().parent().parent().find(".child").prop("checked", false);
                }
            })
            $("#roleForm").validate({
                debug: true,
                errorElement: "label",
                errorClass: "valiError",
                errorPlacement: function (error, element) {
                    error.appendTo($("#" + element.attr('id') + "Tip"));
                },
                rules: {
                    name: {
                        required: true,
                        maxlength: 40
                    },
                    description: {
                        maxlength: 50
                    },
                    displayOrder: {
                        number: true,
                        required: true,
                        maxlength: 10
                    }
                },
                messages: {},
                submitHandler: function (form) {
                    var moduleArr = "";
                    $('input:checkbox[name=module]:checked').each(function (i) {
                        moduleArr += $(this).val() + "@@";
                    });
                    $("#moduleArr").val(moduleArr);
                    var functionArr = "";
                    $('input:checkbox[name=function]:checked').each(function (i) {
                        functionArr += $(this).val() + "@@";
                    });
                    $("#functionArr").val(functionArr);

                    form.submit();
                }
            });
            ///设置按钮选中
            ${checkButton}
        });
    </script>
</critc-script>