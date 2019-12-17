# Push Error

> `pull`을 진행하지 않고 작업을 진행한다음 `push`를 진행하면 발생하는 `Error`
>
> 만약에, 원격 저장소의 이력과 로컬 저장소의 이력이 다른 경우에는 아래의 메시지가 발생한다.

```bash
$ git push origin master
To https://github.com/TunaHG/Database.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://github.com/TunaHG/Database.git'
# 원격 저장소의 작업 내용(work - commit)과 로컬 내용이 다르다.
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
# 원격 저장소 변화내역(changes)를 통합하고 다시 push 해라.
# 예) git pull ...
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

* 원격 저장소의 작업의 흐름을 살펴보기 위해서는 `Github Site`에서는 `Commit`버튼을 클릭한다.
* 로컬 저장소의 작업의 흐름을 살펴보기 위해서는 `git bash`에서 `git log --oneline`을 입력한다
* `pull`을 이용하여 하나의 흐름으로 통합한 후 다시 `push`를 진행하면 됨.

```bash
$ git log --oneline
365f942 (HEAD -> master) test.txt
5c7fc30 (origin/master) Work in Multi-Campus
eec86c2 Study in Home
a90b54d Work in Multicampus
1a527b4 Study in Home
c6ae409 MultiCampus - How to install Database

$ git pull origin master
$ git push origin master
```