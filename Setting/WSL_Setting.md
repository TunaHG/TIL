# WSL Setting

* Windows Terminal Download
  * [Microsoft Download Site](https://www.microsoft.com/ko-kr/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
* WSL Setting
  * [Microsoft Docs](https://docs.microsoft.com/ko-kr/windows/wsl/install-win10)
* Windows Terminal Powershell's Powerline Setting
  * [Microsoft Docs](https://docs.microsoft.com/ko-kr/windows/terminal/tutorials/powerline-setup)
  * [Oh My Posh Theme](https://github.com/JanDeDobbeleer/oh-my-posh#themes)
* Error
  * PSReadLine Error
    * PSReadLine을 로드할수 없다는 Error
    * [Microsoft Docs](https://docs.microsoft.com/ko-kr/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7)
    * 해당 링크를 통해 CurrentUser의 Execution Policy를 RemoteSigned로 변경하면 해결

## ColorScheme Setting

* [Microsoft Docs Theme](https://docs.microsoft.com/ko-kr/windows/terminal/customize-settings/color-schemes)

  * 공식적으로 지원하는, `Alt`를 누른채 설정을 클릭하면 나타나는 default.json에 이미 명시되어 있는 Theme들

* [Windows Terminal Theme](https://atomcorp.github.io/themes/)

  * 원하는 Theme에서 Get Theme를 클릭하여 복사하기 (Dark+ 사용)

  * Terminal의 설정인 Setting.json에서 아래의 `schemes`의 값으로 붙여넣기

    ![image-20200730161958833](C:\Users\Tuna\AppData\Roaming\Typora\typora-user-images\image-20200730161958833.png)

* 원하는 Theme를 선택한 후, `profiles`의 `defaults`에 `"colorScheme"`를 입력하여 모든 탭에 대하여 지정

  * 혹은 `list`의 각 탭에 대하여 `"colorScheme"`를 따로 지정