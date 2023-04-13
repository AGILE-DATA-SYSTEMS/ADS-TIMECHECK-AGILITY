<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GeoTracking.aspx.cs" Inherits="TAMSR2.Dashboard.GeoTracking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title><%=Resources.Resource.geoTracking %> - <%=Resources.Resource.applicationName %> </title>
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/linecons/css/linecons.css'>
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/fontawesome-4.2.0/css/font-awesome.min.css' />
    <link rel="stylesheet" type="text/css" href="../assets/<%= languageStr %>//plugins/jquery-ui/jquery-ui-1.10.1.custom.min.css" />
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../Assets/<%= languageStr %>/css/tams-dashboard.css" />
    <link rel="stylesheet" type="text/css" href="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/css/datepicker.css" />
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
                        <p>THEME COLOR</p>
                        <ul class="inline">
                            <li class="color-black current color-default" data-style="default"></li>
                            <li class="color-blue" data-style="blue"></li>
                            <li class="color-brown" data-style="brown"></li>
                            <li class="color-purple" data-style="purple"></li>
                            <li class="color-white color-light" data-style="light"></li>
                        </ul>
                        <label class="hidden-phone">
                            <input type="checkbox" class="header" checked value="" />
                            <span class="color-mode-label">Fixed Header</span>
                        </label>
                    </div>
                </div>
                <!-- END BEGIN STYLE CUSTOMIZER -->
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title" style="margin: 0px;" runat="server" id="pgTitle">
                    <small><%=Resources.Resource.geoTracking %></small>
                </h3>
                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home"></i>
                        <a href='<%= Page.ResolveClientUrl("../Common/Home") %>'><%=Resources.Resource.home %> </a>

                        <i class="icon-angle-right"></i>
                    </li>
                    <li><a href="#"><%=Resources.Resource.geoTracking %> </a></li>
                    
                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->
        <div id="dashboard" style="width: 99%;" class="tams-dashboard">

            <div class="row-fluid">
                <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_MAP) == true)
                 { %>
               <div class="span12" id="divReaderMap" style="min-height:760px !important; height:760px !Important;float: <%= floatStr %>; display:none;">
                    <div class="portlet box red" style="min-height:760px !important; height:760px !Important;">
                     <div class="portlet-title">
                        <div class="caption"><i class="icon-reorder"></i><%=Resources.Resource.geoTracking %></div>
                        <div class="tools">
                           <a href="javascript:;" class="collapse"></a> 
                        </div>
                     </div>
                     <div class="portlet-body" style="min-height:760px !important; height:760px !Important;float: <%= floatStr %>"> 
                         <div id="map1" style="position:absolute !important; width:98% !important; min-height:80% !important; height:80% !important;"></div> 
                    </div>
               </div>
                
                <% } %> 
            </div>
          <div class="portlet box red">
                     <div class="portlet-title">
                        <div class="caption"><i class="icon-reorder"></i><%=Resources.Resource.geoTracking %></div>
                        <div class="tools">
                           <a href="javascript:;" class="collapse"></a> 
                        </div>
                     </div>
                     <div class="portlet-body" style="min-height:500px !important;" >
                        <div id="map" class="chart" style="padding: 0px; position: relative; min-height:500px !important;">
                             
                        </div>
                                 
                     </div>
                  </div>
           </div>
             
    </div>


    

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="../Styles/HighCharts/jquery.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="../Assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
   <script src="../Assets/<%= languageStr %>/plugins/excanvas.js"></script>
   <script src="../Assets/<%= languageStr %>/plugins/respond.js"></script>  
   <![endif]-->
    <script src="../Assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js" type="text/javascript"></script>
    <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js -->
    <script src="../Assets/<%= languageStr %>/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.cookie.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/date.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery-easy-pie-chart/jquery.easy-pie-chart.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/gritter/js/jquery.gritter.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/jquery.pulsate.min.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/flot/jquery.flot.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/plugins/flot/jquery.flot.resize.js" type="text/javascript"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
    <script type="text/javascript" src="<%= path %>assets/<%= languageStr %>/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>

    
    <script async defer type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDZMwwL1hvA0CP1mgah6f1rxe8paenOxoo"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="../Assets/<%= languageStr %>/scripts/app.js" type="text/javascript"></script>
    <script src="../Assets/<%= languageStr %>/scripts/index.js" type="text/javascript"></script> 
    <script src="../Scripts/jquery.loadmask.js"></script> 

    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        var loadStep = 0;
        window.requestPageUrl = '<%= Page.ResolveClientUrl("~/RequestPages/DashboardPage.aspx") %>';
        window.defaultDateFormat = "yyyy-mm-dd";


        function clearMainPopup() {
            
          //  $('#sample_Late_Early tbody').html('');
        }
     
        $(document).ready(function () {
              if (typeof String.prototype.trim != 'function') {
                String.prototype.trim = function () {
                    return this.replace(/^\s+|\s+$/g, '');
                }
            }
            if (checkbrowser()) {
                $('#ui-datepicker-div').addClass("datepicker-IE");
            }
        });
        var latitude;
        var longitude;
        jQuery(document).ready(function () {

            App.init(); // initlayout and core plugins 
            
              
            Index.init();
            GetReaderTransactionsCount();

            $("#page-sidebar li").removeClass("active");
            $("#page-sidebar li ul li").removeClass("active");
            $("#page-sidebar li ul li ul li").removeClass("active");
            $("#liDashboard").addClass("active");
            $("#liDashboard .arrow").addClass("open");
            $("#liGeoTracking").addClass("active");

              
            if ('<%= Session["sidebar"] + "" %>' != '') {
                $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
            }

            $("[data-widget='collapse']").click(function () {
                //Find the box parent        
                var box = $(this).parents(".box").first();
                //Find the body and the footer
                var bf = box.find(".panel-body");
                if (!box.hasClass("collapsed-box")) {
                    box.addClass("collapsed-box");
                    bf.slideUp();
                } else {
                    box.removeClass("collapsed-box");
                    bf.slideDown();
                }
            });
           

            var currentDate = new Date()
            var day = currentDate.getDate()
            var month = currentDate.getMonth() + 1
            var year = currentDate.getFullYear();
            if (day < 10)
                day = "0" + day;
            if (month < 10)
                month = "0" + month;
            $("#spnMovementDate").html(day + "-" + month + "-" + year);

              

        });
         

        function imposeMaxLength(Object, evt, MaxLen) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 8 || charCode == 37 || charCode == 38 || charCode == 39 || charCode == 40 || charCode == 46) return true;
            return (Object.value.length < MaxLen);
        }

    function ReloadDashboard() {
        loadStep = 0; 
        //LoadGrid();
        //LoadDashboard();
        //LoadGroupVoilations();
        $("ul.nav-tabs li.active a").click();

        }   
