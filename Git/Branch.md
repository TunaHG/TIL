# Branch

### 1. fast-foward

> fast-foward는 feature 브랜치 생성된 이후 master 브랜치에 변경 사항이 없는 상황

1. feature/test branch 생성 및 이동

   ```bash
   $ git checkout -b feature/test
   ```

2. 작업 완료 후 commit

   ```bash
   $ touch test.txt
   $ git add test.txt
   $ git commit -m "Complete test"
   [feature/test 8203e3e] Complete test
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 test.txt
   ```

3. master 이동

   ```bash
   $ git checkout master
   Switched to branch 'master'
   ```

   * master로 이동한 후 폴더를 살펴보면 test.txt파일이 보이지 않음

4. master에 병합

   ```bash
   (master) $ git merge feature/test
   ```

5. 결과 -> fast-foward (단순히 HEAD를 이동)

   ```bash
   Updating 8241778..8203e3e
   Fast-forward
    test.txt | 0
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 test.txt
   ```

   * `HEAD` : 내 위치를 뜻함

6. branch 삭제

   ```bash
   $ git branch -d feature/test
   Deleted branch feature/test (was 8203e3e).
   ```

------

### 2. merge commit

> 서로 다른 이력(commit)을 병합(merge)하는 과정에서 다른 파일이 수정되어 있는 상황
>
> git이 auto merging을 진행하고, commit이 발생된다.

1. feature/signout branch 생성 및 이동

   ```bash
   $ git branch feature/signout    # 생성
   $ git checkout feature/signout  # 이동
   $ git checkout -b feature/signout # 생성 후 이동
   ```

2. 작업 완료 후 commit

   ```bash
   $ touch signout.html
   $ git add signout.html
   $ git commit -m "Complete signout"
   $ git log --oneline
   c1306b5 (HEAD -> feature/signout) Complete signout
   8203e3e (master) Complete test
   8241778 Complete index page
   4cbfad2 Add README
   ```

3. master 이동

   ```bash
   $ git checkout master
   $ git log --oneline
   8203e3e (HEAD -> master) Complete test
   8241778 Complete index page
   4cbfad2 Add README
   ```

4. *master에 추가 commit 이 발생시키기!!*

   - **다른 파일을 수정 혹은 생성하세요!**

   ```bash
   $ touch hotfix.txt
   $ git add .
   $ git commit -m 'Hotfix on master'
   ```

   ```bash
   $ git log --oneline
   d06da96 (HEAD -> master) Hotfix on master
   8203e3e Complete test
   8241778 Complete index page
   4cbfad2 Add README
   ```

5. master에 병합

   ```bash
   (master) $ git merge feature/signout
   ```

6. 결과 -> 자동으로 *merge commit 발생*

   - vim 편집기 화면이 나타납니다.

   - 자동으로 작성된 커밋 메시지를 확인하고, `esc`를 누른 후 `:wq`를 입력하여 저장 및 종료를 합니다.

     - `w` : write
     - `q` : quit

     ```bash
     Merge made by the 'recursive' strategy.
      signout.html | 0
      1 file changed, 0 insertions(+), 0 deletions(-)
      create mode 100644 signout.html
     ```

   - 커밋이 확인 해봅시다.

     ```bash
     $ git log --oneline
     cd2e351 (HEAD -> master) Merge branch 'feature/signout'
     d06da96 Hotfix on master
     c1306b5 (feature/signout) Complete signout
     8203e3e Complete test
     8241778 Complete index page
     4cbfad2 Add README
     ```

7. 그래프 확인하기

   ```bash
   $ git log --online --graph
   *   cd2e351 (HEAD -> master) Merge branch 'feature/signout'
   |\
   | * c1306b5 (feature/signout) Complete signout
   * | d06da96 Hotfix on master
   |/
   * 8203e3e Complete test
   * 8241778 Complete index page
   * 4cbfad2 Add README
   ```

