<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Header.ascx.cs" Inherits="TAMSR2.CustomControls.Header" %>

<script src='<%= Page.ResolveClientUrl("~/Assets/En/plugins/jquery-1.8.3.min.js") %>' type='text/javascript'></script>
<script src='<%= Page.ResolveClientUrl("~/Assets/En/plugins/jquery-validation/dist/jquery.validate.min.js") %>' type='text/javascript'></script>

<script type="text/javascript">

    function ChangeLanguage() {
        var d = "key=changeLanguage";
       
        $.ajax({
            data: d,
            dataType: "json",
            cache: false,
            method: 'POST',
            url: '<%= Page.ResolveClientUrl("~/RequestPages/SettingPage.aspx")%>',
            success: function (html) {
                if (html == "1") {
                    window.location.reload();
                }
            },
            error: function (html) {
            }
        });
    }

    function ClearChangePasswordForm() {

        $(':input', '#form_sample_1')
         .not(':button, :submit, :reset, :hidden')
         .val('')
         .removeAttr('checked')
         .removeAttr('selected');
        $("#divErrorMsg").hide();
        $('.help-inline').hide();
        $('.control-group').removeClass('error');
        $('.control-group').removeClass('success');
        $('.help-inline ok valid').hide();
        $("#txtOldPassword").val("");
        $("#txtNewPassword").val("");
        $("#txtRetypePassword").val("");

        $("#divChangePasswordErrorMsg").css("display", "none");
        $("#spnChangePasswordErrorMsg").html("&nbsp;");
        $("#divChangePasswordSuccessMsg").css("display", "none");
        $("#spnChangePasswordErrorMsg").html("&nbsp;");

    }

    function ChangePassword() {
        $("#divChangePasswordErrorMsg").css("display", "none");
        $("#divChangePasswordSuccessMsg").css("display", "none");

        var oldPassword = $("#txtOldPassword").val();
        var newPassword = $("#txtNewPassword").val();
        var retypePassword = $("#txtRetypePassword").val();

        if (oldPassword == "") {
            $("#spnoldpswd").css("display", "block");
            $("#spnoldpswd").html("<%=Resources.Resource.lblRequired %>");
        }
        else {
            $("#spnoldpswd").css("display", "none");
        }
        if (newPassword == "") {
            $("#spnnewpswd").css("display", "block");
            $("#spnnewpswd").html("<%=Resources.Resource.lblRequired %>");
        }
        else {
            $("#spnnewpswd").css("display", "none");
        }
        if (retypePassword == "") {
            $("#spnretypepswd").css("display", "block");
            $("#spnretypepswd").html("<%=Resources.Resource.lblRequired %>");
        }
        else {
            $("#spnretypepswd").css("display", "none");
        }
        if (newPassword != retypePassword) {
            $("#divChangePasswordErrorMsg").css("display", "block");
            $("#spnChangePasswordErrorMsg").html("<%=Resources.Resource.msgpasswordNotMatch %>");
            return;
        }
        if (oldPassword == "" || newPassword == "" || retypePassword == "") {
            $("#divChangePasswordErrorMsg").css("display", "block");
            $("#spnChangePasswordErrorMsg").html("<%=Resources.Resource.formErrors %>");
            return;
        }
        if (newPassword.length < 5) {
            $("#spnnewpswd").css("display", "block");
            $("#spnnewpswd").html("<%=Resources.Resource.msgPasswordLength %>");
            return;
        }

        var d = "key=changePassword&oldPassword=" + oldPassword + "&newPassword=" + newPassword;

        $.ajax({
            data: d,
            dataType: "json",
            cache: false,
            method: 'POST',
            url: '<%= Page.ResolveClientUrl("~/RequestPages/UserPage.aspx")%>',
            success: function (html) {
                if (html == "-1") {
                    $("#divChangePasswordErrorMsg").css("display", "block");
                    $("#spnChangePasswordErrorMsg").html("<%=Resources.Resource.msgoldPasswordNotCorrect %>");
                }
                else if (html == "0") {
                    $("#divChangePasswordErrorMsg").css("display", "block");
                    $("#spnChangePasswordErrorMsg").html("<%=Resources.Resource.msgPasswordNotChanged %>");
                }
                else {
                    ClearChangePasswordForm();
                    $("#divChangePasswordSuccessMsg").css("display", "block");
                    $("#spnChangePasswordSuccessMsg").html("<%=Resources.Resource.msgPasswordChangedSuccessfully %>");
                }
            },
            error: function (html) {
                $("#divChangePasswordErrorMsg").css("display", "block");
                $("#spnChangePasswordErrorMsg").html("<%=Resources.Resource.msgPasswordNotChanged %>");
            }
        });
    }


</script>

