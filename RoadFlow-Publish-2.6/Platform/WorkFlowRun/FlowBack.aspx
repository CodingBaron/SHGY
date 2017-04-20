<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowBack.aspx.cs" Inherits="WebForm.Platform.WorkFlowRun.FlowBack" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table cellpadding="0" cellspacing="1" border="0" width="99%" align="center" style="margin-top:6px;">
        <tr>
            <td style="vertical-align:top;width:50%;">
                <fieldset style="padding:4px; min-height:200px; border:1px solid #e8e8e8;">
                    <legend>&nbsp;退回步骤&nbsp;</legend>
    <%
    WebForm.Common.Tools.CheckLogin(false);
        
    string flowid = Request.QueryString["flowid"];
    string stepid = Request.QueryString["stepid"];
    string groupid = Request.QueryString["groupid"];
    string taskid = Request.QueryString["taskid"];

    RoadFlow.Platform.WorkFlow bworkFlow = new RoadFlow.Platform.WorkFlow();
    RoadFlow.Platform.WorkFlowTask btask = new RoadFlow.Platform.WorkFlowTask();
    var wfInstalled = bworkFlow.GetWorkFlowRunModel(flowid);
    if(wfInstalled==null)
    {
        Response.Write("未找到流程运行时实体");
        Response.End();
    }
    Guid taskID;
    if(!taskid.IsGuid(out taskID))
    {
        Response.Write("未找到当前任务");
        Response.End();
    }

    var steps = wfInstalled.Steps.Where(p => p.ID == stepid.ToGuid());
    if (steps.Count() == 0)
    {
        Response.Write("未找到当前步骤");
        Response.End();
    }
    var currentStep = steps.First();
   
    int backModel = currentStep.Behavior.BackModel;//退回策略
    if (backModel == 0)
    {
        //Response.Write("<script type=\"text/javascript\">alert(\"当前步骤设置为不能退回!\");</script>");
        //Response.End();
    }
    else if (backModel == 2 || backModel == 3)
    {
        if (btask.GetTaskList(taskID).Find(p => p.Status > 1) != null)
        {
            Response.Write("<script type=\"text/javascript\">alert(\"根据处理策略，当前任务不能退回!\");new RoadUI.Window().close();</script>");
            Response.End();
        }
    }

    
    int backType = currentStep.Behavior.BackType;//退回类型
    var prevSteps = btask.GetBackSteps(taskID, backType, currentStep.ID, wfInstalled);
    int i=0;
    %>
    <table cellpadding="0" cellspacing="1" border="0" width="95%" align="center" style="margin-top:6px;">
        <%
        foreach (var step in prevSteps)
        {
            string checked1 = string.Empty;
            if ((backType == 2 && step.Key == currentStep.Behavior.BackStepID) || currentStep.Behavior.Countersignature != 0 || backType == 0)
            {
                checked1 = "checked=\"checked\""; i++;
            }
            else
            {
                checked1 = !step.Key.ToString().IsNullOrEmpty() && i++ == 0 ? "checked=\"checked\"" : "";
            }
            string disabled = step.Key.ToString().IsNullOrEmpty() || currentStep.Behavior.Countersignature != 0 || backType == 0 ? "disabled=\"disabled\"" : "";
         %>
        <tr>
            <td style="padding:2px 0 2px 0;">
            <input type="hidden" name="nextstepid" value="" />
            <input type="checkbox" value="<%=step.Key %>" <%=checked1 %> <%=disabled %> name="stepid" id="step_<%=step.Key %>" style="vertical-align:middle;" />
            <label for="step_<%=step.Key %>" style="vertical-align:middle;"><%=step.Value %></label>
            </td>
        </tr>
        <tr><td style="height:6px; border-bottom:1px dashed #e8e8e8;"></td></tr>
        <%}%>
    </table>
                    </fieldset>
            </td>
            <!--意见处理栏-->   
            <%
            int signType = Request.QueryString["signType"].ToInt(0);
            bool isSign = signType > 0;
            string display = Request.QueryString["display1"];
            bool isCopyFor = "1" == Request.QueryString["isCopyFor"];
            if (isSign && "0" == display && !isCopyFor)
            {
                string commentsOptions = new RoadFlow.Platform.WorkFlowComment().GetOptionsStringByUserID(RoadFlow.Platform.Users.CurrentUserID);
            %>
            <td style="padding-left:8px; vertical-align:top;">
                <fieldset style="padding:4px; min-height:200px; border:1px solid #e8e8e8;">
                    <legend>&nbsp;处理意见&nbsp;</legend>
                    <div style="height:30px; margin:5px auto 0px auto; text-align:left; width:100%;">
                        <div>
                           <div>快捷意见：<select class="myselect" id="mycomment" style="width:120px;" onchange="$('#comment').val(this.value);"><option value=""></option><%=commentsOptions %></select>
                                <%if (signType == 2){%>
                                <input type="hidden" value="" id="issign" name="issign" />
                                <input type="button" class="mybutton" id="signbutton" onclick="sign();" value="&nbsp;&nbsp;签章&nbsp;&nbsp;"/>
                                <%
                                    string signFile = string.Concat(Server.MapPath("../../Files/UserSigns/"), RoadFlow.Platform.Users.CurrentUserID, ".gif");
                                    string signSrc = string.Concat("../../Files/UserSigns/", RoadFlow.Platform.Users.CurrentUserID, ".gif");
                                    if (!System.IO.File.Exists(signFile))
                                    {
                                        System.Drawing.Bitmap img = new RoadFlow.Platform.WorkFlow().CreateSignImage(RoadFlow.Platform.Users.CurrentUserName);
                                        if (img != null)
                                        {
                                            img.Save(signFile, System.Drawing.Imaging.ImageFormat.Gif);
                                        }
                                    }
                                 %>
                                    <img alt="" src="<%=signSrc %>" id="signimg" style="vertical-align:middle; display:none;" />
                                <%}%>
                            </div>              
                        
                            <div style="height:8px; margin:0px 0 8px 0; border-bottom:1px dashed #e8e8e8;"></div>
                            <div><textarea id="comment" name="comment" style="width:98%; height:90px;" class="mytextarea"></textarea></div>
                            <div style="margin-top:8px;">附件：<input type="text" style="width:60%;" class="myfile" id="flowfiles" name="flowfiles" /></div>
                        </div>   
                    </div>
                </fieldset>
            </td>
            <%}%>
            <!--意见处理栏-->
        </tr>
    </table>
    <div style="width:95%; margin:12px auto 0 auto; text-align:center;">
        <input type="submit" class="mybutton" onclick="return confirm1();" name="Save" value="&nbsp;确&nbsp;定&nbsp;" style="margin-right:5px;" />
        <input type="button" class="mybutton" value="&nbsp;取&nbsp;消&nbsp;" onclick="new RoadUI.Window().close();" />
    </div>
    <script type="text/javascript">
        var frame = null;
        var openerid = '<%=Request.QueryString["openerid"]%>';
        var isSign = <%=isSign.ToString().ToLower()%>;
        var signType = <%=signType%>;
        var iframeid1 = '<%=Request.QueryString["iframeid"]%>';
        $(function ()
        {
            var iframes = top.frames;
            for (var i = 0; i < iframes.length; i++)
            {
                var fname = "";
                try
                {
                    fname = iframes[i].name;
                }
                catch(e)
                {
                    fname="";
                }
                if (fname == openerid + "_iframe")
                {
                    frame = iframes[i]; break;
                }
            }
            if (frame == null)
            {
                frame = parent;
            }
            if (frame == null) return;
        });
        function confirm1()
        {
            if ("0" == "<%=backModel%>")//退回策略为不能退回
            {
                alert("当前步骤设置为不能退回!");
                new RoadUI.Window().close();
                return;
            }
            var opts = {};
            opts.type = "back";
            opts.steps = [];
            var isSubmit = true;
            $(":checked[name='stepid']").each(function ()
            {
                var step = $(this).val();
                opts.steps.push({ id: step, member: "" });
            });
            if (opts.steps.length == 0)
            {
                alert("没有选择要退回的步骤!");
                return false;
            }
            if(signType>0)
            {
                
                if($.trim($("#comment").val()).length==0)
                {
                    alert("请填写处理意见!");
                    return false;
                }
                else
                {
                    frame.document.getElementById("comment").value = $.trim($("#comment").val());
                }
                if(signType==2 && "1"!=$("#issign").val())
                {
                    alert("请签章!");
                    return false;
                }
                else if(signType==2 && "1"==$("#issign").val())
                {
                    frame.document.getElementById("issign").value = "1";
                }
            }
            frame.document.getElementById("flowfiles").value = $("#flowfiles").val();
            if (isSubmit)
            {
                frame.formSubmit(opts);
                new RoadUI.Window().close();
            }
        }
        function sign(id)
        {
            var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
            mainDialog.open({ title: "请输入签章密码", width: 360, height: 130, url: "/Platform/WorkFlowRun/Sign.aspx?appid=&buttonid=" + (id||""), openerid: iframeid1, resize: false });
        }
    </script>
</form>
</body>
</html>
