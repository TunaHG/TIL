# Stash

> 변경사항을 임시로 저장 해놓는 공간
>
> 마지막 Commit 시점으로 되돌려준다.
>
> Commit을 진행하기 전의 애매한 코드들을 Stash임시공간에 넣어두고 merge를 진행한 후에 진행하고 있던 Stash 임시공간에 들어간 코드를 다시 가져와서 작업을 계속 진행한다.

## Problem

```
1. feature branch에서 a.txt 변경 후 commit
2. master branch에서 a.txt 수정 (add나 commit 없이)
3. merge
```

```bash
$ git merge feature
error: Your local changes to the following files would be overwritten by merge:
        a.txt
Please commit your changes or stash them before you merge.
Aborting
Updating e1212ab..58e865d
```

### 명령어

1. Stash 저장

	```bash
  $ git stash
  Saved working directory and index state WIP on master: e1212ab Edit a.txt
	```

2. Stash 목록
	
	```bash
	$ git stash list
	stash@{0}: WIP on master: e1212ab Edit a.txt
	```
	
3. Stash 불러오기

   ```bash
   $ git stash pop
   ```

   * `git stash pop` : 불러오기 + 목록에서 삭제
   * `git stash apply`(불러오기) + `git stash drop`(목록에서 삭제) 가 합쳐진 명령어

### Solution

```bash
$ git stash
Saved working directory and index state WIP on master: e1212ab Edit a.txt

$ git merge feature
Updating e1212ab..58e865d
Fast-forward
 a.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

$ git stash pop
Auto-merging a.txt
CONFLICT (content): Merge conflict in a.txt
The stash entry is kept in case you need it again.
```

* `stash` : 작업중이던 내용 임시공간에 넣기
* `stash pop` : 작업중이던 내용 불러와서 계속 작업하기

```
<<<<<<< Updated upstream
수정수정
=======
마스터마스터
>>>>>>> Stashed changes
```