
float EdgeMorph : CONTROLOBJECT < string name = "(self)"; string item = "�G�b�W�̑���"; >;
float EdgeMorph2 : CONTROLOBJECT < string name = "(self)"; string item = "�G�b�W�傫��"; >;
float4x4 HeadMat : CONTROLOBJECT < string name = "(self)";string item = "��";>;

//�G�b�W����
static float EdgeSize = 0.0001 + 0.001 * (EdgeMorph * 1) + 0.001 * (EdgeMorph2 * 1);
//�G�b�W�Z��
float EdgeShadow = 5.0;

//---�\�t�g�V���h�E�p�p�����[�^---//
//�\�t�g�V���h�E���邳�␳
float LightParam = 1;
//�\�t�g�V���h�E�p�ڂ�����
float SoftShadowParam = 0.25;
//�V���h�E�}�b�v�T�C�Y
//�ʏ�F1024 CTRL+G�ŉ𑜓x���グ���ꍇ 4096
#define SHADOWMAP_SIZE 1024


float Script : STANDARDSGLOBAL <
	string ScriptOutput = "color";
	string ScriptClass = "sceneorobject";
	string ScriptOrder = "standard";
> = 0.8;
    
// ���@�ϊ��s��
float4x4 WorldViewProjMatrix      : WORLDVIEWPROJECTION;
float4x4 WorldMatrix              : WORLD;
float4x4 ViewMatrix               : VIEW;
float4x4 LightWorldViewProjMatrix : WORLDVIEWPROJECTION < string Object = "Light"; >;

float3   LightDirection    : DIRECTION < string Object = "Light"; >;
float3   CameraPosition    : POSITION  < string Object = "Camera"; >;

// �}�e���A���F
float4   MaterialDiffuse   : DIFFUSE  < string Object = "Geometry"; >;
float3   MaterialAmbient   : AMBIENT  < string Object = "Geometry"; >;
float3   MaterialEmmisive  : EMISSIVE < string Object = "Geometry"; >;
float3   MaterialSpecular  : SPECULAR < string Object = "Geometry"; >;
float    SpecularPower     : SPECULARPOWER < string Object = "Geometry"; >;
float3   MaterialToon      : TOONCOLOR;
float4   EdgeColor         : EDGECOLOR;
// ���C�g�F
float3   LightDiffuse      : DIFFUSE   < string Object = "Light"; >;
float3   LightAmbient      : AMBIENT   < string Object = "Light"; >;
float3   LightSpecular     : SPECULAR  < string Object = "Light"; >;
static float4 DiffuseColor  = MaterialDiffuse  * float4(LightDiffuse, 1.0f);
static float3 AmbientColor  = saturate(MaterialAmbient  * LightAmbient + MaterialEmmisive);
static float3 SpecularColor = MaterialSpecular * LightSpecular;

bool     parthf;   // �p�[�X�y�N�e�B�u�t���O
bool     transp;   // �������t���O
bool	 spadd;    // �X�t�B�A�}�b�v���Z�����t���O
#define SKII1    1500
#define SKII2    8000
#define Toon     3

float4	 EgColor;			// �A�N�Z�T���p�A���r�G���g�F

// �I�u�W�F�N�g�̃e�N�X�`��
texture ObjectTexture: MATERIALTEXTURE</*
	int Width = 512;
	int Height = 512;*/
	int MipLevels = 0;
