extends Node2D

#play comments should allow us to set
#volume
#looping
#target bus???
#pitch?

#very needed
var musChs = []
var sfxChs = []

var currentVol1 = -5.0
var currentVol2 = -5.0
var currentVol3 = -5.0
var fadeMode = false
var fadeTime = 0
var origFadeTime = 0
var newTimeTestDebug = 0



#DELAYED SFX SYSTEM NOT WORKING IGNORE 4 NOW

#used for delayed sfx thing
#what this does is, say I want like multiple explosions at very nearly the sametime
#really, I just don't want them at exactly the same time, a little off from each other is fine
#so this is experimentally a way to have it delay and detune the effect
#every frame it checks if an sfx was delayed last round
#if an sfx WAS delayed, it then calls sfx wth the delayed sfx's call but slightly detuned 
#var delayedSfx = [0, null, 0.0]
#delayed sfx array
#[0] = bool is there a delayed sfx
#[1] = what's its name
#[2] = what's its volume

func _ready():
	#ch listing
	#2d arrays, [X][0] = # + 1 so ch0 is labelled 1 here, etc
	#[X][1] = last playing song, stored as a string OR as null
	musChs.append([])
	musChs[0] = [1] #music channel 1
	musChs[0].append([])
	musChs[0][1] = null #current song on channel 1

	musChs.append([])
	musChs[1] = [2] #music channel 2
	musChs[1].append([])
	musChs[1][1] = null #current song on channel 2

	musChs.append([])
	musChs[2] = [3] #music channel 3
	musChs[2].append([])
	musChs[2][1] = null #current song on channel 2
	
	#sfx channels
	sfxChs.append([])
	sfxChs[0] = [1] #sfx channel 1
	sfxChs[0].append([])
	sfxChs[0][1] = null #current sfx on channel 1

	sfxChs.append([])
	sfxChs[1] = [2] #sfx channel 2
	sfxChs[1].append([])
	sfxChs[1][1] = null #current sfx on channel 2

	sfxChs.append([])
	sfxChs[2] = [3] #sfx channel 3
	sfxChs[2].append([])
	sfxChs[2][1] = null #current sfx on channel 2
	
	sfxChs.append([])
	sfxChs[3] = [1] #sfx channel 4
	sfxChs[3].append([])
	sfxChs[3][1] = null #current sfx on channel 1

	sfxChs.append([])
	sfxChs[4] = [2] #sfx channel 5
	sfxChs[4].append([])
	sfxChs[4][1] = null #current sfx on channel 2

	sfxChs.append([])
	sfxChs[5] = [3] #sfx channel 6
	sfxChs[5].append([])
	sfxChs[5][1] = null #current sfx on channel 2
	
	sfxChs.append([])
	sfxChs[6] = [3] #sfx channel 7
	sfxChs[6].append([])
	sfxChs[6][1] = null #current sfx on channel 2
	
func _process(delta):
	#works!
	if fadeMode == true:
		$musicch1.volume_db = lerp(-60 ,currentVol1, fadeTime/origFadeTime)
		$musicch2.volume_db = lerp(-60 ,currentVol2, fadeTime/origFadeTime)
		$musicch3.volume_db = lerp(-60 ,currentVol3, fadeTime/origFadeTime)
		
		newTimeTestDebug += 1
		fadeTime -= delta
		if 0 >= fadeTime:
			fadeMode = false
			stop_mus()
			pass
	pass

func stop_mus():
	$musicch1.stop()
	$musicch2.stop()
	$musicch3.stop()
	musChs[0][1] = null
	musChs[1][1] = null
	musChs[2][1] = null

func stop_sfx():
	$sfxch1.stop()
	$sfxch2.stop()
	$sfxch3.stop()
	$sfxch4.stop()
	$sfxch5.stop()
	$sfxch6.stop()
	$sfxch7.stop()
	sfxChs[0][1] = null
	sfxChs[1][1] = null
	sfxChs[2][1] = null
	sfxChs[3][1] = null
	sfxChs[4][1] = null
	sfxChs[5][1] = null
	sfxChs[6][1] = null

