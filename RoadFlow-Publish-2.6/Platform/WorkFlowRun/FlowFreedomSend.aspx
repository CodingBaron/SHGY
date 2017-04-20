<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowFreedomSend.aspx.cs" Inherits="WebForm.Platform.WorkFlowRun.FlowFreedomSend" %>

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
                <fieldset style="padding:4px; min-height:170px; border:1px solid #ccc;">
                    <legend>&nbsp;接收步骤和人员&nbsp;</legend>
    <%
        WebForm.Common.Tools.CheckLogin(false);

        string flowid = Request.QueryString["flowid"];
        string stepid = Request.QueryString["stepid"];
        string groupid = Request.QueryString["groupid"];
        string taskid = Request.QueryString["taskid"];
        string instanceid = Request.QueryString["instanceid"];
        int tasktype = (Request.QueryString["tasktype"] ?? "0").ToInt(0);
        if (instanceid.IsNullOrEmpty())
        {
            instanceid = Request.QueryString["instanceid1"];
        }
        
        RoadFlow.Platform.WorkFlow bworkFlow = new RoadFlow.Platform.WorkFlow();
        RoadFlow.Platform.WorkFlowTask btask = new RoadFlow.Platform.WorkFlowTask();
        RoadFlow.Platform.Users busers = new RoadFlow.Platform.Users();
        RoadFlow.Data.Model.WorkFlowInstalled wfInstalled = bworkFlow.GetWorkFlowRunModel(flowid);
        if (wfInstalled == null)
        {
            Response.Write("未找到流程运行实体");
            Response.End();
        } 
    
        var steps = wfInstalled.Steps.Where(p => p.ID == stepid.ToGuid());
        if(steps.Count()==0)
        {
            Response.Write("未找到当前步骤");
            Response.End();
        }
        var currentStep = steps.First();
        var nextSteps = new List<RoadFlow.Data.Model.WorkFlowInstalledSub.Step>() { currentStep };
        
        int i = 0;
     %>
        <table cellpadding="0" cellspacing="1" border="0" width="95%" align="center" style="margin-top:0px;">
    <%if (!currentStep.Note.IsNullOrEmpty()){ %>
        <tr>
            <td style="padding:2px 0 0 0; color:#cc0000;"><%=currentStep.Note %></td>
        </tr>
    <%} %>
    <%
    foreach (var step in nextSteps)
    {
        string checked1 = i++ == 0 ? "checked=\"checked\"" : "";//默认选中第一个步骤
        string disabled = step.Behavior.RunSelect == 0 ? "disabled=\"disabled\"" : "";//是否允许运行时选择人员
        string selectRang = string.Empty;//选择范围
        string selectType = string.Empty;//选择类型
        string defaultMember = string.Empty;
        if (tasktype == 7)
        {
            var currTask = new RoadFlow.Platform.WorkFlowTask().Get(taskid.ToGuid());
            if (currTask != null)
            {
                defaultMember = btask.GetAddWriteMembers(taskid.ToGuid());
            }
        }
        else
        {
            defaultMember = btask.GetDefultMember(flowid.ToGuid(), step.ID, groupid.ToGuid(), currentStep.ID, instanceid, out selectType, out selectRang);
        }
        if (!step.Behavior.SelectRange.IsNullOrEmpty())
        {
            selectRang = "rootid=\"" + step.Behavior.SelectRange.Trim() + "\"";
        }
     %>
        <tr>
            <td style="padding:0px 0 2px 0;">
            <input type="hidden" name="nextstepid" value="<%=step.ID %>" />
            <%if (currentStep.Behavior.FlowType == 1){ %>
            <input type="radio" <%=checked1 %> value="<%=step.ID %>" name="step" id="step_<%=step.ID %>" style="vertical-align:middle;" />
            <%}else if (currentStep.Behavior.FlowType == 2){ %>
            <input type="checkbox" <%=checked1 %> value="<%=step.ID %>" name="step" id="Checkbox1" style="vertical-align:middle;" />
            <%}else{%> 
            <input type="checkbox" checked="checked" disabled="disabled" value="<%=step.ID %>" name="step" id="Checkbox2" style="vertical-align:middle;" />
            <%}%> 
            <label for="step_<%=step.ID %>" style="vertical-align:middle;"><%=step.Name %></label>
            </td>
        </tr>
        <tr>
            <td style="padding:2px 0 4px 0;">
            <input type="text" class="mymember" <%=disabled %> <%=selectRang %> <%=selectType %> value="<%=defaultMember %>" id="user_<%=step.ID %>" name="user_<%=step.ID %>" style="width:80%;" title="选择处理人员" isChangeType="<%=selectRang.Length>0?"1":"0" %>" /> <!--span style="color:#999;">//选择处理人员</span-->
            </td>
        </tr>
        <tr><td style="height:6px; border-bottom:1px dashed #e8e8e8;"></td></tr>
    <%} %>
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
                <fieldset style="padding:4px; min-height:170px; border:1px solid #ccc;">
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
                        <div><textarea id="comment" name="comment" style="width:98%; height:90px;" class="mytextarea"></textarea></div></div>   
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
        var nextStepsCount = <%=nextSteps.Count()%>;
        var isAddWrite = "7"=="<%=tasktype%>";
        var isSign = <%=isSign.ToString().ToLower()%>;
        var signType = <%=signType%>;
        var iframeid = '<%=Request.QueryString["tabid"]%>';
        var isShow = "0" != "<%=display%>";//是否是查看模式
        var iframeid1 = '<%=Request.QueryString["iframeid"]%>';
        var isDebug = false;
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
            if(nextStepsCount == 0)//如果后面没有步骤，则完成该流程实例
            {
                var options = {};
                options.type = "completed";
                options.steps = [];
                frame.formSubmit(options);
                new RoadUI.Window().close();
            }
            else if(nextStepsCount>2)
            {
                top.mainDialog.resize(480,(nextStepsCount-2)*45+280);
            }
        });
        function confirm1()
        {
            var opts = {};
            opts.type = "freesubmit";
            opts.steps = [];
            var isSubmit = true;
            $(":checked[name='step']").each(function ()
            {
                var step = $(this).val();
                var member = $("#user_" + step).val() || "";
                if ($.trim(member).length == 0)
                {
                    alert($(this).next().text() + " 没有选择处理人员!");
                    isSubmit = false;
                    return false;
                }
                opts.steps.push({ id: step, member: member });
            });
            if(!isSubmit)
            {
                return false;
            }
            if(opts.steps.length==0)
            {
                alert("没有选择要处理的步骤!");
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
