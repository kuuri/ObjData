
   - mini mqo Viewer -

                Copyright (c) 2005 hheaven.


���X�V������
�@�Q����catmull-clark�ɑΉ�

�@mmc�Ɉȉ��̂��̂�ǉ����܂���
�@ @LayerdEnable,TRUE�@�@���߃��[�h�ŋN��
�@ @ReflashEnable,TRUE�@ ��ɍX�V�ŋN��
�@ @RollEnable,TRUE�@�@�@������]�ŋN��
�@���ʂɑΉ�
�@���s�ړ����������������̂ŏC��

�@mmViewer.cfg�� RButtonRange,5 ��ǉ� �E�N���b�N�̔��a���w�肵�܂�(pix)
�@�E�N���b�N�ƂŃR���e�L�X�g���j���[���J���悤�ɕύX
�@�R���e�L�X�g���j���[�Ɂu��ɍX�V�v��ǉ�
�@�@mmv_time�Ƃ��킹��uv�X�N���[���Ƃ��E�E�E
�@���s�ړ��̑��x���Ȃ�ƂȂ��A�h���b�O�ɂ��킹�Ă݂�
�@uniform int mmv_texture_enable; mmv_tex0�����݂���ꍇ !0
�@uniform int mmv_alpha_enable;   mmv_tex1�����݂���ꍇ !0
�@uniform int mmv_width;          �\���̈�̕�(pix)
�@uniform int mmv_height;         �\���̈�̍���(pix)
�@uniform int mmv_time;           �N�����Ă���̌o�ߎ���(ms)
�@mmv_tex0,mmv_tex1��2Pass�ȍ~����ɂȂ��Ă��Ȃ������̂��C���@�ق��ɂ��e���o�Ă�����

�@���͌��̈������������������̂��C���i���邭�Ȃ��Ă��j

�@�ݒ�t�@�C��.mmc��ǂݍ��ނ悤�ɂ��܂���
�@mqo�Ɠ������O��.mmc��ǂݍ��݂܂��B
�@ @BGColor,255,255,255 ��BG�̃J���[���ύX�ł��܂�
�@���C���[�\���̃v���Z�b�g���w��ł���悤�ɂ��܂����B
�@�@�v���Z�b�g������ꍇ����ɃE�C���h�E���o�܂�
�@�@��ԍ��̓f�t�H���g�̏��(mqo�Ŏw�肳�ꂽ���)�ł��@�e���L�[�ł��w���
�@�@�f�t�H���g�i�O�ԁj�������@�P�`�X�܂Ŏw��ł��܂�
   .mmc�Ŏw�肵�܂�
�@ @LayerPreset,obj1,1,0,2 �� obj1�̃��C���[��
�@ �v���Z�b�g_1�ł͕\��
   �v���Z�b�g_2�ł͔�\��
�@ �v���Z�b�g_3�ł͂O�ԂƓ����\���@�̎w��ɂȂ�܂�
�@ �����w�肵�ĂȂ��v���Z�b�g��2�ƂȂ�܂��B

�@�X�y�L�����̈�����2.3LE����2.4�������ɕύX

�@�E���h���b�O�ŃE�C���h�E�̊g��k��
�@BMP 1bit�Ή�
�@Susie Plugin(spi)�ɑΉ�
�@�@exe�Ɠ����t�H���_�ɒu���Ă���spi���g�p���܂�
�@�@spi�œǂ߂�f�[�^�̏ꍇspi�œǂ�ł��܂��̂�png��tga��32bit���g�������ꍇ�͒���
�@�@(spi�͊�{�I��24bit�̃f�[�^�ɂ��ĊJ���܂�)

�@�A�[�J�C�u�t�@�C�����Ƃr�r���B��Ȃ������̂��C��
�@�r�r�̃t�@�C������"name_�N���������b"�ɕύX

�@uniform int mmv_pass;�@��ǉ�
�@�@���݂̂�pass�ԍ��������Ă܂�
�@mms �� NextPass, FrontFace ��ǉ�
�@�@@FrontFace,CW �Ŗʂ̌��������]���܂�
�@NextPass���w�肷�邲�Ƃɕ`����P�񑝂₵�܂��B
�@�@@NextPass,COPY �Œ��OPass�̐ݒ肵���l�������p���܂�
�@�@@NextPass,NEW �ŐV�K�ݒ�ł�

�@@TexFilter,@ZWrite,@DepthTest,@AlphaTestEnable,@AlphaTest ���V�F�[�_�[���g���Ȃ�
�@�󋵂ł��K�p����悤�ύX�i@BlendMode �͓��߃��[�h�̗��݂ŕۗ��j
�@�e�N�X�`�����P�������\��Ȃ��ꍇ�J���[�}�b�v�݂̂ŕ\������悤�ɕύX
�@�@(OpenGL1.1�Ή��H)
�@mms �� AlphaTestEnable, AlphaTest ��ǉ�
�@�@@AlphaTestEnable,FALSE �ŃA���t�@�e�X�g�����s���܂���
�@�@@AlphaTest,GREATER,0.0 �Œʏ�̃A���t�@�e�X�g
�@�@NEVER, LESS, EQUAL, LEQUAL, GREATER, NOTEQUAL, ALWAYS
�@�@0.0�`1.0���w��\
�@�A���t�@�l��0�̏ꍇ�`������Ȃ��悤�ɕύX(2.4beta�d�l)
�@���ߕ\����tab�L�[�ŃA���t�@�l�t�v�����g�X�N���[��

�@�E�C���h�E��D&D�����ꍇ�A�����E�C���h�E�ɒǉ��ŕ\�������悤�ɂ��܂���
�@�g��Ȃ������������f�����[�h��J��
�@�e�N�X�`�������L���Ďg���悤�ɕύX

�@mms �� DepthTest ��ǉ�
�@�@@DepthTest,LESS �Œʏ�̂y�e�X�g
�@�@NEVER, LESS, EQUAL, LEQUAL, GREATER, NOTEQUAL, ALWAYS�@���w��\
�@���[�h�I�����[�̃t�H���_��exe��u���Ď��s�����ꍇ�����Ă����̂��C��

�@32bit tga �̃A���t�@�̈��������^�Z�R2.4beta�ȍ~�ɏ���

�@32bit tga�̓ǂݍ��݂��C��
�@mms �� BlendMode, ZWrite, TexFilter ��ǉ�
�@�@@BlendMode,ADD �ŉ��Z�\���ɂȂ�܂�
�@  @ZWrite,FALSE �ły�l���������܂Ȃ��悤�ɂȂ�܂�
�@  @TexFilter,NEAREST �Ńe�N�X�`���̃o�C���j�A�\�������Ȃ��悤�ɂȂ�܂�
�@�|�X�g�G�t�F�N�g�������������ǁA�C���^�[�t�F�[�X���܂Ƃ܂�Ȃ��̂Ŕ���J

�@�e�N�X�`�����Q���ȉ������\��Ȃ��{�[�h�ł̕s����C��
�@mmEncrypt �̈Í��t�@�C�� .mme�ɑΉ�
�@�J�����̏����ʒu�v�Z��ύX

�@�o�[�e�b�N�V�F�[�_�[���g���ăt���O�����g�V�F�[�_�[���g���Ȃ��{�[�h��
�@�V�F�[�_�̎g���Ȃ��{�[�h����ɏC��

�@���C�g�ړ��ǉ�
�@�o�[�W�����\���ǉ�
�@.mms mmViewer.cfg �̏����ύX
�@�i���̂Ƃ��Â��̂ł��������ǁA���̂����폜�\��j
�@�ڋ�Ԃ̃^���W�F���g�x�N�g����ǉ��i�v�Z�����������j
�@�V�F�[�_�[�̎g����}�V����glBlendFuncSeparate���g���悤�ɕύX

�@�Q�̗ݏ�T�C�Y�ȊO�̃e�N�X�`���Ή�
�@.exe�Ɠ����t�H���_��mmViewer.cfg�t�@�C����u���ƃA���`�G�C���A�X�\��
�@�i���܂̂Ƃ���t�@�C���ŉ@Radeon X300���Ɨ֊s�����������̂Ŕ�f�t�H���g�j

�@.mmz��.zip�t�@�C���Ƃ��ēǂݍ���
�@.zip�t�@�C���ɑΉ�
�@.net 2003�ɕύX

�@�R���X�^���g�Ή�
�@�}�e���A�����������Ȃ��Ȃ��Ă��̏C��

�@���_�J���[�Ή�
�@�V�F�[�_�[�̃G���[���f�o�b�O���O�ɏo��
�@���h���b�O��ύX
�@�����t�@�C���N��
�@���ڋN�����u�t�@�C�����J���v�_�C�A���O�\��
�@View��D&D�̋���
�@�V�F�[�_�[�I���������Â������̏C��
�@�����}���`�E�C���h�E��

�@bmp��x,y�T�C�Y���t�������̏C��
�@�񓧉ߎ��̃z�C������C��
�@GLSL�ɂ��V�F�[�_�[���g��EX���[�h�ǉ�(OpenGL 1.5)

�@�񓧉ߕ\�����f�t�H���g��
�@glBlendFuncSeparate�g���̃����@�ȑO�̏�����

�@Icon�ݒ�(Powered by ntny)

�@glBlendFuncSeparate(OpenGL 1.4) �ɕύX�@�g���Ȃ��h���C�o�͈ȑO�̂܂�
�@�f�o�b�N���O��exe�̃t�H���_�ɕύX debug_log.txt
�@��΃p�X�Ή�
�@�őO�ʂɕ\�����[�h
�@�񓧉߃��[�h
�@������]���[�h

�@jpg�Ή�
�@32bit24bit(RLE)Tga�Ή�
�@4bitbmp�C��

�@�����J�������C��
�@�o�͎��̃A���t�@�l���C���@�`�敉�ב���
�@�`�揇���C���@�ЂƂ̃I�u�W�F�N�g�ɂ܂Ƃ߂Ă�
�@�A���t�@�}�b�v�Ή��@(OpenGL 1.3)
�@8bit4bitbmp�C���@�C���f�b�N�X���Y���Ă�
�@���s�ړ��ύX

�@win2000�ȑO�͔񓧉߃��[�h�ŋN��
�@�E�_�u���N���b�N�ŏI��
�@8bit4bit bmp �ǉ�
�@��������s�ړ�
�@�E�C���h�E�g��k������ύX
�@�e�N�X�`���t�@�C�����N���[�Y���ĂȂ������̑Ώ��@�܂������� orz
�@�I�u�W�F�N�g��\���Ή�
�@�z�C�[���Ή�
�@�g��k�����상�^�Z�R����

�@�e�N�X�`����png�ǉ�
�@ctrl�Ŕ񃌃C���[�h�E�C���h�E�\��
�@C:\Documents and Settings\(���[�U�[��)\GlTest_log.txt �Ƀf�o�b�N���O�쐬
�@�G���[���b�Z�[�W�\��
�@�t���p�X�ɃX�y�[�X�������Ă�Ɠǂ߂Ȃ��̑Ώ�
�@�e�N�X�`���t�@�C�����N���[�Y���ĂȂ������̑Ώ�
�@�S�p�|���S���Ή�
�@

������̎d�l��
�@�e�N�X�`��
�@�@bmp 24bit8bit4bit1bit
�@�@tga 32bit24bit(RLE)
�@�@png
�@�@jpg

�@�@Susie Plugin�iexe�Ɠ����t�H���_��.spi��u���j


�����쁡

�@�N�����@
�@�@exe�� .mqo .zip .mme ��D&D

�@�I�����@
�@�@�^�X�N�o�[�E�N���b�N������
�@�@Alt+F4
�@�@���_�u���N���b�N������
�@�@�E�N���b�N������

�@���h���b�O�@�@�@�@�@�@�E�C���h�E�ړ�
�@�E�h���b�O�@�@�@�@�@�@��]
�@���h���b�O�@�@�@�@�@�@���s�ړ�
�@���E�h���b�O�i�㉺�j�@�g��k��
�@�z�C�[���@�@�@�@�@�@�@�g��k��
�@SHIFT+���h���b�O�@�@�@XZ�ړ�
�@SHIFT+�E�h���b�O�@�@�@Y�ړ�
�@CTRL+���h���b�O �@�@�@�E�C���h�E�g��k��
�@CTRL+�E�h���b�O �@�@�@���C�g�ړ�
�@CTRL�������@�@�@�@�@�@�񓧉ߕ\��

�@���_�u���N���b�N���j���[
�@�@�őO�ʕ\�����[�h�@�؂�ւ�
�@�@������]���[�h�@�@�؂�ւ�
�@�@���ߕ\�����[�h�@�@�؂�ւ�

�@�@�I��

 �@�X�N���[���V���b�g
 �@�@���ߕ\�����@�@�@�@tab


���e�`�p��
�@Q. �uOpenGL Ver. 1.?.?�v���ă��b�Z�[�W�{�b�N�X���o�ďI������
�@A. �h���C�o���}���`�e�N�X�`���ɑΉ����Ȃ��Ǝv���܂��B
�@�@ �ŐV�̃h���C�o����ꂽ�瓮���ꍇ����������Ȃ�������

  Q. �\������O�ɗ�����
  A. mmViewer.cfg��@MultiSample,16��@MultiSample,0�ɂ��Ă݂ĉ������B

  Q'.����ł�������
  A'.�䂰

�@Q. Radeon�ŃA���`�G�C���A�X�\�������������ł�
�@A. Radeon�̓��ɂ����A���`�G�C���A�X���|���Ă���Ȃ��炵���\�������������Ȃ�܂�
�@�@ ATI�ɕ��匾���Ă���ĉ������B


���̃\�t�g�̓]�ځE�z�z���͏펯�͈̔͂Ŏ��R�ɂ���Ă�����Ă��܂��܂���B
���̃\�t�g���g�p�������Ƃɂ�鑹�Q���ɍ�҂͈�ؕۏႢ�����܂���B


IconDesigen _ Powered by ntny

LICENSE
  libpng   Copyright (C) 1998-2001 Glenn Randers-Pehrson.
  libjpeg  Copyright (C) 1991-1998, Thomas G. Lane.
  zlib     Copyright (C) 1995-1998 Jean-loup Gailly and Mark Adler.
