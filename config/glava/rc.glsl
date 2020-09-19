#request mod circle

/* Window title */
#request settitle "glava_conky"

/* Window geometry (x, y, width, height) */
#request setgeometry 1062 -72 800 600
#request setbg 00000000
#request setxwintype "normal"
#request setclickthrough false
#request setsource "auto"
#request setswap 1

/* Window hints */
#request setfloating  false
#request setdecorated true
#request setfocused   false
#request setmaximized false
#request setopacity "native"

/* Whether to mirror left and right audio input channels from PulseAudio.*/
#request setmirror false

#request setinterpolate true

#request setframerate 0

#request setfullscreencheck true

#request setprintframes true

#request setsamplesize 512

#request setbufsize 1024

#request setsamplerate 11025

/* OpenGL context and GLSL shader versions, do not change unless
   you *absolutely* know what you are doing. */
#request setversion 3 3
#request setshaderversion 330
