# dotfiles #

## Setup ##

* Fork this repo and rename it to `dotfiles`
* Install [homeshick](https://github.com/andsens/homeshick#quick-install)
  (remember to launch a new terminal to get the `homeshick` command working)
* Clone your dotfiles and prezto (replace the `___`)  
  `homeshick clone git@github.com:___/dotfiles sorin-ionescu/prezto`
* Set your shell to zsh  
  On macOS:
	* Install the latest zsh: `brew install zsh`
  * Go into `System Preferences → Users & Groups`
  * Unlock the panel
  * Right click on your account and select `Advanced Options`
  * Change the `Login shell` field to `/usr/local/bin/zsh`

  On Linux:
  * `apt-get install zsh`
  * `chsh --shell /usr/bin/zsh ___` (replace `___` with your username)

## SERVER_ENV ##

The prompt can change the color of the servername depending on whether you
are in a production or staging environment. It uses `$SERVER_ENV` to do that.  
In order to set this property for all users you can add
`/etc/profile.d/20_server_env` to your servers, containing
`SERVER_ENV=production` or `SERVER_ENV=staging`. The default `$HOME/.profile`
and the one in this repo will automatically include all files placed in
`/etc/profile.d/`, so you can use it to e.g. add guards to various commands
that should be run with great care on production servers.

`home/profile` also uses this variable to test whether you are on a remote
server. This could very likely be achieved in a more elegant manner,
so feel free to send a PR.

## Customization ##

### `$HOME/.localenv` ###

Use this untracked file to adjust machine-specific environment variables.  
e.g. a different email on your work computer vs. your home computer.  
Example
```
export PATH=$PATH:$HOME/.local/bin
hash -d WINHOME=/mnt/c/Users/___
hash -d WS=~WINHOME/Workspace
export EMAIL="user@gmail.com"
```

### `home/.forward` ###

* Replace `___@yourdomain.com` with your email

### `cli/profile` ###

* Replace `EMAIL='___@yourdomain.com'` with your email
* Replace `DEFAULT_USER='___'` with the username on your computer

### `config/git/config` ###

* Replace `user.name = Full Name` with your proper name

### `config/ssh/config` ###

* Replace `User ___` with your username on remote servers

### `config/aws/config` ###

* Replace `___` in the path to `aws-unlock.sh` with your own path. The config file does not support `$HOME` or `~`.
* Replace the role arn in the `role` profile with your own role arn.
* Create `config/aws/user` containing your AWS user credentials like so:  
  ```
  AWS_ACCESS_KEY_ID="......"
  AWS_SECRET_ACCESS_KEY="......"
  ```
  Encrypt it with gpg `gpg --encrypt -r KEYID user` to user.gpg and delete the original.

### `config/aws/unlock-aws.sh` ###

* Replace `___@yourdomain.com` with your gpg key identifier

## iTerm ##

* Install [iTerm2](https://www.iterm2.com/)
* Install [Inconsolata-dz](https://github.com/powerline/fonts/tree/master/InconsolataDz)
  (if you prefer to use another font, make sure to get a version with [powerline support](https://github.com/powerline/fonts))
* Enable `Preferences → Load preferences from a customer folder or URL:`
  and set the path to `/Users/___/.homesick/repos/dotfiles/config/iTerm` (replace `___` with your username)
