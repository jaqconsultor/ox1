	<%
	String vurl = "http://localhost:9980/modelodb/";
	String vurl1 = "http://localhost:9980/WebHome/index1.jsp";
	String vurl2 = "http://localhost:9980/WebHome/";

	String vmod = "m/FirstSteps?valormodulo=";
	vmod = "?valormodulo=";
	%>
	<%
	String vsitio = vurl + vmod;
	%>
	<%
	String vmod1 = "nomina";
	vsitio = vurl + vmod + vmod1;
	%>
	<br>	
	<h3>Seguros & Empresas</h3>
	<ul>
		<% 	vsitio = vurl + vmod + "segurosc"; 	%>
		<li><a href="<%=vsitio%>" target="principal">Companias de Seguros</a></li>
		<% 	vsitio = vurl + vmod + "segurose"; 	%>
		<li><a href="<%=vsitio%>" target="principal">Empresas</a></li>
		<% 	vsitio = vurl + vmod + "segurosh"; 	%>
		<li><a href="<%=vsitio%>" target="principal">Contratos Habituales</a></li>
		<% 	vsitio = vurl + vmod + "segurosz"; 	%>
		<li><a href="<%=vsitio%>" target="principal">Beneficiarios De Clinica Esperanza</a></li>
	</ul>

	<h3>Beneficiarios</h3>
	<ul>
	<%
	vmod1 = "cargadebenefisiarios";
	vsitio = vurl + vmod + vmod1;
	%>
	<li><a href="<%=vsitio%>" target="principal">Carga de Beneficiarios</a></li>
	<%
	vmod1 = "procesarbeneficiarios.jsp";
	vsitio = vurl2 + vmod1;
	%>
	<li><a href="<%=vsitio%>" target="principal">Procesar Beneficiarios</a></li>
		
	</ul>

	<h3>Pacientes</h3>
	<ul>
		<% vmod1 = "paciente";	vsitio = vurl + vmod + vmod1; %>
		<li><a href="<%=vsitio%>" target="principal">Consultas</a></li>
	</ul>

	<h3>Admision</h3>
	<ul>
	<%
	vmod1 = "admision";	vsitio = vurl + vmod + vmod1;
	%>
		<li><a href="<%=vsitio%>" target="principal">Ver Admisiones</a></li>
	</ul>

	<h3>Factura de Admision</h3>
	<ul>
		<li><a href="<%=vsitio%>" target="principal">Factura de Admision</a></li>
	</ul>

	<h3>Farmacia</h3>
	<ul>
		<li><a href="<%=vsitio%>" target="principal">Factura de Paciente</a></li>
		<li><a href="<%=vsitio%>" target="principal">Factura de Cliente</a></li>
	</ul>

	<h3>Inventario</h3>
	<ul>
		<% 	vmod1 = "cargai"; vsitio = vurl + vmod + vmod1; 	%>
		<li><a href="<%=vsitio%>" target="principal">Consulta de Inventario</a></li>
	</ul>
	
	<h3>Tablas</h3>
	<ul>
		<% 	vmod1 = "ptablas"; vsitio = vurl + vmod + vmod1; 	%>
		<li><a href="<%=vsitio%>" target="principal">De Pacientes</a></li>
		<% 	vmod1 = "utablas"; vsitio = vurl + vmod + vmod1; 	%>
		<li><a href="<%=vsitio%>" target="principal">Ubicacion</a></li>
		<% 	vmod1 = "ftablas"; vsitio = vurl + vmod + vmod1; 	%>
		<li><a href="<%=vsitio%>" target="principal">Profesion</a></li>
		<% 	vmod1 = "itablas"; vsitio = vurl + vmod + vmod1; 	%>
		<li><a href="<%=vsitio%>" target="principal">De Inventario</a></li>
	</ul>
