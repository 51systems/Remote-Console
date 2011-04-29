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
    
   
    <script src="remote-console.js" data-server="http://localhost:8080${pageContext.request.contextPath}/cometd" data-channel="demo" data-json-ref="true"></script>
    
</head>
<body class="claro">
	<h1>Demo Page</h1>
	<p>This page demonstrates how a console may send data back to the debugging firebug in the main page</p>
	<p>Try it for yourself: On index.jsp connect to the local server on the "demo" channel, then on this page open up the firebug console and type console.log("hello world");</p>
</body>
</html>
