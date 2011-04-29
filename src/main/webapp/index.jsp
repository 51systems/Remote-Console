<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.6/dojo/resources/dojo.css"> 
<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/dojo/1.6/dijit/themes/claro/claro.css">
    
    <script type="text/javascript">
    	var dojoConfig = {
    		parseOnLoad: true
    	};
    </script>
    <script src="http://ajax.googleapis.com/ajax/libs/dojo/1.6/dojo/dojo.xd.js" type="text/javascript"></script>
    
   
    <%--
    The reason to use a JSP is that it is very easy to obtain server-side configuration
    information (such as the contextPath) and pass it to the JavaScript environment on the client.
    --%>
    <script type="text/javascript">
        var config = {
            contextPath: '${pageContext.request.contextPath}'
        };
    </script>
    
    <script type="text/javascript">
    	dojo.require('dijit.form.Form');
    	dojo.require('dijit.form.Button');
    	dojo.require('dijit.form.ValidationTextBox');
    	
    	
    	dojo.require('dojox.cometd');
    	dojo.require('dojox.json.ref');
    	
    	function onFormSubmit(form){
    		if(!form.validate())
    			return false;
    			
    		var values = form.getValues();
    			
    		//Connect to the server
    		dojox.cometd.init(values.server);
    		
    		//subscribe to the channel
    		dojox.cometd.subscribe("/remote-console/" + values.channel, onData);
    		
    		return false;
    	}
    	
    	function onData(message){
    		// summary:
    		//	Fired when a remote debugging command occurs
    		var args = message.data.args;
    		if(message.data.useJsonRef){
    			args = dojox.json.ref.fromJson(args);
    		}
    		
    		//convert the args back into an array
    		var argArray = [];
    		for(var i in args){
    			argArray[i] = args[i];
    		}
    		
    		
    		
    		console[message.data.command].apply(this, argArray);
    	}
    	
    	function disconnect(){
    		console.log("calling dojox.cometd.disconnect");
    		dojox.cometd.disconnect();
    	}
    	
    </script>
    
    <style type="text/css">
    	.input-field{
    		padding-left: 2em;
    	}
    	
    	.input-label{
    		font-weight: bold;
    	}
    </style>
    
</head>
<body class="claro">
    <div id="body">
    	<h1>Connect To Remote Console</h1>
    	<form dojoType="dijit.form.Form" onSubmit="return onFormSubmit(this); return false;">
	    	<div class="input-label">Server:</div>
	    	<div class="input-field"><input name="server" value="http://localhost:8080${pageContext.request.contextPath}/cometd" dojoType="dijit.form.ValidationTextBox" required="true" selectOnClick="true"/></div>
	    	
	    	<div class="input-label">Channel:</div>
	    	<div class="input-field"><input name="channel" value="demo"  dojoType="dijit.form.ValidationTextBox" required="true" selectOnClick="true"/></div>
    	
    		<input type="submit" dojoType="dijit.form.Button" label="Connect"/>
    	</form>
    	
    	<button dojoType="dijit.form.Button" onClick="disconnect">Disconnect</button>
    	
    	
    	<br/><br/><br/>
    	
    	Try the <a href="remote-console.jsp">Demo Page</a> to see the remote console in action!
    </div>
</body>
</html>
