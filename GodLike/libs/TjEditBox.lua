
--
--  TjEditBox.lua
--    by Tuhljin
--

--[[
When used with TjOptions:

Version 0.40 or later of TjOptions is required for full functionality. Make sure that TjOptions.lua is included in your
TOC or XML file BEFORE TjEditBox.lua.

Two new item types are registered, "editbox" and "editboxwhite". The latter is simply a preconfigured "editbox" - set by
default to use a white label positioned to the left.

Item Fields - editbox:

  All of the fields listed below are optional. Note that the standard "text" field is used to create a label, not the
  text in the box.

  width         Number. Width of the edit box. Defaults to 140.
  height        Number. Height of the edit box. Defaults to 16.
  font          String or boolean. The font to use for the label, such as "GameFontNormalLeftRed". If not a string and
                it evaluates to true, "GameFontHighlight" is used. Defaults to "GameFontNormal".
  textOnLeft    Boolean. If true, the label is placed to the left of the edit box instead of above it.
  textWidth     Number. If used, the label is given a set width. Useful for labels placed to the left, especially when
                multiple edit boxes are in use and you want their X-positions aligned.
  justifyH      String. The horizontal justification of the label's text (such as "RIGHT"). (Aligned to the left by
                default.)

  For commit system:

  useCommits    Boolean. If true, the TjEditBox commit system is used, meaning the variable associated with the item
                does not change until a commit (and OnChange functions aren't called except on a commit), instead of
                happening every time the text changes (such as when the player is in the middle of typing something).
  pattern       String. If this is defined and the edit box uses the commit system, then commits are only allowed when
                the text matches the given pattern (as patterns used by functions like strfind()).
  validateFunc  Function. If this is defined and the commit system is used, this function is called to query whether
                it's okay to commit. It is passed the edit box frame and its current text as arguments, in that order.
                It should return true when it is okay to commit. If the "pattern" field is also used, then the pattern
                is checked against first; only if it passes that check is the function called. The function can also
                optionally return a second value, a string; if it does, and the first return is true, then the string
                replaces that currently given in the edit box and is then committed. (The text is only changed on an
                attempted commit, not when used as the "button" field indicates, below.)
  commitFailed  Function. This is called when a commit attempt fails because the text was considered invalid due to the
                associated "pattern" or "validateFunc" fields. It is passed the edit box frame as the first argument and
                the text which was deemed invalid as the second.
  OnTextChanged Function. This is called when the text of the edit box changes. This is useful when the commit system
                is used because it lets you examine the text of the edit box when it isn't being committed. It is
                passed the edit box frame, but note that it doesn't pass its current text. Use the GetText() method
                if it is needed.
  button        String. If defined, then a button with the given text is created next to the edit box. If the commit
                system is used, then a commit is attempted when it is clicked. If the "pattern" or "validateFunc" fields
                are used, then the button is automatically enabled/disabled based on whether the current text is
                considered valid.
--]]


local THIS_VERSION = 0.12