//	string Format = "A8R8G8B8" ;
>;
sampler DefObjTexSampler = sampler_state {
    texture = <ObjectTexture>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

texture UseMipmapObjectTexture : RENDERCOLORTARGET <
	int Width = 512;
	int Height = 512;
	int MipLevels = 0;
	string Format = "A8R8G8B8" ;
>;
sampler ObjTexSampler = sampler_state {
	texture = <UseMipmapObjectTexture>;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MIPFILTER = LINEAR;
	MAXANISOTROPY = 16;
};

texture2D DepthBuffer : RenderDepthStencilTarget <
	int Width = 512;
	int Height = 512;
	string Format = "D24S8";
>;

// �X�t�B�A�}�b�v�̃e�N�X�`��
texture ObjectSphereMap: MATERIALSPHEREMAP;
sampler ObjSphareSampler = sampler_state {
    texture = <ObjectSphereMap>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

//--�e��}�b�v�e�N�X�`��
#define ANISO_NUM 16
//�X�y�L�����}�b�v
texture2D SpMap <
    string ResourceName = "SpecularMap.png";
    int MipLevels = 8;
>;
sampler SpMapSamp = sampler_state {
    texture = <SpMap>;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MIPFILTER = ANISOTROPIC;
	
	MAXANISOTROPY = ANISO_NUM;
    AddressU  = WRAP;
    AddressV = WRAP;
};
texture2D HeightMap <
    string ResourceName = "HeightMap.png";
    int MipLevels = 8;
>;
sampler HeightMapSamp = sampler_state {
    texture = <HeightMap>;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MIPFILTER = ANISOTROPIC;
	
	MAXANISOTROPY = ANISO_NUM;
    AddressU  = WRAP;
    AddressV = WRAP;
};
texture2D NormalMap <
    string ResourceName = "NormalMap.png";
    int MipLevels = 8;
>;
sampler NormalMapSamp = sampler_state {
    texture = <NormalMap>;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MIPFILTER = ANISOTROPIC;
	
	MAXANISOTROPY = ANISO_NUM;
    AddressU  = WRAP;
    AddressV = WRAP;
};
texture2D ExNormalMap <
    string ResourceName = "ExNormalMap.png";
    int MipLevels = 8;
>;
sampler ExNormalMapSamp = sampler_state {
    texture = <ExNormalMap>;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MIPFILTER = ANISOTROPIC;
	
	MAXANISOTROPY = ANISO_NUM;
    AddressU  = WRAP;
    AddressV = WRAP;
};
texture2D ToonTex <
    string ResourceName = "Toon.png";
    int MipLevels = 8;
>;
sampler ToonSamp = sampler_state {
    texture = <ToonTex>;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MIPFILTER = ANISOTROPIC;
	
	MAXANISOTROPY = ANISO_NUM;
    AddressU  = CLAMP;
    AddressV = CLAMP;
};



// MMD�{����sampler���㏑�����Ȃ����߂̋L�q�ł��B�폜�s�B
sampler MMDSamp0 : register(s0);
sampler MMDSamp1 : register(s1);
sampler MMDSamp2 : register(s2);


// �X�N���[���T�C�Y
float2 ViewportSize : VIEWPORTPIXELSIZE;
static float2 ViewportOffset = (float2(0.5,0.5)/ViewportSize);

// �����_�����O�^�[�Q�b�g�̃N���A�l
float4 ClearColor = {0,0,0,0};
float ClearDepth  = 1.0;

//�\�t�g���C�g�����֐�
float3 SoftLight(float3 fg , float3 bg){
	float3 under  = bg+(bg-pow(bg,2.0))*(2.0f*fg-1.0f);
	float3 middle = bg+(bg-pow(bg,2.0f))*(2.0f*fg-1.0f)*(3.0f-8.0f*bg);
	float3 upper  = bg+(pow(bg,0.5f)-bg)*(2.0f*fg-1.0f);

	const float bgLimit = 32.0f / 255.0f;
	
	float3 Dst = (float3)0;
	
	Dst.r = fg.r < 0.5f ? under.r : bg.r <= bgLimit ? middle.r : upper.r;
	Dst.g = fg.g < 0.5f ? under.g : bg.g <= bgLimit ? middle.g : upper.g;
	Dst.b = fg.b < 0.5f ? under.b : bg.b <= bgLimit ? middle.b : upper.b;
	
	//Dst = pow(Dst,5);
	return Dst;
}

////////////////////////////////////////////////////////////////////////////////////////////////
// �~�b�v�}�b�v�쐬

struct VS_OUTPUT_MIPMAPCREATER {
    float4 Pos	: POSITION;
    float2 Tex	: TEXCOORD0;
};
VS_OUTPUT_MIPMAPCREATER VS_MipMapCreater( float4 Pos : POSITION, float4 Tex : TEXCOORD0 ){
    VS_OUTPUT_MIPMAPCREATER Out;
    Out.Pos = Pos;
    Out.Tex = Tex;
    Out.Tex += ViewportOffset;
    return Out;
}

float4  PS_MipMapCreater(float2 Tex: TEXCOORD0) : COLOR0
{
	return tex2D(DefObjTexSampler,Tex);
}

// �֊s�`��p�e�N�j�b�N
technique EdgeTec < string MMDPass = "edge"; > {
}


///////////////////////////////////////////////////////////////////////////////////////////////
// �e�i��Z���t�V���h�E�j�`��

// ���_�V�F�[�_
float4 Shadow_VS(float4 Pos : POSITION) : POSITION
{
    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    return mul( Pos, WorldViewProjMatrix );
}

// �s�N�Z���V�F�[�_
float4 Shadow_PS() : COLOR
{
    // �A���r�G���g�F�œh��Ԃ�
    return float4(AmbientColor.rgb, 0.65f);
}

// �e�`��p�e�N�j�b�N
technique ShadowTec < string MMDPass = "shadow"; > {
    pass DrawShadow {
        VertexShader = compile vs_3_0 Shadow_VS();
        PixelShader  = compile ps_3_0 Shadow_PS();
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////
// �@���v�Z�֐�

float3x3 compute_tangent_frame(float3 Normal, float3 View, float2 UV)
{
  float3 dp1 = ddx(View);
  float3 dp2 = ddy(View);
  float2 duv1 = ddx(UV);
  float2 duv2 = ddy(UV);

  float3x3 M = float3x3(dp1, dp2, cross(dp1, dp2));
  float2x3 inverseM = float2x3(cross(M[1], M[2]), cross(M[2], M[0]));
  float3 Tangent = mul(float2(duv1.x, duv2.x), inverseM);
  float3 Binormal = mul(float2(duv1.y, duv2.y), inverseM);

  return float3x3(normalize(Tangent), normalize(Binormal), Normal);
}

///////////////////////////////////////////////////////////////////////////////////////////////
// �I�u�W�F�N�g�`��i�Z���t�V���h�EOFF�j

struct VS_OUTPUT {
    float4 Pos        : POSITION;    // �ˉe�ϊ����W
    float2 Tex        : TEXCOORD1;   // �e�N�X�`��
    float3 Normal     : TEXCOORD2;   // �@��
    float3 Eye        : TEXCOORD3;   // �J�����Ƃ̑��Έʒu
    float2 SpTex      : TEXCOORD4;	 // �X�t�B�A�}�b�v�e�N�X�`�����W
    float4 Color      : COLOR0;      // �f�B�t���[�Y�F
};

// ���_�V�F�[�_
VS_OUTPUT Basic_VS(float4 Pos : POSITION, float3 Normal : NORMAL, float2 Tex : TEXCOORD0, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;
    
    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    Out.Pos = mul( Pos, WorldViewProjMatrix );
    
    // �J�����Ƃ̑��Έʒu
    Out.Eye = CameraPosition - mul( Pos, WorldMatrix );
    // ���_�@��
    Out.Normal = normalize( mul( Normal, (float3x3)WorldMatrix ) );
    
    // �f�B�t���[�Y�F�{�A���r�G���g�F �v�Z
    Out.Color.rgb = AmbientColor;
    if ( !useToon ) {
        Out.Color.rgb += max(0,dot( Out.Normal, -LightDirection )) * DiffuseColor.rgb;
    }
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );
    
    // �e�N�X�`�����W
    Out.Tex = Tex;
    
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�e�N�X�`�����W
        float2 NormalWV = mul( Out.Normal, (float3x3)ViewMatrix );
        Out.SpTex.x = NormalWV.x * 0.5f + 0.5f;
        Out.SpTex.y = NormalWV.y * -0.5f + 0.5f;
    }
    
    return Out;
}

// �s�N�Z���V�F�[�_
float4 Basic_PS(VS_OUTPUT IN, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon) : COLOR0
{
    // �X�y�L�����F�v�Z
    float3 HalfVector = normalize( normalize(IN.Eye) + -LightDirection );
    float3 Specular = pow( max(0,dot( HalfVector, normalize(IN.Normal) )), SpecularPower ) * SpecularColor;
    
    float4 Color = IN.Color;
    if ( useTexture ) {
        // �e�N�X�`���K�p
        Color *= tex2D( ObjTexSampler, IN.Tex );
    }
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�K�p
        if(spadd) Color.rgb += tex2D(ObjSphareSampler,IN.SpTex).rgb;
        else      Color *= tex2D(ObjSphareSampler,IN.SpTex);
    }
    
    if ( useToon ) {
        // �g�D�[���K�p
        float LightNormal = dot( IN.Normal, -LightDirection );
        Color.rgb *= lerp(MaterialToon, float3(1,1,1), saturate(LightNormal * 16 + 0.5));
    }
    
    float diffContrib = dot( normalize(IN.Normal) , -LightDirection) * 0.5 +0.5;
	
	float RimPower = max( 0.0f, dot( -normalize(IN.Eye), -LightDirection ) );
	float Rim = 1.0f - max( 0.0f, dot( normalize(IN.Normal),normalize(IN.Eye)) );
	diffContrib += Rim*RimPower;
	
	diffContrib = pow(diffContrib,1.0f/0.75);
	
	float3 mColor = diffContrib * Color;
	float3 sColor = SoftLight( diffContrib * 0.75f, Color);
	
	//�ʓx�擾
	float Imax,Imin;
	Imax = max(Color.r , max(Color.g , Color.b ));
	Imin = min(Color.r , min(Color.g , Color.b ));
	
	//HSV �ʓx
	float s = (Imax-Imin) / Imax;
	
	s = s/2.0f;
	s = pow(s,1.0f/0.5f);
	
	Color.rgb = lerp(sColor,mColor,s);

    // �X�y�L�����K�p
    Color.rgb += Specular;
    
    return Color;
}

// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
// �s�v�Ȃ��͍̂폜��
technique MainTec0 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(false, false, false);
        PixelShader  = compile ps_3_0 Basic_PS(false, false, false);
    }
}

