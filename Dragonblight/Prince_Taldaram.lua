﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Prince Taldaram"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Taldaram",

	embracegain = "Embrace of the Vampyr Gained",
	embracegain_desc = "Announce when Prince Taldaram gains Embrace of the Vampyr.",
	embracegain_message = "Embrace of the Vampyr Gained",

	embracefade = "Embrace of the Vampyr Fades",
	embracefade_desc = "Announce when Embrace of the Vampyr fades from Prince Taldaram.",
	embracefade_message = "Embrace of the Vampyr Fades",

	embracebar = "Embrace of the Vampyr Bar",
	embracebar_desc = "Display a bar for the duration of Embrace of the Vampyr.",

	sphere = "Conjure Flame Sphere",
	sphere_desc = "Warn when Prince Taldaram begins conjuring a Flame Sphere.",
	sphere_message = "Conjuring Flame Sphere",
} end)

L:RegisterTranslations("deDE", function() return {
	embracegain = "Umarmung des Vampyrs Bekommen",
	embracegain_desc = "Meldet wenn Prinz Taldaram Umarmung des Vampyrs bekommt.",
	embracegain_message = "Umarmung des Vampyrs bekommen",

	embracefade = "Umarmung des Vampyrs Abgelaufen",
	embracefade_desc = "Meldet wenn Umarmung des Vampyrs von Prinz Taldaram schwindet.",
	embracefade_message = "Umarmung des Vampyrs Schwindet",

	embracebar = "Umarmung des Vampyrs Bar",
	embracebar_desc = "Zeigt eine Bar für die Dauer von Umarmung des Vampyrs.",

	sphere = "Flammensphäre beschwören",
	sphere_desc = "Warnt wenn Prinz Taldaram eine Flammensphäre beschwört.",
	sphere_message = "Beschwört Flammensphäre",
} end)

L:RegisterTranslations("frFR", function() return {
	embracegain = "Etreinte du vampire - Gain",
	embracegain_desc = "Prévient quand le Prince Taldaram gagne l'Etreinte du vampire.",
	embracegain_message = "Etreinte du vampire lancée",

	embracefade = "Etreinte du vampire - Fin",
	embracefade_desc = "Prévient quand Etreinte du vamprie disparait du Prince Taldaram.",
	embracefade_message = "Etreinte du vampire terminée",

	embracebar = "Etreinte du vampire - Barre",
	embracebar_desc = "Affiche une barre indiquant la durée de l'Etreinte du vampire.",

	sphere = "Invocation d'une sphère de flammes",
	sphere_desc = "Prévient quand le Prince Taldaram commence à invoquer une sphère de flammes.",
	sphere_message = "Invocation d'une sphère de flammes en cours",
} end)

L:RegisterTranslations("koKR", function() return {
	embracegain = "흡혈의 은총 획득",
	embracegain_desc = "공작 탈다람의 흡혈의 은총 획득을 알립니다.",
	embracegain_message = "흡혈의 은총 획득!",

	embracefade = "흡혈의 은총 사라짐",
	embracefade_desc = "공작 탈다람에게서 흡혈의 은총이 사라짐을 알립니다.",
	embracefade_message = "흡혈의 은총 사라짐",

	embracebar = "흡혈의 은총 바",
	embracebar_desc = "흡혈의 은총의 지속 시간바를 표시합니다.",

	sphere = "화염 구슬 소환",
	sphere_desc = "공작 탈다람의 화염 구슬 소환 시전을 알립니다.",
	sphere_message = "화염 구슬 소환!",
} end)

L:RegisterTranslations("zhCN", function() return {
} end)

L:RegisterTranslations("zhTW", function() return {
} end)

L:RegisterTranslations("esES", function() return {
} end)

L:RegisterTranslations("ruRU", function() return {
	embracegain = "Получение Объятия вампира",
	embracegain_desc = "Сообщать когда Принц Талдарам получает Объятие вампира.",
	embracegain_message = "Получено Объятие вампира",

	embracefade = "Рассеивание Объятия вампира",
	embracefade_desc = "Сообщать когда Объятие вампира спадает с Принца Талдарам.",
	embracefade_message = "Объятие вампира рассеелось",

	embracebar = "Полоса Объятия вампира",
	embracebar_desc = "Отображать полосу продолжительности Объятия вампира.",

	sphere = "Создание сферы огня",
	sphere_desc = "Предупреждать когда Принц Талдарам начинает Создание сферы огня.",
	sphere_message = "Создание сферы огня",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partycontent = true
mod.otherMenu = "Dragonblight"
mod.zonename = BZ["Ahn'kahet: The Old Kingdom"]
mod.enabletrigger = boss
mod.guid = 29308
mod.toggleoptions = {"embracegain","embracefade","embracebar",-1,"sphere","bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Embrace", 55959, 59513)
	self:AddCombatListener("SPELL_AURA_REMOVED", "EmbraceRemoved", 55959, 59513)
	self:AddCombatListener("SPELL_CAST_START", "Sphere", 55931)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Embrace(_, spellId, _, _, spellName)
	if self.db.profile.embracegain then
		self:IfMessage(L["embracegain_message"], "Important", spellId)
	end
	if self.db.profile.embracebar then
		self:Bar(spellName, 20, spellId)
	end
end

function mod:EmbraceRemoved(_, spellId, _, _, spellName)
	if self.db.profile.embracefade then
		self:IfMessage(L["embracefade_message"], "Important", spellId)
	end
	if self.db.profile.embracebar then
		self:TriggerEvent("BigWigs_StopBar", self, spellName)
	end
end

function mod:Sphere(_, spellId)
	if self.db.profile.sphere then
		self:IfMessage(L["sphere_message"], "Important", spellId)
	end
end