if (not TjEditBox or TjEditBox.Version < THIS_VERSION) then
  TjEditBox = TjEditBox or {}
  local TjEditBox = TjEditBox
  TjEditBox.Version = THIS_VERSION

  TjEditBox.boxEnabled = TjEditBox.boxEnabled or {}
  local boxEnabled = TjEditBox.boxEnabled

  TjEditBox.commitFuncs = TjEditBox.commitFuncs or {}
  local commitFuncs = TjEditBox.commitFuncs
  TjEditBox.committed = TjEditBox.committed or {}
  local committed = TjEditBox.committed
  TjEditBox.patterns = TjEditBox.patterns or {}
  local patterns = TjEditBox.patterns
  TjEditBox.validateFuncs = TjEditBox.validateFuncs or {}
  local validateFuncs = TjEditBox.validateFuncs
  TjEditBox.commitFailFuncs = TjEditBox.commitFailFuncs or {}
  local commitFailFuncs = TjEditBox.commitFailFuncs

  local FocusLost_revert, DoNotCommit


  local function TextOkay(self, val)
    if (committed[self] ~= nil) then
      val = val or self:GetText()
      local pattern, func = patterns[self], validateFuncs[self]
      if (pattern and not strfind(val, pattern)) then
        return false
      elseif (func) then
        local okay, newtext = func(self, val)
        if (not okay) then
          return false
        end
        return true, newtext
      end
    end
    return true
  end

  local function TryClearFocus(self)
    if (self.editbox) then
      self = self.editbox
      if (committed[self] == nil) then  return;  end
    end
    local val = self:GetText()
    local okay, newtext = TextOkay(self, val)
    if (okay) then
      self:Commit(newtext or val)
      DoNotCommit = true
      if (newtext) then  self:SetText(newtext);  end
      self:ClearFocus()
      DoNotCommit = nil
    else
      self:HighlightText()
      local func = commitFailFuncs[self]
      if (func) then  func(self, val);  end
    end
  end

  local function ClearFocusAndRevert(self)
    FocusLost_revert = true
    self:ClearFocus()
    FocusLost_revert = nil
  end

  local function FocusLost(self)
    if (FocusLost_revert) then
      TjEditBox.RevertToCommit(self)
    else
      TjEditBox.Commit(self)
    end
  end
  
  local function CheckBtnState(self)
    if (self:IsEnabled() and TextOkay(self)) then
      self.button:Enable()
    else
      self.button:Disable()
    end
  end


