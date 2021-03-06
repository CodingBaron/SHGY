﻿$(function ()
{
    $(window).bind('resize', function ()
    {
        $('#flowMain').width($(window).width());
        $('#flowMain').height($(window).height() - (isShow ? 0 : (isDebug ? 130 : 26)));
    });
    $(window).resize();
});

function execute(script)
{
    if (!script || $.trim(script).length == 0)
    {
        return false;
    }
    eval(script);
}

function checkSign()
{
    if (isSign)
    {
        if ($.trim($("#comment").val()).length == 0)
        {
            alert("请填写处理意见!"); return false;
        }

        if (signType == "2")
        {
            if ("1" != $("#issign").val())
            {
                alert("请签章!"); return false;
            }
        }
    }
    return true;
}

function setSign()
{
    $("#issign").val("1");
    //$("#signbutton").hide();
    //$("#signbutton").prop("disabled", true);
    //$("#signimg").show();
}

function flowSend(isSubmit)
{
    if (!validateForm() || !checkSign())
    {
        return false;
    }
    if (!isSubmit && "1" == isSystemDetermine)
    {
        saveData('flowSend');
    }
    else
    {
        var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
        mainDialog.open({ url: "/Platform/WorkFlowRun/FlowSend.aspx?" + query + "&instanceid1=" + $("#instanceid").val(), openerid: iframeid, width: 600, height: 320, title: "发送" });
    }
}

function flowFreedomSend(isSubmit)
{
    if (!validateForm() || !checkSign())
    {
        return false;
    }
    if (!isSubmit && "1" == isSystemDetermine)
    {
        saveData('flowFreedomSend');
    }
    else
    {
        var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
        mainDialog.open({ url: "/Platform/WorkFlowRun/FlowFreedomSend.aspx?" + query + "&instanceid1=" + $("#instanceid").val(), openerid: iframeid, width: 600, height: 320, title: "自由发送" });
    }
}

function flowBack(isSubmit)
{
    if (!checkSign())
    {
        return false;
    }
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ url: "/Platform/WorkFlowRun/FlowBack.aspx?" + query, openerid: iframeid, width: 600, height: 320, title: "退回" });
}

function showComment()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ url: "/Platform/WorkFlowRun/ShowComment.aspx?" + query, openerid: iframeid, width: 800, height: 420, title: "查看流程处理意见" });
}

function flowSave()
{
    if (!validateForm())
    {
        return false;
    }
    
    var options = {};
    options.type = "save";
    options.steps = [];
    formSubmit(options);
}

function flowSaveIframe(flag)
{
    if (flag)
    {
        flowSave();
    }
    else
    {
        var f = $("#customeformiframe").get(0).contentWindow.document.forms[0];
        if (new RoadUI.Validate().validateForm(f, 0))
        {
            f.submit();
        }
    }
}

function flowCompleted()
{
    flowSend(true);
    return;
    if (!validateForm() || !checkSign())
    {
        return false;
    }
    var options = {};
    options.type = "completed";
    options.steps = [];
    formSubmit(options);
}

function flowRedirect()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ url: "/Platform/WorkFlowRun/FlowRedirect.aspx?" + query, openerid: iframeid, width: 480, height: 200, title: "选择接收人员" });
}

function flowCopyFor()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ url: "/Platform/WorkFlowRun/FlowCopyFor.aspx?" + query, openerid: iframeid, width: 480, height: 200, title: "选择抄送人员" });
}

function formSubmit(options)
{
    if (!options || !options.type || !options.steps)
    {
        alert("参数不足!");
        return false;
    }
    if (options.type.toLowerCase() != "save" && options.type.toLowerCase() != "completed" && options.steps.length == 0)
    {
        alert("没有要处理的步骤!");
        return false;
    }
    var f = document.forms[0];
    //验证提示类型 0-弹出 1-图标加提示信息 2-图标
    //var validateAlertType = $("#Form_ValidateAlertType").size() > 0 && !isNaN($("#Form_ValidateAlertType").val()) ? parseInt($("#Form_ValidateAlertType").val()) : 1;
    //if (new RoadUI.Validate().validateForm(f, validateAlertType))
    //{
        showProcessing(options.type);
        window.setTimeout('', 100);
        $("#params").val(JSON.stringify(options));
        f.action = "/Platform/WorkFlowRun/Execute.aspx?" + query + "&isSystemDetermine=" + isSystemDetermine;
        f.submit();
    //}
}

