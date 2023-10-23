### 01.10.23
#### RStudio: Switching between the console and the code editor without using your mouse (Mac)

```command line
ctrl 1 (for code editor)
ctrl 2 (for console)
```

<br>

### 02.10.23
#### Fastest way to insert google docstrins so far. Install autoDocstring extension for vsCode. Press `cmd-shift-2` below your funcition definition

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9ea7eb10-e568-4e2a-b5df-345d4c4c1aa4">

### 17.10.23

#### Terminal > Homebrew: I didn't know that homebrew doesn't automatically uninstall old packages, so you'll need to do it yourself.

```command line
brew cleanup
```

### 19.10.23

#### VS Code: CodeSnap - a nice extension to visualize code snippets
#### After installation just highlight your code, right click and there you have it!

![image](https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/03085d7f-4f56-41d3-bc52-b75e7dc029a1)


### 23.10.12:  iTerm: Customizing terminal prompt (PS1) with emojis to add a touch of personalization

<br>

```code
I use agnoster theme for my iTerm2 terminal and settings to that theme can be found at this location ~/.oh-my-zsh/themes/agnoster.zsh-theme

My goal was to get rid of the user and hostname display and replace it with some fancy emojis. 
```

Before that the settings looked like this.

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9a171b16-9851-4908-81e6-229749c60b4a">

After the edit:

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/a0276f75-ac23-4481-944e-8942df89f561">

<br>

```code
Don't forget to include the source ~/.oh-my-zsh/themes/agnoster.zsh-theme command in your .zshrc. Otherwise, after the terminal session is closed, your changes will disappear.
```