-- API
---------

  function TjEditBox.Create(name, parent)
    if (name and type(name) ~= "string") then
      error("Invalid arg(s). Usage: TjEditBox.Create(string/nil name, parent)")
    end

    local num = (TjEditBox.NumCreated or 0) + 1
    name = name or "TjEditBox_Num"..num
    local editbox = CreateFrame("EditBox", name, parent, "InputBoxTemplate")
    TjEditBox.NumCreated = num
    boxEnabled[editbox] = true
    editbox:SetAutoFocus(false)

    -- Functions to call in the fashion of myEditBox:<func>(<args>)
    editbox.IsEnabled = TjEditBox.IsEnabled
    editbox.Disable = TjEditBox.Disable
    editbox.Enable = TjEditBox.Enable
    editbox.SetLabel = TjEditBox.SetLabel
    editbox.SetOnCommit = TjEditBox.SetOnCommit

    return editbox
  end

  function TjEditBox.CreateButton(name, editbox, text)
    if ( (name ~= nil and type(name) ~= "string") or (text and type(text) ~= "string") ) then
      error("Invalid arg(s). Usage: TjEditBox.CreateButton(string/nil name, frame editbox, string/nil text)")
    elseif (boxEnabled[editbox] == nil) then
      error("TjEditBox.CreateButton(): Bad argument #2; must be an edit box created by TjEditBox.Create().")
    end
    assert(not editbox.button, "TjEditBox.CreateButton(): Given edit box already has a button.")
    text, name = text or "", name or editbox:GetName().."Button"
    local button = CreateFrame("Button", name, editbox, "UIPanelButtonTemplate") --GameMenuButtonTemplate
    button.editbox, editbox.button = editbox, button
    button:SetPoint("LEFT", editbox, "RIGHT", 3, 0)
    button:SetScript("OnClick", TryClearFocus)
    button:SetText(text)
    local w = _G[name.."Text"]:GetWidth()
    button:SetWidth(w + 16)
    button:SetHeight(20)
    editbox:HookScript("OnTextChanged", CheckBtnState)
  end

  function TjEditBox.IsEnabled(self)
    return boxEnabled[self]
  end

  function TjEditBox.Disable(self)
    boxEnabled[self] = false
    self:EnableMouse(false)
    ClearFocusAndRevert(self)
    local r, g, b = GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b
    self:SetTextColor(r, g, b)
    if (self.label) then
      self.label:SetVertexColor(r, g, b)
    end
    if (self.button) then  self.button:Disable();  end
  end

  function TjEditBox.Enable(self)
    boxEnabled[self] = true
    self:EnableMouse(true)
    self:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
    if (self.label) then
      local colors = self.label.colors or NORMAL_FONT_COLOR
      self.label:SetVertexColor(colors.r , colors.g , colors.b)
    end
    if (self.button) then  CheckBtnState(self);  end
  end

  function TjEditBox.SetLabel(self, text, onLeft, font)
    if (type(text) ~= "string") then
      error("SetLabel(): Invalid argument. Expected string. Got "..type(text)..".")
    end
    if (not self.label) then
      font = type(font) == "string" and font or font and "GameFontHighlight" or "GameFontNormal"
      self.label = self:CreateFontString(nil, "ARTWORK", font)
      self.label:SetJustifyH("LEFT")
      if (not self:IsEnabled()) then
        self.label:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
      end
      if (font == "GameFontHighlight") then
        self.label.colors = HIGHLIGHT_FONT_COLOR
      elseif (font ~= "GameFontNormal") then
        local r, g, b = self.label:GetTextColor() -- There's no GetVertexColor for this object even though it has SetVertexColor.
        self.label.colors = { r = r, g = g, b = b }
      end
    end
    if (onLeft) then
      self.label:ClearAllPoints()
      self.label:SetPoint("RIGHT", self, "LEFT", -10, 0)
    else
      self.label:ClearAllPoints()
      self.label:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -7, 5)
    end
    self.label:SetText(text)
  end

  function TjEditBox.SetOnCommit(self, func)
    if (commitFuncs[self] == nil) then
      if (type(func) ~= "function") then  return;  end
      self:HookScript("OnEditFocusLost", FocusLost)
      self:HookScript("OnEnterPressed", TryClearFocus)
      self:SetScript("OnEscapePressed", ClearFocusAndRevert)
      self:SetScript("OnTextSet", TjEditBox.Commit)

      self.Commit = TjEditBox.Commit
      self.GetCommittedText = TjEditBox.GetCommittedText
      self.RevertToCommit = TjEditBox.RevertToCommit
      self.SetPattern = TjEditBox.SetPattern
      self.GetPattern = TjEditBox.GetPattern
      self.SetValidateFunc = TjEditBox.SetValidateFunc
      self.GetValidateFunc = TjEditBox.GetValidateFunc
      self.SetCommitFailFunc = TjEditBox.SetCommitFailFunc
      committed[self] = self:GetText()
    else
      func = type(func) == "function" and func or false
    end
    commitFuncs[self] = func
  end

  function TjEditBox.Commit(self, val)
  -- If SetOnCommit has been used, this can also be called as: myEditBox:Commit()
  -- If the val argument is used, checks to see whether this text is valid are skipped.
    if (DoNotCommit) then  return;  end
    local prev = committed[self]
    if (prev ~= nil) then
      if (not val) then
        val = self:GetText()
        if (prev == val) then  return;  end
        local okay, newtext = TextOkay(self, val)
        if (not okay) then
          local func = commitFailFuncs[self]
          if (func) then  func(self, val);  end
          return false
        elseif (newtext) then
          DoNotCommit = true
          self:SetText(newtext)
          DoNotCommit = nil
          val = newtext
        end
      end
      committed[self] = val
      local func = commitFuncs[self]
      if (func) then  func(self, val);  end
    end
  end

  function TjEditBox.GetCommittedText(self)
  -- If SetOnCommit has been used, this can also be called as: myEditBox:GetCommittedText()
    return committed[self]
  end

  function TjEditBox.RevertToCommit(self)
  -- If SetOnCommit has been used, this can also be called as: myEditBox:RevertToCommit()
    local prev = committed[self]
    if (prev ~= nil) then
      DoNotCommit = true
      self:SetText(prev or "")
      DoNotCommit = nil
    end
  end

  function TjEditBox.SetPattern(self, pattern)
  -- If SetOnCommit has been used, this can also be called as: myEditBox:SetPattern(pattern)
  -- Set the pattern to nil to no longer require a pattern match to commit.
    if (boxEnabled[self] ~= nil) then  -- Only usable on our edit boxes
      assert(not pattern or type(pattern) == "string", "Invalid arg. Usage: <obj>:SetPattern(string/nil pattern)")
      patterns[self] = pattern
    end
  end

  function TjEditBox.GetPattern(self)
  -- If SetOnCommit has been used, this can also be called as: myEditBox:GetPattern()
    return patterns[self]
  end

  function TjEditBox.SetValidateFunc(self, func)
  -- If SetOnCommit has been used, this can also be called as: myEditBox:SetValidateFunc(func)
  -- Set the pattern to nil to no longer require a pattern match to commit.
    if (boxEnabled[self] ~= nil) then  -- Only usable on our edit boxes
      assert(not func or type(func) == "function", "Invalid arg. Usage: <obj>:SetValidateFunc(function/nil func)")
      validateFuncs[self] = func
    end
  end

  function TjEditBox.GetValidateFunc(self)
  -- If SetOnCommit has been used, this can also be called as: myEditBox:GetValidateFunc()
    return validateFuncs[self]
  end

  function TjEditBox.SetCommitFailFunc(self, func)
  -- If SetCommitFailFunc has been used, this can also be called as: myEditBox:SetCommitFailFunc(func)
    if (boxEnabled[self] ~= nil) then  -- Only usable on our edit boxes
      assert(not func or type(func) == "function", "Invalid arg. Usage: <obj>:SetCommitFailFunc(function/nil func)")
      commitFailFuncs[self] = func
    end
  end


