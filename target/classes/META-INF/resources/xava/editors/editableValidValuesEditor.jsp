<%@page import="java.util.Map"%>
<%@page import="org.openxava.model.meta.MetaProperty"%>
<%@page import="org.openxava.view.View"%>
<%@page import="java.util.Collections"%>

<jsp:useBean id="style" class="org.openxava.web.style.Style" scope="request"/>
<jsp:useBean id="context" class="org.openxava.controller.ModuleContext" scope="session"/>

<%
String viewObject = request.getParameter("viewObject");
View view = (View) context.get(request, viewObject);
String collectionName = request.getParameter("collectionName");
if (!org.openxava.util.Is.emptyString(collectionName)) {
	view = view.getSubview(collectionName);
}
String propertyKey = request.getParameter("propertyKey");
MetaProperty p = (MetaProperty) request.getAttribute(propertyKey);
String script = request.getParameter("script"); 
String scriptSelect = script; 
String scriptInput = script;
if (script.contains("onchange=")){
	String selectOnChange = "this.nextElementSibling.value=this.options[selectedIndex].text; ";
    String inputOnChange= "this.previousElementSibling.selectedIndex=0; ";
    int i = script.indexOf("onchange=") + 10;
    scriptSelect = script.substring(0,i) + selectOnChange + script.substring(i);
    scriptInput = script.substring(0,i) + inputOnChange + script.substring(i);
} 
boolean editable = "true".equals(request.getParameter("editable")); 
boolean label = org.openxava.util.XavaPreferences.getInstance().isReadOnlyAsLabel();
Object value = request.getAttribute(propertyKey + ".value") == null ? "" : request.getAttribute(propertyKey + ".value");
Map<Object, Object> validValues = view.getValidValues(p.getName()) == null ? Collections.emptyMap(): view.getValidValues(p.getName()) ;
Object description = validValues.get(value);
String optionHidden = new String(new char[p.getSize()]).replace("\0", "A");
String firstOption = "";
if (value != null && !validValues.isEmpty() && !validValues.containsValue(value)){
    firstOption = value.toString();
}
%>
    
<%
if (editable) { 
   	if (validValues.isEmpty()) {
%>
	<input id="<%=propertyKey%>" name="<%=propertyKey%>" class=<%=style.getEditor()%> type="text" tabindex="1" maxlength="<%=p.getSize()%>" size="<%=p.getSize()%>" value="<%=value%>" <%=script%> title="<%=p.getDescription(request)%>"/>
<%
	} else {
%>
    <div class="ox-select-editable">
    	<select tabindex="1" class=<%=style.getEditor()%> title="<%=p.getDescription(request)%>" <%=scriptSelect%> onchange="this.nextElementSibling.value=this.options[selectedIndex].text">
<% 
		if (view.hasBlankValidValue(p.getName())) { 
%>
			<option value="<%=firstOption%>"><%=firstOption%></option>
<% 
		} 
		for (Map.Entry e: validValues.entrySet()) {
			String selected = e.getKey().equals(value) ?"selected":"";
%>
			<option value="<%=e.getKey()%>" <%=selected%>> <%=e.getValue()%> </option>
<%
		}
%>      
        <option hidden><%=optionHidden%></option>
		</select>
		<input id="<%=propertyKey%>" name="<%=propertyKey%>" type="text"  <%=scriptInput%> onchange="this.previousElementSibling.selectedIndex=0" oninput="this.previousElementSibling.options[0].value=this.value; this.previousElementSibling.options[0].innerHTML=this.value"  maxlength="<%=p.getSize()%>" size="<%=p.getSize()%>" value="<%=value%>"/>
		<input type="hidden" name="<%=propertyKey%>__DESCRIPTION__" value="<%=description%>"/>
	</div>
<%		
	}
} else { 
	if (label) {
%>
	<%=description%>
<%
	} else {
%>
	<input name = "<%=propertyKey%>_DESCRIPTION_" class=<%=style.getEditor()%> type="text" title="<%=p.getDescription(request)%>" maxlength="<%=p.getSize()%>" size="<%=p.getSize()%>" value="<%=description%>" disabled/>
<%  
	} 
%>
	<input type="hidden" name="<%=propertyKey%>" value="<%=value%>">	
<% 
} 
%>			
