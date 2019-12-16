# StringBuilder

> String 객체를 메모리 영역에서 좀 더 효율적으로 사용하는 Class이다.
>
> Multi-Thread를 사용한다면 StringBuilder보다 StringBuffer를 사용하는 것이 좋다.

```java
StringBuilder sb = new StringBuilder();
```

* `StringBuilder`는 기본패키지인 `java.lang package`에 포함되어 있어 `import`해줄 필요가 없다.

```java
sb.append("String");
char tmp = 'c';
sb.append(tmp);
```

* `append()`메소드를 사용하여 인스턴스에 문자열을 추가한다.

## 추가 메소드

> StringBuilder 객체 위에 마우스를 올려서 Ctrl + MLB(Mouse Left Button)을 진행하면 StringBuilder Class로 추적해준다. 이를 활용하여 Class에 존재하는 Method를 확인하고 진행한다

# Codes