// fork from https://github.com/HenryQW/docker-phantomjs/blob/master/server.js

"use strict";
var page = require('webpage').create();
var server = require('webserver').create();
var system = require('system');
var url;


var listening = server.listen(8910, function (request, response) {
	console.log(request.post['url']);
	url = request.post['url'];

	response.statusCode = 200;
	response.headers = {
		"Cache": "no-cache",
		"Content-Type": "text/html"
	};

	page.settings.userAgent = 'Mozilla/5.0 (iPhone; CPU OS 11_0 like Mac OS X) AppleWebKit/604.1.25 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1';

	page.open(url, function (status) {
		function checkReadyState() {
			setTimeout(function () {
				var readyState = page.evaluate(function () {
					return document.readyState;
				});

				if ("complete" === readyState) {
					response.write(page.content);
					response.close;
				} else {
					checkReadyState();
				}
			});
		}
		checkReadyState();
	});
});