<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewCounteries.aspx.cs" Inherits="TAMSR2.Details.ViewCounteries" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <title><%=Resources.Resource.nationalities %> - <%=Resources.Resource.applicationName %></title>
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href='../assets/<%= languageStr %>/plugins/select2/select2_metro.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.css' />
    <link rel="stylesheet" href='../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.css' />
    <!-- END PAGE LEVEL STYLES -->
    
    <link rel="stylesheet" type="text/css" media="screen,print" href="../flags/import.css">
    <link rel="stylesheet" type="text/css" media="screen,print" href="../flags/font-medium.css" title="font-medium" disabled="">
    <link rel="alternate stylesheet" type="text/css" media="screen,print" href="../flags/font-small.css" title="font-small" disabled="">
    <link rel="alternate stylesheet" type="text/css" media="screen,print" href="../flags/font-large.css" title="font-large" disabled="">
    <link rel="stylesheet" type="text/css" media="print" href="../flags/import_print.css">
    <link rel="stylesheet" type="text/css" media="screen,print" href="../flags/NI-style.css">
    <link rel="stylesheet" type="text/css" media="screen,print" href="../flags/NI-style-unique.css">
    <link rel="stylesheet" type="text/css" media="screen,print" href="../flags/regionaltip.css">
    <script type="text/javascript">commonFooterMenuFlag = "off";</script>
    <script type="text/javascript" src="../flags/template_non_leftmenu.js"></script>
    <script type="text/javascript" src="../flags/regionalwebsite.js"></script>
    <script type="text/javascript" src="../flags/idx.js"></script>
    <style type="text/css">
        li {
            list-style: none;
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
									<%=Resources.Resource.nationalities %>	
							</h3>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href='<%= Page.ResolveClientUrl("~/Common/Home") %>' ><%=Resources.Resource.home %></a>
										
					<i class="icon-angle-right"></i>
									</li>
								<li>
					<a href="#"><%=Resources.Resource.generalInfo %></a>
										
					<i class="icon-angle-right"></i>
									</li>
				<li><a href="#"><%=Resources.Resource.nationalities %></a></li>					
						
			</ul>
		<!-- END PAGE TITLE & BREADCRUMB-->
               </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN PAGE CONTENT-->
            <div class="row-fluid">
                <div class="span12">
                    <!-- BEGIN NATIONALITIES-->

                    <div id="NI-overall01">

                        <!--NISSAN-JPHD01-START-->

                        <!--NISSAN-JPHD01-END-->


                        <div id="NI-frame-work01" class="png_bg">
                            <div id="NI-contents-block">
                                <div id="RegionItemsBlk">

                                    <div class="NI-contents-block02">
                                        <div id="col_region_01" class="NI-column01">
                                            <h4>
                                                <img src="../flags/h4_title01.gif" alt="Americas" height="11" width="63"></h4>
                                            <span class="NI-column01_btn"><a class="regional_map_btn Americas Collapse" href="#col_region_01" style="display: block; background-position: -71px 0px;">Collapse</a></span>
                                            <!--  /.NI-column01  -->
                                        </div>
                                        <div id="listBlk_Americas" class="opened" style="">
                                            <div class="regional_list_blk">
                                                <ul class="list_country">
                                                    <!--===================  Start Americas Countories Col 1 ===================-->
                                                    <li id="Argentina">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Argentina.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Argentina</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  / #Argentina  -->
                                                    <li id="Bahamas">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Bahamas.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Bahamas</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  / #Bahamas  -->
                                                    <li id="Barbados">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Barbados.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Barbados</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Barbados  -->
                                                    <li id="Bolivia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Bolivia.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Bolivia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Bolivia  -->
                                                    <li id="Brazil">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Brazil.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Brazil</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#Brazil  -->
                                                    <li id="Canada">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Canada.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Canada</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Canada -->
                                                    <li id="Chile">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Chile.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Chile</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Chile  -->
                                                    <!--===================  End Americas Countories col 1 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Americas Countories col 2 ===================-->
                                                    <li id="Colombia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Colombia.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Colombia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Colombia  -->
                                                    <li id="CostaRica">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/CostaRica.gif"></span><span class="country"><a href="#" style="cursor: pointer;">CostaRica</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#CostaRica  -->
                                                    <li id="DominicanRepublic">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/DominicanRepublic.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Dominican Republic</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#DominicanRepublic  -->
                                                    <li id="Ecuador">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Ecuador.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Ecuador</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Ecuador  -->
                                                    <li id="ElSalvador">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/ElSalvador.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">El Salvador</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#ElSalvador  -->
                                                    <li id="Guatemala">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Guatemala.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Guatemala</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Guatemala  -->
                                                    <li id="Grenada">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Grenada.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Grenada</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Grenada  -->
                                                    <!--===================  End Americas Countories col 2 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Americas Countories col 3 ===================-->
                                                    <li id="Haiti">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Haiti.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Haiti</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Haiti  -->
                                                    <li id="Honduras">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Honduras.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Honduras</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Honduras  -->
                                                    <li id="Jamaica">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Jamaica.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Jamaica</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Jamaica  -->
                                                    <li id="Mexico">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Mexico.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Mexico</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Mexico  -->
                                                    <li id="Nicaragua">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Nicaragua.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Nicaragua</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#Nicaragua  -->
                                                    <li id="Panama">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Panama.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Panama</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#Panama  -->
                                                    <li id="Paraguay">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Paraguay.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Paraguay</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Paraguay  -->
                                                    <!--===================  End Americas Countories col 3 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Americas Countories col 4 ===================-->
                                                    <li id="Peru">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Peru.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Peru</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Peru  -->
                                                    <li id="PuertoRico">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/PuertoRico.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Puerto Rico</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#PuertoRico  -->
                                                    <li id="TrinidadandTobago">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/TrinidadandTobago.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Trinidad &amp; Tobago</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#TrinidadandTobago  -->
                                                    <li id="US">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/US.gif"></span><span class="country"><a href="#" style="cursor: pointer;">US</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#US  -->
                                                    <li id="Venezuela">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Venezuela.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Venezuela</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Venezuela  -->
                                                    <li id="LatinAmericaPortal">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/noflag2.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Latin America and
                                                                <br>
                                                                the Caribbean portal</a></span></h4>

                                                    </li>
                                                    <!--  /#LatinAmericaPortal  -->
                                                    <!--===================  End Americas Countories col 4 ===================-->
                                                </ul>
                                                <!--  /.regional_list_blk  -->
                                            </div>
                                            <!--  /#listBlk_Americas  -->
                                        </div>
                                        <!--  /.NI-contents-block02  -->
                                    </div>

                                    <div class="NI-contents-block02">
                                        <div id="col_region_02" class="NI-column01">
                                            <h4>
                                                <img src="../flags/h4_title02.gif" alt="Europe" height="14" width="47"></h4>
                                            <span class="NI-column01_btn"><a class="regional_map_btn Europe Collapse" href="#col_region_02" style="display: block; background-position: -71px 0px;">Collapse</a></span>
                                            <!--  /.NI-column01  -->
                                        </div>
                                        <div id="listBlk_Europe" class="opened" style="">
                                            <div class="regional_list_blk">
                                                <ul class="list_country">
                                                    <!--===================  Start Europe Countories col 1 ===================-->
                                                    <li id="Armenia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Armenia.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Armenia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Armenia  -->
                                                    <li id="Austria">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Austria.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Austria</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Austria  -->
                                                    <li id="Azerbaijan">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Azerbaijan.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Azerbaijan</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Azerbaijan  -->
                                                    <li id="Belgium">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Belgium.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Belgium</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Belgium  -->
                                                    <li id="Bulgaria">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Bulgaria.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Bulgaria</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Bulgaria  -->
                                                    <li id="Cyprus">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Cyprus.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Cyprus</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Cyprus  -->
                                                    <li id="Croatia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Croatia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Croatia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Croatia  -->
                                                    <li id="CzechRepublic">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/CzechRepublic.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Czech Republic</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#CzechRepublic  -->
                                                    <li id="Denmark">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Denmark.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Denmark</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Denmark  -->
                                                    <li id="Estonia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Estonia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Estonia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Estonia  -->
                                                    <!--===================  End Europe Countories col 1 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Europe Countories col 2 ===================-->
                                                    <li id="Finland">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Finland.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Finland</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Finland -->
                                                    <li id="France">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/France.gif"></span><span class="country"><a href="#" style="cursor: pointer;">France</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#France  -->
                                                    <li id="Germany">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Germany.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Germany</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Germany  -->
                                                    <li id="Greece">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Greece.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Greece</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Greece  -->
                                                    <li id="Hungary">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Hungary.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Hungary</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Hungary  -->
                                                    <li id="Iceland">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Iceland.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Iceland</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Iceland  -->
                                                    <li id="Ireland">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Ireland.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Ireland</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Ireland  -->
                                                    <li id="Italy">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Italy.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Italy</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Italy  -->
                                                    <li id="Latvia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Latvia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Latvia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Latvia  -->
                                                    <li id="Lithuania">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Lithuania.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Lithuania</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Lithuania  -->
                                                    <!--===================  End Europe Countories col 2 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Europe Countories col 3 ===================-->
                                                    <li id="Luxembourg">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Luxembourg.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Luxembourg</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Luxembourg  -->
                                                    <li id="Malta">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Malta.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Malta</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Malta  -->
                                                    <li id="Netherlands">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Netherlands.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Netherlands</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Netherlands  -->
                                                    <li id="Norway">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Norway.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Norway</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Norway  -->
                                                    <li id="Poland">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Poland.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Poland</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Poland  -->
                                                    <li id="Portugal">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Portugal.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Portugal</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Portugal  -->
                                                    <li id="Romania">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Romania.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Romania</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Romania  -->
                                                    <li id="Russia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Russia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Russia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Russia  -->
                                                    <li id="Serbia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Serbia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Serbia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Serbia  -->
                                                    <!--===================  End Europe Countories col 3 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Europe Countories col 4 ===================-->
                                                    <li id="Slovakia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Slovakia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Slovakia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Slovakia  -->
                                                    <li id="Slovenia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Slovenia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Slovenia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Slovenia  -->
                                                    <li id="Spain">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Spain.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Spain</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Spain  -->
                                                    <li id="Sweden">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Sweden.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Sweden</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#Sweden  -->
                                                    <li id="Switzerland">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Switzerland.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Switzerland</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#Switzerland  -->
                                                    <li id="Turkey">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Turkey.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Turkey</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Turkey -->
                                                    <li id="UK">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/UK.gif"></span><span class="country"><a href="#" style="cursor: pointer;">UK</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#UK  -->
                                                    <li id="Ukraine">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Ukraine.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Ukraine</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Ukraine  -->
                                                    <li id="Europe">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Europe.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Europe</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Europe  -->
                                                    <!--===================  End Europe Countories col 4 ===================-->
                                                </ul>
                                                <!--  /.regional_list_blk  -->
                                            </div>
                                            <!--  /#listBlk_Europe  -->
                                        </div>
                                        <!--  /.NI-contents-block02  -->
                                    </div>

                                    <div class="NI-contents-block02">
                                        <div id="col_region_03" class="NI-column01">
                                            <h4>
                                                <img src="../flags/h4_title03.gif" alt="Asia/Oceania" height="12" width="93"></h4>
                                            <span class="NI-column01_btn"><a class="regional_map_btn Asia Collapse" href="#col_region_03" style="display: block;">Collapse</a></span>
                                            <!--  /.NI-column01  -->
                                        </div>
                                        <div id="listBlk_Asia" class="opened" style="">
                                            <div class="regional_list_blk">
                                                <ul class="list_country">
                                                    <!--===================  Start Asia/Oceania Countories col 1 ===================-->
                                                    <li id="Australia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Australia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Australia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Australia  -->
                                                    <li id="Brunei">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Brunei.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Brunei</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Brunei  -->
                                                    <li id="China">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/China.gif"></span><span class="country"><a href="#" style="cursor: pointer;">China</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#China  -->
                                                    <li id="HongKong">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/HongKong.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Hong Kong</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#HongKong  -->
                                                    <!--===================  End Asia/Oceania Countories col 1 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Asia/Oceania Countories col 2 ===================-->
                                                    <li id="India">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/India.gif"></span><span class="country"><a href="#" style="cursor: pointer;">India</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#India  -->
                                                    <li id="Indonesia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Indonesia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Indonesia</a></span></h4>

                                                    </li>
                                                    <!--  /#Indonesia  -->
                                                    <li id="Japan">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Japan.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Japan</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Japan  -->
                                                    <li id="Korea">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Korea.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Korea</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Korea  -->
                                                    <!--===================  End Asia/Oceania Countories col 2 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Asia/Oceania Countories col 3 ===================-->
                                                    <li id="Malaysia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Malaysia.gif"></span><span class="country"><a href="#" style="cursor: pointer; color: rgb(102, 102, 102); text-decoration: none;">Malaysia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Malaysia  -->
                                                    <li id="NewZealand">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/NewZealand.gif"></span><span class="country"><a href="#" style="cursor: pointer;">New Zealand</a></span></h4>

                                                    </li>
                                                    <!--  /#NewZealand  -->
                                                    <li id="Pakistan">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Pakistan.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Pakistan</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Pakistan  -->
                                                    <li id="Philippines">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Philippines.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Philippines</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Philippines  -->
                                                    <!--===================  End Asia/Oceania Countories col 3 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Asia/Oceania Countories col 4 ===================-->
                                                    <li id="Singapore">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Singapore.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Singapore</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Singapore  -->
                                                    <li id="Taiwan">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Taiwan.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Taiwan</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Taiwan  -->
                                                    <li id="Thailand">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Thailand.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Thailand</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Thailand  -->
                                                    <li id="Vietnam">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Vietnam.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Vietnam</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Vietnam  -->
                                                    <!--===================  End Asia/Oceania Countories col 4 ===================-->
                                                </ul>
                                                <!--  /.regional_list_blk  -->
                                            </div>
                                            <!--  /#listBlk_Asia  -->
                                        </div>
                                        <!--  /.NI-contents-block02  -->
                                    </div>

                                    <div class="NI-contents-block02">
                                        <div id="col_region_04" class="NI-column01">
                                            <h4>
                                                <img src="../flags/h4_title04.gif" alt="Middle East/Africa" height="11" width="127"></h4>
                                            <span class="NI-column01_btn"><a class="regional_map_btn Africa Collapse" href="#col_region_02" style="display: block;">Collapse</a></span>
                                            <!--  /.NI-column01  -->
                                        </div>
                                        <div id="listBlk_Africa" class="opened" style="">
                                            <div class="regional_list_blk">
                                                <ul class="list_country">
                                                    <!--===================  Start Middle East/Africa Countories col 1 ===================-->
                                                    <li id="AfricanPortal">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/noflag2.gif"></span><span class="country"><a href="#" style="cursor: pointer;">African portal</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#AfricanPortal  -->
                                                    <li id="Abudhabi">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Abudhabi.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Abu Dhabi</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Abudhabi  -->
                                                    <li id="Algeria">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Algeria.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Algeria</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Algeria  -->
                                                    <li id="Angola">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Angola.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Angola</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Angola  -->
                                                    <li id="Bahrain">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Bahrain.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Bahrain</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Bahrain  -->
                                                    <li id="Egypt">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Egypt.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Egypt</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Egypt  -->
                                                    <li id="Ghana">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Ghana.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Ghana</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Ghana  -->
                                                    <li id="Israel">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Israel.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Israel</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Israel  -->
                                                    <li id="Jordan">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Jordan.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Jordan</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Jordan  -->
                                                    <!--===================  End Middle East/Africa Countories col 1 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Middle East/Africa Countories col 2 ===================-->
                                                    <li id="Kenya">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Kenya.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Kenya</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Kenya  -->
                                                    <li id="Kuwait">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Kuwait.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Kuwait</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Kuwait  -->
                                                    <li id="Lebanon">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Lebanon.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Lebanon</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Lebanon  -->
                                                    <li id="Madagascar">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Madagascar.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Madagascar</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Madagascar  -->
                                                    <li id="Malawi">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Malawi.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Malawi</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Malawi  -->
                                                    <li id="Mauritius">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Mauritius.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Mauritius</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#Mauritius  -->
                                                    <li id="Morocco">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Morocco.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Morocco</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Morocco  -->
                                                    <li id="Mozambique">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Mozambique.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Mozambique</a></span></h4>
                                                       
                                                    </li>
                                                    <!--  /#Mozambique  -->
                                                    <!--===================  End Middle East/Africa Countories col 2 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Middle East/Africa Countories col 3 ===================-->
                                                    <li id="Nigeria">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Nigeria.gif"></span><span class="country">Nigeria</span></h4>
                                                    </li>
                                                    <!--  /#Nigeria  -->
                                                    <li id="Oman">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Oman.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Oman</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Oman  -->
                                                    <li id="Palestine">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Palestine.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Palestine</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Palestine  -->
                                                    <li id="Qatar">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Qatar.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Qatar</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Qatar  -->
                                                    <li id="SaudiArabia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/SaudiArabia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Saudi Arabia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#SaudiArabia  -->
                                                    <li id="SouthAfrica">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/SouthAfrica.gif"></span><span class="country"><a href="#" style="cursor: pointer;">South Africa</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#SouthAfrica  -->
                                                    <li id="Sudan">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Sudan.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Sudan</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Sudan  -->
                                                    <li id="Syria">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Syria.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Syria</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Syria  -->
                                                    <!--===================  End Middle East/Africa Countories col 3 ===================-->
                                                </ul>
                                                <ul class="list_country">
                                                    <!--===================  Start Middle East/Africa Countories col 4 ===================-->
                                                    <li id="Tanzania">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Tanzania.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Tanzania</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Tanzania  -->
                                                    <li id="Tchad">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Tchad.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Tchad</a></span></h4>
                                                        
                                                    </li>
                                                    <li id="UAE">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/UAE.gif"></span><span class="country"><a href="#" style="cursor: pointer;">UAE</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#UAE  -->
                                                    <li id="Uganda">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Uganda.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Uganda</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Uganda  -->
                                                    <li id="Yemen">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Yemen.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Yemen</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Yemen  -->
                                                    <li id="Zambia">
                                                        <h4><span class="flag">
                                                            <img alt="" src="../flags/Zambia.gif"></span><span class="country"><a href="#" style="cursor: pointer;">Zambia</a></span></h4>
                                                        
                                                    </li>
                                                    <!--  /#Zambia  -->
                                                    <!--  /#  -->
                                                    <!--===================  End Middle East/Africa Countories col 4 ===================-->
                                                </ul>
                                                <!--  /.regional_list_blk  -->
                                            </div>
                                            <!--  /#listBlk_Africa  -->
                                        </div>
                                        <!--  /.NI-contents-block02  -->
                                    </div>

                                    <!--  /#RegionItemsBlk  -->
                                </div>

                                <!--  /#NI-contents-block  -->
                            </div>
                            <!--  /#NI-frame-work01  -->
                        </div>

                        <!-- goBack01 -->


                        <!--NISSAN-JPFD01-START-->
                        <div class=" fb_reset" id="fb-root">
                            <div style="position: absolute; top: -10000px; height: 0px; width: 0px;">
                                <div></div>
                            </div>
                        </div>
                        <div id="Div1" class=" fb_reset">
                            <div style="position: absolute; top: -10000px; height: 0px; width: 0px;">
                                <div>
                                    <iframe name="fb_xdm_frame_http" allowtransparency="true" id="fb_xdm_frame_http" aria-hidden="true" title="Facebook Cross Domain Communication Frame" tab-index="-1" src="../flags/xd_arbiter.htm" style="border: none;" frameborder="0" scrolling="no"></iframe>
                                    <iframe name="fb_xdm_frame_https" allowtransparency="true" id="fb_xdm_frame_https" aria-hidden="true" title="Facebook Cross Domain Communication Frame" tab-index="-1" src="../flags/xd_arbiter(1).htm" style="border: none;" frameborder="0" scrolling="no"></iframe>
                                </div>
                            </div>
                            <div style="position: absolute; top: -10000px; height: 0px; width: 0px;">
                                <div></div>
                            </div>
                        </div>
                        <!--NISSAN-JPFD01-END-->
                        <!--<iframe name="counter" width="1" height="1" id="counter"></iframe>-->
                        <div id="tipBlock" class="png_bg" style="top: 883px; left: 910px; display: none;">
                            <div id="tipWrapper" style="height: 58px;">
                                <div id="tipBg" style="height: 58px;"></div>
                            </div>
                        </div>
                        <!-- /#NI-overall01 -->
                    </div>
                    <script type="text/javascript">
                        document.getElementById('listBlk_Americas').style.display = 'none';
                        document.getElementById('listBlk_Europe').style.display = 'none';
                        document.getElementById('listBlk_Asia').style.display = 'none';
                        document.getElementById('listBlk_Africa').style.display = 'none';
</script>
                    <script type="text/javascript">initialize();</script>
                    <script type="text/javascript" src="/EN/SHARED/JS/header_footer_menu.js" charset="iso-8859-1"></script>
                    <span style="position: absolute; left: -9999px; top: 0;" id="js_etalon">&nbsp;</span>
                    <script type="text/javascript" src="../flags/header_footer_menu.js" charset="iso-8859-1"></script>
                    <style type="text/css">
                        <!-- -->
                    </style>
                    <iframe id="Iframe1" src="javascript:false;" style="display: none"></iframe>
                    <span style="position: absolute; left: -9999px; top: 0;" id="Span1">&nbsp;</span>
                    <script src="../flags/suggest_ext.js" type="text/javascript" charset="UTF-8"></script>
                    <script type="text/javascript" src="../flags/jqueryg.min.js"></script>
                    <script type="text/javascript" src="../flags/jsonp.min.js"></script>
                    <script type="text/javascript" src="../flags/yahoo-min.js"></script>
                    <script type="text/javascript" src="../flags/dom-min.js"></script>
                    <script type="text/javascript" src="../flags/initJSONPSuggest.js"></script>
                    <script type="text/javascript" src="../flags/view.jsm"></script>
                    <style type="text/css">
                        <!-- -->
                    </style>
                    <script type="text/javascript" src="../flags/nissan_global.js"></script>
                    <script type="text/javascript" charset="utf-8" src="../flags/id-2.js"></script>
                    <script language="JavaScript" type="text/javascript" charset="iso-8859-1" src="../flags/nissan_global_eu.js"></script>
                    <script language="JavaScript" type="text/javascript" charset="utf-8" src="../flags/id.js"></script>
                    <script src="../flags/FT=1.js"></script>
                    <script language="JavaScript" type="text/javascript" charset="iso-8859-1" src="../flags/nissan_global_eu.js"></script>

                    <!-- END NATIONALITIES-->
                </div>
            </div>
            <!-- END PAGE CONTENT-->
         </div>
         <!-- END PAGE CONTAINER-->

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
   <!-- END CORE PLUGINS -->
   <!-- BEGIN PAGE LEVEL PLUGINS -->
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/jquery-validation/dist/additional-methods.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/chosen-bootstrap/chosen/chosen.jquery.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/select2/select2.min.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/jquery.dataTables.js"></script>
   <script type="text/javascript" src="../assets/<%= languageStr %>/plugins/data-tables/DT_bootstrap.js"></script>
   
    <!--Script references. -->
    <!--Reference the SignalR library. -->
    <script src="../Scripts/jquery.signalR-1.1.0.min.js"></script>
    <!--Reference the autogenerated SignalR hub script. -->
    <script src="../signalr/hubs"></script>

    <!-- END PAGE LEVEL PLUGINS -->
    
   <!-- BEGIN PAGE LEVEL SCRIPTS -->
  <script src='../Assets/<%= languageStr %>/plugins/jquery-validation/dist/jquery.validate.min.js' type='text/javascript'></script>
   <script src="../assets/<%= languageStr %>/scripts/app.js"></script>
   <script src="../assets/<%= languageStr %>/scripts/table-managed.js"></script>      
   <!-- START OF PAGE LEVEL SCRIPT-->
   <script type="text/javascript">

       $(document).ready(function () {
           App.init(); // initlayout and core plugins
           FormValidation.init();
           //TableManaged.init();

           $("#page-sidebar li").removeClass("active");
           $("#page-sidebar li ul li").removeClass("active");
           $("#page-sidebar li ul li ul li").removeClass("active");
           $("#liGeneral").addClass("active");
           $("#liGeneral .arrow").addClass("open");
           $("#liGeneralNationality").addClass("active");

           if ('<%= Session["sidebar"] + "" %>' != '') {
               $(".page-container").addClass('<%= Session["sidebar"] + "" %>');
           }

           ////////Get Users and load in grid/////////
           var oTable = $('#sample_1').dataTable({
               "bProcessing": true,
               "bServerSide": true,
               "bDestroy": true,
               "sPaginationType": "bootstrap",
               "aoColumns": [
                 { "bSortable": false },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": true },
                 { "bSortable": false }
               ],
               "oLanguage": {
                   "sLengthMenu": "_MENU_ <%=Resources.Resource.recordsPerPage %>",
                   "sProcessing": "<%=Resources.Resource.processing %>...",
                   "sZeroRecords": "<%=Resources.Resource.noRecordFound %>",
                   "sInfo": "<%=Resources.Resource.showing %> _START_ <%=Resources.Resource.to %> _END_ <%=Resources.Resource.of %> _TOTAL_ <%=Resources.Resource.records %>",
                   "sSearch": "<%=Resources.Resource.search %>:",
                   "sUrl": "",
                   "oPaginate": {
                       "sFirst": "<%=Resources.Resource.first %>",
                       "sPrevious": "<%=Resources.Resource.previous %>",
                       "sNext": "<%=Resources.Resource.next %>",
                       "sLast": "<%=Resources.Resource.last %>"
                   }
               },
               "aaSorting": [[1, "desc"]],
               "sAjaxSource": '<%= Page.ResolveClientUrl("../RequestPages/CountryPage.aspx?key=getAll") %>'
           });

           $('#sample_1 .group-checkable').change(function () {
               var set = $(this).attr("data-set");
               var checked = $(this).is(":checked");
               jQuery(set).each(function () {
                   if (checked) {
                       $(this).attr("checked", true);
                   } else {
                       $(this).attr("checked", false);
                   }
               });
               jQuery.uniform.update(set);
           });


           // Declare a proxy to reference the hub. 
           var users = $.connection.chatHub;
           // Create a function that the hub can call to broadcast messages.
           users.client.broadcastMessage = function (name, message) {
               if (name == "TAMSR2_Cmp_Country") {
                   ReloadGrid();
               }
           };

           // Start the connection.
           $.connection.hub.start().done(function () {
               $('#btnBroadCast').click(function () {
                   // Call the Send method on the hub. 
                   users.server.send('TAMSR2_Cmp_Country', '');
                   // Clear text box and reset focus for next comment. 
               });
           });

       });


       function ReloadGrid() {
           $('#sample_1').dataTable().fnDraw();
       }

       function CloseForm() {
           Clear();
           $("#btnCloseForm").click();
           $("#divSuccessMsg").hide();

       }

       function Clear() {

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
           $("#spnGridMsg").html("&nbsp;");
           $("#spnID").html("0");
           $("#txtDescriptionEn").val("");
           $("#txtDescriptionAr").val("");
           $("#txtCode").val("");
           //$("#txtService").val("");

       }

       function Delete() {
           var v = "key=deleteByID&";

           $("#divSuccessMsg2").css("display", "none");
           $("#divErrorMsg2").css("display", "none");

           var k = 0;
           $("#sample_1 tbody").find("input:checkbox").each(function () {
               if (this.checked == true) {
                   k++;
                   v += "chk" + k + "=" + this.value + "&";
                   //this.checked = chk.checked;
               }
           });
           v += "count=" + k;

           if (k == 0) {
               $("#divErrorMsg2").css("display", "block");
               $("#spnErrorMsg2").html("<%=Resources.Resource.selectOne %>");
              return;
          }
          if (confirm("<%=Resources.Resource.deleteMessage %>")) {
              $.ajax({
                  type: 'POST',
                  data: v,
                  url: '<%= Page.ResolveClientUrl("../RequestPages/CountryPage.aspx") %>',
                  success: function (html) {
                      if (html == "1") {
                          $("#divSuccessMsg2").css("display", "block");
                          $("#spnSuccessMsg2").html("<%=Resources.Resource.msgRecordDelete %>");
                           $('#btnBroadCast').click();
                       }
                       else {
                           $("#divErrorMsg2").css("display", "block");
                           $("#spnErrorMsg2").html("<%=Resources.Resource.msgRecordNotDelete %>");
                       }
                   },
                  error: function (html) {

                  }
              });
           }
           else {
           }
       }

       function Edit(id) {
           //Edit code
           Clear();
           var v = "key=getByID&id=" + id;
           $("#btnAdd").click();
           $("#spnID").html(id);
           $("#spnGridMsg").html("&nbsp;");
           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/CountryPage.aspx") %>',
               success: function (html) {
                   if (html != "") {
                       var j = $.parseJSON(html);
                       $("#spnID").val(j.ID);
                       $("#txtDescriptionEn").val(j.DescriptionEn);
                       $("#txtDescriptionAr").val(j.DescriptionAr);
                       $("#txtCode").val(j.Code);
                   }
               },
               error: function (html) {

               }
           });
       }

       function Save() {
           var id = $("#spnID").html();
           var descriptionEn = $("#txtDescriptionEn").val();
           var descriptionAr = $("#txtDescriptionAr").val();
           var code = $("#txtCode").val();
           if ($('#form_sample_1').validate().form() == false) {
               return false;
           }
           var v = "key=save" + "&id=" + id + "&code=" + code;
           v += "&descriptionEn=" + descriptionEn + "&descriptionAr=" + descriptionAr;

           $.ajax({
               type: 'POST',
               data: v,
               url: '<%= Page.ResolveClientUrl("../RequestPages/CountryPage.aspx") %>',
               success: function (html) {
                   if (html == '-1') {
                       //failed
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordNotSaved %>");
                   }
                   else if (html == '0') {
                       //exists
                       $("#divErrorMsg").css("display", "block");
                       $("#spnErrorMsg").html("<%=Resources.Resource.msgRecordExists %>");
                   }
                   else {
                       //success
                       $("#divSuccessMsg").css("display", "block");
                       $("#spnSuccessMsg").html("<%=Resources.Resource.msgRecordSaved %>");
                       $('#btnBroadCast').click();
                       Clear();
                   }
               },
               error: function (html) {
                   $("#divErrorMsg").css("display", "block");
                   $("#spnErrorMsg").html("Error! " + html);
               }

           });

   }

   var FormValidation = function () {


       return {
           //main function to initiate the module
           init: function () {

               // for more info visit the official plugin documentation: 
               // http://docs.jquery.com/Plugins/Validation

               var form1 = $('#form_sample_1');
               var error1 = $('.alert-error', form1);
               var success1 = $('.alert-success', form1);

               form1.validate({
                   errorElement: 'span', //default input error message container
                   errorClass: 'help-inline', // default input error message class
                   focusInvalid: false, // do not focus the last invalid input required: 
                   ignore: "",
                   rules: {
                       nameEn: {
                           minlength: 3,
                           required: true,
                           maxlength: 50
                       },
                       nameAr:
                           {
                               required: true,
                               maxlength: 50
                           },
                       code:
                           {
                               required: true,
                               maxlength: 50
                           }
                   },
                   message: {
                       nameEn: {
                           required: "<%=Resources.Resource.lblRequired %>"
                           },
                           nameAr: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           },
                           code: {
                               required: "<%=Resources.Resource.lblRequired %>"
                           }
                       },

                       //errorPlacement: function (error, element) { // render error placement for each input type
                       //    if (element.attr("name") == "org") { // for uniform checkboxes, insert the after the given container
                       //        error.addClass("no-left-padding").insertAfter("#form_2_service_error");
                       //    } else {
                       //        error.insertAfter(element); // for other inputs, just perform default behavoir
                       //    }
                       //},
                       invalidHandler: function (event, validator) { //display error alert on form submit              
                           success1.hide();
                           error1.show();
                           App.scrollTo(error1, -200);
                       },

                       highlight: function (element) { // hightlight error inputs
                           $(element)
                               .closest('.help-inline').removeClass('ok'); // display OK icon
                           $(element)
                               .closest('.control-group').removeClass('success').addClass('error'); // set error class to the control group
                       },

                       unhighlight: function (element) { // revert the change dony by hightlight
                           $(element)
                               .closest('.control-group').removeClass('error'); // set error class to the control group
                       },

                       success: function (label) {
                           label
                               .addClass('valid').addClass('help-inline ok') // mark the current input as valid and display OK icon
                           .closest('.control-group').removeClass('error').addClass('success'); // set success class to the control group
                       },

                       submitHandler: function (form) {
                           success1.show();
                           error1.hide();
                       }
                   });
               }
           };
       }();
   </script>
   <!-- END JAVASCRIPTS -->
    
    <!-- END OF PAGE LEVEL SCRIPT-->
</asp:Content>
