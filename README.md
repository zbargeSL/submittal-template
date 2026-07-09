If you don't have the local submittal packages installed already you need to add it to the appropriate path.

### Windows

`%APPDATA%\typst\packages\local\submittal\0.1.0\`

### Linux

`mkdir ~/.local/share/typst/packages/local/submittal/0.1.0/ && mv submittal/* ~/.local/share/typst/packages/local/submittal/0.1.0/`

If you're using linux you also want to make sure your `XDG_DATA_HOME` environment variable is set to ~/.local/share
