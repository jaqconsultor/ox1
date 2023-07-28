<%--
NaviOX. Navigation and security for OpenXava applications.
Copyright 2014 Javier Paniza Lucas

License: Apache License, Version 2.0.	
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

License: GNU Lesser General Public License (LGPL), version 2.1 or later.
See the lgpl.txt file in the root directory or <http://www.gnu.org/licenses/lgpl-2.1.html>.
--%>

<%@page import="org.openxava.util.Users"%>
<%@page import="com.openxava.naviox.util.NaviOXPreferences"%>

<%@include file="../xava/imports.jsp"%>

<jsp:useBean id="modules" class="com.openxava.naviox.Modules" scope="session"/>

<%
boolean isFirstSteps = com.openxava.naviox.Modules.FIRST_STEPS.equals(modules.getCurrentModuleName());
String display = isFirstSteps?"style='display:block'":""; 
%>

<div id="modules_list" <%=display%>>  

	<div id="modules_list_top"> 

		<div id="application_title">
		
			<div id="application_name">
				<%=modules.getApplicationLabel(request)%>
			</div>
		
			<div id="organization_name">
				<% String organizationName = modules.getOrganizationName(request); %>
				<%=organizationName%>
				<%@ include file="organizationNameExt.jsp"%>
			</div>
		
		</div>
		
		<% if (Users.getCurrent() != null && modules.showsIndexLink()) { %>
			 
			<a href="<%=request.getContextPath()%>/m/Index">
				<div id='organizations_index' class='<%="Index".equals(request.getParameter("module"))?"selected":""%>'>	
					<i class="mdi mdi-apps"></i>
					<xava:label key="myOrganizations"/>
				</div>	
			</a>
			
		<% } %>
	
		<jsp:include page="selectModules.jsp">
			<jsp:param name="bookmarkModules" value="true"/>
		</jsp:include>
		
		<% if (modules.showsSearchModules(request) && false ) { %>
		<div id="search_modules">
		<input id="search_modules_text" type="text" size="38" placeholder='<xava:message key="search_modules"/>'/>
		</div>
		<% } %>
		
	</div> 	
							
	<div id="modules_list_outbox">
		<table id="modules_list_box">
			<tr id="modules_list_content">
				<td>
					<jsp:include page="<%=NaviOXPreferences.getInstance().getModulesMenuJSP()%>"/>
				</td>						
			</tr>
		</table>
	</div>
	
</div>

<% if (!isFirstSteps) { %> 
	<a id="modules_list_hide" href="javascript:naviox.hideModulesList('<%=request.getParameter("application")%>', '<%=request.getParameter("module")%>')">
		<i class="mdi mdi-chevron-left"></i>
	</a>
	
	<a id="modules_list_show" href="javascript:naviox.showModulesList('<%=request.getParameter("application")%>', '<%=request.getParameter("module")%>')">
		<i class="mdi mdi-chevron-right"></i>
	</a>
<% } %>
<!--
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/js/bootstrap.bundle.min.js"></script>
-->