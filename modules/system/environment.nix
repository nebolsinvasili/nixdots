{
  userSettings,
  ...
}: 

{
  environment = {
    variables = {
      EDITOR = userSettings.editor;
      TERMINAL = userSettings.terminal;
      BROWSER = userSettings.browser;
    };
    sessionVariables = {
    };
  };
}
