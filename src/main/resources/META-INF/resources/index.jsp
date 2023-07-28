<%@page import="com.openxava.naviox.util.OrganizationsCurrent"%> 
<%@page import="org.openxava.web.Browsers"%>
<%@page import="org.openxava.util.Users"%>
<%@page import="org.configuracion.PreferenciasMenu"%>
<%@page import="com.intefaces.*"%>
<%@page import="java.util.*"%>

<jsp:useBean id="modules" class="com.openxava.naviox.Modules" scope="session"/>

<% 
String valormodulo = request.getParameter("valormodulo");
if( valormodulo == null ){
	valormodulo = "todos";
}
if( valormodulo.isEmpty() ){
	valormodulo = "todos";
}
if( valormodulo.isBlank() ){
	valormodulo = "todos";
}
session.setAttribute("valormodulo",valormodulo);

List mvalor;

ModulosDelMenu preMenu;
preMenu = new ModulosDelMenu();
mvalor = preMenu.modulos();
session.setAttribute("mvalor",mvalor);

%>

<%
if (Users.getCurrent() != null || OrganizationsCurrent.get(request) != null) {
	String module = Users.getCurrent() == null?"SignIn":modules.getCurrent(request);
	String url = Browsers.isMobile(request) && !"Index".equals(modules.getCurrent(request))?"phone":"m/" + module;
	module = "firstSteps";
%>

<script type="text/javascript">
window.location="<%=url%>";
</script>

<%
}
else {
%>
<jsp:include page="naviox/welcome.jsp"/>
<%
}
%>