technique MainTec1 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = false;
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(true, false, false);
        PixelShader  = compile ps_3_0 Basic_PS(true, false, false);
    }
}

technique MainTec2 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(false, true, false);
        PixelShader  = compile ps_3_0 Basic_PS(false, true, false);
    }
}

technique MainTec3 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = false;
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(true, true, false);
        PixelShader  = compile ps_3_0 Basic_PS(true, true, false);
    }
}

// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD���f���p�j
technique MainTec4 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(false, false, true);
        PixelShader  = compile ps_3_0 Basic_PS(false, false, true);
    }
}

technique MainTec5 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = true; 
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(true, false, true);
        PixelShader  = compile ps_3_0 Basic_PS(true, false, true);
    }
}

technique MainTec6 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(false, true, true);
        PixelShader  = compile ps_3_0 Basic_PS(false, true, true);
    }
}

technique MainTec7 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = true; 
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 Basic_VS(true, true, true);
        PixelShader  = compile ps_3_0 Basic_PS(true, true, true);
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// �Z���t�V���h�E�pZ�l�v���b�g

struct VS_ZValuePlot_OUTPUT {
    float4 Pos : POSITION;              // �ˉe�ϊ����W
    float4 ShadowMapTex : TEXCOORD0;    // Z�o�b�t�@�e�N�X�`��
};

