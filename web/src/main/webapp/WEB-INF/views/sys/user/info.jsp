<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>

</head>
<critc-css>
    <link rel="stylesheet" href="${staticServer}/assets/cropper3.0/cropper.min.css"/>
    <link rel="stylesheet" href="${staticServer}/assets/cropper3.0/main.css"/>
</critc-css>
<body>
<div class="container" id="crop-avatar">
    <!-- Cropping modal -->
    <div class="modal fade" id="avatar-modal" aria-hidden="false" aria-labelledby="avatar-modal-label" role="dialog"
         tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form class="avatar-form" action="${dynamicServer}/cutImg.htm" enctype="multipart/form-data" method="post"
                      accept="image/*">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" id="avatar-modal-label">Change Avatar</h4>
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
                                    <div class="avatar-wrapper"> </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="avatar-preview preview-lg"></div>
                                    <div class="avatar-preview preview-md"></div>
                                    <div class="avatar-preview preview-sm"></div>
                                </div>
                            </div>

                            <div class="row avatar-btns">
                                <div class="col-md-9">
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
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary btn-block avatar-save">Done</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- <div class="modal-footer">
                      <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div> -->
                </form>
            </div>
        </div>
    </div><!-- /.modal -->

    <!-- Loading state -->
    <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
</div>

<div class="avatar-view" title="Change the avatar">
    <form id="uploadForm" method="post" enctype="multipart/form-data" action="${dynamicServer}/cutImg.htm">

        <input type="hidden" name="avatar_data" id="avatar_data">
    </form>
</div>
<input type="button" value="取值" onclick="getData()">
<input type="button" value="弹出" onclick="show()">


<!-- jQuery -->
</body>

<critc-script>
    <script src="${staticServer}/assets/cropper3.0/cropper.min.js"></script>
    <script src="${staticServer}/assets/cropper3.0/main.js"></script>
    <script>
        $(function () {

        })
        function getData() {
            var imageData = $('#image').cropper('getData');
            $("#avatar_data").val(JSON.stringify(imageData));
            $.ajax({
                type: 'POST',
                url: '${dynamicServer}/cutImg.htm',
                data: {
                    avatar_data: JSON.stringify(imageData)
                },
                success: function (response) {
                    alert(response)
                },
                dataType: 'json'
            });
        }

        function show()
        {
            $('#avatar-modal').modal('show');
            /*$('#image').cropper({
                aspectRatio: 1 / 1
            });*/
        }
    </script>
</critc-script>

</html>