func play_mus(song, volume=0.0, pitch=1.0, force=false):
	#example call
	#play_music(boss.ogg)
	#where song is an audio file in the audio directory
	#volume is db setting, 0 default, -6 is half, -12 is 1/4th, etc
	
	#read song name and convert to filename
	#print(str(song))
	song = "res://audio/" + song
	#print(str(song))
	
	#check each channel for if its playing
	#if it is try and check next one
	#if all full, give up
	#otherwise mark as one we're playing into
	var openChannel
	var openChannelArrayNum
	
	fadeMode = false #was causing trouble otherwise
	
	if $musicch1.playing == true:
		if $musicch2.playing == true:
			if $musicch3.playing == true:
				openChannel = null
				#print("all channels playing")
			else:
				openChannel = $musicch3
				openChannelArrayNum = 2
				#print("ch3 open")
		else:
			openChannel = $musicch2
			openChannelArrayNum = 1
			#print("ch2 open")
	else:
		openChannel = $musicch1
		openChannelArrayNum = 0
		#print("channel 1 open")
		
	#use normal open channel check, but if force is on, then just override channel 1
	if force == true:
		openChannel = $musicch1
		openChannelArrayNum = 0
		openChannel.stop()
		musChs[0][1] == null
		#print("force, push onto channel 1")
		pass
	
	#if open channel, do pre-play checks
	if openChannel != null:
		
		#check every channel for this song
		#if it's already playing, don't add it
		#unless forced
		var alreadyPlaying = false
		if force == false:
			var i
			i = 2
			while i > -1:
				print("channel " + str(musChs[i]) + " currently playing: " + str(musChs[i][1]))
				if musChs[i][1] == song:
					alreadyPlaying = true
					#print("already playing, don't double play")
				i -= 1

		if alreadyPlaying == true:
			pass
			#print("not playing cuz it's already playing, add a force command later")
		else:
			# record currently playing song name for previous check
			musChs[openChannelArrayNum][1] = song
			#print("now playing " + str(song) + " on channel " + str(musChs[openChannelArrayNum]))
			openChannel.stream = load(song)
			openChannel.volume_db = volume
			openChannel.pitch_scale = pitch
			openChannel.play()
		pass
		
func play_sfx(sfx, volume=0.0, pitch=1.0, force=false):
	#example call
	#play_music(boss.ogg)
	#where song is an audio file in the audio directory
	#volume is db setting, 0 default, -6 is half, -12 is 1/4th, etc
	#force lets you guarantee 1 sound on channel 1
	#delay lets you allow a sound to be played slightly later
	#delayFlag is used exclusively by the delay function to override the restriction
		
	#read song name and convert to filename
	#print(str(sfx))
	sfx = "res://audio/" + sfx
	#print(str(sfx))
	
	#check each channel for if its playing
	#if it is try and check next one
	#if all full, give up
	#otherwise mark as one we're playing into
	var openChannel = null
	var openChannelArrayNum = 0
	
	if $sfxch1.playing == true:
		if $sfxch2.playing == true:
			if $sfxch3.playing == true:
				if $sfxch4.playing == true:
					if $sfxch5.playing == true:
						if $sfxch6.playing == true:
							if $sfxch7.playing == true:
								openChannel = null
								#print("all channels playing")
							else:
								openChannel = $msfxch7
								openChannelArrayNum = 6
								#print("ch7 open")
						else:
							openChannel = $msfxch6
							openChannelArrayNum = 5
							#print("ch6 open")
					else:
						openChannel = $msfxch5
						openChannelArrayNum = 4
						#print("ch5 open")
				else:
					openChannel = $msfxch4
					openChannelArrayNum = 3
					#print("ch4 open")
			else:
				openChannel = $msfxch3
				openChannelArrayNum = 2
				#print("ch3 open")
		else:
			openChannel = $sfxch2
			openChannelArrayNum = 1
			#print("ch2 open")
	else:
		openChannel = $sfxch1
		openChannelArrayNum = 0
		#print("channel 1 open")
		
	#use normal open channel check, but if force is on, then just override channel 1
	if bool(force) == true:
		if openChannel == null:
			openChannel = $sfxch1
			openChannelArrayNum = 0
			openChannel.stop()
			sfxChs[0][1] == null
			#print("force, push onto channel 1")
		pass
	
	#if open channel, do pre-play checks
	if openChannel != null:
		
		#check every channel for this song
		#if it's already playing, don't add it
		#unless forced
		var alreadyPlaying = false
		if bool(force) == false:
			var i
			i = 6
			while i > -1:
				#print("channel " + str(sfxChs[i]) + " currently playing: " + str(sfxChs[i][1]))
				if sfxChs[i][1] == sfx:
					alreadyPlaying = true
					#print("already playing, don't double play")
				i -= 1

		if alreadyPlaying == true:
			pass
			#print("not playing cuz it's already playing, add a force command later")
		else:
			# record currently playing song name for previous check
			sfxChs[openChannelArrayNum][1] = sfx
			#print("now playing " + str(sfx) + " on channel " + str(sfxChs[openChannelArrayNum]))
			openChannel.stream = load(sfx)
			openChannel.volume_db = volume
			openChannel.pitch_scale = pitch
			openChannel.play()
		pass
	
func play_over(channel, channeltype):
	#when song finishes playing signal from that channel to clear it
	#print(channeltype + " channel " + str(channel) + " finished")
	if channeltype == "mus":
		#print("setting mus off")
		musChs[channel][1] = null
		pass
	else:
		#print("setting sfx off")
		sfxChs[channel][1] = null
		pass

func fade_out_mus(time):
	currentVol1 = $musicch1.volume_db
	currentVol2 = $musicch2.volume_db
	currentVol3 = $musicch3.volume_db
	
	fadeTime = time
	origFadeTime = time
	fadeMode = true
	pass
	
