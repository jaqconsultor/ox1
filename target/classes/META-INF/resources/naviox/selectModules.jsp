<%--
NaviOX. Navigation and security for OpenXava applications.
Copyright 2014 Javier Paniza Lucas

License: Apache License, Version 2.0.	
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

License: GNU Lesser General Public License (LGPL), version 2.1 or later.
See the lgpl.txt file in the root directory or <http://www.gnu.org/licenses/lgpl-2.1.html>.
--%>

<%@include file="../xava/imports.jsp"%>


<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="org.openxava.util.Is"%>
<%@page import="org.openxava.util.Strings"%>
<%@page import="org.openxava.util.Locales"%>
<%@page import="org.openxava.application.meta.MetaModule"%>
<%@page import="org.configuracion.PreferenciasMenu"%>

<jsp:useBean id="modules" class="com.openxava.naviox.Modules"
	scope="session" />

<%
String searchWord = request.getParameter("searchWord");
searchWord = searchWord == null ? "" : Strings.removeAccents(searchWord.toLowerCase());
Collection modulesList = modules.getMenuModules(request);
boolean bookmarkModules = "true".equals(request.getParameter("bookmarkModules"));
String smodulesLimit = request.getParameter("modulesLimit");
int modulesLimit = smodulesLimit == null ? 30 : Integer.parseInt(smodulesLimit);
int counter = 0;
int pase = 0;
boolean loadMore = false;
for (Iterator it = modulesList.iterator(); it.hasNext();) {
	/*if (counter == modulesLimit) {
		loadMore = true;
		break;
	}*/
	pase = 0;
	MetaModule module = (MetaModule) it.next();
	String selected = module.getName().equals(modules.getCurrent(request)) ? "selected" : "";
	String label = module.getLabel(Locales.getCurrent());
	String description = module.getDescription(Locales.getCurrent());
	String normalizedLabel = Strings.removeAccents(label.toLowerCase());
	String normalizedDescription = Strings.removeAccents(description.toLowerCase());
	String normalizedModule = Strings.removeAccents(module.getName().toLowerCase());

	if (!Is.emptyString(searchWord) && !normalizedLabel.contains(searchWord)
	&& !normalizedDescription.contains(searchWord))
		continue;

	String nombre = null;
	if (session.getAttribute("valormodulo") != null) {
		nombre = (String) session.getAttribute("valormodulo");
		nombre = nombre.toLowerCase();
	}

	//	String dato1 = request.getParameter("valormodulo");

	//	Object dato = session.getAttribute("valormodulo");

	//	String dato2 = (String) session.getAttribute("valormodulo");

	//Object dato = session.getAttribute("valormodulo");

	Properties pvalor = null;

	PreferenciasMenu preMenu;
	preMenu = new PreferenciasMenu();
	if (nombre != null) {
		pvalor = preMenu.getPropiedades("menu");
	}

	pase = 0;

	String str;
	String skey;
	String smodule;
	for (Enumeration e = pvalor.keys(); e.hasMoreElements();) {
		Object obj = e.nextElement();
		str = obj.toString().toLowerCase();
		skey = pvalor.getProperty(str);
		skey = skey.toLowerCase();
		smodule = normalizedModule;
		
		boolean bpase;
		bpase = true;
		
		bpase = bpase && str.contains( nombre.toLowerCase() );
		bpase = bpase && skey.equals( smodule.toLowerCase() );
				
		if ( bpase ) {
			pase = 1;
		}
	}
	
	if( nombre.equals("todos")) {
		pase = 1;
	}

if (pase == 1) {
counter++;
%>

<a href="<%=modules.getModuleURI(request, module)%>?init=true"
	title="<%=description%>"> <%-- href with the URL in order right mouse button works to add in another tab --%>
	<div id="<%=module.getName()%>_module" class="module-row <%=selected%>"
		onclick="$('#<%=module.getName()%>_loading').show()">
		<div class="module-name">
			<%=label%>
			<%
			if (bookmarkModules) {
			%>
			<i class="mdi mdi-star bookmark-decoration"></i>
			<%
			}
			%>
			<i id="<%=module.getName()%>_loading"
				class="mdi mdi-autorenew module-loading spin"
				style="float: right; display: none;"></i>
		</div>
	</div>
</a>
<%
}
}

if (loadMore) {
%>
<a href="javascript:naviox.displayAllModulesList('<%=searchWord%>')">
	<div id="more_modules" class="module-row"
		onclick="$('#loading_more_modules').show(); $('#load_more_modules').hide();">
		<span id="loading_more_modules" style="display: none;"> <xava:message
				key="loading" />... <i
			class="mdi mdi-autorenew module-loading spin" style="float: right;"></i>
		</span> <span id="load_more_modules"> <xava:message
				key="load_more_modules" />...
		</span>
	</div>
</a>
<%
}
%>