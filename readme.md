# About Remote Console
 
Remote console is a simple remote Firebug console implemenation based on the Dojo libraries and the CometD server.
It is useful for remote debugging mobile devices using the Firebug Firefox plugin and only needs two javascript includes to enable debugging on a remote page.
 
For more information and a getting started tutorial please view the [blog post](http://dustint.com/post/350/remote-debugging-with-firebug-and-cometd)
 
## Javascript Script Attribute Guide
The javascript script tag that enables remote debugging on a page accepts several configuration attributes. These appear prefixed by data- in the `script` tag:
 
	<script src="remote-console.js" data-server="http://127.0.0.1:8080/remote-console/cometd" 
		data-channel="demo" 
		data-json-ref="true">
	</script>
	
`data-server`
Full url to the server endpoint
Required: True

`data-channel`
Name of the channel to use when communicating with the server
Required: True

`data-json-ref`
Flag to indicate that we are using the dojox.json.ref
Default: False
Required: False

`data-replace-console-methods`
Flag to indicate that we are replacing the console methods, rather than connecting to them.
This is needed to get internet explorer working
Default: False
Required: False

`data-remote-methods-only`
Flag to indicate that we are only introducing the console.remote.* methods, not binding to the regular methods
Default: False
Required: False