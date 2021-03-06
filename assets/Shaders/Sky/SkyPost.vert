#import "Shaders/Templates/Common/Compat.glsllib"

//uniform mat4 g_WorldViewProjectionMatrixInverse;
uniform mat4 g_ViewMatrixInverse;
//uniform mat4 g_ViewProjectionMatrixInverse;
//uniform vec3 g_CameraPosition;
//uniform float g_Aspect;

attribute vec3 inPosition;
attribute vec2 inTexCoord;

uniform mat4 g_ViewMatrix;
noperspective out vec3 pos;

#ifdef VIEW
noperspective out vec2 fpPos;
#endif

	
void main() {
	//Option 1
	//vec4 v = g_ViewProjectionMatrixInverse*vec4(vec3(inPosition.x*g_Aspect, inPosition.y, 1.0), 1.0);
	//pos = normalize(v.xyz);

	//Option 2
	//mat4 mat = g_ViewMatrixInverse;
	//mat[3].xyz = vec3(0.0);
	//vec4 v = mat*vec4(inTexCoord.x, inTexCoord.y, -1.0, 1.0);
	//pos = normalize(v.xyz);

	//Option 3
	//vec4 v = g_ViewMatrixInverse*vec4(inTexCoord.x, inTexCoord.y, -1.0, 1.0);
	//pos = normalize(v.xyz-g_ViewMatrixInverse[3].xyz);
	//pos = normalize((v.xyz-g_ViewMatrixInverse[3].xyz));

	vec3 v = vec3(inTexCoord.x, inTexCoord.y, -1.0)*mat3(g_ViewMatrix);
	pos = normalize(v.xyz);

	#ifdef VIEW
		fpPos = inPosition.xy*0.5+0.5;
	#endif

    gl_Position = vec4(inPosition.xy, 1.0, 1.0);
}