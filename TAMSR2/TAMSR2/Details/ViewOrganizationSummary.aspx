<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewOrganizationSummary.aspx.cs" Inherits="TAMSR2.Details.ViewOrganizationSummary" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.organizations %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='<%= path %>assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
   <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/css/bootstrap-tree.css" />
    <!-- END PAGE LEVEL STYLES -->
    <style type="text/css">
        .modal-body {
            min-height: 345px;
            overflow: hidden;
        }
        #tree_1 li {
            padding: 10px;
            list-style: none;
        }
        #tree_1 li a {
            background-color: #ffd800;
            padding: 0 30px;
            color: #666569;
        }
        a.tree-toggle {
            background: none repeat scroll 0 0 rgba(0, 0, 0, 0);
        }
        a:active {
            color: black !important;
            text-decoration: none;
        }
        #tree_1 li a:hover {
            color: black;
            font-weight: bold;
            text-decoration: none;
        }
        #tree_1 li li a {
            background-color: #8FD0F1;
        }
        #tree_1 li a {
            border-radius: 5px !important;
            padding: 10px;
        }
        #tree_1 li li li li a {
            background-color: #f3ef36;
        }
        #tree_1 li li li a {
            background-color: #CEE3AC;
        }
    </style>
    

</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <!-- BEGIN PAGE CONTAINER-->
    <div class="container-fluid">
        <!-- BEGIN PAGE HEADER-->
        <div class="row-fluid">
            <div class="span12">
                <!-- BEGIN STYLE CUSTOMIZER -->
                <div style="display: none;" class="color-panel hidden-phone">
                    <div class="color-mode-icons icon-color"></div>
                    <div class="color-mode-icons icon-color-close"></div>
                    <div class="color-mode">
                        <p><%=Resources.Resource.themeColor %></p>
                        <ul class="inline">
                            <li class="color-black current color-default" data-style="default"></li>
                            <li class="color-blue" data-style="blue"></li>
                            <li class="color-brown" data-style="brown"></li>
                            <li class="color-purple" data-style="purple"></li>
                            <li class="color-white color-light" data-style="light"></li>
                        </ul>
                        <label class="hidden-phone">
                            <input type="checkbox" class="header" checked value="" />
                            <span class="color-mode-label"><%=Resources.Resource.fixedHeader %></span>
                        </label>
                    </div>
                </div>
                <!-- END BEGIN STYLE CUSTOMIZER -->
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    <%=Resources.Resource.organizations %>	
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("~/Common/Home") %>'><%=Resources.Resource.home %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li>
                        <a href="#"><%=Resources.Resource.organization %></a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href='<%= Page.ResolveClientUrl("~/Common/Holidays") %>'><%=Resources.Resource.organizations %></a></li>

                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <!-- BEGIN PAGE CONTENT-->
        <div class="row-fluid"> 
            <div class="actions" style="display:none;"><br />
              <a href="javascript:;" id="tree_1_collapse" class="btn green"> Collapse All</a> 
            </div>
            <div  style="float: <%= floatStr %>;">
              <div  class="tree" id="tree_1">&nbsp;</div>
             <br />
            </div>
        </div>
        <div style="clear: both; margin: 10px;">
            &nbsp;
        </div>
        <!-- END PAGE CONTENT-->
        
    </div>
    <!-- END PAGE CONTAINER-->

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
   <script src="<%= path %>assets/<%= languageStr %>/plugins/excanvas.js"></script>
   <script src="<%= path %>assets/<%= languageStr %>/plugins/respond.js"></script>  
   <![endif]-->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js" type="text/javascript"></script>
    <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js -->
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/jquery.cookie.js" type="text/javascript"></script>
    <script src="<%= path %>assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-validation/dist/additional-methods.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
   <script src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-tree/bootstrap-tree/js/bootstrap-tree.js"></script>

    <!--Script references. -->
    <!--Reference the SignalR library. -->
    <script src="<%= path %>Scripts/jquery.signalR-1.1.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="<%= path %>signalr/hubs"></script>

    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src='<%= path %>Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
    <script src="<%= path %>assets/<%= languageStr %>/scripts/app.js"></script>
    <script src="<%= path %>assets/<%= languageStr %>/scripts/table-managed.js"></script>
    <!-- START OF PAGE LEVEL SCRIPT-->
    <script type="text/javascript">
        var currentZoom = 1.0;
        $(document).ready(function () {
            App.init(); // initlayout and core plugins
            //TableManaged.init();
            UITree.init();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liOrg").addClass("active");
            $("#liOrg .arrow").addClass("open");
            $("#liOrgOrganizationStructure").addClass("active");

            
            LoadRootOrg();
            

        });

        function LoadRootOrg() {
            var d = "key=getRootOrg";
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   $("#tree_1").html(html);
                   $("#tree_1 li a").click();
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                  //$("#form_sample_1").unmask();
              }
           });
        }

        function LoadOrgByParent(id) {
            var d = "key=getOrgByParent&id=" + id;
            //$("#form_sample_1").mask("<%=Resources.Resource.processing %>" + "....");
           $.ajax({
               type: 'POST',
               data: d,
               url: '<%= Page.ResolveClientUrl("../RequestPages/OrgPage.aspx") %>',
               success: function (html) {
                   if (html != "")
                       $("#li" + id + " ul").html(html);
                   //$("#form_sample_1").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   //$("#form_sample_1").unmask();
               }
           });
       }


        var UITree = function () {

            return {
                //main function to initiate the module
                init: function () {
                    // handle collapse/expand for tree_1
                    $('#tree_1_collapse').click(function () { 
                        $('.tree-toggle', $('#tree_1 > li > ul')).addClass("closed");
                        $('.branch', $('#tree_1 > li > ul')).removeClass("in");
                    });
                     
                    $('#tree_1_expand').click(function () { 
                      //  $('.tree-toggle', $('#tree_1 > li > ul')).removeClass("closed");
                        $('.branch', $('#tree_1 > li > ul')).addClass("in");
                    });


                    //This is a quick example of capturing the select event on tree leaves, not branches
                    $("#tree_1").on("nodeselect.tree.data-api", "[data-role=leaf]", function (e) {

                        //LoadOrgByParent(e.node.value);
                        var output = "";

                        output += "Node nodeselect event fired:\n";
                        output += "Node Type: leaf\n";
                        output += "Value: " + ((e.node.value) ? e.node.value : e.node.el.text()) + "\n";
                        output += "Parentage: " + e.node.parentage.join("/");

                        //alert(output);
                    });

                    //This is a quick example of capturing the select event on tree branches, not leaves
                    $("#tree_1").on("nodeselect.tree.data-api", "[role=branch]", function (e) {
                        var output = "Node nodeselect event fired:\n"; + "Node Type: branch\n" + "Value: " + ((e.node.value) ? e.node.value : e.node.el.text()) + "\n" + "Parentage: " + e.node.parentage.join("/") + "\n"

                        //alert(output);
                    });

                    //Listening for the 'openbranch' event. Look for e.node, which is the actual node the user opens

                    $("#tree_1").on("openbranch.tree", "[data-toggle=branch]", function (e) {

                        var output = "Node openbranch event fired:\n" + "Node Type: branch\n" + "Value: " + ((e.node.value) ? e.node.value : e.node.el.text()) + "\n" + "Parentage: " + e.node.parentage.join("/") + "\n"

                        LoadOrgByParent(e.node.value);

                        //alert(e.node.value + "\n" + e.node.el.text() + "");

                        //alert(output);
                    });


                    //Listening for the 'closebranch' event. Look for e.node, which is the actual node the user closed

                    $("#tree_1").on("closebranch.tree", "[data-toggle=branch]", function (e) {

                        var output = "Node closebranch event fired:\n" + "Node Type: branch\n" + "Value: " + ((e.node.value) ? e.node.value : e.node.el.text()) + "\n" + "Parentage: " + e.node.parentage.join("/") + "\n"

                        //alert(output);
                    });
                }

            };

        }();
        ///////////END OF TREE VIEW///////////
        
    </script>
    <!-- END JAVASCRIPTS -->

    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
