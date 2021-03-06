﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Set_Button.aspx.cs" Inherits="WebForm.Platform.ProgramBuilder.Set_Button" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <table class="listtable">
        <thead>
            <tr>
                <th width="3%" style="text-align:center;"><input type="checkbox" onclick="checkAll(this.checked);" style="vertical-align:middle;" /></th>
                <th>名称</th>
                <th>图标</th>
                <th>类型</th>
                <th>权限控制</th>
                <th>排序</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <% 
            foreach(var button in buttons)
            {    
            %>
            <tr>
                <td style="text-align:center;"><input type="checkbox" value="<%=button.ID %>" name="checkbox_app" style="vertical-align:middle;"/></td>
                <td><%=button.ButtonName %></td>
                <td><%=(button.Ico.IsNullOrEmpty()?"":"<img src='"+button.Ico+"'/>") %></td>
                <td><%=(button.ShowType==0?"工具栏":button.ShowType==1?"普通按钮":"列表按钮") %></td>
                <td><%=(button.IsValidateShow==1?"是":"否") %></td>
                <td><%=button.Sort %></td>
                <td>
                    <a class="editlink" href="javascript:;" onclick="add('<%=button.ID %>'); return false;">编辑</a>
                </td>
            </tr>
            <% 
            }    
            %>
        </tbody>
    </table>
    <div class="buttondiv">
        <input type="button" class="mybutton" onclick="add('');" value="添加按钮" />
        <asp:Button ID="Button1" runat="server" Text=" 删 除 " OnClientClick="return del();" CssClass="mybutton" OnClick="Button1_Click" />
    </div>
    </form>
    <script type="text/javascript">
        function checkAll(checked)
        {
            $("input[name='checkbox_app']").prop("checked", checked);
        }
        function add(id)
        {
            window.location = "Set_Button_Add.aspx?bid=" + (id || "") + "<%=query%>";
        }
        function del()
        {
            if ($(":checked[name='checkbox_app']").size() == 0)
            {
                alert("您没有选择要删除的按钮!");
                return false;
            }
            return confirm('您真的要删除所选按钮吗?');
        }
    </script>
</body>
</html>
