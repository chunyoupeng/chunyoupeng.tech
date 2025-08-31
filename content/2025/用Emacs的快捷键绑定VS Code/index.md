+++
title="中文用户的福音：用Emacs的快捷键绑定VS Code，个人感觉比Vim好用"
date=2025-08-31
draft=false
[taxonomies]
tags=["dev"]
+++
特别喜欢Vim，是Vim让我习惯了没有鼠标的日子，高效而流畅。

无奈作为一个中文用户，有输入拼音的需求。听说Emacs由`ctrl`键位控制，不需要频繁的切换中英文，中文状态下也可以流畅使用快捷键，于是开始学习Emacs。

刚开始不太习惯，个人感觉没有Vim流畅，不过在习惯之后，也是逐渐熟悉起来，打字也更加流畅，特别是在中文环境下。

除了有一个不太好的点是，Emacs配置不好弄，我会一点lisp，但是还是很难去搞配置。而且里面的插件都很老了，不太好用。相比之下，VS Code插件就丰富多了。特别是我最喜欢的ssh插件，这里推荐一下VSCode的ssh插件，连上之后基本上更本地开发没有什么太大的区别。

后面渐渐VSCode就用的多了起来。刚开始我还是会安装一个Vim的插件，不过后面还是与遇到相同的问题——打中文不好用。

于是我在想，能不能使用Emacs的快捷键呢？只需要配置一下就可以。后面配置了果然好用，和在emacs里面基本无缝连接。具体配置如下