-- Register with TjOptions
-----------------------------

  if (TjOptions and TjOptions.RegisterItemType) then
    local function Item_TextChanged(self, value)
      TjOptions.ItemChanged(self, value or self:GetText())
    end

    local function CreateEditBoxItem(name, parent, data)
      local obj = TjEditBox.Create(name, parent)
      obj:SetWidth(data.width or 140)
      obj:SetHeight(data.height or 16)
      local x, y = 10, -7
      if (data.text) then
        obj:SetLabel(data.text, data.textOnLeft, data.font)
        if (data.textWidth) then  obj.label:SetWidth(data.textWidth);  end
        if (data.justifyH) then  obj.label:SetJustifyH(data.justifyH);  end
        if (data.textOnLeft) then
          x = x + obj.label:GetWidth() + 3
        else
          y = y - obj.label:GetHeight() - 3
        end
      end
      if (data.useCommits) then
        obj:SetOnCommit(Item_TextChanged)
        if (data.pattern) then  obj:SetPattern(data.pattern);  end
        if (data.validateFunc) then  obj:SetValidateFunc(data.validateFunc);  end
      else
        obj:HookScript("OnTextChanged", Item_TextChanged)
      end
      if (data.OnTextChanged) then  obj:HookScript("OnTextChanged", data.OnTextChanged);  end
      if (data.button) then  TjEditBox.CreateButton(nil, obj, data.button);  end
      if (data.commitFailed) then  obj:SetCommitFailFunc(data.commitFailed);  end
      return obj, true, x, y, 7, true
    end

    local function GetEditBoxVal(self)
      return self.GetCommittedText and self:GetCommittedText() or self:GetText()
    end

    local function SetEditBoxVal(self, val)
      self:SetText(val or "")
    end

    TjOptions.RegisterItemType("editbox", THIS_VERSION,
      { create = CreateEditBoxItem, getvalue = GetEditBoxVal, setvalue = SetEditBoxVal })

    local function CreateEditBoxItem_white(name, parent, data)
      if (data.font == nil) then  data.font = true;  end
      if (data.textOnLeft == nil) then  data.textOnLeft = true;  end
    end

    TjOptions.RegisterItemType("editboxwhite", THIS_VERSION, "editbox",
      { create_prehook = CreateEditBoxItem_white })
  end

end
