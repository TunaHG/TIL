'''
String 조작하기

1. 글자 합체

2. 글자 삽입(수술)

3. 글자 자르기
'''

# 1. 글자 합체
hphk = "happy" + " " + "hacking"
print(hphk)

# 2. 글자 삽입
name = "Tuna"
age = 26

text = "제 이름은 {}입니다. 나이는 {}살 입니다.".format(name, age)
print(text)

f_text = f"제 이름은 {name}입니다. 나이는 {age}살 입니다."
print(f_text)

# 3. 글자 자르기
# String > "어떠한 글자들"[start : end]
text_name = text[:15]
print(text_name)

text_age = text[15:]
print(text_age)

text_split = text.split()
print(text_split)