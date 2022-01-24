fx_version 'adamant'

game 'gta5'

-- Example custom radios
supersede_radio "RADIO_02_POP" { url = "http://149.56.175.167:5461/;stream/1", volume = 0.3, name = "Radio Underground" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://asculta.radiohitfm.net:8340/;", volume = 0.3, name = "RADIO HITFM" }
supersede_radio "RADIO_04_PUNK" { url = "http://manele.capitalfm.ro:8020/;", volume = 0.3, name = "Radio Manele 1" }
supersede_radio "RADIO_05_TALK_01" { url = "http://live1.radioexpert.ro:8889/;", volume = 0.3, name = "Radio Manele 2" }
supersede_radio "RADIO_06_COUNTRY" { url = "http://live.radiotaraf.ro:8181/;stream", volume = 0.3, name = "Radio TARAF NR1" }
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "http://80.86.106.143:9128/magicfm.aacp", volume = 0.3, name = "MagicFM" }
supersede_radio "RADIO_12_REGGAE" { url = "http://www.texfm.ro:8000/romanian_hits", volume = 0.3, name = "RADIO TexFM Romanian Hits" }
supersede_radio "RADIO_13_JAZZ" { url = "http://edge126.rdsnet.ro:84/profm/profm.mp3", volume = 0.3, name = "PRO FM" }
supersede_radio "RADIO_14_DANCE_02" { url = "http://astreaming.europafm.ro:8000/europafm_mp3_64k", volume = 0.3, name = "EuropaFM" }
supersede_radio "RADIO_15_MOTOWN" { url = "http://108.178.13.122:8195/;stream/1", volume = 0.3, name = "Radio Suburban" }
supersede_radio "RADIO_20_THELAB" { url = "http://necenzurat.radiotequila.ro:7000/;stream/1", volume = 0.3, name = "Radio Tequila" }
supersede_radio "RADIO_16_SILVERLAKE" { url = "http://astreaming.virginradio.ro:8000/virgin_mp3_64k", volume = 0.4, name = "Virgin Radio" } 
supersede_radio "RADIO_17_FUNK" { url = "http://live.aquarelle.md:8000/aquarellefm.mp3", volume = 0.3, name = "Aquarelle FM MOLDOVA" }
supersede_radio "RADIO_18_90S_ROCK" { url = "http://asculta.mixmusicradio.ro:8890/;", volume = 0.3, name = "MIX MUSIC RADIO DANCE" }
supersede_radio "RADIO_19_USER" { url = "http://mp3channels.webradio.rockantenne.de/heavy-metal/", volume = 0.3, name = "RADIO Heavy Metal" }
supersede_radio "RADIO_11_TALK_02" { url = "http://87.98.130.355:8624/stream", volume = 0.3, name = "House FM" }
files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}