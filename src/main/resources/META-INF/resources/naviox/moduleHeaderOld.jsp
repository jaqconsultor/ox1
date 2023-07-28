<%--
NaviOX. Navigation and security for OpenXava applications.
Copyright 2014 Javier Paniza Lucas

License: Apache License, Version 2.0.	
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

License: GNU Lesser General Public License (LGPL), version 2.1 or later.
See the lgpl.txt file in the root directory or <http://www.gnu.org/licenses/lgpl-2.1.html>.
--%>

<%@include file="../xava/imports.jsp"%>

<%@page import="org.openxava.application.meta.MetaModule"%> 
<%@page import="org.openxava.util.Is"%>
<%@page import="com.openxava.naviox.util.NaviOXPreferences"%>
<%@page import="org.openxava.util.Users"%>
<%@page import="com.openxava.naviox.util.OrganizationsCurrent"%>

<jsp:useBean id="context" class="org.openxava.controller.ModuleContext" scope="session"/>
<jsp:useBean id="modules" class="com.openxava.naviox.Modules" scope="session"/>

<%
String module = context.getCurrentModule(request);
boolean hasModules = modules.hasModules(request);
boolean isFirstSteps = com.openxava.naviox.Modules.FIRST_STEPS.equals(module);
isFirstSteps = true;
%>
		
<div id="module_header_left"> 			
	<% if (!isFirstSteps) { %>
		<a id="module_header_menu_button" href="javascript:naviox.showModulesList('<%=request.getParameter("application")%>', '<%=request.getParameter("module")%>')">
			<i class="mdi mdi-menu"></i></a>
	<% } %>				
	<%
	String organizationName = modules.getOrganizationName(request);
	if (!Is.emptyString(organizationName)) organizationName += " - ";
	String title = organizationName + modules.getApplicationLabel(request);
	%>
	<% if (hasModules && !isFirstSteps) { %>
		<span id="module_extended_title">
			<h2><%=title%></h2>
		</span>	 
	<%
	}
	else if ("SignIn".equals(module)) {
	%>
		<%=title%>
	<%
	}
	if( 1 == 2) {
		
	
	
	for (MetaModule metaModule: modules.getTopModules()) {
		if (metaModule.getName().equals("SignIn")) continue;
		if ( 1 == 2 ) continue;
		boolean isSelected = metaModule.getName().equals(request.getParameter("module")); 
		String selected = isSelected?"selected":"unselected";
		if (isSelected) {
	%>		
		<span class="selected"><%=metaModule.getLabel(request.getLocale())%></span>
	<%
		}
		else {
	%>
		<a href="<%=modules.getModuleURI(request, metaModule)%>?retainOrder=true" class="unselected"><%=metaModule.getLabel(request.getLocale())%></a>
	<%
		}	
	}
	
	}
	else {
	
	}
	%>				
	&nbsp;
</div>
				

	<div id="module_header_right">
	<%
	if( 1 == 2) {
		%>
	<a id="bookmark" href="javascript:naviox.bookmark()" title="<xava:message key='<%=modules.isCurrentBookmarked(request)?"unbookmark_module":"bookmark_module"%>'/>"> 
		<i class='mdi mdi-star<%=modules.isCurrentBookmarked(request)?"":"-outline"%>'></i> 
	</a>
		<%
	}
		%>
	 				
	<span id="sign_in_out"> 
		<%
		if (Is.emptyString(NaviOXPreferences.getInstance().getAutologinUser())) {
			String userName = Users.getCurrent();
			String currentModule = request.getParameter("module");
			boolean showSignIn = userName == null && !currentModule.equals("SignIn");						
			if (showSignIn) {
				String selected = "SignIn".equals(currentModule)?"selected":"";
				%>
				<a href="<%=request.getContextPath()%>/m/SignIn" class="sign-in <%=selected%>">
					<xava:message key="signin"/>
				</a>
				<%
			}
			if (userName != null) {
				String organization = OrganizationsCurrent.get(request);
				if (organization == null) organization = "";
				%>
				<a  href="<%=request.getContextPath()%>/naviox/signOut.jsp?organization=<%=organization%>" class="sign-in"><xava:message key="signout"/> (<%=userName%>)</a>
				<%
			}
		} 
		%>
	</span>				
</div>
	