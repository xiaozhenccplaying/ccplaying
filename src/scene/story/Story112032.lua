--
-- Author: Kamirotto
-- Date: 2015-04-24 15:48:47
--
local BaseStory = require("scene.story.BaseStory")
local Story = class("story", BaseStory)

function Story:ctor( callback )

	--[[
		1、初始化场景
		2、初始化父类
		3、初始化 头像 和对话 message
		4、添加剧情事件
	--]]


    -- 1\


	-- SCREEN_WIDTH    SCREEN_HEIGHT

	-- GameCache.Avatar.Figure

	-- GameCache.Avatar.Name


	local tang_skins = {
		["Arm"] = 1042,
		["Hat"] = 1092,
		["Coat"] = 1052,
	}
    local tangseng = self:CreatePerson(SCREEN_WIDTH-450, 200, 1026, tang_skins)
	tangseng:setRotationSkewY(180)

	local wangmu_skins = {
		["Arm"] = 1036,
		["Hat"] = 1092,
		["Coat"] = 1066,
	}
	local wangmu = self:CreatePerson(SCREEN_WIDTH-380, 180, 1030, wangmu_skins)
	wangmu:setRotationSkewY(180)

    local wanjia = self:CreatePerson(150, 200, GameCache.Avatar.Figure)

	local koubi = self:CreateEmoji("dummy/koubi.png")

	local jingdai = self:CreateEmoji("dummy/jingdai.png")

	local qinqin = self:CreateEmoji("dummy/qinqin.png")


    -- 2\


    Story.super.ctor(self, callback)


    -- 3\


    local icon_tangseng = self:CreateIcon(1026, tang_skins)

	local icon_wangmu = self:CreateIcon(1030, wangmu_skins)

	local icon_wanjia = self:CreateIcon(GameCache.Avatar.Figure)


    self.message = {
		{icon = icon_wanjia, dir = 1, speak = GameCache.Avatar.Name .."", msg = "对了，话说你们有二郎神的电话对吧，快给我一个！"},
		{icon = icon_tangseng, dir = 2, speak = "唐僧", msg = "你找他有事么？我们刚才在那边那栋楼的楼顶看见过他。"},
		{icon = icon_wangmu, dir = 2, speak = "王母娘娘", msg = "是呀，我们刚刚从天庭下来时看见的，他和一个很杀马特的家伙在一起。"},
		{icon = icon_wanjia, dir = 1, speak = GameCache.Avatar.Name .."", msg = "从天庭下来…唐Boss，你搬上去住啦？"},
		{icon = icon_tangseng, dir = 2, speak = "唐僧", msg = "要你管…"},
    }


    self:AddInitEndEvent(function (  )
		tangseng:setVisible(true)
		wangmu:setVisible(true)
		wanjia:setVisible(true)

		tangseng:setAnimation(0, "idle", true)
		wangmu:setAnimation(0, "idle", true)
		wanjia:setAnimation(0, "move", true)

		local go = cc.MoveBy:create(0.5, cc.p(150,0))
		local event = cc.CallFunc:create(function()
			wanjia:setAnimation(0, "idle", true)
			self:WaitToDialog(0.2)
		end)
		wanjia:runAction(cc.Sequence:create({go,event}))
    end)


    self:AddDialogEndEvent(function ( eventname, hua )
        self.istouch = false
        self:DialogBoxVisible(false)

        if hua == self.message[1].msg then
			self:WaitToDialog(0.2)
			--local go = cc.MoveTo:create(2, cc.p(350,200))

			--local event = cc.CallFunc:create(function()
				--wanjia:setAnimation(0, "idle", true)
				--self:WaitToDialog(0.2)
			--end)

			--wanjia:runAction(cc.Sequence:create({go,event}))


		elseif hua == self.message[2].msg then
			self:WaitToDialog(0.2)


		elseif hua == self.message[3].msg then
			self:WaitToDialog(0.2)
			self:Emoji(wanjia, jingdai)


		elseif hua == self.message[4].msg then
			self:WaitToDialog(0.2)
			tangseng:setRotationSkewY(0)
			self:Emoji(tangseng, koubi)

			local delay = cc.DelayTime:create(1)

			local event = cc.CallFunc:create(function()
				self:Emoji(wangmu, qinqin)
			end)

			self:runAction(cc.Sequence:create({delay, event}))


		elseif hua == self.message[5].msg then
			--self:WaitToDialog(0.5)


		--elseif hua == self.message[6].msg then
            self:StoryEnd()
        end
    end)


	self:StoryBegin()

end


return Story
