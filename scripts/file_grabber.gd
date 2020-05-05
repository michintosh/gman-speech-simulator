extends Node


func get_files(folder):
	var gathered_files = {}
	var file_count = 0
	var dir = Directory.new()
	
	dir.open(folder)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".import"):
			continue
		elif not file.begins_with("."):
			var left_edge = file.find("<")
			var right_edge = file.find(">")
			var new_name = file.substr(left_edge+1, (right_edge-left_edge)-1)
			var spaces_replace = new_name.replace("_"," ")
			gathered_files[file_count] = {
				"path":folder + file,
				"subs":spaces_replace
				}
			file_count += 1
	return gathered_files
			
