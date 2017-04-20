<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditUserHeader.aspx.cs" Inherits="WebForm.Platform.UserInfo.EditUserHeader" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="div_headimg" style="width:98%; margin:8px auto 0 auto;" title="&nbsp;&nbsp;头像&nbsp;&nbsp;">
            <table cellpadding="0" cellspacing="1" border="0" width="96%" style="margin-top:15px;">
                <tr>
                    <td style="width: 140px;vertical-align:middle;">
                        <style type="text/css">
                            .uploadify-ico{border:none 0;vertical-align:middle;margin-right:3px;}
                        </style>
                        <input id="file_upload" name="file_upload" type="file" />
                    </td>
                    <td style="vertical-align:top;">
                        <div id="queue111" style="margin:0 auto 5px 0; display:none;"></div>
                        <input type="button" class="mybutton" style="height:32px;width:80px;" value="保存头像" onclick="saveimg();" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="hidden" id="x" name="x" />
                        <input type="hidden" id="y" name="y" />
                        <input type="hidden" id="x2" name="x2" />
                        <input type="hidden" id="y2" name="y2" />
                        <input type="hidden" id="w" name="w" />
                        <input type="hidden" id="h" name="h" />
                        <img src="" id="HeadImg" name="HeadImg" alt="" runat="server" />
                        <div class="clearfix"></div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script src="js/jquery.Jcrop.min.js"></script>
    <link href="css/jquery.Jcrop.min.css" rel="stylesheet" />
    <script src="/Controls/UploadFiles/Uploadify/jquery.uploadify.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function ()
        {
            var api;
            $('#HeadImg').Jcrop({
                onChange: showCoords,
                onSelect: showCoords
            }, function ()
            {
                api = this;
            });

            $('#file_upload').uploadify({
                'formData': { "filetype": "jpg,png,jpeg" },
                'swf': '../../Controls/UploadFiles/Uploadify/uploadify.swf',
                'uploader': '../../Controls/UploadFiles/Upload.ashx',
                'buttonText': '选择图片',
                'fileTypeDesc': '图片文件',
                'fileTypeExts': '*.jpg;*.png;*.jpeg',
                'auto': true,
                'multi': false,
                'queueID': 'queue111',
                'sizeLimit': 2097152,
                'onUploadSuccess': function (file, data, response)
                {
                    var dataArray = data.split('|');
                    if (dataArray.length > 0 && dataArray[0] == "1")
                    {
                        $('#HeadImg').attr("src", dataArray[1]);
                        api.setImage(dataArray[1]);
                        api.setSelect([0, 0, 200, 200]);
                        api.ui.selection.addClass('jcrop-selection');
                    }
                },
                'onSelect': function ()
                {
                    $("#queue111").hide();
                },
                'onQueueComplete': function ()
                {
                    $("#queue111").hide(1000);
                }
            });
        });

        function showCoords(c)
        {
            $('#x').val(c.x);
            $('#y').val(c.y);
            $('#x2').val(c.x2);
            $('#y2').val(c.y2);
            $('#w').val(c.w);
            $('#h').val(c.h);
        }
        function saveimg()
        {
            var imgdata = { "x": $('#x').val(), "y": $('#y').val(), "x2": $('#x2').val(), "y2": $('#y2').val(), "w": $('#w').val(), "h": $('#h').val(), "img": $('#HeadImg').attr("src") };
            if (imgdata.x.length == 0 || imgdata.y.length == 0 || imgdata.w.length == 0 || imgdata.h.length == 0 || imgdata.img.length == 0)
            {
                alert('请选择图片!');
                return;
            }
            $.ajax({
                url: "SaveUserHead.ashx", data: imgdata, type: "post", success: function (txt)
                {
                    alert(txt);
                }
            });
        }
    </script>
</body>
</html>
