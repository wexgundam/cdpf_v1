<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/taglib.jsp" %>

<head>
    <title>资源管理</title>
    <critc-css>
        <link href="${staticServer }/assets/zTree3.5/css/zTreeStyle/metro.css" rel="stylesheet" type="text/css"/>
    </critc-css>
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
            >资源管理
        </li>
    </ul>
</div>
<h1 class="page-title"> 资源管理
    <small>>>修改资源</small>
</h1>

<div class="row">
    <div class="col-md-8">
        <form role="form" id="resouceForm" name="resouceForm" class="form-horizontal"
              action="update.htm?id=${sysResource.id }" method="post">
            <input type="hidden" name="backUrl" value="${backUrl }">
            <div class="form-body">
                <div class="form-group">
                    <label class="col-md-3 control-label">资源名称：</label>
                    <div class="col-md-9">
                        <input id="name" name="name" type="text" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysResource.name }"> <label id="nameTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">类型：</label>
                    <div class="col-md-9">
                        ${critc:createCombo2('{1:模块,2:功能}',sysResource.type,0,'type','type','form-control input-inline input-xlarge' )}
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">上级节点：</label>
                    <div class="col-md-9">
                        <div class="input-group input-xlarge">
                            <input id="parentId" type="hidden" name="parentId"
                                   value="${sysResource.parentId}">
                            <input id="parentName" type="text" name="parentName" readonly="readonly"
                                   class="form-control " placeholder=""
                                   value="${sysResource.parentName}">
                            <span class="input-group-btn">
											<button type="button" class="btn btn-primary"
                                                    onclick="javascript:showSelTree()">
												<i class="fa fa-search"/></i>  选择
											</button><label id="parentIdTip"></label>
										</span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">资源代码：</label>
                    <div class="col-md-9">
                        <input id="code" type="text" name="code" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysResource.code }"><label id="codeTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">资源链接：</label>
                    <div class="col-md-9">
                        <input id="url" type="text" name="url" class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysResource.url }"><label id="urlTip"></label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">链接目标：</label>
                    <div class="col-md-9">
                        ${critc:createCombo2('{_self:_self,_blank:_blank}',sysResource.target,0,'target','target','form-control input-inline input-xlarge' )}
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">图标：</label>
                    <div class="col-md-9">
                        <div class="input-group input-xlarge">
                            <input id="iconImg" type="text" name="iconImg" class="form-control" placeholder=""
                                   value="${sysResource.iconImg }">
                            <span class="input-group-btn">
											<button type="button" class="btn btn-primary"
                                                    onclick="javascript:showIcon()">
												<i class="fa fa-search"/></i>  选择
											</button>
										</span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">描述：</label>
                    <div class="col-md-9">
                        <input id="description" type="text" name="description"
                               class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysResource.description }">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">排序：</label>
                    <div class="col-md-9">
                        <input id="displayOrder" type="text" name="displayOrder"
                               class="form-control input-inline  input-xlarge"
                               placeholder=""
                               value="${sysResource.displayOrder }"><label id="displayOrderTip"></label>
                    </div>
                </div>
            </div>
            <div class="form-actions">
                <div class="row">
                    <div class="col-md-offset-3 col-md-9">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"/></i> 保存</button>
                        <button type="button" class="btn default" onclick="history.back(-1)"><i class="fa fa-undo"/></i>
                            取消
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>


<div class="modal fade" id="basic" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">选择上级节点</h4>
            </div>
            <div class="modal-body">
                <ul id="tree" class="ztree" style="width: 560px; overflow: auto;"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="javascript:getSelected();">确认</button>
                <button type="button" class="btn " data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="icon.jsp" %>


</body>
<critc-script>
    <script src="${staticServer }/assets/zTree3.5/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        var zTree;
        var setting = {
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pId",
                    rootPId: ""
                }
            }
        };
        var zNodes = [${ztree}];
        jQuery(document).ready(function () {
            var t = $("#tree");
            t = $.fn.zTree.init(t, setting, zNodes);
            var zTree = $.fn.zTree.getZTreeObj("tree");
        });

        function getSelected() {
            var treeObj = $.fn.zTree.getZTreeObj("tree");
            var nodes = treeObj.getSelectedNodes();
            if (nodes.length > 0) {
                $("#parentId").val(nodes[0].id);
                $("#parentName").val(nodes[0].name);
                $('#basic').modal('hide');
            }
            else return;

        }

        function showSelTree() {
            $('#basic').modal('show');
        }
        function showIcon() {
            $('#iconModel').modal('show');
        }
        $(document).ready(function () {
            //如果为新增功能，则不显示图标和target
            var type = '${sysResource.type}';
            if (type == 2) {
                $("#divIconImg").hide();
                $("#divTarget").hide();
            }

            $("#resouceForm").validate({
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
                    code: {
                        required: true,
                        maxlength: 40
                    },
                    url: {
                        required: true,
                        maxlength: 100
                    },
                    displayOrder: {
                        required: true,
                        number: true,
                        maxlength: 10
                    },
                    description: {
                        maxlength: 50
                    }
                },
                messages: {},
                submitHandler: function (form) {
                    form.submit();
                }
            });
        });

    </script>
</critc-script>