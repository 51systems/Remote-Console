dojo.provide('dext.remoteConsole');
dojo.require('dojox.cometd');

dojo.mixin(dojo.getObject('dext.remoteConsole', true), {
	
	// summary:
	//	Full url to the server endpoint
	_server: false,
	
	// summary:
	//	name of the channel to use when communicating with the server
	_channel: false,
	
	// summary:
	//	Flag to indicate that we are using the dojox.json.ref
	_useJsonRef: false,

	init: function(){
		// summary:
		//	Initalizes the dext remote object, reading in the configuration off the script tag
		//	Setting up the connection to the server, and binding to the console.log methods
		
		var scriptTag = dojo.query('script[src *="remote-console"]');
		
		dext.remoteConsole._server = scriptTag.attr('data-server')[0];
		if(dext.remoteConsole._server == null){
			alert('No Server Defined. Please add data-server to script tag');
			return;
		}
		
		dext.remoteConsole._channel = scriptTag.attr('data-channel')[0];
		if(dext.remoteConsole._channel == null){
			alert('No Server Channel Defined. Please add data-channel to script tag');
			return;
		}
		
		dext.remoteConsole._useJsonRef = ((scriptTag.attr('data-json-ref')[0] || false) == "true")
		if(dext.remoteConsole._useJsonRef){
			dojo.require('dojox.json.ref');
		}
		
		//Parse the methods to bind to 
		//And actually bind to them
		
		var bindMethods = scriptTag.attr('data-bind')[0];
		if(bindMethods == null){
			//use defaults
			bindMethods = 'log,info,warn,error,debug,dir';
		}
		
		var bindMethodArray = bindMethods.split(',');
		if(bindMethodArray.length == 0){
			alert('Not binding to any methods');
			return;
		}
		
		dojo.forEach(bindMethodArray, function(/*string*/ item){
			dojo.connect(console, item, function(){
				dext.remoteConsole.onConsoleMethod(item, arguments);
			});
		});
		
		//Initalize the connection with the server
		dojox.cometd.init(dext.remoteConsole._server);
	},

	onConsoleMethod: function(/*string*/command, /*array*/args){
		// summary:
		//	Fired whenever any of the bound console methods are invoked.
		//	Sends the data to the remote console using the cometd protocol
		
		//detect if we are serializing or not
		if(dext.remoteConsole._useJsonRef){
			args = dojox.json.ref.toJson(args);
		}
		
		dojox.cometd.publish('/remote-console/' + dext.remoteConsole._channel, {
			command: command,
			useJsonRef: dext.remoteConsole._useJsonRef,
			args: args
		});
	}
});

dojo.ready(dext.remoteConsole.init);