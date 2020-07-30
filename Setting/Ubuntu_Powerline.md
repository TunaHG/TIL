# Powerline

## Ubuntu Powerline

### Oh My ZSH!를 사용한 Powerline

> [Reference Site](http://programmingskills.net/archives/115)

* ZSH 설치

  ```bash
  $ sudo apt-get install zsh
  ```

* 기본 쉘 변경

  ```bash
  # which zsh로 위치를 확인함
  $ which zsh
  
  # which zsh로 확인한 위치가 /usr/bin/zsh인 경우
  $ chsh -s /usr/bin/zsh
  ```

* 재부팅하면 ZSH 환경 설정

  * 2번을 선택하여 추천하는 환경으로 설정
  * 직접 설정하고 싶다면 1번 선택

* Oh My ZSH! 설치 진행

  * [ZSH Site](http://ohmyz.sh/)

  * wget과 curl 중 하나를 선택하여 진행

    ```bash
    $ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    $ sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    ```

    * wget, curl 둘다 설치되어 있지 않다면 원하는 Tool을 설치한 후 진행

      ```bash
      $ sudo apt-get install curl
      $ sudo apt-get install wget
      ```

* 설치가 완료되면 테마 변경

  * [Theme Site](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes)에서 원하는 테마 선택, 이름기억

  * ZSH의 설정파일 진입

    ```bash
    $ sudo vim ~/.zshrc
    ```

  * Line 11을 수정

    ```
    ZSH_THEME="{Theme}"
    ```

    * `{Theme}`에 아까 봐두었던, 원하는 테마의 이름 입력

    ```
    ZSH_THEME="agnoster"
    ```

* 재부팅 후 적용 확인

* 폰트가 깨진다면, Powerline이 적용될 수 있는 폰트들 중 원하는 폰트로 변경해야 함

  ```bash
  $ git clone https://github.com/powerline/fonts.git
  $ cd fonts
  $ ./install.sh
  ```

  * WSL을 사용중이라면 WSL의 Setting.json에서 fontFace설정을 변경
  * VM을 사용중이라면 해당 Ubuntu의 터미널 설정에서 편집 > 프로파일 기본 설정으로 이동하여 폰트 변경

### Powerline-go를 사용한 Powerline

> [Reference SIte](https://docs.microsoft.com/ko-kr/windows/terminal/tutorials/powerline-setup)
> Microsofts의 공식 Docs

* powerline-go 설치

  ```bash
  $ sudo apt install golang-go
  $ go get -u github.com/justjanne/powerline-go
  ```

* Ubuntu 프롬프트 사용자 지정

  * `vim ~/.bashrc`를 활용하여 `bashrc`의 마지막에 다음의 코드를 추가

  ```bash
  GOPATH=$HOME/go
  function _update_ps1() {
      PS1="$($GOPATH/bin/powerline-go -error $?)"
  }
  if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
      PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
  fi
  ```

## Vim Powerline

* 진행하기위하여 Python-pip와 git을 먼저 설치

  ```bash
  $ sudo apt-get install python-pip git
  ```

  * `python-pip`를 찾지 못한다는 에러가 발생하면 `python3-pip`로 수정하여 진행
  * Error
    * `python3-pip`를 진행했는데 `Package 'python3-pip' has no installation candidate`로 설치되지 않음
    * `sudo apt-get update`를 먼저 진행하고 다시 시도해볼것

* github url을 이용하여 pip install

  ```bash
  $ sudo pip install git+git://github.com/Lokaltog/powerline
  ```

  * 위에서 `python3-pip`로 설치를 진행했다면 `pip` command를 찾지 못할수 있음. `pip3`로 변경하여 진행

* github url을 이용하여 font install

  ```bash
  $ wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
  $ wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
  $ sudo mv PowerlineSymbols.otf /usr/share/fonts
  $ sudo fc-cache -vf
  $ sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d
  ```

  * 4번째 Command에서 `fc-cache`라는 Command를 찾을수 없다고 나온다면,

    ```bash
    $ sudo apt install fontconfig
    ```

    를 진행한 후 다시 명령어를 입력

* 해당 Powerline을 Ubuntu Terminal에 적용하고 싶다면 `vim ~/.bashrc`로 bashrc를 수정

  ```
  if [ -f /usr/local/lib/python3.8/dist-packages/powerline/bindings/bash/powerline.sh ]; then
      source /usr/local/lib/python3.8/dist-packages/powerline/bindings/bash/powerline.sh
  fi
  ```

* Vim에 적용하고 싶다면 `vim ~/.vimrc`로 vimrc를 수정

  ```
  set rtp+=/usr/local/lib/python3.8/dist-packages/powerline/bindings/vim/
  set laststatus=2
  set t_Co=256
  ```

* ZSH를 이용중이라면 `vim ~/.zshrc`로 zshrc를 수정

  ```
  if [ -f /usr/local/lib/python3.8/dist-packages/powerline/bindings/zsh/powerline.zsh ]; then
      source /usr/local/lib/python3.8/dist-packages/powerline/bindings/zsh/powerline.zsh
  fi
  ```

  * ZSH를 수정하는 경우에는 `/bindings`경로 내에 `bash`와 `zsh`가 각각 존재
    * `bash`경로에는 `powerline.sh`가 존재
    * `zsh`경로에는 `powerline.zsh`가 존재
    * 둘 중 어느것을 선택하느냐에 따라서 Powerline이 변경되므로 둘 다 확인해보고 원하는 것 사용
  * 이 3개의 rc를 수정하는 과정에서 주의할 점
    * `/usr/local/lib/python3.8/dist-packages` 경로내에 powerline이 있는지 확인
    * `/lib/python3.8/`에 없다면 `/lib/python2.7`에 있는지 확인
    * 본인에게 맞는 경로로 입력할 것