
--
--  TjSlider.lua
--    by Tuhljin
--


local THIS_VERSION = 0.11

if (not TjSlider or TjSlider.Version < THIS_VERSION) then
  TjSlider = TjSlider or {}
  local TjSlider = TjSlider
  TjSlider.Version = THIS_VERSION

  TjSlider.ValueDisplay = TjSlider.ValueDisplay or {}
  local ValueDisplay = TjSlider.ValueDisplay


  local function ValueDisplayUpdate(self, value)
    local disp = ValueDisplay[self]
    if (disp) then
      if (type(disp) == "string") then
        self.valueDisplay:SetFormattedText(disp, value or self:GetValue())
      else
        disp(self, self.valueDisplay, value)
      end
    end
  end

  function TjSlider.Disable(self)
    getmetatable(self).__index.Disable(self)
    local r, g, b = GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
    self.text:SetVertexColor(r, g, b)
    self.low:SetVertexColor(r, g, b)
    self.high:SetVertexColor(r, g, b)
    if (self.valueDisplay) then
      self.valueDisplay:SetVertexColor(r, g, b)
    end
  end

  function TjSlider.Enable(self)
    getmetatable(self).__index.Enable(self)
    self.text:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b)
    local r, g, b = HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b
    self.low:SetVertexColor(r, g, b)
    self.high:SetVertexColor(r, g, b)
    if (self.valueDisplay) then
      self.valueDisplay:SetVertexColor(r, g, b)
    end
  end


-- API
---------

  function TjSlider.Create(name, parent, min, max, step)
    if ( (name and type(name) ~= "string") or (min and type(min) ~= "number") or (max and type(max) ~= "number") or
         (step and type(step) ~= "number") ) then
      error("Invalid arg(s). Usage: TjSlider.Create(string/nil name, parent, number/nil min, number/nil max, number/nil step)")
    end

    local num = (TjSlider.NumCreated or 0) + 1
    name = name or "TjSlider_Num"..num
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    TjSlider.NumCreated = num
    slider.text = _G[name.."Text"]
    slider.low = _G[name.."Low"]
    slider.high = _G[name.."High"]

    min, max, step = min or 0, max or 100, step or 1
    if (max < min) then  max = min;  end
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step)
    slider:SetValue(min)
    slider.text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)

    slider.Disable = TjSlider.Disable
    slider.Enable = TjSlider.Enable
    slider.SetText = TjSlider.SetText
    slider.SetValueDisplay = TjSlider.SetValueDisplay
    slider.GetValueDisplay = TjSlider.GetValueDisplay

    return slider
  end

  function TjSlider.SetText(self, label, low, high)
  -- Can also be called as: mySlider:SetText(label, low, high)
  -- To leave text how it is, pass false as the argument (not nil, since that's a valid value for the text).
    if (label ~= false) then  self.text:SetText(label);  end
    if (low ~= false) then  self.low:SetText(low);  end
    if (high ~= false) then  self.high:SetText(high);  end
  end

  function TjSlider.SetValueDisplay(self, disp, onRight)
  -- Can also be called as: mySlider:SetValueDisplay(disp)
  -- Set as nil or false to not display the current value. Set as true to simply show the value. Set as a string
  -- containing %s (or the like) to display the value in a formatted string.
    if (ValueDisplay[self] == nil) then
      if (not disp) then  return;  end
      self.valueDisplay = self:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
      self:HookScript("OnValueChanged", ValueDisplayUpdate)
      if (not self:IsEnabled()) then
        self.valueDisplay:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
      end
    end
    if (disp) then
      ValueDisplay[self] = (type(disp) == "string" or type(disp) == "function") and disp or "%s"
      self.valueDisplay:Show()
    else
      ValueDisplay[self] = false
      self.valueDisplay:Hide()
    end
    if (onRight) then
      self.valueDisplay:ClearAllPoints()
      self.valueDisplay:SetPoint("LEFT", self, "RIGHT", 8, 1)
    else
      self.valueDisplay:ClearAllPoints()
      self.valueDisplay:SetPoint("TOP", self, "BOTTOM", 0, 3)
    end
    ValueDisplayUpdate(self)
  end

  function TjSlider.GetValueDisplay(self)
  -- Can also be called as: mySlider:GetValueDisplay()
    return ValueDisplay[self]
  end


-- Register with TjOptions
-----------------------------

  if (TjOptions and TjOptions.RegisterItemType) then
    local function CreateSliderItem(name, parent, data)
      local obj = TjSlider.Create(name, parent, data.min, data.max, data.step)
      if (data.width) then  obj:SetWidth(data.width);  end
      if (data.height) then  obj:SetHeight(data.height);  end

      local text, low, high = data.text, data.textLow, data.textHigh
      obj:SetText(text, low, high)

      local disp, onRight = data.textValue, data.textValueOnRight
      if (disp) then  obj:SetValueDisplay(disp, onRight);  end

      obj:HookScript("OnValueChanged", TjOptions.ItemChanged)
      return obj, true, 7, text and -13 or -7, (low or high or (disp and not onRight)) and 15 or 6
    end

    local function GetSliderVal(self)
      return self:GetValue()
    end

    local function SetSliderVal(self, val)
      if (val) then  self:SetValue(val);  end
    end

    TjOptions.RegisterItemType("slider", THIS_VERSION,
      { create = CreateSliderItem, getvalue = GetSliderVal, setvalue = SetSliderVal })
  end

end
