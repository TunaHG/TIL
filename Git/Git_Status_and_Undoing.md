# Git Status & Undoing

## 1. Commit

#### 1. Working Directory는 있으나 Staging Area는 비어있는 상황

```bash
$ git commit
On branch master

Initial commit

Untracked files:
        a.txt

nothing added to commit but untracked files present
```

* `commit` 할 것이 없다 : Staging Area가 비어있다.
* `untracked file`이 있다 : `git commit` 이력에 담기지 않은 파일은 있다.

#### 2. Working Directory와 Staging Area 둘 다 비어있는 상황

```bash
$ git commit
On branch master

Initial commit

nothing to commit
```

* 어떠한 변경 사항도 없다.

### Status

#### 1. 새로 파일 생성한 경우

```bash
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        a.txt

nothing added to commit but untracked files present (use "git add" to track)
```

* `Untracked files` : `commit` 이력에 담긴 적 없는 파일
* `(user ...)` : `commit` 될 목록(Staging Area)에 추가하려면, `git add <file>`

#### 2. add 한 이후

```bash
$ git add a.txt
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   a.txt
```

* `Changes` : `commit`될 변경 사항들(changes)

#### 3. commit message 작성하기

> 부제 : vim 활용 기초
>
> vim을 학습하고 싶으면 vim adventure를 활용

```bash
$ git commit
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
#
# Initial commit
#
# Changes to be committed:
#       new file:   a.txt
#
```

* 편집(입력) 모드 : `i`
  * 문서 편집 가능
* 명령 모드 : `esc`
  * `dd` : 해당 Line 삭제
  * `:wq` : 저장 및 종료
    * `w` : write
    * `q` : quit
  * `:q!` : 강제 종료
    * `q` : quit
    * `!` : 강제

```bash
$ git commit -m 'commit message'
```

* `commit message`는 항상 해당 작업 이력을 나타낼 수 있도록 작성한다.
* 일관적인 포맷으로 작성하려고 노력한다.

### log

> Commit은 해시 값(hash value)에 의해서 구분된다.
> SHA-1 해시 알고리즘을 사용하여 표현한다.

```bash
$ git log
commit 64aba78a9eeabce7f3f3ac677872bfdc0464d3eb (HEAD -> master)
Author: TunaHG <asdf0185@naver.com>
Date:   Wed Dec 18 09:41:41 2019 +0900

    Add a.txt

    * a.txt 내용 추가
    * blahblah
```

```bash
$ git log --oneline
9aac01d (HEAD -> master) Add b.txt
64aba78 Add a.txt

$ git log -1
commit 9aac01ddb43b16b474ad66676d67ea73bc8b1553 (HEAD -> master)
Author: TunaHG <asdf0185@naver.com>
Date:   Wed Dec 18 10:15:17 2019 +0900

    Add b.txt
    
$ git log --oneline --graph
$ git log -1 --oneline
```

* `--oneline` : `commit message`의 제목만을 간단하게 표시해준다.
* `-number` : `number`만큼의 `commit message`를 출력한다.
* `--graph` : graph를 그려서 `commit message`를 보여준다.

### Commit Undoing

#### 1. Commit Message 수정

```bash
$ git commit --amend
[master 62f5d43] Add b.txt + amend modify
 Date: Wed Dec 18 10:15:17 2019 +0900
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 b.txt
```

* 바로 직전에 `commit`한 내용만을 변경한다. 그 외의 `commit message`는 수정할 수는 있으나 수정하지 않는것이 좋다. (처음 작성할 때부터 신중하게 작성할 것)
* `vim`창이 뜨게 되며, 해당 `vim`창에서 `commit message`를 수정하면 된다.
* `commit message`를 수정하는 경우 해시 값이 변경되므로 다른 이력으로 관리가 된다.
  따라서, 공개된 저장소(원격 저장소)에 **이미 `push`된 경우 절대 수정해서는 안된다.**

#### 2. 특정 파일 추가하기

> `c.txt`파일을 같이 `commit`하려고 했는데, `add`를 하지 않고 `commit`한 경우

```bash
$ git add c.txt
$ git commit --amend
[master 1b9f6bd] Add b.txt + amend modify + Add c.txt
 Date: Wed Dec 18 10:15:17 2019 +0900
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 b.txt
 create mode 100644 c.txt

$ git status
On branch master
nothing to commit, working tree clean

```

* `commit --amend`가 `commit`을 실시하는 시점으로 이동하여 `commit`을 다시 진행하기 때문에 `add`되 있는 파일을 다시 전부 `commit`할 수 있다.

### Staging Area

#### 1. Commit 이력이 있는 파일 수정하는 경우

```bash
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   a.txt

no changes added to commit (use "git add" and/or "git commit -a")

$ git add a.txt
$ git status
On branch master
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   a.txt
        
```

* `Changes not ...` : 변경 사항인데(WorkingDirectory에 있는데), Staging Area에 없다.
* `(use "git add <file>..."` : `Staging Area`로 보내기 위해서
* `(use "git restore <file>..."` : `Staging Area`에서 제외하기 위해서 `(unstage)`

#### 2. add 취소하기

```bash
$ git restore --staged a.txt
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   a.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

* `restore --staged` : `unstage`

* 구 버전의 `git`에서는 아래의 명령어를 사용해야 한다.

  ```bash
  $ git reset HEAD <file>
  ```

#### 3. Working Directory 변화 삭제하기

> git에서는 모든 commit 시점으로 되돌릴 수는 있다.
> 다만 Working Directory를 삭제하는 것은 되돌릴 수가 없다.

```bash
$ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    a.txt
        deleted:    b.txt
        deleted:    c.txt

no changes added to commit (use "git add" and/or "git commit -a")

$ git restore .
$ git status
On branch master
nothing to commit, working tree clean
```

* 구 버전의 `git`에서는 아래의 명령어를 사용해야 한다.

  ```bash
  $ git checkout -- <file>
  ```

### Reference

* [좋은 git commit message를 작성하기 위한 7가지 약속 - TOAST](https://meetup.toast.com/posts/106)



