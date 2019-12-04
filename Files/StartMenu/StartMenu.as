import gfx.io.GameDelegate;
import gfx.ui.NavigationCode;
import gfx.managers.FocusHandler;
import Shared.GlobalFunc;

class StartMenu extends MovieClip
{
    var hasContinueButton, MainListHolder, MainList, SaveLoadPanel_mc, SaveLoadListHolder, DLCPanel, DLCList_mc, DeleteButton, DeleteSaveButton, ChangeUserButton, MarketplaceButton, CharacterSelectionHint, _parent, Logo_mc, GamerTagWidget_mc, GamerTag_mc, GamerIcon_mc, GamerIconSize, GamerIconLoader, ButtonRect, DeleteMouseButton, __get__currentState, VersionText, getNextHighestDepth, GamerIconRect, iPlatform, strCurrentState, __set__ShouldProcessInputs, shouldProcessInputs, __get__ShouldProcessInputs, SaveLoadConfirmText, __set__currentState, LoadingContentMessage, strFadeOutCallback, fadeOutParams, gotoAndPlay, iLoadDLCListTimerID, ConfirmPanel_mc, iLoadDLCContentMessageTimerID;
    function StartMenu()
    {
        super();
        hasContinueButton = false;
        MainList = MainListHolder.List_mc;
        SaveLoadListHolder = SaveLoadPanel_mc;
        DLCList_mc = DLCPanel.DLCList;
        DeleteSaveButton = DeleteButton;
        ChangeUserButton = ChangeUserButton;
        MarketplaceButton = DLCPanel.MarketplaceButton;
        MarketplaceButton._visible = false;
        CharacterSelectionHint = SaveLoadListHolder.CharacterSelectionHint_mc;
        this.ShowCharacterSelectionHint(false);
    } // End of the function
    function InitExtensions()
    {
        GlobalFunc.SetLockFunction();
        _parent.Lock("BR");
        Logo_mc.Lock("BL");
        Logo_mc._y = Logo_mc._y - 80;
        GamerTagWidget_mc.Lock("TL");
        GamerTag_mc = GamerTagWidget_mc.GamerTag_mc;
        GamerIcon_mc = GamerTagWidget_mc.GamerIcon_mc;
        GamerIconSize = GamerIcon_mc._width;
        GamerIconLoader = new MovieClipLoader();
        GamerIconLoader.addListener(this);
        GameDelegate.addCallBack("sendMenuProperties", this, "setupMainMenu");
        GameDelegate.addCallBack("ConfirmNewGame", this, "ShowConfirmScreen");
        GameDelegate.addCallBack("ConfirmContinue", this, "ShowConfirmScreen");
        GameDelegate.addCallBack("FadeOutMenu", this, "DoFadeOutMenu");
        GameDelegate.addCallBack("FadeInMenu", this, "DoFadeInMenu");
        GameDelegate.addCallBack("onProfileChange", this, "onProfileChange");
        GameDelegate.addCallBack("StartLoadingDLC", this, "StartLoadingDLC");
        GameDelegate.addCallBack("DoneLoadingDLC", this, "DoneLoadingDLC");
        GameDelegate.addCallBack("ShowGamerTagAndIcon", this, "ShowGamerTagAndIcon");
        GameDelegate.addCallBack("OnDeleteSaveUISanityCheck", this, "OnDeleteSaveUISanityCheck");
        GameDelegate.addCallBack("OnSaveDataEventLoadSUCCESS", this, "OnSaveDataEventLoadSUCCESS");
        GameDelegate.addCallBack("OnSaveDataEventLoadCANCEL", this, "OnSaveDataEventLoadCANCEL");
        GameDelegate.addCallBack("onStartButtonProcessFinished", this, "onStartButtonProcessFinished");
        MainList.addEventListener("itemPress", this, "onMainButtonPress");
        MainList.addEventListener("listPress", this, "onMainListPress");
        MainList.addEventListener("listMovedUp", this, "onMainListMoveUp");
        MainList.addEventListener("listMovedDown", this, "onMainListMoveDown");
        MainList.addEventListener("selectionChange", this, "onMainListMouseSelectionChange");
        ButtonRect.handleInput = function ()
        {
            return (false);
        };
        ButtonRect.AcceptMouseButton.addEventListener("click", this, "onAcceptMousePress");
        ButtonRect.CancelMouseButton.addEventListener("click", this, "onCancelMousePress");
        ButtonRect.AcceptMouseButton.SetPlatform(0, false);
        ButtonRect.CancelMouseButton.SetPlatform(0, false);
        SaveLoadListHolder.addEventListener("loadGameSelected", this, "ConfirmLoadGame");
        SaveLoadListHolder.addEventListener("saveListPopulated", this, "OnSaveListOpenSuccess");
        SaveLoadListHolder.addEventListener("saveListCharactersPopulated", this, "OnsaveListCharactersOpenSuccess");
        SaveLoadListHolder.addEventListener("saveListOnBatchAdded", this, "OnSaveListBatchAdded");
        SaveLoadListHolder.addEventListener("OnCharacterSelected", this, "OnCharacterSelected");
        SaveLoadListHolder.addEventListener("saveHighlighted", this, "onSaveHighlight");
        SaveLoadListHolder.addEventListener("OnSaveLoadPanelBackClicked", Shared.Proxy.create(this, OnSaveLoadPanelBackClicked));
        SaveLoadListHolder.List_mc.addEventListener("listPress", this, "onSaveLoadListPress");
        DeleteSaveButton._alpha = StartMenu.ALPHA_AVAILABLE;
        DeleteMouseButton._alpha = StartMenu.ALPHA_AVAILABLE;
        MarketplaceButton._alpha = StartMenu.ALPHA_DISABLED;
        DeleteSaveButton._x = -DeleteSaveButton.textField.textWidth - StartMenu.LOADING_ICON_OFFSET;
        DeleteMouseButton._x = DeleteSaveButton._x;
        ChangeUserButton._x = -ChangeUserButton.textField.textWidth - StartMenu.LOADING_ICON_OFFSET;
        DLCList_mc._visible = false;
        CharacterSelectionHint.addEventListener("OnMousePressCharacterChange", Shared.Proxy.create(this, OnMousePressCharacterChange));
    } // End of the function
    function setupMainMenu()
    {
        var _loc8 = 0;
        var _loc5 = 1;
        var _loc6 = 2;
        var _loc10 = 3;
        var _loc11 = 4;
        var _loc9 = 5;
        var _loc7 = 6;
        var _loc4 = StartMenu.NEW_INDEX;
        if (MainList.__get__entryList().length > 0)
        {
            _loc4 = MainList.__get__centeredEntry().index;
        } // end if
        MainList.ClearList();
        if (arguments[_loc5])
        {
            hasContinueButton = true;
            MainList.__get__entryList().push({text: "$CONTINUE", index: StartMenu.CONTINUE_INDEX, disabled: false});
            if (_loc4 == StartMenu.NEW_INDEX)
            {
                _loc4 = StartMenu.CONTINUE_INDEX;
            } // end if
        } // end if
        MainList.__get__entryList().push({text: "$NEW", index: StartMenu.NEW_INDEX, disabled: false});
        MainList.__get__entryList().push({text: "$LOAD", disabled: !arguments[_loc5], index: StartMenu.LOAD_INDEX});
        if (arguments[_loc11] == true)
        {
            MainList.__get__entryList().push({text: "$DOWNLOADABLE CONTENT", index: StartMenu.DLC_INDEX, disabled: false});
        } // end if
        if (arguments[_loc7])
        {
            MainList.__get__entryList().push({text: "$MOD MANAGER", disabled: false, index: StartMenu.MOD_INDEX});
        } // end if
        MainList.__get__entryList().push({text: "$CREDITS", index: StartMenu.CREDITS_INDEX, disabled: false});
        if (arguments[_loc8])
        {
            MainList.__get__entryList().push({text: "$QUIT", index: StartMenu.QUIT_INDEX, disabled: false});
        } // end if
        if (arguments[_loc9])
        {
            MainList.__get__entryList().push({text: "$HELP", index: StartMenu.HELP_INDEX, disabled: false});
        } // end if
        for (var _loc3 = 0; _loc3 < MainList.__get__entryList().length; ++_loc3)
        {
            if (MainList.__get__entryList()[_loc3].index == _loc4)
            {
                MainList.RestoreScrollPosition(_loc3, false);
            } // end if
        } // end of for
        MainList.InvalidateData();
        if (this.__get__currentState() == undefined)
        {
            if (arguments[_loc10])
            {
                this.StartState(StartMenu.PRESS_START_STATE);
            }
            else
            {
                this.StartState(StartMenu.MAIN_STATE);
            } // end else if
        }
        else if (this.__get__currentState() == StartMenu.SAVE_LOAD_STATE || this.__get__currentState() == StartMenu.SAVE_LOAD_CONFIRM_STATE || this.__get__currentState() == StartMenu.DELETE_SAVE_CONFIRM_STATE)
        {
            this.StartState(StartMenu.MAIN_STATE);
        } // end else if
        if (arguments[_loc6] != undefined)
        {
            VersionText.SetText("v " + arguments[_loc6]);
        }
        else
        {
            VersionText.SetText(" ");
        } // end else if
    } // End of the function
    function ShowGamerTagAndIcon(strGamerTag)
    {
        if (strGamerTag.length > 0)
        {
            GlobalFunc.MaintainTextFormat();
            GamerTag_mc.GamerTagText_tf.text = strGamerTag;
            GamerTag_mc.visible = true;
            GamerIconRect = GamerIcon_mc.createEmptyMovieClip("GamerIconRect", this.getNextHighestDepth());
            GamerIconLoader.loadClip("img://BGSUserIcon", GamerIconRect);
        }
        else
        {
            GamerTag_mc.visible = false;
            GamerIcon_mc.visible = false;
        } // end else if
    } // End of the function
    function onLoadInit(aTargetClip)
    {
        aTargetClip._width = GamerIconSize;
        aTargetClip._height = GamerIconSize;
    } // End of the function
    function OnDeleteSaveUISanityCheck(aHasRecentSave, aCanLoadGame)
    {
        var _loc7 = false;
        if (hasContinueButton)
        {
            if (!aHasRecentSave)
            {
                if (MainList.__get__entryList()[0].index == StartMenu.CONTINUE_INDEX)
                {
                    MainList.__get__entryList().shift();
                } // end if
                MainList.RestoreScrollPosition(1, true);
                _loc7 = true;
            } // end if
        } // end if
        if (!aCanLoadGame)
        {
            for (var _loc2 = 0; _loc2 < MainList.__get__maxEntries(); ++_loc2)
            {
                if (MainList.__get__entryList()[_loc2].index == StartMenu.LOAD_INDEX)
                {
                    MainList.__get__entryList().splice(_loc2, 1, {text: "$LOAD", disabled: true, index: StartMenu.LOAD_INDEX, textColor: 6316128});
                    _loc7 = true;
                    MainList.RestoreScrollPosition(0, false);
                    break;
                } // end if
            } // end of for
        } // end if
        if (_loc7)
        {
            MainList.InvalidateData();
        } // end if
    } // End of the function
    function ShowCharacterSelectionHint(abFlag)
    {
        if (iPlatform == StartMenu.PLATFORM_ORBIS)
        {
            CharacterSelectionHint._visible = false;
        }
        else
        {
            CharacterSelectionHint._visible = abFlag;
        } // end else if
    } // End of the function
    function OnSaveDataEventLoadSUCCESS()
    {
        this.ShowCharacterSelectionHint(false);
        if (iPlatform == StartMenu.PLATFORM_ORBIS)
        {
            this.onCancelPress();
        } // end if
    } // End of the function
    function OnSaveDataEventLoadCANCEL()
    {
        if (iPlatform == StartMenu.PLATFORM_ORBIS)
        {
            this.RequestCharacterListLoad();
        } // end if
    } // End of the function
    function get currentState()
    {
        return (strCurrentState);
    } // End of the function
    function set currentState(strNewState)
    {
        if (strNewState == StartMenu.MAIN_STATE)
        {
            MainList.__set__disableSelection(false);
        } // end if
        if (strNewState != strCurrentState)
        {
            this.__set__ShouldProcessInputs(true);
        } // end if
        if (iPlatform == StartMenu.PLATFORM_ORBIS)
        {
            this.ShowDeleteButtonHelp(strNewState == StartMenu.CHARACTER_SELECTION_STATE);
        }
        else
        {
            this.ShowDeleteButtonHelp(strNewState == StartMenu.SAVE_LOAD_STATE);
        } // end else if
        this.ShowChangeUserButtonHelp(strNewState == StartMenu.MAIN_STATE);
        this.ShowCharacterSelectionHint(strNewState == StartMenu.SAVE_LOAD_STATE);
        SaveLoadListHolder.ShowSelectionButtons(strNewState == StartMenu.SAVE_LOAD_STATE || strNewState == StartMenu.CHARACTER_SELECTION_STATE);
        strCurrentState = strNewState;
        this.ChangeStateFocus(strNewState);
        //return (this.currentState());
        null;
    } // End of the function
    function get ShouldProcessInputs()
    {
        return (shouldProcessInputs);
    } // End of the function
    function set ShouldProcessInputs(abFlag)
    {
        shouldProcessInputs = abFlag;
        //return (this.ShouldProcessInputs());
        null;
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        if (this.__get__currentState() == StartMenu.PRESS_START_STATE && iPlatform == StartMenu.PLATFORM_ORBIS)
        {
            if (GlobalFunc.IsKeyPressed(details))
            {
                GameDelegate.call("EndPressStartState", []);
            } // end if
        }
        else if (pathToFocus.length > 0 && !pathToFocus[0].handleInput(details, pathToFocus.slice(1)))
        {
            if (GlobalFunc.IsKeyPressed(details) && this.__get__ShouldProcessInputs())
            {
                if (details.navEquivalent == NavigationCode.ENTER)
                {
                    this.onAcceptPress();
                }
                else if (details.navEquivalent == NavigationCode.TAB)
                {
                    this.onCancelPress();
                }
                else if ((details.navEquivalent == NavigationCode.GAMEPAD_X || details.code == 88) && DeleteSaveButton._visible && DeleteSaveButton._alpha == StartMenu.ALPHA_AVAILABLE)
                {
                    if (iPlatform == StartMenu.PLATFORM_ORBIS)
                    {
                        var _loc5 = SaveLoadListHolder.__get__selectedEntry();
                        if (_loc5 != undefined)
                        {
                            var _loc4 = _loc5.flags;
                            if (_loc4 == undefined)
                            {
                                _loc4 = 0;
                            } // end if
                            var _loc3 = _loc5.id;
                            if (_loc3 == undefined)
                            {
                                _loc3 = 4294967295.000000;
                            } // end if
                        } // end if
                        GameDelegate.call("ORBISDeleteSave", [_loc3, _loc4]);
                    }
                    else
                    {
                        this.ConfirmDeleteSave();
                    } // end else if
                }
                else if ((details.navEquivalent == NavigationCode.GAMEPAD_Y || details.code == 84) && strCurrentState == StartMenu.SAVE_LOAD_STATE && !SaveLoadListHolder.__get__isSaving())
                {
                    GameDelegate.call("PlaySound", ["UIMenuCancel"]);
                    this.EndState();
                }
                else if (details.navEquivalent == NavigationCode.GAMEPAD_Y && this.__get__currentState() == StartMenu.DLC_STATE && MarketplaceButton._visible && MarketplaceButton._alpha == StartMenu.ALPHA_AVAILABLE)
                {
                    SaveLoadConfirmText.textField.SetText("$Open Xbox LIVE Marketplace?");
                    this.SetPlatform(iPlatform);
                    this.StartState(StartMenu.MARKETPLACE_CONFIRM_STATE);
                }
                else if (details.navEquivalent == NavigationCode.GAMEPAD_Y && this.__get__currentState() == StartMenu.MAIN_STATE && ChangeUserButton._visible)
                {
                    GameDelegate.call("ChangeUser", []);
                } // end else if
            } // end else if
        } // end else if
        return (true);
    } // End of the function
    function onMouseButtonDeleteSaveClick()
    {
        if (DeleteSaveButton._alpha == StartMenu.ALPHA_AVAILABLE)
        {
            this.ConfirmDeleteSave();
        } // end if
    } // End of the function
    function onMouseButtonDeleteRollOver()
    {
        GameDelegate.call("PlaySound", ["UIMenuFocus"]);
    } // End of the function
    function onStartButtonProcessFinished()
    {
        this.EndState(StartMenu.PRESS_START_STATE);
    } // End of the function
    function onAcceptPress()
    {
        switch (strCurrentState)
        {
            case StartMenu.MAIN_CONFIRM_STATE:
            {
                if (MainList.__get__selectedEntry().index == StartMenu.NEW_INDEX)
                {
                    GameDelegate.call("PlaySound", ["UIStartNewGame"]);
                    this.FadeOutAndCall("StartNewGame");
                }
                else if (MainList.__get__selectedEntry().index == StartMenu.CONTINUE_INDEX)
                {
                    GameDelegate.call("PlaySound", ["UIMenuOK"]);
                    this.FadeOutAndCall("ContinueLastSavedGame");
                }
                else if (MainList.__get__selectedEntry().index == StartMenu.QUIT_INDEX)
                {
                    GameDelegate.call("PlaySound", ["UIMenuOK"]);
                    GameDelegate.call("QuitToDesktop", []);
                } // end else if
                break;
            } 
            case StartMenu.CHARACTER_SELECTION_STATE:
            {
                GameDelegate.call("PlaySound", ["UIMenuOK"]);
                break;
            } 
            case StartMenu.SAVE_LOAD_CONFIRM_STATE:
            {
                GameDelegate.call("PlaySound", ["UIMenuOK"]);
                this.FadeOutAndCall("LoadGame", [SaveLoadListHolder.__get__selectedIndex()]);
                break;
            } 
            case StartMenu.DELETE_SAVE_CONFIRM_STATE:
            {
                SaveLoadListHolder.DeleteSelectedSave();
                if (SaveLoadListHolder.__get__numSaves() == 0)
                {
                    GameDelegate.call("DoDeleteSaveUISanityCheck", []);
                    this.StartState(StartMenu.MAIN_STATE);
                }
                else
                {
                    this.EndState();
                } // end else if
                break;
            } 
            case StartMenu.MARKETPLACE_CONFIRM_STATE:
            {
                GameDelegate.call("PlaySound", ["UIMenuOK"]);
                GameDelegate.call("OpenMarketplace", []);
                this.StartState(StartMenu.MAIN_STATE);
                break;
            } 
        } // End of switch
    } // End of the function
    function isConfirming()
    {
        return (strCurrentState == StartMenu.SAVE_LOAD_CONFIRM_STATE || strCurrentState == StartMenu.DELETE_SAVE_CONFIRM_STATE || strCurrentState == StartMenu.MARKETPLACE_CONFIRM_STATE || strCurrentState == StartMenu.MAIN_CONFIRM_STATE);
    } // End of the function
    function onAcceptMousePress()
    {
        if (this.isConfirming())
        {
            this.onAcceptPress();
        } // end if
    } // End of the function
    function OnMousePressCharacterChange(evt)
    {
        GameDelegate.call("PlaySound", ["UIMenuCancel"]);
        this.EndState();
    } // End of the function
    function onCancelMousePress()
    {
        if (this.isConfirming())
        {
            this.onCancelPress();
        } // end if
    } // End of the function
    function onCancelPress()
    {
        switch (strCurrentState)
        {
            case StartMenu.SAVE_LOAD_STATE:
            {
                this.__set__currentState(StartMenu.CHARACTER_SELECTION_STATE);
                this.EndState();
                SaveLoadListHolder.ForceStopLoading();
                break;
            } 
            case StartMenu.CHARACTER_SELECTION_STATE:
            case StartMenu.MAIN_CONFIRM_STATE:
            case StartMenu.SAVE_LOAD_CONFIRM_STATE:
            case StartMenu.DELETE_SAVE_CONFIRM_STATE:
            case StartMenu.DLC_STATE:
            case StartMenu.MARKETPLACE_CONFIRM_STATE:
            {
                GameDelegate.call("PlaySound", ["UIMenuCancel"]);
                this.EndState();
                break;
            } 
        } // End of switch
    } // End of the function
    function onMainButtonPress(event)
    {
        if (strCurrentState == StartMenu.MAIN_STATE || iPlatform == 0)
        {
            switch (event.entry.index)
            {
                case StartMenu.CONTINUE_INDEX:
                {
                    GameDelegate.call("CONTINUE", []);
                    GameDelegate.call("PlaySound", ["UIMenuOK"]);
                    break;
                } 
                case StartMenu.NEW_INDEX:
                {
                    GameDelegate.call("NEW", []);
                    GameDelegate.call("PlaySound", ["UIMenuOK"]);
                    break;
                } 
                case StartMenu.QUIT_INDEX:
                {
                    this.ShowConfirmScreen("$Quit to desktop?  Any unsaved progress will be lost.");
                    GameDelegate.call("PlaySound", ["UIMenuOK"]);
                    break;
                } 
                case StartMenu.LOAD_INDEX:
                {
                    if (!event.entry.disabled)
                    {
                        SaveLoadListHolder.__set__isSaving(false);
                        this.RequestCharacterListLoad();
                    }
                    else
                    {
                        GameDelegate.call("OnDisabledLoadPress", []);
                    } // end else if
                    break;
                } 
                case StartMenu.DLC_INDEX:
                {
                    this.StartState(StartMenu.DLC_STATE);
                    break;
                } 
                case StartMenu.CREDITS_INDEX:
                {
                    this.FadeOutAndCall("OpenCreditsMenu");
                    break;
                } 
                case StartMenu.HELP_INDEX:
                {
                    GameDelegate.call("HELP", []);
                    GameDelegate.call("PlaySound", ["UIMenuOK"]);
                    break;
                } 
                case StartMenu.MOD_INDEX:
                {
                    GameDelegate.call("MOD", []);
                    GameDelegate.call("PlaySound", ["UIMenuOK"]);
                    break;
                } 
                default:
                {
                    GameDelegate.call("PlaySound", ["UIMenuCancel"]);
                    break;
                } 
            } // End of switch
        } // end if
    } // End of the function
    function RequestCharacterListLoad()
    {
        GameDelegate.call("PopulateCharacterList", [SaveLoadListHolder.List_mc.entryList, SaveLoadListHolder.__get__batchSize()]);
        this.StartState(StartMenu.CHARACTER_LOAD_STATE);
    } // End of the function
    function onMainListPress(event)
    {
        this.onCancelPress();
    } // End of the function
    function onPCQuitButtonPress(event)
    {
        if (event.index == 0)
        {
            GameDelegate.call("QuitToMainMenu", []);
        }
        else if (event.index == 1)
        {
            GameDelegate.call("QuitToDesktop", []);
        } // end else if
    } // End of the function
    function onSaveLoadListPress()
    {
        this.onAcceptPress();
    } // End of the function
    function onMainListMoveUp(event)
    {
        GameDelegate.call("PlaySound", ["UIMenuFocus"]);
        if (event.scrollChanged == true)
        {
            MainList._parent.gotoAndPlay("moveUp");
        } // end if
    } // End of the function
    function onMainListMoveDown(event)
    {
        GameDelegate.call("PlaySound", ["UIMenuFocus"]);
        if (event.scrollChanged == true)
        {
            MainList._parent.gotoAndPlay("moveDown");
        } // end if
    } // End of the function
    function onMainListMouseSelectionChange(event)
    {
        if (event.keyboardOrMouse == 0 && event.index != -1)
        {
            GameDelegate.call("PlaySound", ["UIMenuFocus"]);
        } // end if
    } // End of the function
    function SetPlatform(aiPlatform, abPS3Switch)
    {
        ButtonRect.AcceptGamepadButton._visible = aiPlatform != 0;
        ButtonRect.CancelGamepadButton._visible = aiPlatform != 0;
        ButtonRect.AcceptMouseButton._visible = aiPlatform == 0;
        ButtonRect.CancelMouseButton._visible = aiPlatform == 0;
        var _loc4 = DeleteSaveButton._visible;
        if (aiPlatform == StartMenu.PLATFORM_PC_KBMOUSE)
        {
            DeleteSaveButton._visible = false;
            DeleteMouseButton.label = DeleteSaveButton.label;
            DeleteMouseButton._x = DeleteButton._x;
            DeleteMouseButton.trackAsMenu = true;
            DeleteSaveButton = DeleteMouseButton;
            DeleteSaveButton.onPress = Shared.Proxy.create(this, onMouseButtonDeleteSaveClick);
            DeleteSaveButton.addEventListener("rollOver", Shared.Proxy.create(this, onMouseButtonDeleteRollOver));
        }
        else if (aiPlatform == StartMenu.PLATFORM_PC_GAMEPAD && DeleteSaveButton == DeleteMouseButton)
        {
            DeleteSaveButton._visible = false;
            DeleteSaveButton = DeleteButton;
            DeleteSaveButton.onPress = undefined;
            DeleteMouseButton.removeEventListeners("rollOver", Shared.Proxy.create(this, onMouseButtonDeleteRollOver));
        }
        else
        {
            DeleteMouseButton._visible = false;
        } // end else if
        this.ShowDeleteButtonHelp(_loc4);
        DeleteSaveButton.SetPlatform(aiPlatform, abPS3Switch);
        ChangeUserButton.SetPlatform(aiPlatform, abPS3Switch);
        MarketplaceButton.SetPlatform(aiPlatform, abPS3Switch);
        MainListHolder.SelectionArrow._visible = aiPlatform != 0;
        if (aiPlatform != 0)
        {
            ButtonRect.AcceptGamepadButton.SetPlatform(aiPlatform, abPS3Switch);
            ButtonRect.CancelGamepadButton.SetPlatform(aiPlatform, abPS3Switch);
        } // end if
        CharacterSelectionHint.SetPlatform(aiPlatform);
        MarketplaceButton._visible = false;
        if (iPlatform == undefined)
        {
            DLCPanel.warningText.SetText("$Loading downloadable content..." + (iPlatform == StartMenu.PLATFORM_ORBIS ? ("_PS3") : ("")));
            LoadingContentMessage.Message_mc.textField.SetText("$Loading extra content." + (iPlatform == StartMenu.PLATFORM_ORBIS ? ("_PS3") : ("")));
        } // end if
        iPlatform = aiPlatform;
        SaveLoadListHolder.__set__platform(iPlatform);
        MainList.SetPlatform(aiPlatform, abPS3Switch);
    } // End of the function
    function DoFadeOutMenu()
    {
        this.FadeOutAndCall();
    } // End of the function
    function DoFadeInMenu()
    {
        _parent.gotoAndPlay("fadeIn");
        this.EndState();
    } // End of the function
    function FadeOutAndCall(strCallback, paramList)
    {
        strFadeOutCallback = strCallback;
        fadeOutParams = paramList;
        _parent.gotoAndPlay("fadeOut");
        GameDelegate.call("fadeOutStarted", []);
    } // End of the function
    function onFadeOutCompletion()
    {
        if (strFadeOutCallback != undefined && strFadeOutCallback.length > 0)
        {
            if (fadeOutParams != undefined)
            {
                GameDelegate.call(strFadeOutCallback, fadeOutParams);
            }
            else
            {
                GameDelegate.call(strFadeOutCallback, []);
            } // end if
        } // end else if
    } // End of the function
    function StartState(strStateName)
    {
        this.__set__ShouldProcessInputs(false);
        if (strStateName == StartMenu.CHARACTER_SELECTION_STATE)
        {
            SaveLoadListHolder.__set__isShowingCharacterList(true);
        }
        else if (strStateName == StartMenu.SAVE_LOAD_STATE)
        {
            SaveLoadListHolder.__set__isShowingCharacterList(false);
        }
        else if (strStateName == StartMenu.DLC_STATE)
        {
            this.ShowMarketplaceButtonHelp(false);
        } // end else if
        if (strCurrentState == StartMenu.MAIN_STATE)
        {
            MainList.__set__disableSelection(true);
        } // end if
        this.ShowDeleteButtonHelp(false);
        this.ShowChangeUserButtonHelp(false);
        SaveLoadListHolder.ShowSelectionButtons(false);
        strCurrentState = strStateName + StartMenu.START_ANIM_STR;
        this.gotoAndPlay(strCurrentState);
        FocusHandler.instance.setFocus(this, 0);
    } // End of the function
    function EndState()
    {
        if (strCurrentState == StartMenu.DLC_STATE)
        {
            this.ShowMarketplaceButtonHelp(false);
        } // end if
        if (strCurrentState != StartMenu.MAIN_STATE)
        {
            strCurrentState = strCurrentState + StartMenu.END_ANIM_STR;
            this.gotoAndPlay(strCurrentState);
        } // end if
        if (strCurrentState == StartMenu.SAVE_LOAD_CONFIRM_STATE || strCurrentState == StartMenu.DELETE_SAVE_CONFIRM_STATE)
        {
            SaveLoadListHolder.ShowSelectionButtons(true);
        } // end if
    } // End of the function
    function ChangeStateFocus(strNewState)
    {
        switch (strNewState)
        {
            case StartMenu.MAIN_STATE:
            {
                FocusHandler.instance.setFocus(MainList, 0);
                break;
            } 
            case StartMenu.CHARACTER_SELECTION_STATE:
            case StartMenu.SAVE_LOAD_STATE:
            {
                FocusHandler.instance.setFocus(SaveLoadListHolder.List_mc, 0);
                SaveLoadListHolder.List_mc.disableSelection = false;
                break;
            } 
            case StartMenu.DLC_STATE:
            {
                iLoadDLCListTimerID = setInterval(this, "DoLoadDLCList", 500);
                FocusHandler.instance.setFocus(DLCList_mc, 0);
                break;
            } 
            case StartMenu.MAIN_CONFIRM_STATE:
            case StartMenu.SAVE_LOAD_CONFIRM_STATE:
            case StartMenu.DELETE_SAVE_CONFIRM_STATE:
            case StartMenu.PRESS_START_STATE:
            case StartMenu.MARKETPLACE_CONFIRM_STATE:
            {
                FocusHandler.instance.setFocus(ButtonRect, 0);
                break;
            } 
        } // End of switch
    } // End of the function
    function ShowConfirmScreen(astrConfirmText)
    {
        ConfirmPanel_mc.textField.SetText(astrConfirmText);
        this.SetPlatform(iPlatform);
        this.StartState(StartMenu.MAIN_CONFIRM_STATE);
    } // End of the function
    function OnSaveListOpenSuccess()
    {
        if (SaveLoadListHolder.__get__numSaves() > 0 && strCurrentState.indexOf(StartMenu.SAVE_LOAD_STATE) == -1)
        {
            GameDelegate.call("PlaySound", ["UIMenuOK"]);
            this.StartState(StartMenu.SAVE_LOAD_STATE);
        }
        else
        {
            GameDelegate.call("PlaySound", ["UIMenuCancel"]);
        } // end else if
    } // End of the function
    function OnsaveListCharactersOpenSuccess()
    {
        if (strCurrentState == StartMenu.CHARACTER_LOAD_STATE || strCurrentState == "CharacterLoadStartAnim")
        {
            SaveLoadListHolder.__set__isShowingCharacterList(true);
            this.ShowCharacterSelectionHint(false);
            GameDelegate.call("PlaySound", ["UIMenuOK"]);
            this.StartState(StartMenu.CHARACTER_SELECTION_STATE);
        }
        else
        {
            GameDelegate.call("PlaySound", ["UIMenuCancel"]);
        } // end else if
    } // End of the function
    function OnSaveListBatchAdded()
    {
        if (SaveLoadListHolder.__get__numSaves() > 0 && strCurrentState == StartMenu.SAVE_LOAD_STATE)
        {
            this.ShowCharacterSelectionHint(true);
        } // end if
    } // End of the function
    function OnCharacterSelected()
    {
        if (iPlatform != StartMenu.PLATFORM_ORBIS)
        {
            this.StartState(StartMenu.SAVE_LOAD_STATE);
        } // end if
    } // End of the function
    function onSaveHighlight(event)
    {
        DeleteSaveButton._alpha = event.index == -1 ? (StartMenu.ALPHA_DISABLED) : (StartMenu.ALPHA_AVAILABLE);
        if (iPlatform == 0)
        {
            GameDelegate.call("PlaySound", ["UIMenuFocus"]);
        } // end if
    } // End of the function
    function ConfirmLoadGame(event)
    {
        SaveLoadListHolder.List_mc.disableSelection = true;
        SaveLoadConfirmText.textField.SetText("$Load this game?");
        this.SetPlatform(iPlatform);
        this.StartState(StartMenu.SAVE_LOAD_CONFIRM_STATE);
    } // End of the function
    function ConfirmDeleteSave()
    {
        SaveLoadListHolder.List_mc.disableSelection = true;
        SaveLoadConfirmText.textField.SetText("$Delete this save?");
        this.SetPlatform(iPlatform);
        this.StartState(StartMenu.DELETE_SAVE_CONFIRM_STATE);
    } // End of the function
    function ShowDeleteButtonHelp(abFlag)
    {
        DeleteSaveButton.__set__disabled(!abFlag);
        DeleteSaveButton._visible = abFlag;
        VersionText._visible = !abFlag;
    } // End of the function
    function ShowChangeUserButtonHelp(abFlag)
    {
        if (iPlatform == StartMenu.PLATFORM_DURANGO)
        {
            ChangeUserButton.__set__disabled(!abFlag);
            ChangeUserButton._visible = abFlag;
            VersionText._visible = !abFlag;
        }
        else
        {
            ChangeUserButton.__set__disabled(true);
            ChangeUserButton._visible = false;
        } // end else if
    } // End of the function
    function ShowMarketplaceButtonHelp(abFlag)
    {
        if (iPlatform == StartMenu.PLATFORM_DURANGO)
        {
            MarketplaceButton._visible = abFlag;
            VersionText._visible = !abFlag;
        }
        else
        {
            MarketplaceButton._visible = false;
        } // end else if
    } // End of the function
    function ShowPressStartState()
    {
        if (strCurrentState != StartMenu.PRESS_START_STATE)
        {
            this.StartState(StartMenu.PRESS_START_STATE);
        } // end if
    } // End of the function
    function StartLoadingDLC()
    {
        LoadingContentMessage.gotoAndPlay("startFadeIn");
        clearInterval(iLoadDLCContentMessageTimerID);
        iLoadDLCContentMessageTimerID = setInterval(this, "onLoadingDLCMessageFadeCompletion", 1000);
    } // End of the function
    function onLoadingDLCMessageFadeCompletion()
    {
        clearInterval(iLoadDLCContentMessageTimerID);
        GameDelegate.call("DoLoadDLCPlugins", []);
    } // End of the function
    function DoneLoadingDLC()
    {
        LoadingContentMessage.gotoAndPlay("startFadeOut");
    } // End of the function
    function DoLoadDLCList()
    {
        clearInterval(iLoadDLCListTimerID);
        DLCList_mc.__get__entryList().splice(0, DLCList_mc.__get__entryList().length);
        GameDelegate.call("LoadDLC", [DLCList_mc.__get__entryList()], this, "UpdateDLCPanel");
    } // End of the function
    function UpdateDLCPanel(abMarketplaceAvail, abNewDLCAvail)
    {
        if (DLCList_mc.__get__entryList().length > 0)
        {
            DLCList_mc._visible = true;
            DLCPanel.warningText.SetText(" ");
            if (iPlatform != 0)
            {
                DLCList_mc.__set__selectedIndex(0);
            } // end if
            DLCList_mc.InvalidateData();
        }
        else
        {
            DLCList_mc._visible = false;
            DLCPanel.warningText.SetText("$No content downloaded" + (iPlatform == StartMenu.PLATFORM_ORBIS ? ("_PS3") : ("")));
        } // end else if
        MarketplaceButton._visible = false;
        if (abNewDLCAvail == true)
        {
            DLCPanel.NewContentAvail.SetText("$New content available");
        } // end if
    } // End of the function
    function OnSaveLoadPanelSelectClicked()
    {
        this.onAcceptPress();
    } // End of the function
    function OnSaveLoadPanelBackClicked()
    {
        this.onCancelPress();
    } // End of the function
    static var PRESS_START_STATE = "PressStart";
    static var MAIN_STATE = "Main";
    static var MAIN_CONFIRM_STATE = "MainConfirm";
    static var CHARACTER_LOAD_STATE = "CharacterLoad";
    static var CHARACTER_SELECTION_STATE = "CharacterSelection";
    static var SAVE_LOAD_STATE = "SaveLoad";
    static var SAVE_LOAD_CONFIRM_STATE = "SaveLoadConfirm";
    static var DELETE_SAVE_CONFIRM_STATE = "DeleteSaveConfirm";
    static var DLC_STATE = "DLC";
    static var MARKETPLACE_CONFIRM_STATE = "MarketplaceConfirm";
    static var START_ANIM_STR = "StartAnim";
    static var END_ANIM_STR = "EndAnim";
    static var CONTINUE_INDEX = 0;
    static var NEW_INDEX = 1;
    static var LOAD_INDEX = 2;
    static var DLC_INDEX = 3;
    static var MOD_INDEX = 4;
    static var CREDITS_INDEX = 5;
    static var QUIT_INDEX = 6;
    static var HELP_INDEX = 7;
    static var LOADING_ICON_OFFSET = 50;
    static var PLATFORM_PC_KBMOUSE = 0;
    static var PLATFORM_PC_GAMEPAD = 1;
    static var PLATFORM_DURANGO = 2;
    static var PLATFORM_ORBIS = 3;
    static var ALPHA_AVAILABLE = 100;
    static var ALPHA_DISABLED = 50;
} // End of Class
