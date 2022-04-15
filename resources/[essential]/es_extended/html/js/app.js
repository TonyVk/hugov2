(() => {

	ESX = {};
	ESX.HUDElements = [];

	ESX.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	ESX.insertHUDElement = function (name, index, priority, html, data) {
		ESX.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		ESX.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	ESX.updateHUDElement = function (name, data) {

		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements[i].data = data;
			}
		}

		ESX.refreshHUD();
	};

	ESX.deleteHUDElement = function (name) {
		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements.splice(i, 1);
			}
		}

		ESX.refreshHUD();
	};

	ESX.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < ESX.HUDElements.length; i++) {
			let html = Mustache.render(ESX.HUDElements[i].html, ESX.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	ESX.inventoryNotification = function (add, item, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		notif += count + ' ' + item.label;

		let elem = $('<div>' + notif + '</div>');

		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};

	function guidGenerator() {
		var S4 = function() {
		   return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
		};
		return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
	}

	ESX.showNotification = function (mess, ms) {
		if(mess){
			let id = guidGenerator();
			// $("#notifikacije").append(`
			// <div class="notif skrivanje" id="not`+id+`">
			// 	<span id="tekst">`+mess+`</span>
			// 	<img src="img/hugo.png" id="slika">
			// </div>
			// `).show('slow');
			const reg1 = /~.~/g
			const nString = mess.replace(reg1, "");
			$("#notifikacije").append(`
			<div class="notification green skrivanje" id="not`+id+`">
				<div class="info">
					<h1>Informacija</h1>
					<p>`+nString+`</p>
				</div>
				<div class="icon">
					<img src="img/hugo.png" id="slika">
				</div>
			</div>
			`).show('slow');
			$("#not" + id).css('display', 'flex');
			setTimeout(function() {$("#not" + id).removeClass('skrivanje')} ,200);
			setTimeout(function() {
				$("#not" + id).addClass('skrivanje');
				setTimeout(()=>{$("#not"+id).remove()}, 1000);
			}, ms);
		}
	};

	ESX.showPBar = function (mess, ms) {
		if(mess){
			$("#pbar").show();
			var start = new Date();
			var maxTime = ms;
			var text = mess;
			var timeoutVal = Math.floor(maxTime/100);
			animateUpdate();

			$('#pbar_innertext').text(text);

			function updateProgress(percentage) {
				$('#pbar_innerdiv').css("width", percentage + "%");
			}

			function animateUpdate() {
				var now = new Date();
				var timeDiff = now.getTime() - start.getTime();
				var perc = Math.round((timeDiff/maxTime)*100);
				if (perc <= 100) {
					updateProgress(perc);
					setTimeout(animateUpdate, timeoutVal);
				} else {
					$("#pbar").hide();
				}
			}
		}
	};

	window.onData = (data) => {
		console.log(data.action);
		switch (data.action) {
			case 'setHUDDisplay': {
				ESX.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				ESX.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				ESX.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				ESX.deleteHUDElement(data.name);
				break;
			}

			case 'inventoryNotification': {
				ESX.inventoryNotification(data.add, data.item, data.count);
				break;
			}

			case 'showNotification': {
				ESX.showNotification(data.mess, data.ms);
				break;
			}

			case 'showPBar': {
				ESX.showPBar(data.mess, data.ms);
				break;
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});
	};

})();