// ���_�V�F�[�_
VS_ZValuePlot_OUTPUT ZValuePlot_VS( float4 Pos : POSITION )
{
    VS_ZValuePlot_OUTPUT Out = (VS_ZValuePlot_OUTPUT)0;

    // ���C�g�̖ڐ��ɂ�郏�[���h�r���[�ˉe�ϊ�������
    Out.Pos = mul( Pos, LightWorldViewProjMatrix );

    // �e�N�X�`�����W�𒸓_�ɍ��킹��
    Out.ShadowMapTex = Out.Pos;

    return Out;
}

// �s�N�Z���V�F�[�_
float4 ZValuePlot_PS( float4 ShadowMapTex : TEXCOORD0 ) : COLOR
{
    // R�F������Z�l���L�^����
    return float4(ShadowMapTex.z/ShadowMapTex.w,0,0,1);
}

// Z�l�v���b�g�p�e�N�j�b�N
technique ZplotTec < string MMDPass = "zplot"; > {
    pass ZValuePlot {
        AlphaBlendEnable = FALSE;
        VertexShader = compile vs_3_0 ZValuePlot_VS();
        PixelShader  = compile ps_3_0 ZValuePlot_PS();
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// �I�u�W�F�N�g�`��i�Z���t�V���h�EON�j

// �V���h�E�o�b�t�@�̃T���v���B"register(s0)"�Ȃ̂�MMD��s0���g���Ă��邩��
sampler DefSampler : register(s0) ;

struct BufferShadow_OUTPUT {
    float4 Pos      : POSITION;     // �ˉe�ϊ����W
    float4 ZCalcTex : TEXCOORD0;    // Z�l
    float2 Tex      : TEXCOORD1;    // �e�N�X�`��
    float3 Normal   : TEXCOORD2;    // �@��
    float3 Eye      : TEXCOORD3;    // �J�����Ƃ̑��Έʒu
    float2 SpTex    : TEXCOORD4;	 // �X�t�B�A�}�b�v�e�N�X�`�����W
    float4 Color    : COLOR0;       // �f�B�t���[�Y�F
    float4 WorldPos		: TEXCOORD5;
};

// ���_�V�F�[�_
BufferShadow_OUTPUT BufferShadow_VS(float4 Pos : POSITION, float3 Normal : NORMAL, float2 Tex : TEXCOORD0, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon)
{
    BufferShadow_OUTPUT Out = (BufferShadow_OUTPUT)0;
	//�������W�ۑ�
	Out.WorldPos = mul(Pos,WorldMatrix);
    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    Out.Pos = mul( Pos, WorldViewProjMatrix );
    
    // �J�����Ƃ̑��Έʒu
    Out.Eye = CameraPosition - mul( Pos, WorldMatrix );
    // ���_�@��
    Out.Normal = normalize( mul( Normal, (float3x3)WorldMatrix ) );
	// ���C�g���_�ɂ�郏�[���h�r���[�ˉe�ϊ�
    Out.ZCalcTex = mul( Pos, LightWorldViewProjMatrix );
    
    /*
    // �f�B�t���[�Y�F�{�A���r�G���g�F �v�Z
    Out.Color.rgb = AmbientColor;
    if ( !useToon ) {
        Out.Color.rgb += max(0,dot( Out.Normal, -LightDirection )) * DiffuseColor.rgb;
    }
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );
    */
    
    // �e�N�X�`�����W
    Out.Tex = Tex;
    
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�e�N�X�`�����W
        float2 NormalWV = mul( Out.Normal, (float3x3)ViewMatrix );
        Out.SpTex.x = NormalWV.x * 0.5f + 0.5f;
        Out.SpTex.y = NormalWV.y * -0.5f + 0.5f;
    }
    
    return Out;
}

// �s�N�Z���V�F�[�_
float4 BufferShadow_PS(BufferShadow_OUTPUT IN, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon) : COLOR
{
	
	//�����x�N�g���̐��K��
	float3 Eye = normalize(CameraPosition-IN.WorldPos);
	/*
	//�����}�b�v����
	IN.Tex = IN.Tex - Eye.xy * tex2D( HeightMapSamp, IN.Tex) * 0.001;
    */
	float Height = tex2D( HeightMapSamp, IN.Tex).r;
	
    //�@���}�b�v����
    float4 NormalColor = tex2D( NormalMapSamp, IN.Tex)*2;	
	NormalColor = NormalColor.rgba;
	NormalColor.a = 1;
	float3x3 tangentFrame = compute_tangent_frame(IN.Normal, Eye, IN.Tex);
	IN.Normal = normalize(mul(NormalColor - 1.0f, tangentFrame));
    IN.Normal = lerp(IN.Normal,mul(float3(0,0.5,-1),HeadMat),tex2D(ExNormalMapSamp,IN.Tex).r);
    // �X�y�L�����F�v�Z
    float3 HalfVector = normalize( Eye + -LightDirection );
    float3 Specular = pow( max(0,dot( HalfVector, normalize(IN.Normal) )), SpecularPower ) * SpecularColor;
    //return float4(IN.Normal,1);
    float4 Color = float4(1,1,1,MaterialDiffuse.a);
    float4 ShadowColor = float4(AmbientColor, Color.a);  // �e�̐F
    if ( useTexture ) {
        // �e�N�X�`���K�p
        float4 TexColor = tex2D( ObjTexSampler, IN.Tex );
        Color *= TexColor;
        ShadowColor *= TexColor;
    }
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�K�p
        float4 TexColor = tex2D(ObjSphareSampler,IN.SpTex);
        if(spadd) {
            Color.rgb += TexColor.rgb;
            ShadowColor.rgb += TexColor.rgb;
        } else {
            Color *= TexColor;
            ShadowColor *= TexColor;
        }
    }
    // �X�y�L�����K�p
    Color.rgb += Specular;
    
	//Z�e�N�X�`����蒼��
	float4 WP = IN.WorldPos;
	WP.xyz += IN.Normal*Height*0.1;
    
    IN.ZCalcTex = mul( WP, LightWorldViewProjMatrix );
    
    // �e�N�X�`�����W�ɕϊ�
    IN.ZCalcTex /= IN.ZCalcTex.w;
    float2 TransTexCoord;
    TransTexCoord.x = (1.0f + IN.ZCalcTex.x)*0.5f;
    TransTexCoord.y = (1.0f - IN.ZCalcTex.y)*0.5f;

    if( any( saturate(TransTexCoord) != TransTexCoord ) ) {
        // �V���h�E�o�b�t�@�O
        float comp = 1;
        float4 ans;
		if ( useToon ) {
            // �g�D�[���K�p
            comp = min(saturate(dot(IN.Normal,-LightDirection)*Toon),comp);
            //ShadowColor.rgb *= MaterialToon;
        }
        if(useToon){
			ans = ShadowColor * (comp+float4(MaterialToon,1)*(1-comp)) +  float4(Specular,0) * comp;
			
			float diffContrib = dot( normalize(IN.Normal) , -LightDirection) * 0.5 +0.5;
			
		    float RimPower = pow(max( 0.0f, dot( -normalize(IN.Eye), -LightDirection ) ),4);
		    float Rim = 1.0f - max( 0.0f, dot( normalize(IN.Normal),normalize(IN.Eye)) );
		    diffContrib += Rim*RimPower;
		    
		    diffContrib = pow(diffContrib,1.0f/0.75);
		    diffContrib = saturate(pow(diffContrib,2));
			diffContrib = tex2D(ToonSamp,diffContrib).r-0.2;
			diffContrib = pow(diffContrib,2);
			
			float3 shadow_work = float3(1,0.9,1);
			//return float4(shadow_work,1);
			//return ans*float4(shadow_work,1);
			//return float4(diffContrib,0,0,1);
			
			float3 mColor = diffContrib * (ans*shadow_work);
			//return float4(mColor,1);
			float3 sColor = SoftLight( diffContrib * 0.75f, lerp(ans,ans*shadow_work,1-diffContrib));
			//�ʓx�擾
			float Imax,Imin;
			Imax = max(ans.r , max(ans.g , ans.b ));
			Imin = min(ans.r , min(ans.g , ans.b ));
			
			//HSV �ʓx
			float s = (Imax-Imin) / Imax;
			
			s = s/2.0f;
			s = pow(s,5);
			ans.rgb = lerp(sColor,mColor,s);
			ans.rgb += pow(max(0,dot( normalize(IN.Normal), normalize(normalize(-normalize(IN.Eye) ) ))+0.75),2) * Color * 2;
			return saturate(ans);			
        }else{
       		ans = (EgColor + MaterialDiffuse * pow(dot(normalize(IN.Normal), -LightDirection ) *0.5+0.5,1/0.5));
       		ans = (ans*Color + float4(Specular,0))*comp + EgColor*Color*(1-comp);
        }
        
        
        return ans;
    } else {
        float comp = 0;
		float U = SoftShadowParam / SHADOWMAP_SIZE;
		float V = SoftShadowParam / SHADOWMAP_SIZE;
        if(parthf) {
            // �Z���t�V���h�E mode2
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
        } else {
            // �Z���t�V���h�E mode1
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,-V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,-V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,-V)).r , 0.0f)*SKII1-0.3f);
        }
        comp = 1-saturate(comp/9);
        if ( useToon ) {
            // �g�D�[���K�p
            comp = min(saturate(dot(IN.Normal,-LightDirection)*Toon),comp);
            //ShadowColor.rgb *= MaterialToon;
        }
        float4 ans;
        if(useToon){
			ans = ShadowColor * (comp+float4(MaterialToon,1)*(1-comp)) +  float4(Specular,0) * comp;
			
			float diffContrib = dot( normalize(IN.Normal) , -LightDirection) * 0.5 +0.5;
			
		    float RimPower = pow(max( 0.0f, dot( -normalize(IN.Eye), -LightDirection ) ),4);
		    float Rim = 1.0f - max( 0.0f, dot( normalize(IN.Normal),normalize(IN.Eye)) );
		    diffContrib += Rim*RimPower;
		    
		    diffContrib = pow(diffContrib,1.0f/0.75);
		    diffContrib = saturate(pow(diffContrib,2));
			diffContrib = tex2D(ToonSamp,diffContrib).r-0.2;
			diffContrib = pow(diffContrib,2);
			
			float3 shadow_work = float3(1,0.9,1);
			//return float4(shadow_work,1);
			//return ans*float4(shadow_work,1);
			//return float4(diffContrib,0,0,1);
			
			float3 mColor = diffContrib * (ans*shadow_work);
			//return float4(mColor,1);
			float3 sColor = SoftLight( diffContrib * 0.75f, lerp(ans,ans*shadow_work,1-diffContrib));
			//�ʓx�擾
			float Imax,Imin;
			Imax = max(ans.r , max(ans.g , ans.b ));
			Imin = min(ans.r , min(ans.g , ans.b ));
			
			//HSV �ʓx
			float s = (Imax-Imin) / Imax;
			
			s = s/2.0f;
			s = pow(s,5);
			ans.rgb = lerp(sColor,mColor,s);
			ans.rgb += pow(max(0,dot( normalize(IN.Normal), normalize(normalize(-normalize(IN.Eye) ) ))+0.75),2) * Color * 2;
			return saturate(ans);			
        }else{
       		ans = (EgColor + MaterialDiffuse * pow(dot(normalize(IN.Normal), -LightDirection ) *0.5+0.5,1/0.5));
       		ans = (ans*Color + float4(Specular,0))*comp + EgColor*Color*(1-comp);
        }
        
        return ans;
    }
}