function saveData(opation)
{
    showProcessing("savedata");
    var f = document.forms[0];
    window.setTimeout('', 100);
    f.action = "/Platform/WorkFlowRun/SaveData.aspx?" + query + "&opation=" + opation;
    f.submit();
}

function validateForm()
{
    //验证提示类型 0-弹出 1-图标加提示信息 2-图标
    var validateAlertType = $("#Form_ValidateAlertType").size() > 0 && !isNaN($("#Form_ValidateAlertType").val()) ? parseInt($("#Form_ValidateAlertType").val()) : 1;
    return new RoadUI.Validate().validateForm(document.forms[0], validateAlertType);
}

function showProcessing(type)
{
    var title = "正在处理";
    switch (type)
    {
        case "save": title = "正在保存..."; break;
        case "savedata": title = "正在保存数据..."; break;
        case "submit": title = "正在发送..."; break;
        case "back": title = "正在退回..."; break;
        case "redirect": title = "正在转交..."; break;
        case "taskend": title = "正在终止..."; break;
        case "onload": title = "正在加载..."; break;
    }
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({
        title: title, width: 260, height: 120, url: "/Platform/WorkFlowRun/Process.aspx?op=" + type,
        openerid: iframeid, opener:window, resize: false, showclose: true, showico: true
    });
}

function sign(id)
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ title: "请输入签章密码", width: 360, height: 130, url: "/Platform/WorkFlowRun/Sign.aspx?appid=" + appid + "&buttonid=" + (id||""), openerid: iframeid, resize: false });
}

function signature(id, issign)
{
    var $obj = $(document.getElementById(id));
    var ispassword = $obj.attr("ispassword") || "0";
    var id1 = $obj.attr("id1");
    if (!issign && "1" == ispassword)
    {
        sign(id);
    }
    else
    {
        var src = $obj.attr("src");
        if (src)
        {
            $obj.next('span').remove();
            $obj.after('<span><img style="vertical-align:middle;margin-left:10px;" src="' + src + '" border="0" /><input type="hidden" name="' + id1 + '" value="' + src + '"/></span>');
        }
    }
}

function showProcess()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ id: 'showprocess', title: '查看处理过程', url: '/Platform/WorkFlowTasks/Detail.aspx?' + query, width: 1024, height: 550 });
}

function showFlowDesign()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ id: 'showflowdesign', title: '查看流程图', url: '/Platform/WorkFlowRun/ShowDesign.aspx?' + query, width: 1024, height: 550 });
}

function formPrint()
{
    RoadUI.Core.open("/Platform/WorkFlowRun/Print.aspx?" + query + "&instanceid1=" + $("#instanceid").val() + "&isreadonly=1&display=1", 980, 600, "打印表单");
}

function showSubFlow()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ id: 'showsubflow', title: '查看子流程处理过程', url: '/Platform/WorkFlowTasks/DetailSubFlow.aspx?' + query, width: 1024, height: 550 });
}

//终止
function taskEnd()
{
    if (!confirm('您真的要终止当前流程吗?'))
    {
        return;
    }
    showProcessing("taskend");
    var f = document.forms[0];
    window.setTimeout('', 100);
    f.action = "/Platform/WorkFlowRun/TaskEnd.aspx?" + query;
    f.submit();
}

//查看主流程表单
function showMainFlowForm()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ id: 'showmainflowform', title: '查看主流程表单', url: '/Platform/WorkFlowRun/ShowForm.aspx?' + query, width: 1024, height: 550 });
}
//加签
function addWrite()
{
    var mainDialog = top && top.mainDialog ? top.mainDialog : new RoadUI.Window();
    mainDialog.open({ id: 'addWrite', title: '加签', url: '/Platform/WorkFlowRun/AddWrite.aspx?' + query, width: 500, height: 350 });
}