```json
[

{

"key": "ctrl+[",

"command": "scrollLineDown",

"when": "textInputFocus"

},

{

"key": "ctrl+pagedown",

"command": "-scrollLineDown",

"when": "textInputFocus"

},

{

"key": "ctrl+]",

"command": "scrollLineUp",

"when": "textInputFocus"

},

{

"key": "ctrl+shift+o",

"command": "workbench.action.files.toggleActiveEditorReadonlyInSession"

},

{

"key": "ctrl+shift+w",

"command": "workbench.action.files.resetActiveEditorReadonlyInSession"

},

{

"key": "ctrl+/",

"command": "undo"

},

{

"key": "ctrl+shift+p",

"command": "cursorUpSelect"

},

{

"key": "ctrl+shift+n",

"command": "cursorDownSelect"

},

{

"key": "shift+alt+f",

"command": "cursorWordRightSelect"

},

{

"key": "shift+alt+b",

"command": "cursorWordLeftSelect"

},

{

"key": "alt+f",

"command": "cursorWordRight"

},

{

"key": "alt+d",

"command": "deleteWordRight",

"when": "textInputFocus"

},

{

"key": "alt+b",

"command": "cursorWordLeft"

},

{

"key": "shift+alt+f",

"command": "-notebook.formatCell",

"when": "editorHasDocumentFormattingProvider && editorTextFocus && inCompositeEditor && notebookEditable && !editorReadonly && activeEditor == 'workbench.editor.notebook'"

},

{

"key": "shift+alt+f",

"command": "-editor.action.formatDocument",

"when": "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor"

},

{

"key": "shift+alt+f",

"command": "-editor.action.formatDocument.none",

"when": "editorTextFocus && !editorHasDocumentFormattingProvider && !editorReadonly"

},

// ===== 基础移动 =====

{

"key": "ctrl+b",

"command": "cursorLeft",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+f",

"command": "cursorRight",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+p",

"command": "cursorUp",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+n",

"command": "cursorDown",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "alt+b",

"command": "cursorWordLeft",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "alt+f",

"command": "cursorWordRight",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+a",

"command": "cursorHome",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+e",

"command": "cursorEnd",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+v",

"command": "cursorPageDown",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "alt+v",

"command": "cursorPageUp",

"when": "editorTextFocus && !editorReadOnly"

},

  

// ===== 选择（Emacs 的 C-Shift-* 风格）=====

{

"key": "ctrl+shift+b",

"command": "cursorLeftSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+shift+f",

"command": "cursorRightSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+shift+p",

"command": "cursorUpSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+shift+n",

"command": "cursorDownSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "alt+shift+b",

"command": "cursorWordLeftSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "alt+shift+f",

"command": "cursorWordRightSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+shift+a",

"command": "cursorHomeSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+shift+e",

"command": "cursorEndSelect",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+d",

"command": "deleteRight",

"when": "editorTextFocus && !editorReadOnly"

}, // C-d

{

"key": "ctrl+h",

"command": "deleteLeft",

"when": "editorTextFocus && !editorReadOnly"

}, // C-h

{

"key": "alt+d",

"command": "deleteWordRight",

"when": "editorTextFocus && !editorReadOnly"

}, // M-d

{

"key": "alt+backspace",

"command": "deleteWordLeft",

"when": "editorTextFocus && !editorReadOnly"

}, // M-Backspace

{

"key": "ctrl+k",

"command": "deleteAllRight",

"when": "editorTextFocus && !editorReadOnly"

}, // 近似 kill-line

{

"key": "ctrl+t",

"command": "editor.action.transposeLetters",

"when": "editorTextFocus && !editorReadOnly"

},

// ===== 复制/剪切/粘贴 & 撤销 =====

{

"key": "alt+w",

"command": "editor.action.clipboardCopyAction",

"when": "editorTextFocus"

}, // M-w

{

"key": "ctrl+w",

"command": "editor.action.clipboardCutAction",

"when": "editorTextFocus"

}, // C-w

{

"key": "ctrl+y",

"command": "editor.action.clipboardPasteAction",

"when": "editorTextFocus"

}, // C-y

{

"key": "ctrl+/",

"command": "undo"

},

{

"key": "ctrl+shift+/",

"command": "redo"

}, // C-_ 近似

// ===== 搜索 =====

{

"key": "ctrl+s",

"command": "actions.find",

"when": "editorFocus && !findWidgetVisible"

},

{

"key": "ctrl+s",

"command": "editor.action.nextMatchFindAction",

"when": "editorFocus && findWidgetVisible"

},

{

"key": "ctrl+r",

"command": "editor.action.previousMatchFindAction",

"when": "editorFocus"

},

{

"key": "alt+shift+5",

"command": "editor.action.startFindReplaceAction",

"when": "editorFocus"

}, // M-%

// ===== 注释 / 代码辅助 =====

{

"key": "alt+;",

"command": "editor.action.commentLine",

"when": "editorTextFocus && !editorReadOnly"

}, // M-;

{

"key": "alt+/",

"command": "editor.action.triggerSuggest",

"when": "editorTextFocus && !editorReadOnly"

}, // M-/

{

"key": "alt+\\",

"command": "editor.action.formatDocument",

"when": "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadOnly"

}, // M-\

{

"key": "ctrl+g",

"command": "editor.action.cancelSelectionAnchor",

"when": "editorTextFocus"

},

{

"key": "ctrl+g",

"command": "closeFindWidget",

"when": "findWidgetVisible"

},

{

"key": "ctrl+g",

"command": "cancelSelection",

"when": "textInputFocus && !findWidgetVisible"

},

{

"key": "ctrl+g",

"command": "workbench.action.closeQuickOpen",

"when": "inQuickOpen"

},

// ===== 文件/缓冲区 & 命令 =====

{

"key": "ctrl+x ctrl+f",

"command": "workbench.action.quickOpen"

}, // 访文件

{

"key": "ctrl+x b",

"command": "workbench.action.quickOpenPreviousRecentlyUsedEditor"

}, // 切缓冲（近似）

{

"key": "alt+x",

"command": "workbench.action.showCommands"

}, // M-x

{

"key": "ctrl+x 2",

"command": "workbench.action.splitEditorDown"

},

{

"key": "ctrl+x 3",

"command": "workbench.action.splitEditorRight"

},

{

"key": "ctrl+x 0",

"command": "workbench.action.closeActivePinnedEditor"

},

{

"key": "ctrl+x 1",

"command": "workbench.action.closeEditorsInOtherGroups"

},

{

"key": "ctrl+x o",

"command": "workbench.action.focusNextGroup"

},

// ===== 跳转 / 问题导航 =====

{

"key": "alt+g alt+g",

"command": "workbench.action.gotoLine"

}, // M-g M-g

{

"key": "alt+g s",

"command": "workbench.action.gotoSymbol"

},

// ===== 选择全部 / 打开资源管理器 =====

{

"key": "ctrl+x h",

"command": "editor.action.selectAll"

},

{

"key": "ctrl+x ctrl+d",

"command": "workbench.view.explorer"

}, // 近似 dired

// ===== 终端 / Shell =====

{

"key": "ctrl+x m",

"command": "workbench.action.terminal.toggleTerminal"

},

{

"key": "ctrl+x ctrl+m",

"command": "workbench.action.terminal.new"

},

{

"key": "alt+shift+1",

"command": "workbench.action.terminal.toggleTerminal"

},

// ===== 放大/缩小（字体）=====

{

"key": "ctrl+x ctrl+=",

"command": "editor.action.fontZoomIn"

},

{

"key": "ctrl+x ctrl+-",

"command": "editor.action.fontZoomOut"

},

{

"key": "ctrl+x ctrl+0",

"command": "editor.action.fontZoomReset"

},

// ===== 行/段落编辑 =====

{

"key": "ctrl+x ctrl+j",

"command": "editor.action.joinLines",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+alt+\\",

"command": "editor.action.formatSelection",

"when": "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadOnly"

},

{

"key": "alt+c",

"command": "editor.action.transformToTitlecase",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+x ctrl+u",

"command": "editor.action.transformToUppercase",

"when": "editorTextFocus && !editorReadOnly"

},

{

"key": "ctrl+x ctrl+l",

"command": "editor.action.transformToLowercase",

"when": "editorTextFocus && !editorReadOnly"

},

// ===== 定义跳转 / 返回 / 括号跳转 =====

{

"key": "alt+.",

"command": "editor.action.revealDefinition",

"when": "editorHasDefinitionProvider && editorTextFocus"

}, // M-.

{

"key": "alt+,",

"command": "workbench.action.navigateBack"

}, // M-,

{

"key": "alt+m",

"command": "editor.action.jumpToBracket",

"when": "editorTextFocus"

},

// ===== 折叠 =====

{

"key": "ctrl+x shift+4",

"command": "editor.toggleFold",

"when": "editorTextFocus"

}, // C-x $

{

"key": "ctrl+x 4 0",

"command": "editor.unfoldAll",

"when": "editorTextFocus"

},

// ===== 多光标 / 扩选到下一个匹配 =====

{

"key": "alt+shift+.",

"command": "editor.action.addSelectionToNextFindMatch",

"when": "editorFocus"

},

{

"key": "alt+shift+,",

"command": "editor.action.moveSelectionToPreviousFindMatch",

"when": "editorFocus"

},

// ===== Expand-Region 风格（内置 Smart Select）=====

{

"key": "ctrl+=",

"command": "editor.action.smartSelect.expand",

"when": "editorTextFocus"

},

{

"key": "ctrl+-",

"command": "editor.action.smartSelect.shrink",

"when": "editorTextFocus"

},

// ===== 选中括号内 / 含括号 / 跳到括号 =====

{

"key": "alt+\\",

"command": "editor.action.selectToBracket",

"args": {

"selectBrackets": false

},

"when": "editorTextFocus"

}, // 仅括号内

{

"key": "alt+shift+\\",

"command": "editor.action.selectToBracket",

"args": {

"selectBrackets": true

},

"when": "editorTextFocus"

}, // 连同括号

{

"key": "ctrl+shift+\\",

"command": "editor.action.jumpToBracket",

"when": "editorTextFocus"

},

{

"key": "ctrl+alt+backspace",

"command": "editor.action.removeBrackets",

"when": "editorTextFocus"

}

]
```

[^1]: good
