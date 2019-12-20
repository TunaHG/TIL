# Basic Python Programming

## 1. 저장

### 1) 숫자

```python
a = 7
b = 3
```

* `python`에서는 다른 프로그래밍 언어와 다르게 데이터 타입을 선언해주지 않는다.

```python
print(a)

print(a + b)   # 덧셈
print(a - b)   # 뺄셈
print(a * b)   # 곱셈

print(a / b)   # 나눗셈
print(a // b)  # 몫
print(a % b)   # 나머지
```

* [Codes](./01_numbers.py)

### 2) 글자

1. 글자 합체

   ```python
   hphk = "happy" + " " + "hacking"
   print(hphk)
   ```

2. 글자 삽입

   ```python
   name = "Tuna"
   age = 26
   
   text = "제 이름은 {}입니다. 나이는 {}살 입니다.".format(name, age)
   print(text)
   ```

   * `{}`의 순서대로 올 변수를 뒤의 `format()`에 넣어준다.

   ```python
   f_text = f"제 이름은 {name}입니다. 나이는 {age}살 입니다."
   print(f_text)
   ```

   * `{}`내부에 올 변수명을 입력하고 문자열 가장 앞에 `f`를 입력해주는 것으로 동일한 기능을 수행한다.

3. 글자 자르기

   ```python
   text_name = text[:15]
   print(text_name)
   
   text_age = text[15:]
   print(text_age)
   ```

   * `"String"`의 뒤에 `[start : end]`를 입력하여 start부터 end까지의 순서에 해당하는 문자열을 가져온다.

   ```python
   text_split = text.split()
   print(text_split)
   ```

   * `split()`을 사용하여 `()`내부에 선언된 인자를 기준으로 문자열을 구분해준다. 아무것도 선언해주지 않으면 공백으로 취급한다.

* [Codes](./02_Strings.py)

### 3) 참/거짓

> 주로 조건문에서 사용한다.

```python
참 = True
거짓 = False
```

* `python`에서 `True`와 `False`는 가장 앞 알파뱃이 대문자여야한다.

* [Codes](./03_boolean.py)

### 4) List, Dictionary

```python
menus1 = "순남 시래기"
menus2 = "양자강"
menus3 = "20층"

menus = ["순남 시래기", "양자강", "20층..."]
print(menus[0])
```

* `menus1, 2, 3`을 모아놓은 `menus`가  `list`에 해당한다. 
* `menus[]`의 `[]`내부의 숫자로 `list value`에 접근한다.

```python
dict_nums = {"순남 시래기" : "02-0216-1343",
             "양자강" : "02-0216-1133",
             "20층" : "02-0216-1673"}
print(dict_nums["순남 시래기"])
print(dict_nums.get("희희"))
```

* `Dictionary`는 `key`와 `value`로 쌍을 이루는 데이터를 가진다.
* `[]`에 `key`값을 넣음으로써 해당 `key`값에 대응하는 `value`값에 접근한다.
* `key`값이 없는 값이면 `None`을 `return`한다.
* [Codes](./04_example.py)

## 2. 조건

```python
dust = 120

if dust > 150:
    print("매우 나쁨")
elif dust > 100:
    print("나쁨")
elif dust > 80:
    print("보통")
else:
    print("좋음")
```

* `if`와 `elif`뒤에 `()`가 없지만 `:`이전까지가 조건문이며, 조건문이 `True`일 때 내부의 코드가 실행된다. `False`라면 `else`가 실행된다.
* `python`에서는 `intent`가 중요하며 `java`에서 처럼 `{}`로 묶이지 않고 `intent`가 `{}`의 역할을 수행한다.
* [Codes](./05_Condition.py)

## 3. 반복

```python
menus = ["순남 시래기", "양자강", "20층...", "바스버거"]

for menu in menus:
    print(menu)

print("======")
for i in range(4):
    print(i)
    print(menus[i])
```

* `for`반복문을 사용할 땐 위와 같이 사용하며, `in`앞이 반복되는 값이고 뒤가 반복의 범위를 의미한다.
* `range`는 `(start, end, by)`의 인자를 가진다. `start`부터 `end`까지 `by`의 차이를 가지고 반복된다.
  * `range(1, 10, 2)`라면 `1, 3, 5, 7, 9`를 의미한다.
  * `range(1, 3)`이라면 `1, 2, 3`을 의미한다.
  * `range(3)`이라면 `1, 2, 3`을 의미한다.
* [Codes](./06_loop.py)

## 4. Input

```python
a = input()

print("------")
print(a)
print(type(a))
```

* `input()`을 사용하여 사용자로부터 입력을 받을 수 있다.
* `input()`의 `return`값은 `type(a)`에서 볼수 있듯이 `String`이다.

```python
b = int(input())

print(b)
print(type(b))
print(b + 123123)
```

* `input()`을 `int()`로 묶어준다면 `String`이 `int`로 변환되어 결과값이 `int`형이 된다.

* [Codes](./07_input.py)
