'''
문제 1.
문자열을 입력받아 문자열의 첫 글자와 마지막 글자를 출력하는 프로그램을 작성하세요 :)
'''

sample = input('문자를 입력해주세요! : ')
# 아래에 코드를 작성해 주세요.
print(sample[0])
print(sample[-1])
print(f"첫 글자 : {sample[0]}, 마지막 글자 : {sample[len(sample)-1]}")