function checkbrowser() {

    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");

    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))  // If Internet Explorer, return version number
    {
        return true
    }
    else  // If another browser, return 0
    {
        return false;
    }

    return false;
}
var colors = {
    blue: "#5fb4ef",
    purple: "#7c38bc",
    orange: "#ff851b",
    red: "#cc3f44",
    green: "#a1c436"

};

    function Clear(reset) {

        $('#ddOrg option[value=""]').attr('selected', 'selected');
        $("#ddOrg").trigger("liszt:updated");
        $('#ddEmp option[value=""]').attr('selected', 'selected');
        $("#ddEmp").trigger("liszt:updated");
        $('#ddMgr option[value=""]').attr('selected', 'selected');
        $("#ddMgr").trigger("liszt:updated");
      
    }
    var watchID;
    var geoLoc;

    function showLocation(position) {
        latitude = position.coords.latitude.toFixed(5);
        longitude = position.coords.longitude.toFixed(5);
    }

    function errorHandler(err) {
        if (err.code == 1) {
            location = "";
            alert("Error: Access is denied!");
        } else if (err.code == 2) {
            alert("Error: Position is unavailable!");
        }
    }

    var getLocationUpdate = function () {
        var r = $.Deferred();
        if (navigator.geolocation) {

            // timeout at 60000 milliseconds (60 seconds)
            var options = { timeout: 60000 };
            geoLoc = navigator.geolocation;
            watchID = geoLoc.getCurrentPosition(showLocation, errorHandler, options);
           
        } else {
            alert("Sorry, browser does not support geolocation!");
        }
        return r;
    } 



    function GetReaderTransactionsCount() {


        <% if (new TAMSR2.ObjectClasses.TAMSPrivilege().IsPrivileged(TAMSR2.ObjectClasses.TAMSPrivilege.VIEW_DASHBOARD_MAP) == false)
            { %> 
             return;
        <%  } %>


        var dt = $("#txtDashboardDate").val();
        if (dt == "" || dt == 'undefined' || dt == undefined || dt == "Select date...") {
            dt = '<%= DateTime.UtcNow.AddHours(TAMSR2Framework.DAL.AppSetting.defaultTimeZone).ToString("yyyy-MM-dd") %>';
        }

        var v = "key=GetReaderTransactionsCount&dt=" + dt; 
        $.ajax({
            type: 'POST',
            data: v,
            url: '<%= Page.ResolveClientUrl("~/RequestPages/DashboardGeoTrackingPage.aspx") %>',
            success: function (html) { 
                    if (html != "") {
                        initMap(html);
                    }

                },
                error: function (html) {
                    $("#divErrorMsgValidate").css("display", "block");
                    $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                    }
            });

            }

            var map, infoWindow;
            function initMap(locations) {

                $("#divReaderMap").mask("<%=Resources.Resource.processing %>" + "....");
                var j = $.parseJSON(locations);
                var infowindow = new google.maps.InfoWindow({});
                var center = { lat: 25.205056, lng: 55.270583 };
                var marker, count;
                //var locations = [
                //                ['546837809  (Transactions =8)', 24.484104, 54.373858],
                //                ['B6 Admin [10.64.85.100]  (Transactions =53)', 24.584204, 54.473958],
                //                ['DM2 Reception [10.137.19.101]  (Transactions =5)', 24.684304, 54.574058],
                //                ['B3 Sales [10.3.19.100]  (Transactions =60)', 24.784404, 54.674158],
                //                ['IT NAMI B3 GF [10.76.80.206]  (Transactions =1)', 24.884504, 54.774258]
                //                    ];

                var map = new google.maps.Map(document.getElementById('map'), {
                    zoom: 8,
                    center: center
                });
                //var marker = new google.maps.Marker({
                //    position: { lat: locations[count][1], locations[count][2] },
                //    title: Name
                //});
                for (count = 0; count < j.length; count++) {
                    var pos = { lat: parseFloat(j[count].Latitude), lng: parseFloat(j[count].Longitude) };

                    marker = new google.maps.Marker({
                        position: pos,
                        icon: '../Images/reader-min.png',
                        title: j[count].NameEn
                    });
                    marker.setMap(map);
                }

                $("#divReaderMap").unmask();
            }

            function handleLocationError(browserHasGeolocation, infoWindow, pos) {
                infoWindow.setPosition(pos);
                infoWindow.setContent(browserHasGeolocation ?
                                      'Error: The Geolocation service failed.' :
                                      'Error: Your browser doesn\'t support geolocation.');
                infoWindow.open(map);
            } 
    </script>
</asp:Content>
