﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Set_Flow.aspx.cs" Inherits="WebForm.Platform.WorkFlowDesigner.Set_Flow" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="tabdiv">
    <div id="div_base" title="基本信息">
    <div style="height:8px;"></div>
    <table cellpadding="0" cellspacing="1" border="0" width="99%" class="formtable">
    <tr>
        <th style="width:100px;">流程ID：</th>
        <td><input type="text" id="base_ID" name="base_ID" readonly="readonly" value="<%=flowID %>" class="mytext" style="width:75%"  /></td>
    </tr>
    <tr>
        <th>流程名称：</th>
        <td><input type="text" id="base_Name" name="base_Name" class="mytext" style="width:75%"  /></td>
    </tr>
    <tr>
        <th>流程分类：</th>
        <td>
            <select id="base_Type" name="base_Type" class="myselect" style="margin-right:5px;"><option value=""></option><%=base_TypesOptions %></select>
            <!--
            类型：<select class="myselect" id="base_FlowType" name="base_FlowType">
                <%//=bworkFlow.GetFlowTypeOptions("") %>
               </select>
            -->
        </td>
    </tr>
    <tr>
        <th>管理者：</th>
        <td><input type="text" id="base_Manager" value="<%=defaultManager %>" name="base_Manager"  class="mymember" title="选择流程管理者" more="1" user="1" dept="0" station="0" workgroup="0" unit="0" style="width:75%"  /></td>
    </tr>
    <tr>
        <th>实例管理者：</th>
        <td><input type="text" id="base_InstanceManager" value="<%=defaultManager %>" name="base_InstanceManager" class="mymember" title="选择流程实例管理者" more="1" user="1" dept="0" station="0" workgroup="0" unit="0" style="width:75%"  /></td>
    </tr>
    <tr>
        <th>删除已完成：</th>
        <td>
        <select id="base_RemoveCompleted" name="base_RemoveCompleted" class="myselect" style="width:120px;" >
            <option value="0">不删除</option>
            <option value="1">删除</option>
        </select>
        </td>
    </tr>
    <tr>
        <th>调试模式：</th>
        <td>
            <select class="myselect" id="base_Debug">
                <option value="0">关闭</option>
                <option value="1">开启(有调试窗口)</option>
                <option value="2">开启(无调试窗口)</option>
            </select>
            <input type="text" id="base_DebugUsers" title="选择调试人员" class="mymember" /> //调试人员
        </td>
    </tr>
    <tr>
        <th>备注：</th>
        <td><textarea rows="1" cols="1" id="base_Note" name="base_Note" class="mytext" style="width:90%; height:40px;" ></textarea></td>
    </tr>
    </table>
    </div>
    <div id="div_data" title="数据连接">
    <div style="height:8px;"></div>
    <table cellpadding="0" cellspacing="1" border="0" width="99%" style="width:99%" class="listtable" id="link_listtable">
    <thead>
        <tr>
            <th style="width:28%">数据库连接</th>
            <th style="width:28%">数据表</th>
            <th style="width:30%">主键</th>
            <th><a href="javascript:link_add();"><img alt="" src="../../Images/ico/add.gif" style="border:0; vertical-align:middle;" /><span style="vertical-align:middle;">添加</span></a></th>
        </tr>
    </thead>
    <tbody>
            
    </tbody>
    </table>
    </div>
    <div id="div_title" title="标识字段">
    <div style="height:8px;"></div>
    <table cellpadding="0" cellspacing="1" border="0" width="99%" class="formtable">
        <tr>
            <th style="width:100px;">数据连接：</th>
            <td><select id="title_dbconn" name="title_dbconn" class="myselect" 
            onchange="title_db_change(this)" style="width:400px;" disabled="disabled" ><option value=""></option><%=link_DBConnOptions %></select></td>
        </tr>
        <tr>
            <th>数据表：</th>
            <td><select id="title_tables" onchange="title_table_change(this)" name="title_tables" class="myselect" style="width:400px;" ></select></td>
        </tr>
        <tr>
            <th>标识字段：</th>
            <td><select id="title_title" name="title_title" class="myselect" style="width:400px;" ></select></td>
        </tr>
    </table>
    </div>
    </div>
    <div style="width:99%; margin:8px auto 0 auto; text-align:center;">
        <input type="button" class="mybutton" value=" 确 定 " onclick="confirm1(this)" />
        <input type="button" class="mybutton" value=" 取 消 " onclick="new RoadUI.Window().close();" />
    </div>
    </form>
    <script type="text/javascript">
        var link_options = '<option value=""></option><%=link_DBConnOptions%>'; //数据连接选项
        var isAdd = '1' == '<%=Request.QueryString["isadd"]%>';
        var openerid = '<%=Request.QueryString["openerid"]%>';
        var flowID = '<%=flowID%>';
        var defaultManager = '<%=defaultManager%>';
        var win = new RoadUI.Window();
        var frame = null;

        $(function ()
        {
            new RoadUI.Tab({ id: "tabdiv", replace: true, contextmenu: false, dblclickclose: false });
            var iframes = top.frames;
            for (var i = 0; i < iframes.length; i++)
            {
                var fname = "";
                try
                {
                    fname = iframes[i].name;
                }
                catch (e)
                {
                    fname = "";
                }
                if (fname == openerid + "_iframe")
                {
                    frame = iframes[i]; break;
                }
            }
            if (frame == null) return;

            if (!isAdd)
            {
                var json = frame.wf_json;
                if (json)
                {
                    $("#base_Name").val(json.name);
                    $("#base_Type").val(json.type);
                    $("#base_Manager").val(json.manager || defaultManager); new RoadUI.Member().setValue($("#base_Manager"));
                    $("#base_InstanceManager").val(json.instanceManager || defaultManager); new RoadUI.Member().setValue($("#base_InstanceManager"));
                    $("#base_RemoveCompleted").val(json.removeCompleted);
                    $("#base_Note").val(json.note);
                    $("#base_Debug").val(json.debug);
                    $("#base_DebugUsers").val(json.debugUsers); new RoadUI.Member().setValue($("#base_DebugUsers"));
                    $("#base_FlowType").val(json.flowType || "");
                    var databases = json.databases;
                    if (databases)
                    {
                        for (var i = 0; i < databases.length; i++)
                        {
                            link_add(databases[i].link, databases[i].table, databases[i].primaryKey);
                        }
                    }
                    if (json.titleField)
                    {
                        $("#title_dbconn").val(json.titleField.link);
                        $("#title_tables").html(getTables(json.titleField.link, json.titleField.table));
                        $("#title_title").html(getFields(json.titleField.link, json.titleField.table, json.titleField.field));
                    }
                }
            }
        });


        function link_add(db, table, field)
        {
            var tableOptions = '';
            var fieldOptions = '';
            if (db && table)
            {
                tableOptions = getTables(db, table);
            }
            if (db && table && field)
            {
                fieldOptions = getFields(db, table, field);
            }
            var index = $("#link_listtable tbody tr").size() + 1;
            var tr = '<tr>';
            tr += '<td style="background:#ffffff; height:30px;">';
            tr += '<input type="hidden" name="link_index" value="' + index.toString() + '"/>';
            tr += '<select class="myselect" style="width:120px" onchange="link_db_change(this);" id="link_db_' + index.toString() + '" name="link_db_' + index.toString() + '">' + link_options + '</select></td>';
            tr += '<td style="background:#ffffff;"><select class="myselect" style="width:120px" onchange="link_table_change(this)" id="link_table_' + index.toString() + '" name="link_table_' + index.toString() + '">' + tableOptions + '</select></td>';
            tr += '<td style="background:#ffffff;"><select class="myselect" style="width:120px" id="link_key_' + index.toString() + '" name="link_key_' + index.toString() + '">' + fieldOptions + '</select></td>';
            tr += '<td style="background:#ffffff;"><a href="javascript:link_delete(' + index.toString() + ');" class="deletelink">删除</a></td>';
            tr += '</tr>';
            $("#link_listtable tbody").append(tr);
            new RoadUI.Select().init($(".myselect", $("#link_listtable tbody")));
            
            if (!db && $("#link_listtable tbody tr").size() > 0)
            {
                var $dbselect = $("#link_listtable tbody tr:first [id^='link_db_']");
                if ($dbselect.size() > 0)
                {
                    db = $dbselect.eq(0).val();
                }
            }
            if (db)
            {
                $("#link_db_" + index.toString()).val(db);
            }
        }
        function link_delete(index)
        {
            $("#link_listtable tbody tr td input[type='hidden']").each(function ()
            {
                if ($(this).val() == index.toString())
                {
                    $(this).parent().parent().remove();
                }
            });
        }
        function link_db_change(obj, table)
        {
            if (!obj || !obj.value) return;
            $("#link_listtable tbody tr").each(function ()
            {
                var $dbselect = $("[id^='link_db_']", $(this));
                if ($dbselect.size() > 0)
                {
                    $dbselect.val(obj.value);
                }
            });
            var html = getTables(obj.value, table);
            $("select", $(obj).parent().next()).html(html);
            var title_tables = $("#title_tables").val();
            var title_title = $("#title_title").val();
            $("#title_dbconn").val(obj.value);
            $("#title_tables").html(html);
        }
        function getTables(connid, table)
        {
            var options = '<option value=""></option>';
            var tableds = frame.getTables(connid);
            for (var i = 0; i < tableds.length; i++)
            {
                options += '<option value="' + tableds[i].name + '" ' + (tableds[i].name == table ? 'selected="selected"' : '') + '>' + tableds[i].name + '</option>';
            }
            return options;
        }
        function link_table_change(obj, field)
        {
            if (!obj || !obj.value) return;
            var conn = $("select", $(obj).parent().prev()).val();
            $("select", $(obj).parent().next()).html(getFields(conn, obj.value, field));
        }
        function getFields(connid, table, field)
        {
            var options = '<option value=""></option>';
            var fields = frame.getFields(connid, table);
            for (var i = 0; i < fields.length; i++)
            {
                options += '<option value="' + fields[i].name + '" ' + (fields[i].name == field ? 'selected="selected"' : '') + '>' + fields[i].name + (fields[i].note ? '(' + fields[i].note + ')' : '') + '</option>';
            }
            return options;
        }

        function title_db_change(obj, table)
        {
            if (!obj || !obj.value) return;
            $("#title_tables").html(getTables(obj.value, table));

        }
        function title_table_change(obj, fields)
        {
            if (!obj || !obj.value) return;
            var conn = $("#title_dbconn").val();
            $("#title_title").html(getFields(conn, obj.value, fields));
        }



        function confirm1(but)
        {
            $(but).prop("disabled", true);
            if (isAdd)
            {
                frame.initwf();
            }
            var json = frame.wf_json;
            json.id = flowID;
            json.name = $("#base_Name").val() || '';
            json.type = $("#base_Type").val() || '';
            json.manager = $("#base_Manager").val() || '';
            json.instanceManager = $("#base_InstanceManager").val() || '';
            json.removeCompleted = $("#base_RemoveCompleted").val() || '';
            json.debug = $("#base_Debug").val() || "0";
            json.debugUsers = $("#base_DebugUsers").val() || '';
            json.note = $("#base_Note").val() || '';
            json.flowType = $("#base_FlowType").val() || "";
            json.databases = [];
            $("input[type='hidden'][name='link_index']").each(function ()
            {
                var index = $(this).val();
                json.databases.push({
                    link: $('#link_db_' + index).val() || '',
                    linkName: $("#link_db_" + index + " option[value='" + ($('#link_db_' + index).val() || '') + "']").text(),
                    table: $('#link_table_' + index).val() || '',
                    primaryKey: $('#link_key_' + index).val() || ''
                });
            });
            json.titleField = {
                link: $("#title_dbconn").val() || '',
                table: $("#title_tables").val() || '',
                field: $("#title_title").val() || ''
            };

            frame.wf_id = flowID;
            frame.initLinks_Tables_Fields(json.databases);
            new RoadUI.Window().close();
        }
    </script>
</body>
</html>