// ���_�V�F�[�_
BufferShadow_OUTPUT Edge_VS(float4 Pos : POSITION, float3 Normal : NORMAL, float2 Tex : TEXCOORD0, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon)
{
    BufferShadow_OUTPUT Out = (BufferShadow_OUTPUT)0;
    // �J�����Ƃ̑��Έʒu
    Out.Eye = CameraPosition - mul( Pos, WorldMatrix );
	Pos.xyz += normalize(Normal)*length(Out.Eye)*EdgeSize;
    // �J�������_�̃��[���h�r���[�ˉe�ϊ�
    Out.Pos = mul( Pos, WorldViewProjMatrix );
    
    // ���_�@��
    Out.Normal = normalize( mul( Normal, (float3x3)WorldMatrix ) );
	// ���C�g���_�ɂ�郏�[���h�r���[�ˉe�ϊ�
    Out.ZCalcTex = mul( Pos, LightWorldViewProjMatrix );
    
    // �f�B�t���[�Y�F�{�A���r�G���g�F �v�Z
    Out.Color.rgb = AmbientColor;
    if ( !useToon ) {
        Out.Color.rgb += max(0,dot( Out.Normal, -LightDirection )) * DiffuseColor.rgb;
    }
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );
    // �e�N�X�`�����W
    Out.Tex = Tex;
    
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�e�N�X�`�����W
        float2 NormalWV = mul( Out.Normal, (float3x3)ViewMatrix );
        Out.SpTex.x = NormalWV.x * 0.5f + 0.5f;
        Out.SpTex.y = NormalWV.y * -0.5f + 0.5f;
    }
    
    return Out;
}
// �s�N�Z���V�F�[�_
float4 Edge_PS(BufferShadow_OUTPUT IN, uniform bool useTexture, uniform bool useSphereMap, uniform bool useToon) : COLOR
{
	IN.Color.a *= 0.9;
    float4 Color = IN.Color;
    float4 ShadowColor = float4(AmbientColor, Color.a);  // �e�̐F
	Color.rgb = clamp(Color.rgb,0,0.95);
	ShadowColor.rgb = clamp(ShadowColor.rgb,0,0.95);
   
    if ( useTexture ) {
        // �e�N�X�`���K�p
        float4 TexColor = tex2D( ObjTexSampler, IN.Tex );
        Color *= TexColor;
        ShadowColor *= TexColor;
    }
    if ( useSphereMap ) {
        // �X�t�B�A�}�b�v�K�p
        float4 TexColor = tex2D(ObjSphareSampler,IN.SpTex);
        
        if(spadd) {
            Color.rgb += TexColor.rgb;
            ShadowColor.rgb += TexColor.rgb;
        } else {
            Color.rgb *= TexColor.rgb;
            ShadowColor.rgb *= TexColor.rgb;
        }
    }
    
	float work = saturate(dot( IN.Normal, LightDirection ));
	work = pow(saturate(work*1.5),16);
	ShadowColor.rgb = lerp(ShadowColor,pow(ShadowColor,2),work);
	
	
	Color.rgb = pow(Color.rgb,EdgeShadow);
	ShadowColor.rgb = pow(ShadowColor.rgb,EdgeShadow);
	
    // �e�N�X�`�����W�ɕϊ�
    IN.ZCalcTex /= IN.ZCalcTex.w;
    float2 TransTexCoord;
    TransTexCoord.x = (1.0f + IN.ZCalcTex.x)*0.5f;
    TransTexCoord.y = (1.0f - IN.ZCalcTex.y)*0.5f;
    
    if( any( saturate(TransTexCoord) != TransTexCoord ) ) {
        // �V���h�E�o�b�t�@�O
        return Color;
    } else {
        float comp = 0;
		float U = SoftShadowParam / SHADOWMAP_SIZE;
		float V = SoftShadowParam / SHADOWMAP_SIZE;
        if(parthf) {
            // �Z���t�V���h�E mode2
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,0)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,-V)).r , 0.0f)*SKII2*TransTexCoord.y-0.3f);
        } else {
            // �Z���t�V���h�E mode1
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,0)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(0,-V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(-U,-V)).r , 0.0f)*SKII1-0.3f);
	        comp += saturate(max(IN.ZCalcTex.z-tex2D(DefSampler,TransTexCoord+float2(U,-V)).r , 0.0f)*SKII1-0.3f);
        }
        comp = 1-saturate(comp/9);
        if ( useToon ) {
            // �g�D�[���K�p
            comp = min(saturate(dot(IN.Normal,-LightDirection)*Toon*5),comp);
            ShadowColor.rgb *= MaterialToon;
        }
        
        float4 ans = lerp(ShadowColor, Color, comp);
        if( transp ) ans.a = 0.5f;
        return ans;
    }
}
// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
technique MainTecBS0  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, false, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, false, false);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}

