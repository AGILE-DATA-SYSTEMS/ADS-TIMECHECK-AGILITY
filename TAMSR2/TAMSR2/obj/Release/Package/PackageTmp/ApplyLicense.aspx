<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyLicense.aspx.cs" Inherits="TAMSR2.ApplyLicense" %>
 <!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
   <meta charset="utf-8" />
   <title> <%=Resources.Resource.applicationName %></title>
   <meta content="width=device-width, initial-scale=1.0" name="viewport" />
   <meta content="" name="description" />
   <meta content="" name="author" />
   <!-- BEGIN GLOBAL MANDATORY STYLES -->
   <link href="../assets/<%= languageStr %>/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
   <link href="../assets/<%= languageStr %>/plugins/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
   <link href="../assets/<%= languageStr %>/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
   <link href="../assets/<%= languageStr %>/css/style-metro.css" rel="stylesheet" type="text/css"/>
   <link href="../assets/<%= languageStr %>/css/style.css" rel="stylesheet" type="text/css"/>
   <link href="../assets/<%= languageStr %>/css/style-responsive.css" rel="stylesheet" type="text/css"/>
   <link href="../assets/<%= languageStr %>/css/themes/default.css" rel="stylesheet" type="text/css" id="style_color"/>
   <link href="../assets/<%= languageStr %>/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
   <!-- END GLOBAL MANDATORY STYLES -->
   <link href="../assets/<%= languageStr %>/css/pages/promo.css" rel="stylesheet" type="text/css"/>
   <link href="../assets/<%= languageStr %>/css/animate.css" rel="stylesheet" type="text/css"/>
    <link href="../Styles/jquery.loadmask.css" rel="stylesheet" />
   <link rel="shortcut icon" href="favicon.ico" />
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="fixed-top"> 
   <!-- BEGIN CONTAINER -->   
   <div class="page-container row-fluid full-width-page">
       
      <!-- BEGIN PAGE -->
      <div class="page-content no-min-height">
         <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
         <div id="portlet-config" class="modal hide">
            <div class="modal-header">
               <button data-dismiss="modal" class="close" type="button"></button>
               <h3>portlet Settings</h3>
            </div>
            <div class="modal-body">
               <p>Here will be a configuration form</p>
            </div>
         </div>
         <!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
         <!-- BEGIN PAGE CONTAINER-->
         <div class="container-fluid promo-page">
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
               <div class="span12" id="maindiv"> 
                  <div class="block-yellow">
                     <div class="container">
                        <div class="row-fluid">
                           <div class="span5 margin-bottom-20">
                              <a href="index.html"><img src="../Images/img1.png" alt=""></a>
                           </div>
                           <div class="span7">
                              <h2>Application License Expired!</h2>
                              <h3>
                                  Dear Customer, 
                                  <br />Your TimeCheck application License got expired. Please contact vendor for license renewal or contact your System Admin for support. 
                              </h3>
                              <h4>
                                  Please share the below License ID with vendor to provide you a valid license 
                                  <h3 style="color:red !important;">License ID : <%= MachineID %></h3> 
                              </h4>
                             
                            <div class="control-group">
                                <label class="control-label"><%=Resources.Resource.license  + " " + Resources.Resource.type %></label>
                                <div class="controls chzn-controls">
                                    <select id="ddLicenseCat" name="ddLicenseCat" style="width: 220px;" class="span6 chosen" data-with-diselect="1" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.group %>">
                                        <option value="P">Primary</option>
                                        <option value="S">Secondary</option>
                                    </select>
                                </div>
                            </div> 
                               <div style="clear: both; display: inline;" class="controls chzn-controls" id="btnPatch">
                                            <input type="file" id="patchUpload" class="btn" accept=".skyline" />
                                </div>

                                <a   class="btn blue big xlarge" id="btnApplyLicense">
                             <%=Resources.Resource.apply %>
                              <i class="m-icon-big-swapright m-icon-white"></i>                                
                              </a>
                               <br />
                                <div id="divErrorMsg" class="alert alert-error hide">
                                    <button class="close" data-dismiss="alert"></button>
                                    <span id="spnErrorMsg"><%=Resources.Resource.formErrors %></span>
                                </div>
                           </div>
                        </div>
                     </div>
                  </div> 
               </div>
            </div>
         </div>
         <!-- END PAGE CONTENT-->
      </div>
      <!-- END PAGE CONTAINER--> 
   </div>
   <!-- END PAGE --> 
   <!-- END CONTAINER -->
   <!-- BEGIN FOOTER -->
    <!-- BEGIN FOOTER -->
       <div class="footer">
          <div style="text-align: center;">
              <%=Resources.Resource.footerText %>
          </div>
          <div class="span pull-<%= pullDirectionStr %>">
             <span class="go-top"><i class="icon-angle-up"></i></span>
          </div>
       </div>
       <!-- END FOOTER --> 
   <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
   <!-- BEGIN CORE PLUGINS -->
   <script src="../assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js" type="text/javascript"></script>   
   <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->  
   <script src="../assets/<%= languageStr %>/plugins/jquery-ui/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
   <script src="../assets/<%= languageStr %>/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
   <!--[if lt IE 9]>
   <script src="../assets/<%= languageStr %>/plugins/excanvas.js"></script>
   <script src="../assets/<%= languageStr %>/plugins/respond.js"></script>  
   <![endif]-->   
   <script src="../assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js" type="text/javascript"></script>  
   <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js --> 
   <script src="../assets/<%= languageStr %>/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
   <script src="../assets/<%= languageStr %>/plugins/jquery.blockui.js" type="text/javascript"></script>  
   <script src="../assets/<%= languageStr %>/plugins/jquery.cookie.js" type="text/javascript"></script>
   <script src="../assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js" type="text/javascript" ></script> 
    <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js"></script>
   <!-- END CORE PLUGINS -->
   <script src="../assets/<%= languageStr %>/scripts/app.js"></script>      
    <script src="../Scripts/jquery.loadmask.js"></script>
   <script>

       $(document).ready(function () { 
           var a = $('.page-content').height()-75;
           
           $('.row-fluid').css('minHeight', a + 'px');
            $('.page-content').resize(function () {
                $('.row-fluid').css('minHeight', a + 'px');
            });
            setInterval(function () {
                $("#divErrorMsg").css("display", "none");
            }, 20000);
            //setTimeout(function () { 
            //        alert('ddd');
            //       // $("#divErrorMsg").css("display", "none");
                 
            //}, 200);
            //var patchUploader = document.getElementById("patchUpload");
            //patchUpload.onchange = function (e) {

            //    var ext = this.value.match(/\.(.+)$/)[1];
                
            //    switch (ext) {
            //        case 'skyline' :
            //            uploadExcelFile(this);
            //            break;
            //        case 'Skyline':
            //            uploadExcelFile(this);
            //            break;
            //        default:
            //            alert('not allowed');
            //            this.value = '';
            //    }

            //};
       });


       $('#btnApplyLicense').click(function () {
           var patchUploader = document.getElementById("patchUpload");
          
           //alert(patchUploader.files.length);
           if (patchUploader.files.length == 0) {
               $("#divErrorMsg").css("display", "block");
               $("#spnErrorMsg").html("Please select license file");
           }
           var ext = patchUploader.value.match(/\.(.+)$/)[1];

           switch (ext) {
               case 'skyline':
                   uploadExcelFile(patchUploader);
                   break;
               case 'Skyline':
                   uploadExcelFile(patchUploader);
                   break;
               default:
                   alert('not allowed');
                   this.value = '';
           }
       })

       function uploadExcelFile(obj) { 
           $("#maindiv").mask("<%=Resources.Resource.processing %>" + "....");
            //event.stopPropagation(); // Stop stuff happening
            //event.preventDefault(); // Totally stop stuff happening
           var Cat = $("#ddLicenseCat option:selected").val();// $("#ddLicenseCat").val()
            var files = obj.files;
            
            
            var v = "key=applyLicense&LicenseType=AppLicense&Cat=" + Cat;
           var url = "/Handlers/ApplyLicense.ashx?" + v;
           var handlerURL = url;
           
            // START A LOADING SPINNER HERE

            // Create a formdata object and add the files
            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            $.ajax({
                url: handlerURL,
                type: "POST",
                data: data,
                contentType: false,
                processData: false,
                success: function (result) { 
                    if (result == "1") {
                        $("#maindiv").unmask();
                        $("#patchUpload").val("");
                        window.location.href = "Common/Default.aspx";

                    }
                    else if(result == "2")
                    {
                        $("#maindiv").unmask();
                        $("#patchUpload").val("");
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("Invalid licese, Please apply valid license or contact vendor.");
                    }
                    else {
                        $("#maindiv").unmask();
                        $("#patchUpload").val("");
                        $("#divErrorMsg").css("display", "block");
                        $("#spnErrorMsg").html("Error Occured, Please apply valid license or contact vendor");
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        };


   </script>
   <!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>