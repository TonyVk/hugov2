DiscordWebhookSystemInfos = 'https://discord.com/api/webhooks/1045758884566007808/WxXMPpqliAhJHz44KRCOgfuTThnVJ9mOt59Z4Ow93uFMmnssJENghRxIyf4Bv84iBwZj'
DiscordWebhookKillinglogs = 'https://discord.com/api/webhooks/1045759019798761532/RwWiU-VZaqA31alAwkqYC-PdzdQjVbdFI-9-vpMJ14RkKymZTnBraL8g9XfquGZd1buI'
DiscordWebhookChat = 'https://discord.com/api/webhooks/1045759124517961780/NuuDZ6rBmgPbQMaXhJD210zLvD5Qq3M3E8dPysAiuYMw4iPQ8idweN_zHbib_qETwg5p'
DiscordWebhookMeh = 'https://discord.com/api/webhooks/1045759553985314906/qdFfD-7gfk-3gkMeeDA7_ZYNbFO_PoQXUH2HPNhyG22jlS08DpHm_RWQyBMMaIZqoJFW'
DiscordWebhookVozila = 'https://discord.com/api/webhooks/1045759179761123329/H1otrwy2cElKEZlDnhzg0vlixe54HicK3Zfpj3AhZmYwoZ1eRmpZJhTmDLskVB0j2_vS'
DiscordWebhookInventory = 'https://discord.com/api/webhooks/1045759288615907368/iXL78Gbr0HhmWJJLJrAs0YjlzBJ9hZwU8OKkkXLL_2D7-bPV29XZlI0P_QN0T3Zqhr23'
DiscordWebhookAnticheat = 'https://discord.com/api/webhooks/1045759235092398090/SzCWfnE7PGERnQqOcR8VLTqNifXZD_amsQhIRR76mGvuQ1zE_6M1cxUEy7a_7oBBchTu'
DiscordWebhookMarkeri = 'https://discord.com/api/webhooks/1045759360158146620/8IiG0D5JxKOwxvKljzYfylAPSATpFJVe6ZbUQ7SRbBZfDkGC8EzPO9rLkbH-55l3hqxq'
DiscordWebhookGepek = 'https://discord.com/api/webhooks/1045759414801551440/No7bSzuH_MDz32bCetrd1trvNQi9qFjD3VWu1lurVYJ-WwJTlbtwFKgH_TWzBCUaFWe4'
DiscordWebhookOduzimanje = 'https://discord.com/api/webhooks/1045759491972538420/hxPabxqGzdvQS8qRwg1riCPyS2WgHFHz2ZSYFnP0qUCORb1XcyfojmC6CJQMi6dwGBmP'
DiscordWebhookZetoni = 'https://discord.com/api/webhooks/794536116770045972/5AyVyA8ezOEgRGDH_7bK9CqECA3Sjdu9NO6mTHhvKs4f8ftI_mQ90OzFktzisjQBElFv'
DiscordWebhookGranica = 'https://discord.com/api/webhooks/801580952601231431/vEWbueIzvYYfM4OwRX8dvOfgNHRKMWTLkkifYQcP_l5BRb2RIQ21Q0zJWQuhzFzHGPWJ'
DiscordWebhookProdaja = 'https://discord.com/api/webhooks/1045812610781675550/UZrhll8y1clAmAdoHVDcsjRkXPosnaMzOKcsPbQJmyssd7z8N-s1fvb1xeQq3xq2bGiN'
DiscordWebhookDuty = 'https://discord.com/api/webhooks/1045759788836982834/kJf2UkLlA91pNWixgA0IM-nhLOEVvmVe07qmyw368cHNeEHuIttBhKQ4GelIo91-Rza8'
DiscordWebhookSefKuce = 'https://discord.com/api/webhooks/1045759611887681606/mFxIV_oVCsqSy9SY2idMWGaSKnSMm25xrMg_KT48UdHO9AIvEIEke0bW5WtiaL5QYM0k'

SystemAvatar = 'https://purepng.com/public/uploads/large/purepng.com-sealanimalssealsea-lion-981524671319vlofh.png'

UserAvatar = 'https://purepng.com/public/uploads/large/purepng.com-sealanimalssealsea-lion-981524671319vlofh.png'

SystemName = 'SEAL'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/AnotherCommand', 'WEBHOOK_LINK_HERE'},
					  {'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

