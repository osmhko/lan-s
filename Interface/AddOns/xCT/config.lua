local addon, ns=...
ns.config={
---------------------------------------------------------------------------------
-- use ["option"] = true/false, to set options.
-- options
-- blizz damage options.
	["blizzheadnumbers"] = true,	-- ʹ��blz��ʽ��ͷ�����ս����Ϣ
	["damagestyle"] = true,		-- �ı�Ĭ�ϵ�ս����Ϣ��ʽ����Ҫ����wow���ܿ���Ч��,�����Ҹо�����ֻ�Ǽ��˸�shadow����
-- xCT outgoing damage/healing options
	["damage"] = true,		-- ��ʾ�˺�
	["healing"] = true,		-- ��ʾ����
	["showhots"] = true,		-- ��ʾ��������
	["damagecolor"] = true,		-- ���˺�����Ⱦɫ
	["critprefix"] = "|cffFF0000 |r",	-- ����ǰ����
	["critpostfix"] = "|cffFF0000!|r",	-- ������������Ĭ��ֵΪ��ɫ
	["incomecritprefix"] = "|cffFF0000*|r", -- ���ܱ���ǰ������Ĭ��ֵΪ��ɫ"*"
	["incomecritpostfix"] = "|cffFF0000*|r", -- ���ܱ���������
	["icons"] = true,		-- ��ʾ�˺�ͼ��
	["iconsize"] = 22,		-- ͼ���С����Ϊ��ֵ��"auto"
	["petdamage"] = true,		-- ��ʾ�����˺�
	["dotdamage"] = true,		-- ��ʾ�����˺�
	["treshold"] = 1,		-- �˺���ʾ����
	["healtreshold"] = 1,		-- ������ʾ����

-- appearence
	["font"] = "Fonts\\FRIZQT__.TTF",	-- xCT������壬����Ĭ���˺�����Ϊ"Fonts\\Zykai_C.TTF"
	["fontsize"] = 18,					-- �����С
	["fontstyle"] = "OUTLINE",	-- ������ߣ���ѡֵΪ"OUTLINE", "MONOCHROME", "THICKOUTLINE", "OUTLINE,MONOCHROME", "THICKOUTLINE,MONOCHROME"
	["damagefont"] = "Fonts\\FRIZQT__.TTF",	 -- �޸�blzս����Ϣ����
	["damagefontsize"] = 15,	-- xCT�˺������С����Ϊ��ֵ��"auto"
	["critfix"] = 7,
	["timevisible"] = 3, 		-- �Զ���ʧʱ�䣬ԭ�����Ƽ���Ϊ3
	["scrollable"] = false,		-- ����ʹ�ù��ֹ���
	["maxlines"] = 64,		-- �����Ϣ��������Խ��ռ�ڴ�Խ��

-- justify messages in frames, valid values are "RIGHT" "LEFT" "CENTER" ���뷽ʽ��"RIGHT" "LEFT" "CENTER"�ֱ�Ϊ�Ҷ��롢����롢����
	["justify_1"] = "LEFT",		-- �����˺��Ķ��뷽ʽ
	["justify_2"] = "RIGHT",	-- �������ƵĶ��뷽ʽ
	["justify_3"] = "CENTER",	-- ������Ϣ������ŭ�����������⻷�������㣩�Ķ��뷽ʽ
	["justify_4"] = "RIGHT",	-- ����˺������ƵĶ��뷽ʽ
	["justify_5"] = "LEFT",		-- ��������Ķ��뷽ʽ

-- class modules and goodies
	["stopvespam"] = false,		-- �������밵Ӱ��̬���Զ��ر��������...��������Ч����?
	["dkrunes"] = true,		-- ��ʾdk���Ļָ�
	["mergeaoespam"] = true,	-- �ϲ�AOE
	["mergeaoespamtime"] = 0.1,	-- �ϲ�AOEʱ�����ƣ���СֵΪ0.1
	["killingblow"] = true,		-- �ڸ�����Ϣ�������"��ɱ����˭"����Ҫ["damage"] = true���ܹ���
	["dispel"] = true,		-- �ڸ�����Ϣ�������"����ɢ��ɶ"����Ҫ["damage"] = true���ܹ���
	["interrupt"] = true,		-- �ڸ�����Ϣ�������"������ɶ"����Ҫ["damage"] = true���ܹ���
}