class SaveLoadPanel extends MovieClip
{
    var List_mc, SaveLoadList_mc, bSaving, showCharacterBackHint, showingCharacterList, lastSelectedIndexMemory, uiSaveLoadManagerProcessedElements, uiSaveLoadManagerNumElementsToLoad, isForceStopping, ScreenshotLoader, iBatchSize, PlayerInfoText, __get__isSaving, iPlatform, ScreenshotHolder, ScreenShotRect_mc, __get__isShowingCharacterList, BackMouseButton, SelectMouseButton, CharacterSelectionHint_mc, BackGamepadButton, SelectGamepadButton, __get__platform, dispatchEvent, iScreenshotTimerID, ScreenshotRect, __set__isShowingCharacterList, __get__LastSelectedIndexMemory, __get__batchSize, __set__isSaving, __get__numSaves, __set__platform, __get__selectedEntry, __get__selectedIndex;
    function SaveLoadPanel()
    {
        super();
        gfx.events.EventDispatcher.initialize(this);
        SaveLoadList_mc = List_mc;
        bSaving = true;
        showCharacterBackHint = false;
        showingCharacterList = false;
        lastSelectedIndexMemory = 0;
        uiSaveLoadManagerProcessedElements = 0;
        uiSaveLoadManagerNumElementsToLoad = 0;
        isForceStopping = false;
    } // End of the function
    function onLoad()
    {
        ScreenshotLoader = new MovieClipLoader();
        ScreenshotLoader.addListener(this);
        gfx.io.GameDelegate.addCallBack("ConfirmOKToLoad", this, "onOKToLoadConfirm");
        gfx.io.GameDelegate.addCallBack("onSaveLoadBatchComplete", this, "onSaveLoadBatchComplete");
        gfx.io.GameDelegate.addCallBack("onFillCharacterListComplete", this, "onFillCharacterListComplete");
        gfx.io.GameDelegate.addCallBack("ScreenshotReady", this, "ShowScreenshot");
        SaveLoadList_mc.addEventListener("itemPress", this, "onSaveLoadItemPress");
        SaveLoadList_mc.addEventListener("selectionChange", this, "onSaveLoadItemHighlight");
        iBatchSize = SaveLoadList_mc.maxEntries;
        PlayerInfoText.createTextField("LevelText", PlayerInfoText.getNextHighestDepth(), 0, 0, 200, 30);
        PlayerInfoText.LevelText.text = "$Level";
        PlayerInfoText.LevelText._visible = false;
    } // End of the function
    function get isSaving()
    {
        return (bSaving);
    } // End of the function
    function set isSaving(abFlag)
    {
        bSaving = abFlag;
    } // End of the function
    function get isShowingCharacterList()
    {
        return showingCharacterList;
    } // End of the function
    function set isShowingCharacterList(abFlag)
    {
        showingCharacterList = abFlag;
        if (iPlatform != 3)
        {
            ScreenshotHolder._visible = !showingCharacterList;
            ScreenShotRect_mc._visible = !showingCharacterList;
        } // end if
        PlayerInfoText._visible = !showingCharacterList;
    } // End of the function
    function get selectedIndex()
    {
        return SaveLoadList_mc.selectedIndex;
    } // End of the function
    function get platform()
    {
        return iPlatform;
    } // End of the function
    function set platform(aiPlatform)
    {
        iPlatform = aiPlatform;
        if (iPlatform == SaveLoadPanel.CONTROLLER_PC)
        {
            BackMouseButton.SetPlatform(iPlatform);
            SelectMouseButton.SetPlatform(iPlatform);
            BackMouseButton.addEventListener("click", Shared.Proxy.create(this, OnBackClicked));
            SelectMouseButton.addEventListener("click", Shared.Proxy.create(this, OnSelectClicked));
            var _loc2 = SelectMouseButton.getBounds(this);
            SelectMouseButton._x = SelectMouseButton._x + (CharacterSelectionHint_mc._x - _loc2.xMin);
        }
        else
        {
            BackGamepadButton.SetPlatform(iPlatform);
            SelectGamepadButton.SetPlatform(iPlatform);
        } // end else if
        BackMouseButton._visible = SelectMouseButton._visible = iPlatform == SaveLoadPanel.CONTROLLER_PC;
        BackGamepadButton._visible = SelectGamepadButton._visible = iPlatform != SaveLoadPanel.CONTROLLER_PC;
        if (iPlatform == SaveLoadPanel.CONTROLLER_ORBIS)
        {
            ScreenshotHolder._visible = false;
            ScreenShotRect_mc._visible = false;
        } // end if
    } // End of the function
    function get batchSize()
    {
        return iBatchSize;
    } // End of the function
    function get numSaves()
    {
        return SaveLoadList_mc.length;
    } // End of the function
    function get selectedEntry()
    {
        return SaveLoadList_mc.entryList[SaveLoadList_mc.selectedIndex];
    } // End of the function
    function get LastSelectedIndexMemory()
    {
        if (lastSelectedIndexMemory > SaveLoadList_mc.__get__entryList().length - 1)
        {
            lastSelectedIndexMemory = Math.max(0, SaveLoadList_mc.__get__entryList().length - 1);
        } // end if
        return lastSelectedIndexMemory;
    } // End of the function
    function onSaveLoadItemPress(event)
    {
        lastSelectedIndexMemory = SaveLoadList_mc.selectedIndex;
        if (this.__get__isShowingCharacterList())
        {
            var _loc4 = SaveLoadList_mc.__get__entryList()[SaveLoadList_mc.__get__selectedIndex()];
            if (_loc4 != undefined)
            {
                if (iPlatform != 0)
                {
                    SaveLoadList_mc.__set__selectedIndex(0);
                } // end if
                var _loc3 = _loc4.flags;
                if (_loc3 == undefined)
                {
                    _loc3 = 0;
                } // end if
                var _loc2 = _loc4.id;
                if (_loc2 == undefined)
                {
                    _loc2 = 4294967295.000000;
                } // end if
                gfx.io.GameDelegate.call("CharacterSelected", [_loc2, _loc3, bSaving, SaveLoadList_mc.__get__entryList(), iBatchSize]);
                this.dispatchEvent({type: "OnCharacterSelected"});
            } // end if
        }
        else if (!bSaving)
        {
            gfx.io.GameDelegate.call("IsOKtoLoad", [SaveLoadList_mc.__get__selectedIndex()]);
        }
        else
        {
            this.dispatchEvent({type: "saveGameSelected", index: SaveLoadList_mc.__get__selectedIndex()});
        } // end else if
    } // End of the function
    function ShowSelectionButtons(show)
    {
        if (iPlatform == SaveLoadPanel.CONTROLLER_PC)
        {
            SelectMouseButton._visible = BackMouseButton._visible = show;
        }
        else
        {
            SelectGamepadButton._visible = BackGamepadButton._visible = show;
        } // end else if
    } // End of the function
    function onOKToLoadConfirm()
    {
        this.dispatchEvent({type: "loadGameSelected", index: SaveLoadList_mc.__get__selectedIndex()});
    } // End of the function
    function ForceStopLoading()
    {
        isForceStopping = true;
        if (uiSaveLoadManagerProcessedElements < uiSaveLoadManagerNumElementsToLoad)
        {
            gfx.io.GameDelegate.call("ForceStopSaveListLoading", []);
        } // end if
    } // End of the function
    function onSaveLoadItemHighlight(event)
    {
        if (isForceStopping)
        {
            return;
        } // end if
        if (iScreenshotTimerID != undefined)
        {
            clearInterval(iScreenshotTimerID);
            iScreenshotTimerID = undefined;
        } // end if
        if (ScreenshotRect != undefined)
        {
            ScreenshotRect.removeMovieClip();
            PlayerInfoText.textField.SetText(" ");
            PlayerInfoText.DateText.SetText(" ");
            PlayerInfoText.PlayTimeText.SetText(" ");
            ScreenshotRect = undefined;
        } // end if
        if (!this.__get__isShowingCharacterList())
        {
            if (event.index != -1)
            {
                iScreenshotTimerID = setInterval(this, "PrepScreenshot", SaveLoadPanel.SCREENSHOT_DELAY);
            } // end if
            this.dispatchEvent({type: "saveHighlighted", index: SaveLoadList_mc.__get__selectedIndex()});
        } // end if
    } // End of the function
    function PrepScreenshot()
    {
        clearInterval(iScreenshotTimerID);
        iScreenshotTimerID = undefined;
        if (bSaving)
        {
            gfx.io.GameDelegate.call("PrepSaveGameScreenshot", [SaveLoadList_mc.__get__selectedIndex() - 1, SaveLoadList_mc.__get__selectedEntry()]);
        }
        else
        {
            gfx.io.GameDelegate.call("PrepSaveGameScreenshot", [SaveLoadList_mc.__get__selectedIndex(), SaveLoadList_mc.__get__selectedEntry()]);
        } // end else if
    } // End of the function
    function ShowScreenshot()
    {
        ScreenshotRect = ScreenshotHolder.createEmptyMovieClip("ScreenshotRect", 0);
        ScreenshotLoader.loadClip("img://BGSSaveLoadHeader_Screenshot", ScreenshotRect);
        if (SaveLoadList_mc.__get__selectedEntry().corrupt == true)
        {
            PlayerInfoText.textField.SetText("$SAVE CORRUPT");
        }
        else if (SaveLoadList_mc.__get__selectedEntry().obsolete == true)
        {
            PlayerInfoText.textField.SetText("$SAVE OBSOLETE");
        }
        else if (SaveLoadList_mc.__get__selectedEntry().name != undefined)
        {
            var _loc2 = SaveLoadList_mc.__get__selectedEntry().name;
            var _loc3 = 20;
            if (_loc2.length > _loc3)
            {
                _loc2 = _loc2.substr(0, _loc3 - 3) + "...";
            } // end if
            if (SaveLoadList_mc.__get__selectedEntry().raceName != undefined && SaveLoadList_mc.__get__selectedEntry().raceName.length > 0)
            {
                _loc2 = _loc2 + (", " + SaveLoadList_mc.__get__selectedEntry().raceName);
            } // end if
            if (SaveLoadList_mc.__get__selectedEntry().level != undefined && SaveLoadList_mc.__get__selectedEntry().level > 0)
            {
                _loc2 = _loc2 + (", " + PlayerInfoText.LevelText.text + " " + SaveLoadList_mc.__get__selectedEntry().level);
            } // end if
            PlayerInfoText.textField.textAutoSize = "shrink";
            PlayerInfoText.textField.SetText(_loc2);
        }
        else
        {
            PlayerInfoText.textField.SetText(" ");
        } // end else if
        if (SaveLoadList_mc.__get__selectedEntry().playTime != undefined)
        {
            PlayerInfoText.PlayTimeText.SetText(SaveLoadList_mc.__get__selectedEntry().playTime);
        }
        else
        {
            PlayerInfoText.PlayTimeText.SetText(" ");
        } // end else if
        if (SaveLoadList_mc.__get__selectedEntry().dateString != undefined)
        {
            PlayerInfoText.DateText.SetText(SaveLoadList_mc.__get__selectedEntry().dateString);
        }
        else
        {
            PlayerInfoText.DateText.SetText(" ");
        } // end else if
    } // End of the function
    function onLoadInit(aTargetClip)
    {
        aTargetClip._width = ScreenshotHolder.sizer._width;
        aTargetClip._height = ScreenshotHolder.sizer._height;
    } // End of the function
    function onFillCharacterListComplete(abDoInitialUpdate)
    {
        this.__set__isShowingCharacterList(true);
        var _loc2 = 20;
        for (var _loc3 in SaveLoadList_mc.__get__entryList())
        {
            if (SaveLoadList_mc.__get__entryList()[_loc3].text.length > _loc2)
            {
                SaveLoadList_mc.__get__entryList()[_loc3].text = SaveLoadList_mc.__get__entryList()[_loc3].text.substr(0, _loc2 - 3) + "...";
            } // end if
        } // end of for...in
        SaveLoadList_mc.InvalidateData();
        if (iPlatform != 0)
        {
            this.onSaveLoadItemHighlight({index: this.__get__LastSelectedIndexMemory()});
            SaveLoadList_mc.__set__selectedIndex(LastSelectedIndexMemory);
            SaveLoadList_mc.UpdateList();
        } // end if
        this.dispatchEvent({type: "saveListCharactersPopulated"});
    } // End of the function
    function onSaveLoadBatchComplete(abDoInitialUpdate, aNumProcessed, aSaveCount)
    {
        var _loc2 = 20;
        uiSaveLoadManagerProcessedElements = aNumProcessed;
        uiSaveLoadManagerNumElementsToLoad = aSaveCount;
        for (var _loc3 in SaveLoadList_mc.__get__entryList())
        {
            if (iPlatform == SaveLoadPanel.CONTROLLER_ORBIS)
            {
                if (SaveLoadList_mc.__get__entryList()[_loc3].text == undefined)
                {
                    SaveLoadList_mc.__get__entryList().splice(_loc3, 1);
                } // end if
            } // end if
            if (SaveLoadList_mc.__get__entryList()[_loc3].text.length > _loc2)
            {
                SaveLoadList_mc.__get__entryList()[_loc3].text = SaveLoadList_mc.__get__entryList()[_loc3].text.substr(0, _loc2 - 3) + "...";
            } // end if
        } // end of for...in
        var _loc4 = "$[NEW SAVE]";
        if (bSaving && SaveLoadList_mc.__get__entryList()[0].text != _loc4)
        {
            var _loc5 = {name: " ", playTime: " ", text: _loc4};
            SaveLoadList_mc.__get__entryList().unshift(_loc5);
        }
        else if (!bSaving && SaveLoadList_mc.__get__entryList()[0].text == _loc4)
        {
            SaveLoadList_mc.__get__entryList().shift();
        } // end else if
        SaveLoadList_mc.InvalidateData();
        if (iPlatform == SaveLoadPanel.CONTROLLER_ORBIS)
        {
            lastSelectedIndexMemory = 0;
        } // end if
        if (abDoInitialUpdate)
        {
            isForceStopping = false;
            this.__set__isShowingCharacterList(false);
            if (iPlatform != 0)
            {
                this.onSaveLoadItemHighlight({index: this.__get__LastSelectedIndexMemory()});
                SaveLoadList_mc.__set__selectedIndex(LastSelectedIndexMemory);
                SaveLoadList_mc.UpdateList();
            } // end if
            this.dispatchEvent({type: "saveListPopulated"});
        }
        else if (!isForceStopping)
        {
            this.dispatchEvent({type: "saveListOnBatchAdded"});
        } // end else if
    } // End of the function
    function DeleteSelectedSave()
    {
        if (!bSaving || SaveLoadList_mc.__get__selectedIndex() != 0)
        {
            if (bSaving)
            {
                gfx.io.GameDelegate.call("DeleteSave", [SaveLoadList_mc.__get__selectedIndex() - 1]);
            }
            else
            {
                gfx.io.GameDelegate.call("DeleteSave", [SaveLoadList_mc.__get__selectedIndex()]);
            } // end else if
            SaveLoadList_mc.__get__entryList().splice(SaveLoadList_mc.__get__selectedIndex(), 1);
            SaveLoadList_mc.InvalidateData();
            this.onSaveLoadItemHighlight({index: SaveLoadList_mc.__get__selectedIndex()});
        } // end if
    } // End of the function
    function PopulateEmptySaveList()
    {
        trace ("PopulateEmptySaveList");
        SaveLoadList_mc.ClearList();
        SaveLoadList_mc.__get__entryList()().push(new Object());
        this.onSaveLoadBatchComplete(true, 0, 0);
    } // End of the function
    function OnSelectClicked()
    {
        this.onSaveLoadItemPress(null);
    } // End of the function
    function OnBackClicked()
    {
        this.dispatchEvent({type: "OnSaveLoadPanelBackClicked"});
    } // End of the function
    static var SCREENSHOT_DELAY = 750;
    static var CONTROLLER_PC = 0;
    static var CONTROLLER_PC_GAMEPAD = 1;
    static var CONTROLLER_DURANGO = 2;
    static var CONTROLLER_ORBIS = 3;
} // End of Class
