@tool
extends EditorScript
func _run() -> void:
	var root := get_editor_interface().get_edited_scene_root()
	if root == null:
		printerr("Отвори сцена преди да пуснеш скрипта.")
		return
	_scan_node(root)

func _scan_node(n: Node) -> void:
	if n is AnimationPlayer:
		_check_player(n)
	for c in n.get_children():
		_scan_node(c)

func _check_player(ap: AnimationPlayer) -> void:
	for anim_name in ap.get_animation_list():
		var anim: Animation = ap.get_animation(anim_name)
		if anim == null:
			continue
		var length := anim.length
		for t in anim.get_track_count():
			var kc := anim.track_get_key_count(t)
			for k in range(kc):
				var kt := anim.track_get_key_time(t, k)
				if kt < 0.0 or kt > length + 0.00001:
					printerr("Открит key извън обхват: ",
						str(kt), " (length=", str(length), ") ",
						"в ", ap.get_path(), " / animation '", anim_name,
						"' / track ", str(t))
