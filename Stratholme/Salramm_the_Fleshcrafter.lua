﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Salramm the Fleshcrafter"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Salramm",

	flesh = "Twisted Flesh",
	flesh_desc = "Warn when someone has the Twisted Flesh curse.",

	fleshBar = "Twisted Flesh Bar",
	fleshBar_desc = "Show a bar for the duration of the Twisted Flesh curse.",

	flesh_message = "Twisted Flesh: %s",

	ghouls = "Summon Ghouls",
	ghouls_desc = "Warn when Salramm the Fleshcrafter summons ghouls.",
	ghouls_message = "Summoning Ghouls",
} end )

L:RegisterTranslations("koKR", function() return {
	flesh = "비틀린 살덩이",
	flesh_desc = "비틀린 살덩이의 저주에 걸린 플레이어를 알립니다.",

	fleshBar = "비틀린 살덩이 바",
	fleshBar_desc = "비틀린 살덩이의 저주가 지속되는 바를 표시합니다.",

	flesh_message = "비틀린 살덩이: %s",

	ghouls = "구울 소환",
	ghouls_desc = "살덩이창조자 살람의 구울 소환을 알립니다.",
	ghouls_message = "구울 소환",
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
	flesh = "扭曲血肉詛咒",
	flesh_desc = "當玩家中了扭曲血肉詛咒時發出警報。",

	fleshBar = "扭曲血肉詛咒計時條",
	fleshBar_desc = "當扭曲血肉詛咒持續時顯示計時條。",

	flesh_message = "扭曲血肉詛咒：>%s<！",

	ghouls = "召喚食屍鬼",
	ghouls_desc = "當『血肉工匠』塞歐朗姆召喚食屍鬼時發出警報。",
	ghouls_message = "召喚 食屍鬼！",
} end )

L:RegisterTranslations("deDE", function() return {
	flesh = "Verdorbenes Fleisch",
	flesh_desc = "Warnung wenn jemand vom Fluch des verdorbenen Fleisches betroffen ist.",

	fleshBar = "Verdorbenes Fleisch-Anzeige",
	fleshBar_desc = "Eine Leiste f\195\188r die Dauer des Fluchs des verdorbenen Fleisches anzeigen.",

	flesh_message = "Verdorbenes Fleisch: %s",

	ghouls = "Ghule beschw\195\182ren",
	ghouls_desc = "Warnung wenn Salramm der Fleischformer Ghule beschw\195\182rt.",
	ghouls_message = "Beschw\195\182rt Ghule!",	
} end )

L:RegisterTranslations("zhCN", function() return {
	flesh = "扭曲血肉诅咒",
	flesh_desc = "当玩家中了扭曲血肉诅咒时发出警报。",

	fleshBar = "扭曲血肉诅咒计时条",
	fleshBar_desc = "当扭曲血肉诅咒持续时显示计时条。",

	flesh_message = "扭曲血肉诅咒：>%s<！",

	ghouls = "召唤食尸鬼",
	ghouls_desc = "当塑血者沙尔拉姆召唤食尸鬼时发出警报。",
	ghouls_message = "召唤 食尸鬼！",
} end )

L:RegisterTranslations("ruRU", function() return {
	flesh = "Проклятие искаженной плоти",
	flesh_desc = "Предупреждать когда на кого либо накладывается проклятие искаженной плоти.",

	fleshBar = "Полоса искаженной плоти",
	fleshBar_desc = "Отображать полосу продолжительности проклятия искаженной плоти.",

	flesh_message = "Искаженная плоть: %s",

	ghouls = "Призывание вурдалаков",
	ghouls_desc = "Сообщает когда Салрамм Плоторез призывает вурдалаков.",
	ghouls_message = "Призывание вурдалаков!",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26530
mod.toggleoptions = {"flesh", "fleshBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Flesh", 58845)
	self:AddCombatListener("SPELL_AURA_REMOVED", "FleshRemoved", 58845)
	self:AddCombatListener("SPELL_CAST_START", "Ghouls", 52451)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Ghouls(_, spellId)
	if self.db.profile.ghouls then
		self:IfMessage(L["ghouls_message"], "Important", spellId)
	end
end

function mod:Flesh(player, spellId)
	if self.db.profile.flesh then
		self:IfMessage(L["flesh_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.fleshBar then
		self:Bar(L["flesh_message"]:format(player), 30, spellId)
	end
end

function mod:FleshRemove(player)
	if self.db.profile.fleshBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["flesh_message"]:format(player))
	end
end