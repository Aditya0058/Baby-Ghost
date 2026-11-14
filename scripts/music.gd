extends Node

@onready var track_1: AudioStreamPlayer = $Track1
@onready var track_2: AudioStreamPlayer = $Track2
@onready var switch_timer: Timer = $SwitchTimer

const TRACKS: Array[AudioStream] = [
    preload("res://assets/music/night_bgm.mp3"),
    preload("res://assets/music/time_for_adventure.mp3"),
]

var current_index: int = 0

func _ready() -> void:
    track_1.stream = TRACKS[0]
    track_2.stream = TRACKS[1]
    switch_timer.timeout.connect(_on_switch_timer_timeout)
    _play_track(0)

func _play_track(index: int) -> void:
    current_index = index
    track_1.stop()
    track_2.stop()

    if index == 0:
        track_1.play()
    else:
        track_2.play()

func _on_switch_timer_timeout() -> void:
    var next_index: int = 1 - current_index
    _play_track(next_index)