8. branch 삭제

   ```bash
   $ git branch -d feature/signout
   Deleted branch feature/signout (was c1306b5).
   ```

**branch에서 진행한 내용을 먼저 commit하고 이후에 master에서 진행한 내용을 commit한다. **

**로컬입장에서 외부의 작업내용을 먼저 commit해야 충돌이 발생하지 않는다.**

------

### 3. merge commit 충돌

> 서로 다른 이력(commit)을 병합(merge)하는 과정에서 동일 파일이 수정되어 있는 상황
>
> git이 auto merging을 하지 못하고, 해당 파일의 위치에 라벨링을 해준다.
>
> 원하는 형태의 코드로 직접 수정을 하고 merge commit을 발생 시켜야 한다.

1. feature/board branch 생성 및 이동

   ```bash
   $ git checkout -b feature/board
   Switched to a new branch 'feature/board'
   ```

2. 작업 완료 후 commit

   ```bash
   $ touch board.html
   # README.md 수정
   $ git add .
   $ git commit -m 'Complete board &`` Update README'
   ```

   ```bash
   $ git log --oneline
   f4109fe (HEAD -> feature/board) Complete board $ Update README
   cd2e351 (master) Merge branch 'feature/signout'
   d06da96 Hotfix on master
   c1306b5 Complete signout
   8203e3e Complete test
   8241778 Complete index page
   4cbfad2 Add README
   ```

3. master 이동

   ```bash
   $ git checkout master
   ```

4. *master에 추가 commit 이 발생시키기!!*

   - **동일 파일을 수정 혹은 생성하세요!**

   ```bash
   # README.md 수정
   (master) $ git add .
   $ git commit -m 'Update README on master'
   ```

   ```bash
   $ git log --oneline
   68492e1 (HEAD -> master) Update README on master
   cd2e351 Merge branch 'feature/signout'
   d06da96 Hotfix on master
   c1306b5 Complete signout
   8203e3e Complete test
   8241778 Complete index page
   4cbfad2 Add README
   ```

5. master에 병합

   ```bash
   $ git merge feature/board
   Auto-merging README.md
   CONFLICT (content): Merge conflict in README.md
   Automatic merge failed; fix conflicts and then commit the result.
   
   $ git status
   On branch master
   You have unmerged paths.
     (fix conflicts and run "git commit")
     (use "git merge --abort" to abort the merge)
   
   Changes to be committed:
           new file:   board.html
   
   Unmerged paths:
     (use "git add <file>..." to mark resolution)
           both modified:   README.md
   ```

6. 결과 -> *merge conflict발생*

7. 충돌 확인 및 해결

   ```
   <<<<<<< HEAD
   master에서 추가함!
   =======
   게시판 기능 구현 완료
   >>>>>>> feature/board
   ```

   * `HEAD`(현재 상황), 아래에 `feature/board` 변화 내역들이 각각 표기 되어 있다.
   * 원하는 형태로 코드를 수정한다.

8. merge commit 진행

   ```bash
   $ git add .
   $ git commit
   ```

   - vim 편집기 화면이 나타납니다.
   - 자동으로 작성된 커밋 메시지를 확인하고, `esc`를 누른 후 `:wq`를 입력하여 저장 및 종료를 합니다.
     - `w` : write
     - `q` : quit
   - 커밋이 확인 해봅시다.

9. 그래프 확인하기

   ```bash
   $ git log --oneline --graph
   *   dce4461 (HEAD -> master) Merge branch 'feature/board'
   |\
   | * f4109fe (feature/board) Complete board $ Update README
   * | 68492e1 Update README on master
   |/
   *   cd2e351 Merge branch 'feature/signout'
   |\
   | * c1306b5 Complete signout
   * | d06da96 Hotfix on master
   |/
   * 8203e3e Complete test
   * 8241778 Complete index page
   * 4cbfad2 Add README
   ```

10. branch 삭제

    ```bash
    $ git branch -d feature/board
    Deleted branch feature/board (was f4109fe).
    ```

    