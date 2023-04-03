{
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;

    keybindings = [
      {
        key = "ctrl+alt+down";
        command = "editor.action.copyLinesDownAction";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+alt+up";
        command = "editor.action.copyLinesUpAction";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+shift+alt+down";
        command = "-editor.action.copyLinesDownAction";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+shift+alt+up";
        command = "-editor.action.copyLinesUpAction";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+shift+q";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+shift+7";
        command = "-editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+tab";
        command = "workbench.action.nextEditor";
      }
      {
        key = "ctrl+tab";
        command = "-workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup";
        when = "!activeEditorGroupEmpty";
      }
      {
        key = "ctrl+shift+tab";
        command = "workbench.action.previousEditor";
      }
      {
        key = "ctrl+shift+tab";
        command = "-workbench.action.quickOpenLeastRecentlyUsedEditorInGroup";
        when = "!activeEditorGroupEmpty";
      }
      {
        key = "ctrl+pageup";
        command = "-workbench.action.previousEditor";
      }
      {
        key = "ctrl+pagedown";
        command = "-workbench.action.nextEditor";
      }
    ];

    userSettings = {
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', monospace";
      "editor.formatOnSave" = true;
      "editor.codeActionsOnSave" = {
        "source.fixAll.eslint" = true;
      };
      "editor.tabSize" = 2;
      "workbench.tree.indent" = 16;
      "workbench.colorCustomizations" = {
        "[*]" = {
          "editorInlayHint.background" = "#00000000";
          "editorInlayHint.foreground" = "#ffffff90";
        };
      };
      "workbench.colorTheme" = "Monokai Spectrum Tweaks";
      "explorer.compactFolders" = false;
      "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
      "typescript.inlayHints.variableTypes.suppressWhenTypeMatchesName" = false;
      "typescript.inlayHints.variableTypes.enabled" = true;
      "typescript.inlayHints.parameterTypes.enabled" = true;
      "typescript.inlayHints.enumMemberValues.enabled" = true;
      "files.insertFinalNewline" = true;
    };

    /*globalSnippets = {
      log = {
        scope = "javascript,typescript,javascriptreact,typescriptreact";
        prefix = [ "log" ];
        body = [ "console.log($1)" ];
        description = "console log";
      };
      warn = {
        scope = "javascript,typescript,javascriptreact,typescriptreact";
        prefix = [ "warn" ];
        body = [ "console.warn($1)" ];
        description = "console warn";
      };
      error = {
        scope = "javascript,typescript,javascriptreact,typescriptreact";
        prefix = [ "err" ];
        body = [ "console.error($1)" ];
        description = "console error";
      };
    };*/
  };
}
