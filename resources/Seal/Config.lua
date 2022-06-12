DiscordWebhookSystemInfos = 'https://discord.com/api/webhooks/884729536439263263/sAKBbFMMlXHkQHn8oQdmY8qytYfNpJVjMzPScwUNhjSSBnnGmjBdWbk2jIXGWsYGROM2'
DiscordWebhookKillinglogs = 'https://discord.com/api/webhooks/884729958486921236/91p2RcKahl6tob-RHrB-hoISgrkyijx3-cLMtYKW4KWBOmI7rNStqEEiah2YnO_5GR-2'
DiscordWebhookChat = 'https://discord.com/api/webhooks/884730172023111710/tz8gmUYC-WKg8zyfnPjTEL73H6CoN7OSUnACILfwnwkXwhWPOj5B6gE1lO3ieMaHFEO6'
DiscordWebhookMeh = 'https://discord.com/api/webhooks/884730575636820009/t-oSmAfQ91md71jCHngpnoDqjlBIleG9NNqgzbToDZq9z0LNGLmufVl7e4YTH_rBnbh4'
DiscordWebhookVozila = 'https://discord.com/api/webhooks/884730857347235850/JexJXAYX2wGgNNTWB7iacEymvkt9SshJQla_tZ03U6o2LzyLPleBQvbU3oO2TG_Ew1xT'
DiscordWebhookInventory = 'https://discord.com/api/webhooks/884731149941887007/-lRSjKTVONR2whGNvbtrChjO-nN877sdB7S7PZugpmM55jEb09GNkUJuYXoosEJbH2db'
DiscordWebhookAnticheat = 'https://discord.com/api/webhooks/884731650800488499/IX5cbZ4kprVMa0OnP6trIt5yiTsnd8h1b-gk_uuxTUib9_HKKNPjSjdjuQNoVwKDzPhT'
DiscordWebhookMarkeri = 'https://discord.com/api/webhooks/884732164363649024/X7CWy0sMm_eysFUSK3DRRDTQ0dHkkmS3n_Ox3AVJEJFacXrws0NEVC1SjdQdkrRF3Xyb'
DiscordWebhookGepek = 'https://discord.com/api/webhooks/884739011992780830/IHLGLFRGDC4pDIlJlrMlGKYq1cqSpyjgM_PrXOxjfIJXTZFwWXLLN4gLbTij-MOUrxlv'
DiscordWebhookOduzimanje = 'https://discord.com/api/webhooks/884739269883727892/u6G76MDo7JtCKsBG_wEE2IgsYcbnyqK-7QJ2r0dzzVdvVkAoYXKsJHVdNObgJal4L204'
DiscordWebhookZetoni = 'https://discord.com/api/webhooks/794536116770045972/5AyVyA8ezOEgRGDH_7bK9CqECA3Sjdu9NO6mTHhvKs4f8ftI_mQ90OzFktzisjQBElFv'
DiscordWebhookGranica = 'https://discord.com/api/webhooks/801580952601231431/vEWbueIzvYYfM4OwRX8dvOfgNHRKMWTLkkifYQcP_l5BRb2RIQ21Q0zJWQuhzFzHGPWJ'
DiscordWebhookProdaja = 'https://discord.com/api/webhooks/848188467594526760/C9upnyfA0ELSoRd59IqDV-OU3sRpjhbphYVZOWXjW--p2vVMbHmnP0TbMft7Fq9Jotu5'
DiscordWebhookDuty = 'https://discord.com/api/webhooks/980825678473732156/XBQvwmuHvpqow2Gub6zFj3c9V4itDErfrv5TehqEe5VfyN6wNz6qXjkz7_m0ZvWw2SQ5'
DiscordWebhookSefKuce = 'https://discord.com/api/webhooks/920504181150871563/jPqLp54pJqq49RcT2tiFIqkfDrroe7P16v-F1TliCnyDXVScHS3uR2WgE-4Jw-vvoxEn'

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

