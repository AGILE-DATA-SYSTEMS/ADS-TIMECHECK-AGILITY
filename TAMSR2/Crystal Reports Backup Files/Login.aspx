<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TAMSR2.Login" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
  <meta charset="utf-8" />
  <title><%=Resources.Resource.login %> - <%=Resources.Resource.applicationName %></title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="TAMS" name="description" />
  <meta content="muhammad aqeel abbas" name="author" />
  <!-- BEGIN GLOBAL MANDATORY STYLES -->
  <link href='Assets/<%= languageStr %>/plugins/bootstrap/css/bootstrap.min.css' rel='stylesheet' type='text/css'/>
  <link href='Assets/<%= languageStr %>/plugins/bootstrap/css/bootstrap-responsive.min.css' rel='stylesheet' type='text/css'/>
  <link href='Assets/<%= languageStr %>/plugins/font-awesome/css/font-awesome.min.css' rel='stylesheet' type='text/css'/>
  <link href='Assets/<%= languageStr %>/css/style-metro.css' rel='stylesheet' type='text/css'/>
  <link href='Assets/<%= languageStr %>/css/style.css' rel='stylesheet' type='text/css'/>
  <link href='Assets/<%= languageStr %>/css/style-responsive.css' rel='stylesheet' type='text/css'/>
  <link href='Assets/<%= languageStr %>/css/themes/default.css' rel='stylesheet' type='text/css' id='style_color'/>
  <link href='Assets/<%= languageStr %>/plugins/uniform/css/uniform.default.css' rel='stylesheet' type='text/css'/>
  <!-- END GLOBAL MANDATORY STYLES -->
  <!-- BEGIN PAGE LEVEL STYLES -->
  <link href="Styles/jquery.loadmask.css" rel="stylesheet" />
  <link href='Assets/<%= languageStr %>/css/pages/login.css' rel='stylesheet' type='text/css'/>
  <link rel="stylesheet" type="text/css" href='assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
  <link rel="stylesheet" href='assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
  <!-- END PAGE LEVEL STYLES -->
  <link rel="shortcut icon" href="favicon.ico" />

    <script type="text/javascript">
    </script>
</head>
<!-- END HEAD -->
    
