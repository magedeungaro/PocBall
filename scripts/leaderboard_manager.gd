extends Node

@onready var api_key = ApiKey

var base_url = "https://api.lootlocker.io/"
var session_token = null
var player_name = null
var last_ranking_data = null
var last_level_name = null

# HTTP Request node can only handle one call per node
var auth_http = HTTPRequest.new()
var leaderboard_http = HTTPRequest.new()
var submit_score_http = HTTPRequest.new()
var set_name_http = HTTPRequest.new()
var get_name_http = HTTPRequest.new()


func send_player_info(info_dict):
	var leaderboard_key = info_dict.leaderboard_key
	last_level_name = leaderboard_key.replace("\\b(\\d)", " \\0")
	var score = info_dict.score
	_upload_score(score, leaderboard_key)
	get_leaderboards(leaderboard_key)


func _ready():
	_authentication_request()

func _authentication_request():
	var player_session_exists = false
	var player_identifier : String
	var file = FileAccess.open("user://LootLocker.data", FileAccess.READ)
	if file != null:
		player_identifier = file.get_as_text()
		file.close()
 
	if player_identifier != null and player_identifier.length() > 1:
		player_session_exists = true
	
	var data = { "game_key": api_key.LOOT_LOCKER_API_KEY,
							 "game_version": "0.0.0.1",
							 "development_mode": api_key.DEVELOPMENT_MODE }
	
	if(player_session_exists == true):
		data["player_identifier"] = player_identifier

	var headers = ["Content-Type: application/json"]
	var endpoint = "game/v2/session/guest"
	auth_http = HTTPRequest.new()
	add_child(auth_http)
	auth_http.request_completed.connect(_on_authentication_request_completed)
	auth_http.request(base_url+endpoint, headers, HTTPClient.METHOD_POST, JSON.stringify(data))

func get_leaderboards(leaderboard_key):
	print("Getting leaderboards")
	var endpoint = "game/leaderboards/"+leaderboard_key+"/list?count=10"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	leaderboard_http = HTTPRequest.new()
	add_child(leaderboard_http)

	leaderboard_http.request_completed.connect(_on_leaderboard_request_completed)
	leaderboard_http.request(base_url+endpoint, headers, HTTPClient.METHOD_GET, "")

func _upload_score(score, leaderboard_key):
	var endpoint = "game/leaderboards/"+leaderboard_key+"/submit"
	var data = { "score": str(score) }
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]

	submit_score_http = HTTPRequest.new()
	add_child(submit_score_http)

	submit_score_http.request_completed.connect(_on_upload_score_request_completed)
	submit_score_http.request(base_url+endpoint, headers, HTTPClient.METHOD_POST, JSON.stringify(data))

func _change_player_name(new_player_name):
	var data = { "name": str(new_player_name) }
	var endpoint =  "game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	set_name_http = HTTPRequest.new()
	add_child(set_name_http)

	set_name_http.request_completed.connect(_on_player_set_name_request_completed)
	set_name_http.request(base_url+endpoint, headers, HTTPClient.METHOD_PATCH, JSON.stringify(data))
	
func _get_player_name():
	print("Getting player name")
	var endpoint = "game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	get_name_http = HTTPRequest.new()
	add_child(get_name_http)

	get_name_http.request_completed.connect(_on_player_get_name_request_completed)
	get_name_http.request(base_url+endpoint, headers, HTTPClient.METHOD_GET, "")

func _on_authentication_request_completed(_result, response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	print(response_code) # remove after debug
	var file = FileAccess.open("user://LootLocker.data", FileAccess.WRITE)
	file.store_string(json.get_data().player_identifier)
	file.close()
	session_token = json.get_data().session_token
	auth_http.queue_free()

func _on_leaderboard_request_completed(_result, response_code, _headers, body):
	if response_code != 200: return
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	
	var leaderboardFormatted = ""
	for n in json.get_data().items.size():
		leaderboardFormatted += str(json.get_data().items[n].rank)+str(". ")
		leaderboardFormatted += str(json.get_data().items[n].player.id)+str(" - ")
		leaderboardFormatted += str(json.get_data().items[n].score)+str("\n")
	leaderboard_http.queue_free()
	last_ranking_data = leaderboardFormatted

func _on_player_get_name_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	print(json.get_data())
	print(json.get_data().name)

func _on_upload_score_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	print(json.get_data())
	submit_score_http.queue_free()

func _on_player_set_name_request_completed(_result, _response_code, _headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	print(json.get_data())
	set_name_http.queue_free()