<!-- BEGIN HEADER -->
<div class="header navbar navbar-inverse navbar-fixed-top">
    <!-- BEGIN TOP NAVIGATION BAR -->
    <div class="navbar-inner">
        <div class="container-fluid">
            <!-- BEGIN LOGO -->
            <a class="brand" style="width: auto !important; color: white; " href='<%= Page.ResolveClientUrl("~/Common/Home")%>'>
                <h3><%= Session["companyName"] + "" %> - <%=Resources.Resource.tams %></h3>
            </a>
            <!-- END LOGO -->
            <!-- BEGIN RESPONSIVE MENU TOGGLER -->
            <a href="javascript:;" class="btn-navbar collapsed" data-toggle="collapse" data-target=".nav-collapse">
                <img src='<%= Page.ResolveClientUrl("~/Assets/" + languageStr + "/img/menu-toggler.png")%>' alt="" />
            </a>
            <!-- END RESPONSIVE MENU TOGGLER -->
            <!-- BEGIN TOP NAVIGATION MENU -->
            <ul class="nav pull-<%= pullDirectionStr%>">
                <!-- BEGIN NOTIFICATION DROPDOWN -->
                <!-- END NOTIFICATION DROPDOWN -->
                <!-- BEGIN TODO DROPDOWN -->
                <!-- END TODO DROPDOWN -->
            
                 <li class="dropdown" id="Li2" style="display:none;">
                    <a style="padding-top: 10px; color: red;" onclick="EvacReport();" href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span style="font-weight: bold;" id="btnEvacReport"   >Evacuation Report</span> &nbsp;
                    </a> 
                </li>

        <%  if (IsMultiLang ==  true)
            { %>
                <li class="dropdown" id="Li1">
                    <a style="padding-top: 10px; color: #FFF;" href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span style="font-weight: bold;" onclick="ChangeLanguage()"><%= Session["changeLanguage"] + ""%></span> &nbsp;
                    </a>
                </li>
           <% }%>
                <!-- BEGIN USER LOGIN DROPDOWN -->

                <li class="dropdown user">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <img alt="" style="width: 24px; height: 24px;" src="<%= Page.ResolveClientUrl("~/Handlers/EmployeeProfileImage.ashx?id=" + Session["ID"] + "") %>" />
                        <span class="username"><%= Session["Username"] + ""%></span>
                        
                         <%  if (IsWindowsLogin ==  false)
            { %>
                        <i class="icon-angle-down"></i>  <% }%>
                    </a>

                    <ul class="dropdown-menu">

                        <%  if (!IsWindowsLogin && !IsActiveDirectoryLogin)   { %>
                        <li><a onclick="return ClearChangePasswordForm()" href='#divChangePassword' data-toggle="modal"><i class="icon-key"></i><%=Resources.Resource.changePassword %></a></li>
                       <% }%>

                         <%  if (!IsWindowsLogin)
                        { %>
                        <li><a href='<%= Page.ResolveClientUrl("~/Logout")%>'><i class="icon-key"></i><%=Resources.Resource.logout%></a></li> <% }%>
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->
            </ul>
            <!-- END TOP NAVIGATION MENU -->
        </div>
    </div> 
    <!-- END TOP NAVIGATION BAR -->
    <div class="alert alert-error" id="divLicenseWarning" style="text-align:center !important; display:none;">
     <span id="spnLicenseWarningMsg"></span>
    </div>
</div>
<!-- END HEADER -->



<div id="divEvacReport" class="modal hide">
        <div class="modal-body">
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN VALIDATION STATES-->
                    <div class="portlet box purple">
                        <div class="portlet-title">
                            <h4><i class="icon-reorder"></i>&nbsp; <%=Resources.Resource.dashboardFilters %>  </h4>
                        </div>
                        <div class="portlet-body form">
                            <!-- BEGIN FORM-->
                            <form action="#" id="form_1" class="form-horizontal" style="min-height:350px !Important;">
                                   
                                <div class="row-fluid datecontrol">
                                    <div class="span6 ">
                                          <div class="control-group">
                                               <label class="control-label"><%=Resources.Resource.date %><span class="required">*</span></label>
                                                   <div class="controls">
                                                   <input id="txtDashboardDate12" name="DashboardDate1" style="width: 211px;" data-required="1" class="m-wrap m-ctrl-medium date-picker reportcalendar" size="16" type="text" value="" />
                                              </div>
                                         </div>
                                    </div>
                                    <!--/span-->
                                </div>
                                <div class="control-group">
                                    <label class="control-label">&nbsp;</label>
                                    <div class="controls">
                                        <input id="chkboxActive" type="checkbox" name="active" />
                                        <%=Resources.Resource.active %>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <span id="spnID" style="display: none;">0</span>
                                    <a id="btnSearch1" class="label label-info label-mini"><%=Resources.Resource.search %></a>
                                    <a id="btnSearchClear" onclick="return Clear(true)" class="label label-inverse label-mini"><%=Resources.Resource.clear %></a>
                                    <a id="btnClosePopup" data-dismiss="modal" class="label label-mini"><%=Resources.Resource.close %></a>
                                </div>
                            </form>
                            <!-- END FORM-->
                        </div>
                    </div>
                    <!-- END VALIDATION STATES-->
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript">
    $(document).ready(function () {

        var licDays = '<%= LicenseLeftDays  %>';

        if (licDays > 0 && licDays <= 30) {

            $('#divLicenseWarning').css('display', 'block');
            $('#spnLicenseWarningMsg').html(" <strong> Warning!! Your TimeCheck Support License Expires in " + <%= LicenseLeftDays %> + " days, Please contact your vendor to renew the license </strong>");
        }
        else if (licDays <= 0) {

            $('#divLicenseWarning').css('display', 'block');
            $('#spnLicenseWarningMsg').html(" <strong> Warning!! Your TimeCheck Support License Expired, Please contact your vendor to renew the license </strong>");

        }
        else {
            $('#divLicenseWarning').css('display', 'none');
        }

        
    });

    function EvacReport() { 
        $("#divEvacReport").click();
    }
</script>