technique MainTecBS1  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = false; 
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
			"Pass=DrawEdge;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, false, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, false, false);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}

technique MainTecBS2  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, true, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, true, false);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}

technique MainTecBS3  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = false; 
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
			"Pass=DrawEdge;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, true, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, true, false);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}

// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD���f���p�j
technique MainTecBS4  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, false, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, false, true);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}

technique MainTecBS5  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = true;
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
			"Pass=DrawEdge;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, false, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, false, true);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}

technique MainTecBS6  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, true, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, true, true);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}

technique MainTecBS7  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = true;
	string Script= 
		"RenderColorTarget0=UseMipmapObjectTexture;"
			"RenderDepthStencilTarget=DepthBuffer;"
				"ClearSetColor=ClearColor;"
				"ClearSetDepth=ClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
			"Pass=CreateMipmap;"
		"RenderColorTarget0=;"
			"RenderDepthStencilTarget=;"
			"Pass=DrawObject;"
			"Pass=DrawEdge;"
		;
 > {
	pass CreateMipmap < string Script= "Draw=Buffer;"; > {
		AlphaBlendEnable = FALSE;
		ZEnable = FALSE;
		VertexShader = compile vs_3_0 VS_MipMapCreater();
		PixelShader  = compile ps_3_0 PS_MipMapCreater();
	}
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, true, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, true, true);
    }
    pass DrawEdge {
    	CULLMODE = CW;
        VertexShader = compile vs_3_0 Edge_VS(true, false, true);
        PixelShader  = compile ps_3_0 Edge_PS(true, false, true);
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
