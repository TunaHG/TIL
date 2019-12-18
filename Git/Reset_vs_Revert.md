# Reset vs Revert

## Reset

> 공개된 저장소(원격 저장소)에 push된 이력은 절대 reset하지 않는다.

```bash
$ git reset {Hash Code}
```

* 기본 (`--mixed`) : 이후 변경 사항을 Working Directory에 유지시켜줌.
* `--hard` : 이후 변경 사항이 모두 삭제됨. **주의**
* `--soft` : 지금 작업하고 있는 내용(Working Directory) 및 변경사항을 Working Directory에 유지시켜줌.

## Revert

> 해당 Commit으로 되돌렸다는 이력(Revert Commit)을 남긴다.

```bash
$ git revert {Hash Code}
```

* `{Hash Code}` : `log`에서 가장 위에 있는 `Hash Code`
* `Commit Message`를 입력할 수 있는 `vim`창이 뜸.