<!-- BEGIN BODY -->
<body class="login">
    <form id="form1" runat="server" visible="false">
    <div>
    
    </div>
    </form>

    <!-- BEGIN LOGO -->
  <div class="logo">
    <img src="Assets/<%= languageStr %>/img/logo-big.png" alt="" /> 
  </div>
  <!-- END LOGO -->
  <!-- BEGIN LOGIN -->
  <div class="content">
      <div onclick="ChangeLanguage()" style="display: inline; float: <%= pullDirectionStr%>; cursor: pointer;"> <%= Session["changeLanguage"] + "" %></div>
    <!-- BEGIN LOGIN FORM -->
    <form class="form-vertical login-form">
      <h3 class="form-title"><%=Resources.Resource.loginToYourAccount %></h3>
      <div id="divError">
          <div id="divErrorMsg" class='alert alert-error hide'>
            <span><%=Resources.Resource.enterUsernamePassword %></span>
          </div>
      </div> 
      <div class="control-group">
        <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
        <label class="control-label visible-ie8 visible-ie9"><%=Resources.Resource.username %></label>
        <div class="controls">
          <div class="input-icon left">
            <i class="icon-user"></i>
            <input id="txtUsername" class="m-wrap placeholder-no-fix" type="text" placeholder="<%=Resources.Resource.username %>" name="username" tabindex="1"/>
          </div>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label visible-ie8 visible-ie9"><%=Resources.Resource.password %></label>
        <div class="controls">
          <div class="input-icon left">
            <i class="icon-lock"></i>
            <input id="txtPassword" class="m-wrap placeholder-no-fix" type="password" placeholder="<%=Resources.Resource.password %>" name="password" tabindex="2"/>
          </div>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label visible-ie8 visible-ie9"><%=Resources.Resource.company %></label>
        <div class="controls">
          <div class="input-icon left">
              <select id="ddCompany" style="width: 288px;" class="span6 chosen" data-with-diselect="1" name="company" data-placeholder="<%=Resources.Resource.choose %> <%=Resources.Resource.company %>" tabindex="3">
                <option value=""></option>
              </select>
          </div>
        </div>
      </div>
        <br />
      <div class="form-actions">
        <label class="checkbox">
        <input id="chkboxRemember" type="checkbox" name="remember" value="1" tabindex="4"/> <%=Resources.Resource.rememberMe %>
        </label>
          <button type="button" onclick="UserLogin()" value="Login" class="btn green pull-<%= pullDirectionStr %>">
        <%=Resources.Resource.login %> <i class="m-icon-swapright m-icon-white" tabindex="5"></i>
        </button>            
      </div>
      <div class="forget-password">
        <h4><%=Resources.Resource.forgotYourPassword %></h4>
        <p>
          <a href="javascript:;" class="" id="forget-password"><%=Resources.Resource.forgotYourPasswordText %></a>
        </p>
      </div>
      <div class="create-account" style="display: none;">
        <p>
          Don't have an account yet ?&nbsp; 
          <a class="" id="register-btn" href="javascript:;">Create an account</a>
        </p>
      </div>
    </form>
    <!-- END LOGIN FORM -->        
    <!-- BEGIN FORGOT PASSWORD FORM -->
    <form class="form-vertical forget-form" action="index.html">
      <h3 class=""><%=Resources.Resource.forgotYourPassword %></h3>
      <p><%=Resources.Resource.forgotResetText %></p>
      <div class="control-group">
        <div class="controls">
          <div class="input-icon left">
            <i class="icon-envelope"></i>
            <input class="m-wrap placeholder-no-fix" type="text" placeholder="<%=Resources.Resource.email %>" name="email" />
          </div>
        </div>
      </div>
      <div class="form-actions">
        <button type="button" id="back-btn" class="btn">
        <i class="m-icon-swapleft"></i> <%=Resources.Resource.back %>
        </button>
        <button type="submit" class="btn green pull-<%= pullDirectionStr %>">
        <%=Resources.Resource.submit %> <i class="m-icon-swapright m-icon-white"></i>
        </button>            
      </div>
    </form>
    <!-- END FORGOT PASSWORD FORM -->
    <!-- BEGIN REGISTRATION FORM -->
    <form class="form-vertical register-form" action="index.html">
      <h3 class="">Sign Up</h3>
      <p>Enter your account details below:</p>
      <div class="control-group">
        <label class="control-label visible-ie8 visible-ie9"><%=Resources.Resource.username %></label>
        <div class="controls">
          <div class="input-icon left">
            <i class="icon-user"></i>
            <input class="m-wrap placeholder-no-fix" type="text" placeholder="<%=Resources.Resource.username %>" name="username"/>
          </div>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label visible-ie8 visible-ie9"><%=Resources.Resource.password %></label>
        <div class="controls">
          <div class="input-icon left">
            <i class="icon-lock"></i>
            <input class="m-wrap placeholder-no-fix" type="password" id="register_password" placeholder="<%=Resources.Resource.password %>" name="password"/>
          </div>
        </div>
      </div>
      <div class="control-group">
        <label class="control-label visible-ie8 visible-ie9"><%=Resources.Resource.retypePassword %></label>
        <div class="controls">
          <div class="input-icon left">
            <i class="icon-ok"></i>
            <input class="m-wrap placeholder-no-fix" type="password" placeholder="<%=Resources.Resource.retypePassword %>" name="rpassword"/>
          </div>
        </div>
      </div>
      <div class="control-group">
        <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
        <label class="control-label visible-ie8 visible-ie9"><%=Resources.Resource.email %></label>
        <div class="controls">
          <div class="input-icon left">
            <i class="icon-envelope"></i>
            <input class="m-wrap placeholder-no-fix" type="text" placeholder="<%=Resources.Resource.email %>" name="email"/>
          </div>
        </div>
      </div>
      <div class="control-group">
        <div class="controls">
          <label class="checkbox">
          <input type="checkbox" name="tnc"/> <%=Resources.Resource.agreeTo %> <a href="#"><%=Resources.Resource.termsOfServices %></a> <%=Resources.Resource.and %> <a href="#"><%=Resources.Resource.privacyPolicy %></a>
          </label>  
          <div id="register_tnc_error"></div>
        </div>
      </div>
      <div class="form-actions">
        <button id="register-back-btn" type="button" class="btn">
        <i class="m-icon-swapleft"></i>  <%=Resources.Resource.back %>
        </button>
        <button type="submit" id="register-submit-btn" class="btn green pull-<%= pullDirectionStr %>">
        <%=Resources.Resource.signUp %> <i class="m-icon-swapright m-icon-white"></i>
        </button>            
      </div>
    </form>
    <!-- END REGISTRATION FORM -->
  </div>
  <!-- END LOGIN -->
  <!-- BEGIN COPYRIGHT -->
  <div class="copyright">
    <%=Resources.Resource.footerText %>
  </div>
  <!-- END COPYRIGHT -->
  <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
  <!-- BEGIN CORE PLUGINS -->
  <script src='Assets/<%= languageStr %>/plugins/jquery-1.8.3.min.js' type='text/javascript'></script> 
  <!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->  
  <script src='Assets/<%= languageStr %>/Enplugins/jquery-ui/jquery-ui-1.10.1.custom.min.js' type='text/javascript'></script>    
  <script src='Assets/<%= languageStr %>/plugins/bootstrap/js/bootstrap.min.js' type='text/javascript'></script>
  <!--[if lt IE 9]>
  <script src='Assets/<%= languageStr %>/plugins/excanvas.js'></script>
  <script src='Assets/<%= languageStr %>/plugins/respond.js'></script> 
  <![endif]-->  
  <script src='Assets/<%= languageStr %>/plugins/breakpoints/breakpoints.js' type='text/javascript'></script>  
  <!-- IMPORTANT! jquery.slimscroll.min.js depends on jquery-ui-1.10.1.custom.min.js -->  
  <script src='Assets/<%= languageStr %>/plugins/jquery-slimscroll/jquery.slimscroll.min.js' type='text/javascript'></script>
  <script src='Assets/<%= languageStr %>/plugins/jquery.blockui.js' type='text/javascript'></script> 
  <script src='Assets/<%= languageStr %>/plugins/jquery.cookie.js' type='text/javascript'></script>
  <script src='Assets/<%= languageStr %>/plugins/uniform/jquery.uniform.min.js' type='text/javascript' ></script>  
  <!-- END CORE PLUGINS -->
  <!-- BEGIN PAGE LEVEL PLUGINS -->
  <script src="Scripts/jquery.loadmask.js"></script>
  <script type="text/javascript" src="assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
  <script type="text/javascript" src="assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
  <script src='Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
  <script src='Assets/<%= languageStr %>/scripts/app.js' type='text/javascript'></script>
      
  <!-- END PAGE LEVEL SCRIPTS --> 
  <script>
      $(document).ready(function () {
          App.init();
          Login.init();
          $("#txtUsername").val('<%= username %>');
          $("#txtPassword").val('<%= password %>');
          LoadCompanies();
          if ('<%= remember %>') {
              $("#chkboxRemember").attr("checked", "checked");
              $("#uniform-chkboxRemember span").addClass("checked");
          }
      });

      function LoadCompanies() {
          var d = "key=getIdNameListString";
          $(".content").mask("<%=Resources.Resource.processing %>" + "....");
          $.ajax({
              type: 'POST',
              data: d,
              url: '<%= Page.ResolveClientUrl("../RequestPages/CompanyPage.aspx") %>',
               success: function (html) {
                   $("#ddCompany").html(html);
                   $('#ddCompany option[value=<%= companyID %>]').attr('selected', 'selected');
                   $("#ddCompany").trigger("liszt:updated");
                   $(".content").unmask();
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("<%=Resources.Resource.msgError %>");
                   $(".content").unmask();
               }
           });
      }

      function ChangeLanguage() {
          var d = "key=changeLanguage";
          $(".content").css("cursor", "wait");
          $(".content").mask("<%=Resources.Resource.processing %>...");
            $.ajax({
                data: d,
                dataType: "json",
                cache: false,
                method: 'POST',
                url: '<%= Page.ResolveClientUrl("~/RequestPages/SettingPage.aspx") %>',
                success: function (html) {
                    if (html == "1") {
                        window.location.reload();
                    }
                    $(".content").css("cursor", "pointer");
                    $(".content").unmask();
                },
                //error : function(xhr,status,message){
                //    notifier.error("Sorry looks like an error occurred.");
                //}
                error: function (html) {
                    $(".content").css("cursor", "pointer");
                    $(".content").unmask();
                }
            });
      }

        function UserLogin() {
            var username = $("#txtUsername").val();
            var password = $("#txtPassword").val();
            var companyID = $("#ddCompany").val();
            var remember = $("#chkboxRemember").is(":checked");
            var d = "key=login&userName=" + username + "&password=" + password + "&companyID=" + companyID + "&remember=" + remember;
            if ($('.login-form').validate().form() == false) {
                return false;
            }
            $(".content").css("cursor", "wait");
            $(".content").mask("<%=Resources.Resource.processing %>...");
            $.ajax({
                url: 'RequestPages/UserPage.aspx',
                data: d,
                type: 'POST',
                success: function (chk) {
                    if (chk == "1") {
                        window.location = 'Common/Default.aspx';
                    }
                    else if (chk == '0') {
                        $(".content").css("cursor", "pointer");
                        $("#divErrorMsg").css("display", "block");
                        $("#divErrorMsg").html("<%=Resources.Resource.usernameOrPasswordNotMatched %>");
                    }
                    else {
                        $(".content").css("cursor", "pointer");
                        $("#divErrorMsg").css("display", "block");
                        $("#divErrorMsg").html("<%=Resources.Resource.userNotActive %>");
                    }
                    $(".content").unmask();
                },
                error: function () {
                    $(".content").css("cursor", "pointer");
                    $("#divErrorMsg").css("display", "block");
                    $("#divErrorMsg").html("<%=Resources.Resource.couldNotConnectToServer %>");
                    $(".content").unmask();
                }

            });
        }

      var Login = function () {

          return {
              //main function to initiate the module
              init: function () {

                  $('.login-form').validate({
                      errorElement: 'label', //default input error message container
                      errorClass: 'help-inline', // default input error message class
                      focusInvalid: false, // do not focus the last invalid input
                      rules: {
                          username: {
                              required: true
                          },
                          password: {
                              required: true
                          },
                          company: {
                              required: true
                          },
                          remember: {
                              required: false
                          }
                      },

                      messages: {
                          username: {
                              required: "<%=Resources.Resource.usernameRequired %>"
                        },
                          password: {
                              required: "<%=Resources.Resource.passwordRequired %>"
	                    },
                          company: {
                              required: "<%=Resources.Resource.companyCodeRequired %>"
                        }
                      },

                      invalidHandler: function (event, validator) { //display error alert on form submit   
                          $('.alert-error', $('.login-form')).show();
                      },

                      highlight: function (element) { // hightlight error inputs
                          $(element)
                              .closest('.control-group').addClass('error'); // set error class to the control group
                      },

                      success: function (label) {
                          label.closest('.control-group').removeClass('error');
                          label.remove();
                      },

                      errorPlacement: function (error, element) {
                          error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
                      },

                      submitHandler: function (form) {
                          //alert("hhhhh"); Login();
                      }
                  });

                  //$('.login-form input').keypress(function (e) {
                  //    if (e.which == 13) {
                  //        if ($('.login-form').validate().form()) {
                  //            UserLogin();
                  //        }
                  //        return false;
                  //    }
                  //});

                  $('.forget-form').validate({
                      errorElement: 'label', //default input error message container
                      errorClass: 'help-inline', // default input error message class
                      focusInvalid: false, // do not focus the last invalid input
                      ignore: "",
                      rules: {
                          email: {
                              required: true,
                              email: true
                          }
                      },

                      messages: {
                          email: {
                              required: "Email is required."
                          }
                      },

                      invalidHandler: function (event, validator) { //display error alert on form submit   

                      },

                      highlight: function (element) { // hightlight error inputs
                          $(element)
                              .closest('.control-group').addClass('error'); // set error class to the control group
                      },

                      success: function (label) {
                          label.closest('.control-group').removeClass('error');
                          label.remove();
                      },

                      errorPlacement: function (error, element) {
                          error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
                      },

                      submitHandler: function (form) {
                          window.location.href = "index.html";
                      }
                  });

                  $('.forget-form input').keypress(function (e) {
                      if (e.which == 13) {
                          if ($('.forget-form').validate().form()) {
                              window.location.href = "index.html";
                          }
                          return false;
                      }
                  });

                  jQuery('#forget-password').click(function () {
                      jQuery('.login-form').hide();
                      jQuery('.forget-form').show();
                  });

                  jQuery('#back-btn').click(function () {
                      jQuery('.login-form').show();
                      jQuery('.forget-form').hide();
                  });

                  $('.register-form').validate({
                      errorElement: 'label', //default input error message container
                      errorClass: 'help-inline', // default input error message class
                      focusInvalid: false, // do not focus the last invalid input
                      ignore: "",
                      rules: {
                          username: {
                              required: true
                          },
                          password: {
                              required: true
                          },
                          rpassword: {
                              equalTo: "#register_password"
                          },
                          email: {
                              required: true,
                              email: true
                          },
                          tnc: {
                              required: true
                          }
                      },

                      messages: { // custom messages for radio buttons and checkboxes
                          tnc: {
                              required: "Please accept TNC first."
                          }
                      },

                      invalidHandler: function (event, validator) { //display error alert on form submit   

                      },

                      highlight: function (element) { // hightlight error inputs
                          $(element)
                              .closest('.control-group').addClass('error'); // set error class to the control group
                      },

                      success: function (label) {
                          label.closest('.control-group').removeClass('error');
                          label.remove();
                      },

                      errorPlacement: function (error, element) {
                          if (element.attr("name") == "tnc") { // insert checkbox errors after the container                  
                              error.addClass('help-small no-left-padding').insertAfter($('#register_tnc_error'));
                          } else {
                              error.addClass('help-small no-left-padding').insertAfter(element.closest('.input-icon'));
                          }
                      },

                      submitHandler: function (form) {
                          window.location.href = "index.html";
                      }
                  });

                  jQuery('#register-btn').click(function () {
                      jQuery('.login-form').hide();
                      jQuery('.register-form').show();
                  });

                  jQuery('#register-back-btn').click(function () {
                      jQuery('.login-form').show();
                      jQuery('.register-form').hide();
                  });
              }

          };

      }();
  </script>
  <!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
